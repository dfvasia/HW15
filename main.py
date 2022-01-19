from flask import Flask, render_template, request, abort, jsonify
import os
from func_1 import open_sqlite3 as sql

app = Flask(__name__)


BASEDIR = os.path.abspath(os.path.dirname(__file__))
DBNAME = f"{BASEDIR}\\animal.db"


@app.route('/')
def start_page():
    found = set()
    query = f"""
        SELECT DISTINCT animal_id
        FROM animals_cards ac
        WHERE animal_id IS NOT NULL
        ORDER BY animal_id DESC 
    """
    s = sql(DBNAME, query)
    for row in s:
        temp_t = row[0].split(', ')
        for t in temp_t:
            found.add(t)
    dict_t = []
    id_animals = request.args.get("id_animals")
    query = f"""
    SELECT animal_id, at.animals_type, name, ad.breed_type, colors.color_type, c.color_type, date_of_birth
    FROM animals_cards ac
    LEFT JOIN animals_type at on ac.id_animal_type = at.id_animals_type
    LEFT JOIN animals_breed ad on ac.id_breed =ad.id_breed
    LEFT JOIN colors on ac.id_color_1=colors.id_colors
    LEFT JOIN colors c on ac.id_color_2=c.id_colors
    WHERE ac.animal_id='{id_animals}'
    """
    s = sql(DBNAME, query)
    for row in s:
        dict_t.append({
            "name": row[0],
            "description": row[1]
        })
    }
    return render_template('found.html', s=dict_t, sa=found)


if __name__ == '__main__':
    app.run(debug=True)
