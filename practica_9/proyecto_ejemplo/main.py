from flask import Flask, Response
from flask import render_template
from flask import request
import os
from libreria import saludar

app = Flask(__name__)

def root_dir():
    return os.path.abspath(os.path.dirname(__file__))

def get_file(filename):
    try:
        src = os.path.join(root_dir(), filename)
        return open(src).read()
    except IOError as exc:
        return str(exc)

@app.route("/")
def home():
    return render_template("home.html")

@app.route("/entrada",methods = ["GET","POST"])
def entrada():
    if request.method == "POST":
        dato1 = request.form["asd"]
        dato2 = request.form["dato2"]
        return f"Dato1: {dato1}, Dato2: {dato2}"

    elif request.method == "GET":
        return render_template("entrada.html")


@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def get_resource(path):
    mimetypes = {
        ".css": "text/css",
        ".html": "text/html",
        ".js": "application/javascript",
    }
    complete_path = os.path.join(root_dir(), path)
    ext = os.path.splitext(path)[1]
    mimetype = mimetypes.get(ext, "text/html")
    content = get_file(complete_path)
    return Response(content, mimetype=mimetype)


if __name__ == "__main__":
    app.run(debug=True)