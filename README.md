# Real-Time Face Recognition Attendance System Using CNN (MATLAB)

## Overview

This project implements a **real-time face recognition–based attendance system** using a **Convolutional Neural Network (CNN)** in MATLAB. The system captures faces using a webcam, detects and preprocesses facial images, and identifies registered students using a trained CNN model. Once recognized, the system automatically logs attendance and generates attendance reports.

The project demonstrates the practical integration of **computer vision, deep learning, and GUI development** to automate attendance management.

---

## Key Features

* Student registration with automatic webcam image capture
* Face detection using Haar Cascade classifier
* Image preprocessing (grayscale conversion and resizing)
* CNN-based face recognition
* Confidence-based recognition system
* Real-time attendance marking
* Prevention of duplicate attendance entries for the same day
* Storage of unknown faces for later review
* Attendance export to Excel format
* User-friendly GUI built with MATLAB App Designer

---

## Dataset Information

| Parameter                     | Value                             |
| ----------------------------- | --------------------------------- |
| Number of registered students | 4                                 |
| Images captured per student   | 20                                |
| Total training images         | 80                                |
| Image resolution              | 100 × 100 pixels                  |
| Face preprocessing            | Grayscale conversion and resizing |

### Preprocessing Steps

1. Face detection using `vision.CascadeObjectDetector`
2. Convert detected face to grayscale
3. Resize image to **100 × 100 pixels**
4. Store processed images in dataset folders organized by roll number

---

## CNN Training Details

| Parameter             | Value                               |
| --------------------- | ----------------------------------- |
| Network type          | Custom Convolutional Neural Network |
| Epochs                | 40                                  |
| MiniBatchSize         | 8                                   |
| Initial Learning Rate | 0.0005                              |
| Training dataset      | 80 images                           |

---

## Training Performance

| Metric              | Value       |
| ------------------- | ----------- |
| Training accuracy   | ~98%        |
| Validation accuracy | ~66%        |
| Training time       | ~30 seconds |

The difference between training and validation accuracy is mainly due to the **small dataset size**, which is typical for prototype systems.

---

## Recognition System

| Parameter               | Value                                                                                 |
| ----------------------- | ------------------------------------------------------------------------------------- |
| Recognition threshold   | 85% confidence                                                                        |
| Classification function | `classify(net, image)`                                                                |
| Unknown face handling   | Faces below the threshold are labeled **Unknown** and stored in the `unknown/` folder |

---

## System Performance

| Metric                   | Value                  |
| ------------------------ | ---------------------- |
| Recognition accuracy     | ~88%                   |
| Average recognition time | ~0.3 seconds per frame |

The system performs **near real-time recognition**, suitable for small classroom environments.

---

## Project Workflow

Face Capture
↓
Face Detection
↓
Image Preprocessing
↓
CNN Classification
↓
Confidence Verification
↓
Attendance Logging

---

## Project Structure

```
face-recognition-attendance-matlab
│
├── dataset_sample/        # Example dataset structure
│
├── attendance/            # Daily attendance CSV files
│
├── gui/
│   └── AttendanceApp.mlapp
│
├── model/
│   └── cnnModel.mat
│
├── utils/
│   ├── markAttendance.m
│   ├── preprocessFace.m
│   └── validateRoll.m
│
├── registerStudent.m
├── trainCNNModel.m
├── recognizeCNN.m
├── readAndPreprocess.m
│
├── Attendance_Report.xlsx
│
└── README.md
```

---

## Technologies Used

* MATLAB
* Deep Learning Toolbox
* Computer Vision Toolbox
* Image Processing Toolbox
* Convolutional Neural Networks (CNN)
* Haar Cascade Face Detection

---

## Future Improvements

1. Increase dataset size to improve validation accuracy.
2. Implement **liveness detection** to prevent spoofing attacks.
3. Add **face mask detection capability**.
4. Integrate **cloud-based attendance storage**.
5. Develop a **web or mobile interface** for attendance monitoring.

---

## Author

Nitin Vishwakarma
Jabalpur Engineering College

Minor Project — Real-Time Face Recognition and Attendance System Using CNN

