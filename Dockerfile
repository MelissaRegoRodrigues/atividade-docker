# Etapa de build
FROM python:3.12-slim as build

WORKDIR /app

# Arquivos de requirements e instalar dependências
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Código da aplicação
COPY app.py .

# Etapa final, imagem otimizada
FROM python:3.12-slim

WORKDIR /app

# Dependências e código da etapa de build
COPY --from=build /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=build /app .

# Expor a porta e iniciar a aplicação
EXPOSE 8080
CMD ["python", "app.py"]
