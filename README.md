# README



=======
### Model Task

| Colums      | Description |
| ----------- | ----------- |
| name        | string      |
| content     | string      |
| expiry_date | string      |
| status      | boolean     |
| priority    | string      |
| user_id     | foreign_key |

### Model User

| Colums   | Description |
| -------- | ----------- |
| name     | string      |
| email    | string      |
| password | string      |
| is_admin | boolean     |

### Ticket

| Colums | Description |
| ------ | ----------- |
| name   | string      |

### task_ticket_relation

| Colums    | Description |
| --------- | ----------- |
| task_id   | foreign_key |
| ticket_id | foreign_key |


# pushing step:2 on heroku


***
| heroku login |
| ------------ |
| git add . |
| --------- |
| git commit -m "step2" |
| --------------------- |
| git push heroku step2:master |
| ---------------------------- |