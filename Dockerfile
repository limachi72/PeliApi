FROM node:20-bookworm

# Actualizar e instalar dependencias del sistema necesarias para FFmpeg, yt-dlp y Puppeteer
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    curl \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libpango-1.0-0 \
    libcairo2 \
    && rm -rf /var/lib/apt/lists/*

# Instalar yt-dlp globalmente
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

# Directorio de trabajo
WORKDIR /app

# Copiar archivos de configuración de dependencias
COPY package*.json ./

# Instalar dependencias de Node y Puppeteer
RUN npm install && npm install puppeteer

# Copiar el resto del código del proyecto
COPY . .

# Crear la carpeta de descargas temporal
RUN mkdir -p downloads

# Koyeb utiliza el puerto 8000 por defecto para contenedores web
ENV PORT=8000
EXPOSE 8000

# Comando para iniciar el servidor
CMD ["npm", "start"]
