from fastapi import FastAPI, File, UploadFile
import soccer_api


app = FastAPI()

@app.post("/find_coordinate")
async def find_coordinate(target_squares: str, detect_video: UploadFile):
    score, coordinate_x, coordinate_y = detect_video_to_calculate_data(target_squares)
    return {"score": score, "coordinate_x": coordinate_x, "coordinate_y": coordinate_y}


@app.get("/")
async def root():
    return {"message": "Hello World"}