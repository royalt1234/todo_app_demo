FROM python:3.9-alpine
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir --upgrade -r requirements.txt 
COPY . .
EXPOSE 5000

CMD ["python3", "app.py"] 

## run "python3 app.py" on local to be sure it's running before proceeding.