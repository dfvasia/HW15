from flask import Flask

app = Flask(__name__)


@app.route('/')
def start_page():
    pass


if __name__ == '__main__':
    app.run(debag=True)
