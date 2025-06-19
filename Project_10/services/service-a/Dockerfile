FROM python:3.10-slim
RUN pip install flask prometheus_client
WORKDIR /app
COPY app.py .
EXPOSE 80
CMD ["python", "app.py"]
