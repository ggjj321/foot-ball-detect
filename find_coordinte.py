import cv2
import torch
import numpy as np 
import math

# goal_area[0]:xmin goal_area[1]:xmax goal_area[2]:ymin goal_area[3]:ymax
def in_goal_area(horn_point, goal_area): 
  horn_x_min = horn_point[0]
  horn_x_max = horn_point[1]
  horn_y_min = horn_point[2]
  horn_y_max = horn_point[3]

  goal_x_min = goal_area[0]
  goal_x_max = goal_area[1]
  goal_y_min = goal_area[2]
  goal_y_max = goal_area[3]

  horn_points = [[horn_x_min, horn_y_min], [horn_x_min, horn_y_max], [horn_x_max, horn_y_min], [horn_x_max, horn_y_max]]

  for horn_point in horn_points:
    in_x_range = goal_x_min < horn_point[0] and horn_point[0] < goal_x_max
    in_y_range = goal_y_min < horn_point[1] and horn_point[1] < goal_y_max
    if in_x_range and in_y_range:
      return True

  return False
 
def get_coordinte(df, i):
  x_min = int(df.at[i, 'xmin'])
  x_max = int(df.at[i, 'xmax'])
  y_min = int(df.at[i, 'ymin'])
  y_max = int(df.at[i, 'ymax'])

  coordinte = [x_min, x_max, y_min, y_max]

  return coordinte

def find_closest_point(horn_point, goal_points):
    distances = []
    for goal_point in goal_points:
        distances.append(math.sqrt((horn_point[0] - goal_point[0])**2 + (horn_point[1] - goal_point[1])**2))
    return distances.index(min(distances))

def find_center(horn_point):
  return [int((horn_point[0] + horn_point[1]) / 2), int((horn_point[2] + horn_point[3]) / 2)]

def split_line(point1, point2, part_num):
  points = []

  x_length = int((point2[0] - point1[0]) / part_num)
  y_length = int((point2[1] - point1[1]) / part_num)

  for i in range(1, part_num):
    points.append([point1[0] + i * x_length, point1[1] + i * y_length])
  return points

def create_white_image(frame_height, frame_width):
  shape = (frame_height, frame_width, 3)

  origin_img = np.zeros(shape, np.uint8)
  origin_img.fill(255)
  return origin_img
    
# Model
model = torch.hub.load('ultralytics/yolov5', 'custom', path='weights/best.pt')

cap = cv2.VideoCapture('detect_video.mp4')

frame_height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
frame_width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))

res = (frame_width, frame_height) 
fourcc = cv2.VideoWriter_fourcc(*'MP4V')
videowrite = cv2.VideoWriter('result_video.mp4', fourcc, 20.0, res)

# save whole coordinate to avoid hoen hidden
goal_upper_left_x  = []
goal_upper_left_y  = []
goal_upper_right_x = []
goal_upper_right_y = []
goal_down_left_x  = []
goal_down_left_y  = []
goal_down_right_x = []
goal_down_right_y = []

shoot_in = False

