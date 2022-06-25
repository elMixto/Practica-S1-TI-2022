from flask import Flask
from flask import render_template
from flask import request
from libreria import saludar
app = Flask(__name__)

@app.route("/")
def home() -> None:
    return render_template("home.html ")    

@app.route("/entrada",methods = ["GET","POST"])
def entrada():
    if request.method == "POST":
        dato1 = request.form["dato1"]
        dato2 = request.form["dato2"]
        return f"Dato1: {dato1}, Dato2: {dato2}"

    elif request.method == "GET":
        return render_template("entrada.html")

if __name__ == "__main__":
    app.run(debug=True)