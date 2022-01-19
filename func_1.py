import sqlite3
import os
from flask import Flask, render_template, request, abort, jsonify


BASEDIR = os.path.abspath(os.path.dirname(__file__))
DBNAME = f"{BASEDIR}\\animal.db"


def open_sqlite3(name_db, query):
    with sqlite3.connect(name_db) as connection:
        cursor = connection.cursor()
        cursor.execute(query)
    return cursor.fetchall()


def first_list_inquiry():
    found = set()
    query = f"""
        SELECT DISTINCT animal_id
        FROM animals_cards ac
        WHERE animal_id IS NOT NULL
        ORDER BY animal_id DESC 
    """
    s = open_sqlite3(DBNAME, query)
    for row in s:
        temp_t = row[0].split(', ')
        for t in temp_t:
            found.add(t)
    return found


def first_inquiry(id_item):
    dict_t = []
    query = f"""
        SELECT animal_id, at.animals_type, name, ad.breed_type, colors.color_type, c.color_type, date_of_birth
        FROM animals_cards ac
        LEFT JOIN animals_type at on ac.id_animal_type = at.id_animals_type
        LEFT JOIN animals_breed ad on ac.id_breed =ad.id_breed
        LEFT JOIN colors on ac.id_color_1=colors.id_colors
        LEFT JOIN colors c on ac.id_color_2=c.id_colors
        WHERE ac.animal_id='{id_item}'
        """
    s = open_sqlite3(DBNAME, query)
    for row in s:
        dict_t.append({
            "id": row[0],
            "type": row[1],
            "name": row[2],
            "breed": row[3],
            "color_1": row[4],
            "color_2": row[5],
            "birth": row[6]
        })
    print(dict_t)
    return dict_t

