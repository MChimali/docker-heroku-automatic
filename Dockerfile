# Este dockerfile es una evolución de lo que aparece en _dockerfile.md.
# Lo que estamos haciendo aquí es dividir mi workflow en fases. El objetivo es aislar el npm install en la fase de release y extraer de ahí el dist, que es lo que me interesa de esa fase.
# A partir de ahí, en una fase posterior que vamos a llamar release, vamos a partir de la base (sin el node_modules de build). Lo primero que tendremos que hacer es copiarnos el contenido de "server" en mi archivo local y llevármelo a la fase de release (si nos fijamos el copiado se ha hecho en la fase de build).
# Esto me lo copio en mi release en mi directorio raiz. Ya no me hace falta una carpeta que se llame "server", puedo soltar el index y el package.json directamente en la raiz.
# A continuación lo que necesito es copiar de mi fase de build, el dist que ha sido generado en mi build. Para ello hago un COPY from=build (copiar desde build) y claro, aquí tengo que meter la ruta completa del dist, porque estoy entrando desde cero, por la cara. Una vez en /sur/app/dist, puedo copiar todo el resultado directamente en una carpeta que se llame public.
# Una vez hecho esto, ya puedo hacer el npm install.

FROM node:12-alpine AS base
RUN mkdir -p /usr/app
WORKDIR /usr/app

FROM base AS build
COPY ./ ./
RUN npm install
RUN npm run build

FROM base AS release
COPY ./server ./
COPY --from=build /usr/app/dist ./public
RUN npm install

ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["node", "index.js"]









