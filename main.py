from fastapi import FastAPI, File, UploadFile


app = FastAPI()

@app.post("/find_coordinate")
async def find_coordinate(target_squares: str, detect_video: UploadFile):
    detect_video_to_calculate_data([1, 2, 3])
    return {"message": "Hello World"}


@app.get("/")
async def root():
    return {"message": "Hello World"}