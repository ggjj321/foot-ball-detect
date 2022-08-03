import os
from flask import Flask, request, send_file

app = Flask(__name__)

@app.route("/find_coordinte", methods=["POST"])
def find_coordinte():
    detect_video = request.files["detect_video"]
    detect_video.save("detect_video.mp4")
    os.system('py find_coordinte.py')

    return send_file("result_img.jpg")

@app.route("/result_img", methods=["GET"])
def get_result_img():
    return send_file("result_img.jpg")

@app.route("/")
def hello():
    return "Hello, World!"
    
if __name__ == '__main__':
    app.run(host="118.160.86.37", port=5000) 