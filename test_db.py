from simpletodolist import db

# Intentar conectar a la base de datos y crear una sesión
try:
    db.session.execute('SELECT 1')
    print("Conexión a la base de datos exitosa.")
except Exception as e:
    print(f"Error al conectar a la base de datos: {e}")
