FROM python:3.13.5-alpine3.22
# Etapa 1: Use uma imagem base oficial do Python.
# A imagem 'slim' é uma boa escolha por ser leve, mas ainda ter o necessário.
FROM python:3.11-slim

# Etapa 2: Defina o autor da imagem (opcional, mas boa prática)
LABEL authors="lucasmagalhaes"

# Etapa 3: Defina o diretório de trabalho dentro do contêiner
WORKDIR /app

# Etapa 4: Copie o arquivo de dependências primeiro
# Isso aproveita o cache de camadas do Docker. A instalação das dependências
# só será executada novamente se o arquivo requirements.txt mudar.
COPY requirements.txt .

# Etapa 5: Instale as dependências
# --no-cache-dir cria uma imagem menor
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 6: Copie o resto do código da sua aplicação para o diretório de trabalho
COPY . .

# Etapa 7: Exponha a porta em que o Uvicorn irá rodar
EXPOSE 8000

# Etapa 8: Comando para iniciar a aplicação quando o contêiner for executado
# "app:app" refere-se ao objeto 'app' dentro do arquivo 'app.py'
# --host 0.0.0.0 é essencial para que a aplicação seja acessível de fora do contêiner
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]