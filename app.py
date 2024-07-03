from __init__ import app, db
from flask import render_template, request, redirect, url_for
from datetime import datetime

# Modelos para las tablas de opciones
class ImportanceLevel(db.Model):
    __tablename__ = 'importance_levels'
    id = db.Column(db.Integer, primary_key=True)
    importance = db.Column(db.String(50), nullable=False)

class UrgencyLevel(db.Model):
    __tablename__ = 'urgency_levels'
    id = db.Column(db.Integer, primary_key=True)
    urgency_level = db.Column(db.String(50), nullable=False)

class ActivityType(db.Model):
    __tablename__ = 'activity_types'
    id = db.Column(db.Integer, primary_key=True)
    activities = db.Column(db.String(50), nullable=False)

class Project(db.Model):
    __tablename__ = 'projects'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)

class Importance(db.Model):
    __tablename__ = 'importances'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)

class Category(db.Model):
    __tablename__ = 'categories'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)

class MentalFocus(db.Model):
    __tablename__ = 'mental_focus'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)

class Day(db.Model):
    __tablename__ = 'days'
    id = db.Column(db.Integer, primary_key=True)
    day = db.Column(db.String(50), nullable=False)

# Modelo para la tabla principal de tareas
class Task(db.Model):
    __tablename__ = 'tasks'
    id = db.Column(db.Integer, primary_key=True)
    day = db.Column(db.String(50), nullable=False)
    date = db.Column(db.Date, nullable=False)
    proactive = db.Column(db.String(250), nullable=False)
    project_id = db.Column(db.Integer, db.ForeignKey('projects.id'), nullable=False)
    project = db.relationship('Project')
    priority_id = db.Column(db.Integer, db.ForeignKey('importance_levels.id'), nullable=False)
    priority = db.relationship('ImportanceLevel')
    category_id = db.Column(db.Integer, db.ForeignKey('categories.id'), nullable=False)
    category = db.relationship('Category')
    importance_id = db.Column(db.Integer, db.ForeignKey('importances.id'), nullable=False)
    importance = db.relationship('Importance')
    urgency_id = db.Column(db.Integer, db.ForeignKey('urgency_levels.id'), nullable=False)
    urgency = db.relationship('UrgencyLevel')
    action_to_take = db.Column(db.String(255), nullable=False)
    activity_type_id = db.Column(db.Integer, db.ForeignKey('activity_types.id'), nullable=False)
    activity_type = db.relationship('ActivityType')
    mental_focus_id = db.Column(db.Integer, db.ForeignKey('mental_focus.id'), nullable=False)
    mental_focus = db.relationship('MentalFocus')
    delegate = db.Column(db.Boolean, nullable=False)
    was_delegated = db.Column(db.Boolean, nullable=False)
    due_date = db.Column(db.Date, nullable=False)
    task_arrived = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)
    started = db.Column(db.DateTime, nullable=True)
    finish = db.Column(db.DateTime, nullable=True)
    duration = db.Column(db.String(50), nullable=True)
    duration_since_arrival = db.Column(db.String(50), nullable=True)
    comments = db.Column(db.Text, nullable=True)
    status = db.Column(db.String(50), default='pending', nullable=False)

db.create_all()

@app.route('/')
def index():
    tasks_pending = Task.query.filter_by(status='pending').order_by(Task.due_date, Task.action_to_take, Task.priority_id).all()
    tasks_in_progress = Task.query.filter_by(status='in progress').order_by(Task.due_date, Task.action_to_take, Task.priority_id).all()
    tasks_completed = Task.query.filter_by(status='completed').order_by(Task.due_date, Task.action_to_take, Task.priority_id).all()
    return render_template('index.html', tasks_pending=tasks_pending, tasks_in_progress=tasks_in_progress, tasks_completed=tasks_completed)

@app.route('/add', methods=['GET', 'POST'])
def add_task():
    if request.method == 'POST':
        importance = Importance.query.get(request.form.get('importance'))
        urgency = UrgencyLevel.query.get(request.form.get('urgency'))

        # Definir la acción a tomar basada en la combinación de nivel de importancia y urgencia
        if importance.name == 'Importante' and urgency.urgency_level == 'Urgente':
            action = 'Hazlo YA'
        elif importance.name == 'Importante' and urgency.urgency_level == 'No Urgente':
            action = 'Diseña / Decidir'
        elif importance.name == 'No Importante' and urgency.urgency_level == 'Urgente':
            action = 'Elimina tarea'
        else:
            action = 'Delega la tarea'

        task = Task(
            day=request.form.get('day'),
            date=request.form.get('date'),
            proactive=request.form.get('actividad'),
            project_id=request.form.get('project'),
            priority_id=request.form.get('priority'),
            category_id=request.form.get('category'),
            importance_id=request.form.get('importance'),
            urgency_id=request.form.get('urgency'),
            action_to_take=action,
            activity_type_id=request.form.get('activity_type'),
            mental_focus_id=request.form.get('mental_focus'),
            delegate=bool(request.form.get('delegate')),
            was_delegated=bool(request.form.get('was_delegated')),
            due_date=request.form.get('due_date'),
            comments=request.form.get('comments')
        )
        db.session.add(task)
        db.session.commit()
        return redirect(url_for('index'))

    # Obtener las opciones para las listas desplegables
    days = Day.query.all()
    priorities = ImportanceLevel.query.all()
    urgencies = UrgencyLevel.query.all()
    activity_types = ActivityType.query.all()
    projects = Project.query.all()
    importances = Importance.query.all()
    categories = Category.query.all()
    mental_focuses = MentalFocus.query.all()

    return render_template(
        'add_task.html',
        days=days,
        priorities=priorities,
        urgencies=urgencies,
        activity_types=activity_types,
        projects=projects,
        importances=importances,
        categories=categories,
        mental_focuses=mental_focuses
    )

@app.route('/start/<int:task_id>')
def start_task(task_id):
    task = Task.query.get(task_id)
    if task:
        task.started = datetime.utcnow()
        task.status = 'in progress'
        db.session.commit()
    return redirect(url_for('index'))

@app.route('/complete/<int:task_id>')
def complete_task(task_id):
    task = Task.query.get(task_id)
    if task:
        task.finish = datetime.utcnow()
        task.status = 'completed'
        if task.started:
            task.duration = str(task.finish - task.started)
        task.duration_since_arrival = str(task.finish - task.task_arrived)
        db.session.commit()
    return redirect(url_for('index'))

@app.route('/delete/<int:task_id>')
def delete_task(task_id):
    task = Task.query.get(task_id)
    if task:
        db.session.delete(task)
        db.session.commit()
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True)
