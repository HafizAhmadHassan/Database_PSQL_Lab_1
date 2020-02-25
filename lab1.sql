-------------------Lab1

Creating types and tables using PostgreSQL

SQL sentences  video (except for create database)

-- We're going to create a database to store the electronic documentation
-- For each document we need to know
--      file name (name + extension)
--      who has created the document with some contact data
--      version (example: 3.1, 5.2, ...)
--      summary info
--      date of creation

DROP TABLE IF EXISTS tbl_docs;
DROP TYPE IF EXISTS tp_file;
DROP TYPE IF EXISTS tp_version;
DROP TYPE IF EXISTS tp_fileName;
DROP TABLE IF EXISTS tbl_author;
DROP TYPE IF EXISTS tp_author;


-- First we create the type for author
CREATE TYPE tp_author as (
 ID  char(10),
 name varchar(100),
 telf varchar(12),
 email varchar(255)
);

-- Creating the table to store the authors collaborators

CREATE TABLE tbl_author OF tp_author (
 PRIMARY KEY (ID)
);

-- Inserting some authors


INSERT INTO tbl_author VALUES (
 '0000000001',  -- ID,
 'Joan Pi',  -- NAME
 '659...',  -- TELEPHONE
 'jpi@email.com'  -- EMAIL
);

SELECT * FROM tbl_author;


-- Creating filename and file types
--      file name (name + extension)

CREATE TYPE tp_fileName AS (
 name  varchar(200),
 extension varchar(10)
);

-- We need to create version type
--      version (example: 3.1, 5.2, ...) 
-- major and minor 

CREATE TYPE tp_version AS (
 major int,
 minor int
);


-- Info related to type file
--      file name (name + extension)
--      who has created the document with some contact data
--      version (example: 3.1, 5.2, ...)
--      summary info
--      date of creation


CREATE TYPE tp_file AS (
 name  tp_filename,
 description text,  -- summary info
 idAuthor char(10), -- field related to authors table. We associated on table creation
 createdDate timestamp with time zone, -- date of creation
 version  tp_version -- Version of the document
);

-- Creating the table to store the document's info

CREATE TABLE tbl_docs of tp_file (
 PRIMARY KEY (name,version),
 CONSTRAINT FK_AUTHOR  -- Associating idAuthor with ID field of tbl_author
  FOREIGN KEY (idAuthor) REFERENCES tbl_author(ID)
);


-- INSERTING SOME DATA ON tbl_docs

INSERT INTO tbl_docs VALUES (
 ROW('Requirements','odt')::tp_filename, -- name,extension. specify ::tp_filename is optional
 'Requirements ....',   -- description
 '0000000001',    -- author identification. Must exist in tbl_author
 '2018-07-03 12:25:00',   -- creation date
 ROW(3,1)    -- version . In this case cast (::tp_version) not specified
);

----------Lab started----------------
Select * from psycho_db.domicilio_paziente;


Select * from psycho_db.telefono_paziente;

Select * from psycho_db.professione_paziente;

Select * from psycho_db.diagnosi_paziente;

Select * from psycho_db.diagnosi;

Select d.paziente ,d.Indirizzo , t1.tel , pp.professione,dp.diagnosi
from psycho_db.domicilio_paziente d join 
psycho_db.telefono_paziente t1 on d.paziente = t1.paziente
join psycho_db.professione_paziente pp on pp.paziente=t1.paziente
join psycho_db.diagnosi_paziente dp on  dp.paziente=pp.paziente



drop type if exists patient_tt;
create type patient_tt as (
id integer,
indirizzo1 Varchar(128),
tel1	Varchar(128),
professione1	integer,
diagnosi1 integer

);


drop table if exists patient_tbl;

CREATE TABLE patient_tbl OF patient_tt;

INSERT INTO TABLE1 (id, col_1, col_2, col_3)
SELECT id, 'data1', 'data2', 'data3'
FROM TABLE2
WHERE col_a = 'something';

INSERT INTO patient_tbl Select d.paziente ,d.Indirizzo , t1.tel , pp.professione,dp.diagnosi
from psycho_db.domicilio_paziente d join 
psycho_db.telefono_paziente t1 on d.paziente = t1.paziente
join psycho_db.professione_paziente pp on pp.paziente=t1.paziente
join psycho_db.diagnosi_paziente dp on  dp.paziente=pp.paziente


--Find the code, the date and place of birth of the patients
--that lived or are living in one municipality that does not
--belong to the province of Verona.

Select * from psycho_db.paziente p1 join 
patient_tbl p2 on p1.codice=p2.id
where p1.luogo_nascita!='VERONA';


Select * from psycho_db.provincia 
Select * from patient_tbl pt join  psycho_db.provincia pr
on pt.id=pr.codice_istat
where indirizzo1 != '%VERONA%';


--Find the code and the telephone numbers of the patients
--that had a diagnosis of the disease “Episodio depressivo”

Select * from patient_tbl d1 join 
psycho_db.diagnosi d2 on d1.diagnosi1=d2.codice
where descrizione = 'Episodio depressivo' 



--Group the patient for type of job and produce for each
--type: the name, the number of patients, the average
--number of diseases per patient and the average number
--of telephone per patient.
Select * from patient_tbl;
Select * from psycho_db.professione;

Select count(pt.id) as Patient , avg(pd.diagnosi), pro.categoria 
from patient_tbl pt join
psycho_db.professione_paziente pp
on pp.paziente=pt.id join 
psycho_db.professione pro
on pro.codice = pp.professione
join psycho_db.diagnosi_paziente pd on pt.id=pd.paziente
Group by  pro.categoria--,pd.diagnosi


Select * from psycho_db.paziente;
Select * from psycho_db.professione_paziente 



