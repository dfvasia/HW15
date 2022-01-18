from flask import Flask, render_template, request, abort, jsonify
import os

app = Flask(__name__)


BASEDIR = os.path.abspath(os.path.dirname(__file__))
DBNAME = f"{BASEDIR}\\netflix.db"


@app.route('/')
def start_page():
    s = {
        'title': 1,
        'genre': 2,
        'description': 3,
        'country': 4,
        'release_year': 5
    }
    return render_template('found.html', s=s)


if __name__ == '__main__':
    app.run(debug=True)
