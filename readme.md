# VIDEO 2 - DOCKER
Para trabajar con docker lo primero que tenemos que tener es una imagen ya sea creada por nosotros o una imagen sacada de dockerhub.
Con una imagen se pueden crear varios contenedores. Una imagen es básicamente un estado de una máquina virtual, con un SO determinado y unos paquetes instalados. Con estas imágenes podemos crear contenedores. De una misma imagen podemos crear todos los contenedores que queramos. Estas máquinas virtuales son ordenadores virtuales que contienen lo estrictamente necesario para poder levantar esa parte de la aplicación. Así, cada contenedor, al ejecutarse, desplegará una función determinada. Cada contenedor ocupa una cantidad de espacio determinada, por lo que es imporante ir cerrando contenedores a medida que estos se van dejando de usar.

La ventaja de las imágenes es que son versiones estables, con todos los componentes necesarios. Usando estas imágenes, listas para ser consumidas, tienes la certeza de que tu proyecto se va a desplegar como debe ser desplegado, sin sorpresas.

0. docker pull IMAGEN > descargarme la imagen del hub a mi local.
1. docker images > me muestra todas las imágenes que tengo en mi local.
1. docker ps > me muestra todos los contenedores en activo.
2. docker ps --all > me muestra todos los contenedores que se han ejecutado o se están ejecutando en mi sistema.
3. docker container rm docker_id_Inicio > comando para borrar contenedores
4. docker run IMAGEN > crea contenedor de imagen y la ejecuta.
5. docker login > sirve para logarme
6. docker container prune > esto borra todos los containers
7. docker start IMAGEN_ID> vuelve a ejecutar un contenedor que está parado. docker run te crea un nuevo contenedor y te lo ejecuta; docker start no te crea ningún contenedor nuevo, simplemente te lo ejecuta de nuevo.
8. docker image rm NOMBRE_IMAGEN > borra la imagen
9. docker rmi $(docker images --filter "dangling=true" -q --no-trunc) > borra imágenes sin tag
10. docker build -t my-app:1 .  >> monta una imagen
11. docker run --name my-app-container my-app:1
12. docker run --name my-app-container -it my-app:1 sh ( crea contenedor y me mete dentro de la terminal)
13. --rm añadido arriba va a hacer que se elemine el contendor cuando éste pare
14. -p 8083:8080 va a hacer que el puerto 8080 de la máquina virtual apunte al puerto 8083 de mi máquina
15. docker exec -it my-app-container sh > sirve para acceder a ese contenedor de manera interactiva
16. docker stop "nombre de contenedor"

Por ejemplo un contenedor que contiene un servidor que está esperando todo el día peticiones es un contenedor que al lanzarse no para la ejecución. No parará como el de hello-world, que sirve únicamente para lanzar un mensaje en la consola del terminal.

Si por ejemplo ejecuto la imagen que contiene el sistema operativo de Ubunto, me va a dar error porque este contenedor requerirá que me conecte a su terminal. Digamos que a través de mi terminal en mi máquina local podré conectarme al terminal de la máquina virtual que contiene el Ubuntu y a partir de ahí podré dar las órdenes que necesite.

de ahí que tenga que para instalarlo tenga que hacer docker run -it ubuntu sh (el -it es para conectarme interactivamente y el sh es para abrir una terminal de bash)

# VIDEO 3 - DOCKER

Vamos a crear un fichero llamado "Dockerfile" tal cual. No puede tener otro nombre.
Nuestro Dockerfile va a ser nuestra imagen y ésta se va a crear a partir de otra imagen a la que vamos a ir añadiendo cosas para completar nuestra imagen. Nuestro Dockerfile será un workflow donde se encontrarán todas las instrucciones automatizadas que tendremos que usar en esa máquina virtual.

Una vez tenemos el workflow implementado podemos convertirlo en imagen. Para crear una imagen a partir de esto hacemos en el terminal
>> docker build -t my-app:1 . (-t es para darle un nombre, my-app es el nombre y el :1 es la versión. El punto hay que ponerlo tb)

En este momento si hago un "docker image"  me aparecerá mi imagen almacenada.

Sin embargo aun no hemos creado ningún contenedor. Únicamente está mi imagen creada.

Si hago un contenedor de mi imagen este contenedor se ejecutará y parará porque no tenemos nada escuchando > docker run --name my-app-container my-app:1 (--name es para darle un nombre a ese contenedor) Si hago docker ps no me aparecerá nada porque se ha ejecutado y cerrado.

Así vamos a crearnos un contenedor pero vamos a crearlo de manera interactiva, que es básicamente metiéndome en su terminal directamente > docker run --name my-app-container -it my-app:1 sh (--name: da nommbre a mi container, -it: me mete en la terminal de ese contenedor, my-app:1: nombre de mi imagen, sh: tipo de terminal).

Si creamos el contenedor peor no lo hacemos de manera interactiva, también podemos entrar interactivamente a través de este comando: docker exec -it my-app-container sh

Cuando lo ejecuto me aparece directamente "/usr/app #", que es básicamente la terminal de mi ordenador virtual.
Si ejecuto ls -a puedo ver todos los archivos en mi directorio (los que están ocultos tb)

Para salir ejecuto exit > vuelvo a mi local

Ahora necesitamos mi servidor andando.

PAra eso añadimos el ENTRYPOINT.

Una vez que o haya añadido tenemos que actualizar la imagen.
Lo que podemos hacer es hacer un build de la imagen usando el mismo nombre y versión, con lo cual estaremos machacando esa imagen.
>> docker build -t my-app:1

Para parar de ejecutar un contenedor ejecutamos docker stop "nombre de contenedor"

Para crear un contenedor y exponer en un puerto de mi máquina un puerto de la máquina virtual hacemos lo siguiente:
> docker run --name my-app-container --rm -p 8080:8083 my-app-1
Donde --rm borrará el contenedor una vez este pare
Donde -p 8080:8083 sirve para publicar en mi máquina un puerto de la máquina virtual

-----------------------------------------------

¿Cómo despliego ahora mi imagen en dockerhub?
Lo primero es cambiarle el nombre a mi imagen a "perfilDockerHub/NomreAplicacion" > mchimali/my-app
Eso se hace con el comando docker tag my-app:2 mchimali/my-app
> Docker pull es para traer una imagen, docker push es para exportarla
> Docker push mchimali/my-app

A partir de ahora podemos usar esta imagen para crear otras imágenes. Es exactamente lo mismo.

-----------------------------------------------

Ahora vamos a usar Heroku como servidor para desplegar mi imagen y contenedor.

1. creamos un nuevo repositorio en github sin ningún archivo dentro.
2. me clono mi repositorio en local
3. git init, git remote add origin "address", git add ., git commit -m "justo", git push
4. nos vamos a heroku y hacemos "create new app". Damos nombre, escogemos región. click en Create App.
5. Desde la consola hacemos "heroku login"
