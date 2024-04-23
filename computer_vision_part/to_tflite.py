from ultralytics import YOLO

# Load the YOLOv8 model
model = YOLO('./runs/detect/train/weights/best.pt')

# Export the model to TFLite format
# model.export(format='tflite') # creates 'yolov8n_float32.tflite'
model.export(format='tflite', half=True) # creates 'yolov8n_float16.tflite'