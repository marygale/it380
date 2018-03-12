# IT380 Introduction to Data Mining using R

#### BY: 👨‍🔧 Angelo Dan Bagasbas and 👩‍🔧Mary Gale Jabagat

![IT380](https://im2.ezgif.com/tmp/ezgif-2-b2b26f49c6.gif)

Song Recommendation using Association Rule

> - a clean csv file is already provided for database population
> - the csv "unique_jam.csv" and "jav10.csv" are the result from the R script "jam_rules.R"
> - refer to github link https://github.com/marygale/it380

### Installation

Install download the zip file or clone the repository to your local environment

```sh
$ git clone https://github.com/marygale/it380.git
$ cd it380
```

Setup a database on your local environment with the following credentials:

|Field  | Value|
| ------ | ------ |
| Database name | test |
| Database username | root |
| Database password |  |

If test database name already exist on your phpmyadmin make sure no table are present under these database name.
Initial load will run a sql script to create tables and migrate data from the clean csv to the database.
