FROM python:3.8-alpine

COPY ./requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip3 install -r requirements.txt
COPY . /app
ENTRYPOINT [ "python3" ]
CMD ["-m", "flask", "run", "--host=0.0.0.0" ]