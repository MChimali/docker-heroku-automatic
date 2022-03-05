# me crea una máquina virtual con Linux y node en su versión mínima (alpine)
FROM node:12-alpine

# me crea una carpeta dentro de mi máquina nueva (con -p me crea todas las carpetas de la ruta sino existe alguna)
RUN mkdir -p /usr/app

# Seleccionar la carpeta donde va a ocurrir todo, la carpeta raiz de nuestro proyecto. Básicamente estamos apuntando ahí.
WORKDIR /usr/app

# Aquí estamos copiando los archivos de mi máquina virtual a la máquina virtual que he creado. La primera ruta es local, la segunda es la de la máquina virtual.
COPY ./ ./

# Una vez que tenemos todo hacemos un npm install y un run build dentro de este contenedor.
RUN npm install
RUN npm run build

# Una vez todo está instalado y el build hecho, tengo que copiarme el contenido de mi carpeta dist en mi carpeta server.
RUN cp -r ./dist ./server/public

# Ahora tengo que instalar dentro de mi carpeta server el npm install para poder servir esos ficheros.
RUN cd server
RUN npm install

#Esto sirve para dar valor a la variable de entorno PORT. El EXPOSE es para exponer el puerto de mi máquina virtual.
ENV PORT=8083
EXPOSE 8083

# Hasta aquí es la creación de la imagen. En este punto mi imagen está preparada para ser usada para crear contenedores. Una vez esos contenedores se monten, entonces podrán ser usados como servidores, no antes.
# Para hacer que un contenedor realice una función una vez esté creado usamos ENTRYPOINT.
# En este caso, queremos que mi contenedor haga de servidor del contenido de SERVER, así que eso es función del contenedor. En mi script de server tenía "start":"node index.js", ese es el comando que tenemos que ejecutar dentro de mi contenedor.
ENTRYPOINT ["node", "server"]









