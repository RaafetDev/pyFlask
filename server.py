from flask import Flask, request, jsonify
import pytesseract
from PIL import Image
import cv2
import base64
import numpy as np
from io import BytesIO

app = Flask(__name__)

def process_image(base64_str):
    # Decode the base64 string
    img_data = base64.b64decode(base64_str)
    image = Image.open(BytesIO(img_data)).convert('RGB')
    
    # Convert to numpy array
    image_np = np.array(image)
    
    # Convert to grayscale
    gray = cv2.cvtColor(image_np, cv2.COLOR_BGR2GRAY)
    
    # Apply thresholding
    _, thresh = cv2.threshold(gray, 150, 255, cv2.THRESH_BINARY_INV)
    
    # Perform OCR
    text = pytesseract.image_to_string(thresh, config='--psm 6')
    
    return text.strip()

@app.route('/ocr', methods=['POST'])
def ocr():
    data = request.get_json()
    
    if not data or len(data) != 9:
        return jsonify({"status": False, "error": "Invalid input data"}), 400
    
    results = {}
    for key, base64_str in data.items():
        try:
            text = process_image(base64_str)
            results[key] = text
        except Exception as e:
            results[key] = f"Error: {str(e)}"
    
    response = {"status": True}
    response.update(results)
    
    return jsonify(response)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
