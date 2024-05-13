from ultralytics import YOLO

# Load the YOLOv8 model
model = YOLO('./runs/detect/train/weights/best.pt')

# Export the model to Torchscript format
model.export(format='torchscript')
