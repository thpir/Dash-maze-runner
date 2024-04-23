from ultralytics import YOLO

# Load model
model = YOLO('yolov8n.pt')

# Train the model
results = model.train(data='/Users/thijspirmez/Documents/Prive/Thpir/Dash Maze Runner/computer_vision_part/dataset/data_config.yaml', epochs=300, imgsz=640)