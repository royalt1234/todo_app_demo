FROM python:3.9-alpine
WORKDIR /app
COPY requirements.txt ./
RUN python3 -m venv env
RUN source env/bin/activate
RUN pip install --no-cache-dir --upgrade -r requirements.txt 
COPY . .
EXPOSE 8080

CMD ["python3", "app.py"] 

## run "python3 app.py" on local to be sure it's running before proceeding.