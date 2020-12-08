# Simple Dolibarr ERP CRM Docker container spec.

Originally based on tuxgasy work, this repository follows a clearer and more straightforward way to create runtime environments, particularly useful for the not-so-experienced users (me included).

Some customizations that took place in this repository:
* **Keep it simple**. Maintain updated just the latest branch project structure, including only the minimum needed functionality (autoupdate, autorebuild and the like scripts).
* **Compression**. Build images without compression.
* **Define versions**. Avoiding as much as possible surprises due to tag "latest" changing versions.
* **Manual updates**. Keep control over version updates.
* **Manual install**. Stick to standard installation, rather to custom script.
* **Volumes**. (to-do) Exploit Docker volume possibilities.


## Supported tags

* 12.0.3 12 latest


## What is Dolibarr ?

Dolibarr ERP & CRM is a modern software package that helps to manage your organization's activity (contacts, suppliers, invoices, orders, stocks, agenda…).

> [More information](https://github.com/dolibarr/dolibarr)


## Prerequisites

To test this repository (Linux or Windows), please install, in case you still didn't:

* `Docker Desktop`. 
* `bash`. Most Linux distributions include bash, in Windows there are many ways you can have access to a bash command line, as installing MinGW or Git, for example.


## Build

Take a look at `Dockerfile`, adjust version numbers if needed (don't worry much about environment variables at this point, they will be overriden at runtime by `docker-compose.yml`, explained below) and run from your bash command line:
```sh
# ./1container.sh
```


## First Run

This repository comes with two predefined environments: production and development, that will generate the corresponding Dolibarr runtime Docker container groups.
You can create your own additional Docker container groups: assume you want to create one new group called **yourcompany**, then you just have to copy one of the existing folders to a new folder called **doliyourcompany**, ensuring that one `docker-compose.yml` exists inside.

Customize the `docker-compose.yml` file inside the environment folder you want to run, attending to the following table. This will overwrite the default environment defined at image building level in the `Dockerfile` file:


| Variable               | Default value      | Description |
| ---------------------- | ------------------ | ----------- |
| DOLI_INSTALL_AUTO      | 1                  | The installation **will (=1)** / **won't (=0)** be executed automatically on first boot.
| DOLI_DB_HOST           | mysql              | Host name of the MariaDB/MySQL server.
| DOLI_DB_USER           | doli               | Database user.
| DOLI_DB_PASSWORD       | doli_pass          | Database user's password.
| DOLI_DB_NAME           | dolidb             | Database name.
| DOLI_ADMIN_LOGIN       | admin              | Dolibarr Admin's login created on the first boot.
| DOLI_ADMIN_PASSWORD    | admin              | Dolibarr Admin's password.
| DOLI_URL_ROOT          | http://localhost   | Url root of the Dolibarr installation.
| PHP_INI_DATE_TIMEZONE  | UTC                | Default timezone on PHP.
| PHP_INI_MEMORY_LIMIT   | 256M               | PHP Memory limit.
| WWW_USER_ID            |                    | ID of user www-data. ID will not be changed if you leave empty. During a development, it is very practical to put the same ID as a regular host user.
| WWW_GROUP_ID           |                    | ID of group www-data. ID will not be changed if you leave empty.


To start your Dolibarr environment, open bash on your host and execute the one that suits the Dolibarr environment you want to run:
* **Production**: 
```sh
# ./2run.sh prod
```

* **Development**: 
```sh
# ./2run.sh devel
```

* **Others**:
```sh
# ./2run.sh yourcompany
```

Now that you have a running container, let's proceed to the Dolibarr installation. On Docker Desktop, open a shell in the 'web' container and type:
```sh
# chmod 600 /var/www/html/conf/conf.php
```
On your host's browser, go to: `http://localhost/install`
(Or, depending on the **"ports"** section at your `docker-compose.yml`, `http://localhost:another-port/install`)

Follow on screen instructions and, after the last step, return to the 'web' container shell: 
```sh
# chmod 400 /var/www/html/conf/conf.php
# touch /var/www/documents/install.lock 
# chmod 444 /var/www/documents/install.lock 
```
(`install.lock` must be removed later to allow Dolibarr updates or calling install again).

And that's all, wellcome to your brand new Dolibarr on Docker instance.


## Regular Run

Subsequent executions are pretty easy, just open bash on your host and execute this command line, see previous chapter for explanations:
```sh
# ./2run.sh environment
```


## Stopping the Server

To stop a running group of containers type:
```sh
# ./3stop.sh environment
```

