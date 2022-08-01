import os
from flask import Flask, request

app = Flask(__name__)

@app.route("/find_coordinte", methods=["POST"])
def find_coordinte():
    detect_video = request.files["detect_video"]
    detect_video.save("detect_video.mp4")
    os.system('py find_coordinte.py')

    return "success"

@app.route("/")
def hello():
    return "Hello, World!"
    
if __name__ == '__main__':
    app.run()