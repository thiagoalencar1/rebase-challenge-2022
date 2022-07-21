# Rebase Challenge 2022

## Prepare Environment

With Docker properly installed in your machine type:

```
docker-compose up
```

The application gonna be ready to use when you see the follow text in your terminal:

```
ruby      | * Puma version: 5.6.4 (ruby 3.1.2-p20) ("Birdie's Version")
ruby      | *  Min threads: 0
ruby      | *  Max threads: 5
ruby      | *  Environment: development
ruby      | *          PID: 1
ruby      | * Listening on http://0.0.0.0:3000
ruby      | Use Ctrl-C to stop
```
The load time may vary acoording your conection and storage speed.

## Running Tests
- With your appication up and running, open another terminal and just type:
```
docker exec ruby rspec
```
And you got the tests results.

---
<br />

# **Endpoints**
## **GET /tests**: 
- Show all Clinical Exams.
- Response example: 

``` json
[
	{
		"id": "1",
		"cpf": "048.973.170-88",
		"name": "Emilly Batista Neto",
		"email": "gerald.crona@ebert-quigley.com",
		"birthdate": "2001-03-11",
		"address": "165 Rua Rafaela",
		"city": "Ituverava",
		"state": "Alagoas",
		"crm": "B000BJ20J4",
		"crm_state": "PI",
		"doctor_name": "Maria Luiza Pires",
		"doctor_email": "denna@wisozk.biz",
		"token_exam_result": "IQCZ17",
		"exam_date": "2021-08-05",
		"exam_type": "hemácias",
		"exam_type_limit": "45-52",
		"exam_result": "97"
	},
	{
		"id": "2",
		"cpf": "048.973.170-88",
		"name": "Emilly Batista Neto",
		"email": "gerald.crona@ebert-quigley.com",
		"birthdate": "2001-03-11",
		"address": "165 Rua Rafaela",
		"city": "Ituverava",
		"state": "Alagoas",
		"crm": "B000BJ20J4",
		"crm_state": "PI",
		"doctor_name": "Maria Luiza Pires",
		"doctor_email": "denna@wisozk.biz",
		"token_exam_result": "IQCZ17",
		"exam_date": "2021-08-05",
		"exam_type": "leucócitos",
		"exam_type_limit": "9-61",
		"exam_result": "89"
	}
]
```
---
## **GET /tests/:token**
- Show details from one Clinical Exam.
- Replace token by your token.
- Response example: 

``` json
{
	"token_exam_result": "IQCZ17",
	"exam_date": "2021-08-05",
	"cpf": "048.973.170-88",
	"name": "Emilly Batista Neto",
	"email": "gerald.crona@ebert-quigley.com",
	"doctor": {
		"doctor_name": "Maria Luiza Pires",
		"doctor_email": "denna@wisozk.biz",
		"crm": "B000BJ20J4",
		"crm_state": "PI"
	},
	"tests": [
		{
			"exam_type": "ácido úrico",
			"exam_type_limit": "15-61",
			"exam_result": "2"
		},
		{
			"exam_type": "eletrólitos",
			"exam_type_limit": "2-68",
			"exam_result": "85"
		},
		{
			"exam_type": "glicemia",
			"exam_type_limit": "25-83",
			"exam_result": "98"
		},
		{
			"exam_type": "hdl",
			"exam_type_limit": "19-75",
			"exam_result": "0"
		},
		{
			"exam_type": "hemácias",
			"exam_type_limit": "45-52",
			"exam_result": "97"
		},
		{
			"exam_type": "ldl",
			"exam_type_limit": "45-54",
			"exam_result": "80"
		},
		{
			"exam_type": "leucócitos",
			"exam_type_limit": "9-61",
			"exam_result": "89"
		},
		{
			"exam_type": "plaquetas",
			"exam_type_limit": "11-93",
			"exam_result": "97"
		},
		{
			"exam_type": "t4-livre",
			"exam_type_limit": "34-60",
			"exam_result": "94"
		},
		{
			"exam_type": "tgo",
			"exam_type_limit": "50-84",
			"exam_result": "87"
		},
		{
			"exam_type": "tgp",
			"exam_type_limit": "38-63",
			"exam_result": "9"
		},
		{
			"exam_type": "tsh",
			"exam_type_limit": "25-80",
			"exam_result": "65"
		},
		{
			"exam_type": "vldl",
			"exam_type_limit": "48-72",
			"exam_result": "82"
		}
	]
}
```
---
## **POST /import** 
- Import new results with CSV.
- Example to upload using Imnsonia:
<br />

![image](https://user-images.githubusercontent.com/14118336/180081121-5a8aa1ff-b5c7-4176-aefa-c5b467bb60b4.png)

<br />

- CSV header format:

| cpf | nome paciente | email paciente | data nascimento paciente | endereço/rua paciente | cidade paciente | estado patiente | crm médico | crm médico estado | nome médico | email médico | token resultado exame | data exame | tipo exame | limites tipo exame | resultado tipo exame |
|:---:|:-------------:|:--------------:|:------------------------:|:---------------------:|:---------------:|:---------------:|:----------:|:-----------------:|:-----------:|:------------:|:---------------------:|:----------:|:----------:|:------------------:|:--------------------:|
<br />

```
cpf;nome paciente;email paciente;data nascimento paciente;endereço/rua paciente;cidade paciente;estado patiente;crm médico;crm médico estado;nome médico;email médico;token resultado exame;data exame;tipo exame;limites tipo exame;resultado tipo exame
```