while cap.isOpened():
  success, image = cap.read()
  if not success:
    break
  results = model(image)
  df = results.pandas().xyxy[0]

  horn_points = []
  goal_area = []

  for i in range(len(df)):
    if df.at[i, 'name'] == 'soccer' and float(df.at[i, 'confidence']) > 0.4:
      boal_area = get_coordinte(df, i)
      start_point = (boal_area[0], boal_area[2])
      end_point = (boal_area[1], boal_area[3])
      cv2.rectangle(image, start_point, end_point, (255, 0, 0), 3)

      distance = 168.596 / (boal_area[3] - boal_area[2]) 

      cv2.putText(image, str(distance), (boal_area[0], boal_area[2]), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 3, cv2.LINE_AA)

    elif df.at[i, 'name'] == 'soccer-goal':
      goal_area = get_coordinte(df, i)
                         
      distance = 1820.24 / (goal_area[3] - goal_area[2]) 

      cv2.putText(image, str(distance), (goal_area[0], goal_area[2]), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 3, cv2.LINE_AA)
    
    elif df.at[i, 'name'] == 'horn':
      horn_area = get_coordinte(df, i)

      horn_points.append(horn_area)
  
  rate = (goal_area[3] - goal_area[2]) / (boal_area[1] - boal_area[0])
  rate_string = "rate:" + str(rate)
  print(rate_string)
  cv2.putText(image, rate_string, (goal_area[0] - 50, goal_area[2] - 50), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 3, cv2.LINE_AA)

  if goal_area:
    goal_upper_left  = [goal_area[0], goal_area[2]]
    goal_upper_right = [goal_area[1], goal_area[2]]
    goal_down_left   = [goal_area[0], goal_area[3]]
    goal_down_right  = [goal_area[1], goal_area[3]]

    goal_points = [goal_upper_left, goal_upper_right, goal_down_left, goal_down_right]

    check_point = []


    for horn_point in horn_points:
      if in_goal_area(horn_point, goal_area):
        cv2.circle(image, find_center(horn_point), 10, (255, 255), 10)
        i = find_closest_point(find_center(horn_point), goal_points)
        if i == 0:
          upper_left = find_center(horn_point)
          goal_upper_left_x.append(upper_left[0])
          goal_upper_left_y.append(upper_left[1])
          check_point.append(0)
        if i == 1:
          upper_right = find_center(horn_point)
          goal_upper_right_x.append(upper_right[0])
          goal_upper_right_y.append(upper_right[1])
          check_point.append(1)
        if i == 2:
          down_left = find_center(horn_point)
          goal_down_left_x.append(down_left[0])
          goal_down_left_y.append(down_left[1])
          check_point.append(2)
        if i == 3:
          down_right = find_center(horn_point)
          goal_down_right_x.append(down_right[0])
          goal_down_right_y.append(down_right[1])
          check_point.append(3)

    if 0 not in check_point:
      if goal_upper_left_x:
        upper_left = [int(np.mean(goal_upper_left_x)), int(np.mean(goal_upper_left_y))]
      else:
        upper_left = goal_upper_left
    if 1 not in check_point:
      if goal_upper_right_x:
        upper_right = [int(np.mean(goal_upper_right_x)), int(np.mean(goal_upper_right_y))]
      else:
        upper_right = goal_upper_right
    if 2 not in check_point:
      if goal_down_left_x:
        down_left = [int(np.mean(goal_down_left_x)), int(np.mean(goal_down_left_y))]
      else:
        down_left = goal_down_left
    if 3 not in check_point:
      if goal_down_right_x:
        down_right = [int(np.mean(goal_down_right_x)), int(np.mean(goal_down_right_y))]
      else:
        down_right = goal_down_right
            
    cv2.line(image, upper_left, upper_right, (0, 0, 255), 5)
    cv2.line(image, upper_right, down_right, (0, 0, 255), 5)
    cv2.line(image, down_right, down_left, (0, 0, 255), 5)
    cv2.line(image, down_left, upper_left, (0, 0, 255), 5)

    hor_up = split_line(upper_left, upper_right, 4)
    hor_down = split_line(down_left, down_right, 4)
    straight_left = split_line(upper_left, down_left, 3)
    straight_right = split_line(upper_right, down_right, 3)

    for x in range(3):
      cv2.line(image, hor_up[x], hor_down[x], (0, 0, 255), 5)
    
    for y in range(2):
      cv2.line(image, straight_left[y], straight_right[y], (0, 0, 255), 5)
    
    if rate > 10 and not shoot_in:
      result_img = create_white_image(frame_height, frame_width)

      cv2.line(result_img, upper_left, upper_right, (0, 0, 255), 5)
      cv2.line(result_img, upper_right, down_right, (0, 0, 255), 5)
      cv2.line(result_img, down_right, down_left, (0, 0, 255), 5)
      cv2.line(result_img, down_left, upper_left, (0, 0, 255), 5)

      for x in range(3):
        cv2.line(result_img, hor_up[x], hor_down[x], (0, 0, 255), 5)
    
      for y in range(2):
        cv2.line(result_img, straight_left[y], straight_right[y], (0, 0, 255), 5)
      
      cv2.rectangle(result_img, (boal_area[0], boal_area[2]), (boal_area[1], boal_area[3]), (255, 0, 0), 3)

      cv2.imwrite('result_img.jpg', result_img)

  videowrite.write(image)
    
cap.release()
videowrite.release()