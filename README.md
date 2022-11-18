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

**Obs.:** A través de -u le decimos a git que debe crear la rama main en el repositorio remoto ya que no existe.

**Crear modelos y migraciones**

    $ rails g model companies name:string

**Ejeuctar migraciones**

    $ rake db:migrate

**Crear un endpoint de prueba**

- Crear el controlador companies_controller con el método index que retorna un json.
- Agregar la ruta en routes.rb sólo para index.
- Crear un seed con companies de ejemplo y ejecutar el seed con rake db:seed.

    **Obs.:** Para crear los seed se usa la gema activerecord-import que permite insertar datos de forma sencilla y 
    sin duplicados. Sin usar la gema, habrá que resetear la base de datos cada vez que agregamos nuevos datos al seed o 
    habría que agregar algunas condicionales para evitar duplicados. La gema se agrega al Gemfile usando el formato
    gem "gem_name", "~> X.Y", de este modo se asegura que la versión de la gema a instalar será igual o mayor a X.Y.0 y 
    menor a (X + 1).0.0, esto porqué la X se incrementa cuando hay cambios que son incompatibles con versiones 
    anteriores. Mas información en https://blog.makeitreal.camp/manejo-de-dependencias-en-ruby-con-bundler/. 
    Cualquier gema agregada tendrá el siguiente formato (indicando una breve descripción de la gema, el repositorio de 
    la gema entre corchetes tal y como lo hace Rails, la versión con el formtao X.Y y usando comillas dobles):

    ```ruby
    # A library for bulk insertion of data into your database using ActiveRecord [https://github.com/zdennis/activerecord-import]
    gem "activerecord-import", "~> 1.4"
    ```
    Para evitar duplicados con activerecord-import se debe crear un unique constraint para el atributo name de la tabla 
    companies, y, al momento de importar usar el parametro on_duplicate_key_ignore a true  

- Acceder a localhost:3000/companies

**Agregar Rubocop y rails_best_practices al Gemfile**

- Agregar rubocop, rubocop-performance, rubocop-rails y rails_best_practices. Rubocop-performance no sé que verifica
- Configurar Rubocop a través del archivo de configuración .rubocop.yml
- Ejecutar rubocop con el comando: rubocop
- Ejecutar rails_best_practices con el comando: rails_best_practices .
- Corregir las advertencias dadas por los dos comandos y/o configurar las advertencia a tener o no en cuenta

**Crear modelos y migraciones**

    $ rails g model monitored_services name:string company:references

**Permitir conexión de aplicaciones externas a la API**
- Descomentar el contenido de config/initializers/cors.rb
- Reemplazar "example.com" por *
- Descomentar gem "rack-cors" del Gemfile y ejecutar bundle install

**Crear modelos y migraciones**

    $ rails g model weekly_monitoring_calendars monitored_service:references start_at:datetime end_at:datetime
    $ rails g model employees name:string assigned_color:string
    $ rails g model time_blocks name:string
    $ rails g model time_block_employee_assignments time_block:references employee:references start_at:datetime end_at:datetime 
    $ rails g model time_block_service_assignments time_block:references monitored_service:references start_at:datetime end_at:datetime 