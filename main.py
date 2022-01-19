from flask import Flask, render_template, request, abort, jsonify
import func_1 as sql

app = Flask(__name__)

@app.route('/')
def start_page():
    id_animals = request.args.get("id_animals")
    return render_template('found.html', sa=sql.first_list_inquiry(), sk=sql.first_inquiry(id_animals))


if __name__ == '__main__':
    app.run(debug=True)
