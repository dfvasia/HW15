from flask import Flask, render_template, request, abort, jsonify
import func_1 as sql

app = Flask(__name__)


@app.route('/')
def start_page():
    id_animals = request.args.get("id_animals")
    return render_template('found.html', sa=sql.first_list_inquiry(), sk=sql.first_inquiry(id_animals))


@app.route('/patient/<id_patient>')
def patient_page(id_patient):
    id_animals = id_patient
    # items = [{
    #     "date": id_animals,
    #     "id": id_animals,
    #     "status": id_animals,
    #     "position": id_animals
    # }]
    # print(items)
    return render_template('patient.html', items=sql.second_inquiry(id_animals))


if __name__ == '__main__':
    app.run(debug=True)
