CREATE TABLE date_type(
    id_date_type INTEGER PRIMARY KEY AUTOINCREMENT
    ,date_type VARCHAR(15)
);

INSERT INTO date_type (date_type)
SELECT * FROM(
SELECT DISTINCT substr(animals.age_upon_outcome,3) as tr
FROM animals
WHERE tr NOT LIKE '% %');

-- DROP TABLE temp_date_type;
-- CREATE TABLE temp_date_type
-- (
--     id_temp_date_type INTEGER PRIMARY KEY AUTOINCREMENT,
--     num_date INTEGER,
-- --     id_date_type INTEGER,
--     age_upon_outcome VARCHAR(70),
--     id_date_type INTEGER,
--     FOREIGN KEY (id_date_type) REFERENCES date_type(id_date_type)
-- );
--
-- INSERT INTO temp_date_type (age_upon_outcome, num_date, id_date_type)
-- select distinct age_upon_outcome
--      , substr(age_upon_outcome,1, instr(age_upon_outcome,' ')-1) as cnt_args
--      , trim(replace(age_upon_outcome,substr(age_upon_outcome,1, instr(age_upon_outcome,' ')-1),''))  as name_args
-- from animals;
--
--
-- INSERT INTO temp_date_type (age_upon_outcome, num_date, id_date_type)
-- SELECT an.age_upon_outcome, substr(an.age_upon_outcome,1, instr(an.age_upon_outcome,' ')-1) AS num_date, dt.id_date_type
-- FROM animals an, date_type
-- LEFT JOIN date_type dt ON trim(replace(an.age_upon_outcome,substr(an.age_upon_outcome,1, instr(an.age_upon_outcome,' ')-1),''))=dt.date_type
-- ;
--
-- SELECT trim(replace(an.age_upon_outcome,substr(an.age_upon_outcome,1, instr(an.age_upon_outcome,' ')-1),''))
-- FROM animals AS an;

CREATE TABLE outcome_type(
    id_outcome_type INTEGER primary key AUTOINCREMENT
    ,outcome_type VARCHAR(60)
);

INSERT INTO outcome_type(outcome_type)
SELECT * FROM (
            SELECT DISTINCT animals.outcome_type as tr
            FROM animals
            WHERE tr IS NOT NULL);

CREATE TABLE outcome_subtype(
    id_outcome_subtype INTEGER primary key AUTOINCREMENT
    ,outcome_subtype VARCHAR(60)
);

INSERT INTO outcome_subtype(outcome_subtype)
SELECT * FROM (
            SELECT DISTINCT animals.outcome_subtype as tr
            FROM animals
            WHERE tr IS NOT NULL);


drop table clinic_patient;
CREATE TABLE clinic_patient(
    id_clinic_patient INTEGER PRIMARY KEY AUTOINCREMENT
    ,animal_id VARCHAR(10)
    ,date_num INTEGER
    ,id_date_type INTEGER
    ,id_outcome_subtype INTEGER
    ,id_outcome_type INTEGER
    ,outcome_month INTEGER
    ,outcome_year INTEGER
    ,FOREIGN KEY (id_date_type) REFERENCES date_type(id_date_type)
    ,FOREIGN KEY (id_outcome_subtype) REFERENCES outcome_subtype(id_outcome_subtype)
    ,FOREIGN KEY (id_outcome_type) REFERENCES outcome_type(id_outcome_type)
);
INSERT INTO clinic_patient (animal_id, date_num, id_date_type, id_outcome_subtype, id_outcome_type, outcome_month, outcome_year)
SELECT animal_id, substr(an.age_upon_outcome,1, instr(an.age_upon_outcome,' ')-1) AS date_num, dt.id_date_type, os.id_outcome_subtype, ot.id_outcome_type, an.outcome_month, an.outcome_year
FROM animals an
    LEFT JOIN date_type dt ON trim(replace(an.age_upon_outcome,substr(an.age_upon_outcome,1, instr(an.age_upon_outcome,' ')-1),''))=dt.date_type
    LEFT JOIN outcome_subtype os on an.outcome_subtype=os.outcome_subtype
    LEFT JOIN outcome_type ot on an.outcome_type=ot.outcome_type
;

SELECT count(id_clinic_patient)
FROM clinic_patient
;

SELECT count("index")
FROM animals;

CREATE TABLE animals_type(
    id_animals_type INTEGER PRIMARY KEY AUTOINCREMENT
    ,animals_type VARCHAR(10)
                         );
INSERT INTO animals_type (animals_type)
    SELECT DISTINCT an.animal_type
    FROM animals an
;
CREATE TABLE animals_breed(
    id_breed INTEGER PRIMARY KEY AUTOINCREMENT
    ,breed_type VARCHAR(10)
                         );
INSERT INTO animals_breed (breed_type)
    SELECT DISTINCT an.breed
    FROM animals an
;

CREATE TABLE colors(
    id_colors INTEGER PRIMARY KEY AUTOINCREMENT
    ,color_type VARCHAR(10)
                         );
INSERT INTO colors (color_type)
    SELECT *
    FROM(SELECT DISTINCT rtrim(color1) FROM animals
    UNION
    SELECT DISTINCT rtrim(color2) FROM animals WHERE color2 IS NOT NULL)
;
CREATE TABLE animals_colors(
    id_colors INTEGER PRIMARY KEY AUTOINCREMENT
    ,color_type VARCHAR(10)
                         );
INSERT INTO animals_colors (color_type)
    SELECT DISTINCT an.color1
    FROM animals an
;
CREATE TABLE animals_cards(
    id_animals_cards INTEGER PRIMARY KEY AUTOINCREMENT
    ,animal_id VARCHAR(10)
    ,id_animal_type INTEGER
    ,name VARCHAR(50)
    ,id_breed VARCHAR(50)
    ,Id_color INTEGER
    ,date_of_birth DATE
    ,FOREIGN KEY (id_animal_type) REFERENCES animals_type(id_animals_type)
    ,FOREIGN KEY (id_breed) REFERENCES animals_breed(id_breed)
    ,FOREIGN KEY (Id_color) REFERENCES outcome_type(id_outcome_type)
);