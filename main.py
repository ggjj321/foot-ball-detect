from fastapi import FastAPI, File, UploadFile
import soccer_api


app = FastAPI()

@app.post("/find_coordinate")
async def find_coordinate(target_squares: str, detect_video: UploadFile):
    return {"message": "Hello World"}


@app.get("/")
async def root():
    return {"message": "Hello World"}