# README

## Proceso de Desarrollo

**Establecer versión de Ruby a utilizar**

    $ rvm use 3.0.0

**Crear un gemset para contener y aislar todas las gemas del proyecto**

    $ rvm gemset create maas

**Establecer el gemset**

    $ rvm gemset use maas

**Instalar Rails**

    $ gem install rails --version 7.0.4

**Crear un nuevo proyecto Rails de tipo API usando Postgresql como base de datos**

    $ rails new maas-api --api --database=postgresql

**Crear un archivo de configuración del gemset**

    $ echo "maas" > "maas-api/.ruby-gemset"

**Obs.:** Gracias a este archivo, cuando se ingresa a la carpeta del proyecto, el gemset se configura automáticamente, para que esto funcione, a veces se requiere configurar run as login shell en la terminal en uso.

**Ingresar a la carpeta del proyecto**

    $ cd maas-api

**Inicializar la base de datos**

    $ rake db:create

**Obs.:** No sé porqué se creó la base de datos sin antes haber indicado usuario y contraseña para la base de datos.

**Iniciar la aplicación**

    $ rails s    

Acceder a localhost:3000 en el navegador

**Agregar todo el proyecto a staged**

    $ git add .

**Realizar un commit inicial**

    $ git commit -m "Initial commit"

Crear repositorio en Github

**Linkear repositorio local con el repositorio remoto en Github**

    $ git remote add origin https://github.com/rofaccess/maas-api.git

**Renombrar la rama master a main**

    $ git branch -M main 

**Obs.:** No sé porqué las instrucciones de Github piden renombrar la rama master

**Subir los cambios al repositorio**

    $ git push -u origin main 