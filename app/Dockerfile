FROM python:3.7.4

# 
WORKDIR /code

# 
COPY ./* /code/

RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y

# 
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# 
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]

