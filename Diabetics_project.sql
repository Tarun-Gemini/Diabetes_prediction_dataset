select * from Diabetes_prediction;

/* deleting duplicate records */

WITH CTE AS (
    SELECT
        EmployeeName,
        ROW_NUMBER() OVER (PARTITION BY EmployeeName ORDER BY (SELECT NULL)) AS RowNumber
    FROM
        Diabetes_prediction
)
DELETE FROM CTE WHERE RowNumber > 1;


/* Retrieve the Patient_id and ages of all patients. */

SELECT patient_id, age 
from Diabetes_prediction;

/* Select all female patients who are older than 40. */

SELECT EmployeeName, gender 
from Diabetes_prediction
where age > 40 AND gender = 'Female'
ORDER BY EmployeeName;


/* Calculate the average BMI of patients. */

SELECT patient_id, ROUND(AVG(bmi), 2) AS average_bmi
FROM Diabetes_prediction
GROUP BY Patient_id
ORDER BY Patient_id;


/* List patients in descending order of blood glucose levels. */

SELECT EmployeeName, blood_glucose_level
from Diabetes_prediction
ORDER BY blood_glucose_level DESC;


/* Find patients who have hypertension and diabetes. */

SELECT patient_id, EmployeeName
FROM Diabetes_prediction
where hypertension = 1 AND diabetes = 1;


/* Determine the number of patients with heart disease. */

SELECT COUNT(patient_id) AS Number_of_patients
from Diabetes_prediction
where heart_disease = 1;

/* Group patients by smoking history and count how many smokers and non-smokers there are. */

select smoking_history, COUNT(*) AS No_of_patients
from Diabetes_prediction
GROUP BY smoking_history;


/* Retrieve the Patient_ids of patients who have a BMI greater than the average BMI. */

SELECT patient_id
from Diabetes_prediction
where bmi > (
	select AVG(bmi)
	from Diabetes_prediction
	)
;


/* Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel. */

SELECT TOP 1 patient_id, HbA1c_level
FROM Diabetes_prediction
ORDER BY HbA1c_level DESC;

SELECT TOP 1 patient_id, HbA1c_level
FROM Diabetes_prediction
ORDER BY HbA1c_level ASC;


/* Rank patients by blood glucose level within each gender group. */

SELECT patient_id,
blood_glucose_level,
gender,
RANK() OVER(PARTITION BY gender ORDER BY blood_glucose_level DESC) AS glucoseLevel_rank
FROM Diabetes_prediction;


/* Update the smoking history of patients who are older than 50 to "Ex-smoker." */

UPDATE Diabetes_prediction
SET smoking_history = 'Ex-smoker'
WHERE age > 50;


/* Insert a new patient into the database with sample data. */

INSERT INTO Diabetes_prediction values ('Malla Reddy', 'PT123321', 'Male', 67, 1, 0, 'current', 28.5454, 6.89, 310, 1)

/* Delete all patients with heart disease from the database. */

DELETE FROM Diabetes_prediction
WHERE heart_disease = 1;


/* Find patients who have hypertension but not diabetes using the EXCEPT operator. */

SELECT patient_id
from Diabetes_prediction
where hypertension = 1

EXCEPT

SELECT patient_id
from Diabetes_prediction
where diabetes = 1;


/* Define a unique constraint on the "patient_id" column to ensure its values are unique. */

ALTER TABLE Diabetes_prediction
ADD CONSTRAINT UC_patientID UNIQUE (patient_id);

/* Create a view that displays the Patient_ids, ages, and BMI of patients */

CREATE VIEW PatientinfoView AS
SELECT
	patient_id,
	age,
	bmi
FROM
Diabetes_prediction;

SELECT * FROM PatientinfoView;







