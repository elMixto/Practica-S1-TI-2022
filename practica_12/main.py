from flask import Flask, render_template,request
from random import randbytes
from flaskext.mysql import MySQL

app = Flask(__name__)

app.config['MYSQL_DATABASE_HOST'] = "localhost"
app.config['MYSQL_DATABASE_PORT'] = 3308
app.config['MYSQL_DATABASE_USER'] = "root"
app.config['MYSQL_DATABASE_PASSWORD'] = "password"
app.config['MYSQL_DATABASE_DB'] = "practica_7"
app.config['MYSQL_DATABASE_CHARSET'] = "utf8"

mysql = MySQL()
mysql.init_app(app)

def query_sql(query: str):
    cursor = mysql.connect().cursor()
    cursor.execute(query)
    return cursor.fetchall()

def ejecutar_sql(query:str):
    cursor = mysql.connect().cursor()
    cursor.execute(query)


@app.get("/")
def home():
    salida = query_sql("SELECT numMat, nombre from postulantes")
    return render_template("home.jinja",nombres=salida)

@app.get("/crud")
def crud():
    context = dict()
    context["n_secciones"] = len(query_sql("SELECT DISTINCT seccion from postulantes;"))
    context["carreras_disponibles"] = query_sql("SELECT codCarrera, nombreCarrera from carreras;")
    return render_template("crud.jinja",context=context)

@app.post("/crud")
def crud_form():
    context = dict()
    tipo = request.form["tipo_form"]
    if tipo == "R":
        nombre = request.form['nombre']
        consulta = f"SELECT * FROM postulantes WHERE nombre LIKE \"%{nombre}%\";"
        context["columnas"] = ["numMat","seccion","pref1","pref2","pref3","nombre","ptu","codCarrera"]
        context["filas"] = query_sql(consulta)
        return render_template("salida.jinja",context=context,title="Se han encontrado los siguientes postulantes")
    elif tipo == "D":
        n_mat = request.form['numMat']
        consulta = f"SELECT numMat FROM postulantes WHERE numMat = \"{n_mat}\";"
        consulta = query_sql(consulta)
        mats = [ i[0] for i in consulta]
        if n_mat in mats:
            consulta = f"SELECT * FROM postulantes WHERE numMat = \"{n_mat}\";"
            context["columnas"] = ["seccion","numMat","pref1","pref2","pref3","nombre","ptu","codCarrera"]
            context["filas"] = query_sql(consulta)
            ejecutar_sql(f"DELETE FROM postulantes WHERE numMat = \"{n_mat}\";")
            return render_template("salida.jinja",context=context,title="Se han eliminado los siguien campos")
        else:
            return "No se ha encontrado el numero de matricula"
    elif tipo == "C":
        request.form['codCarrera']
        
    

if __name__ == '__main__':
    app.secret_key = str(randbytes(10))
    app.run(debug = True,host="0.0.0.0",port = 8002)

