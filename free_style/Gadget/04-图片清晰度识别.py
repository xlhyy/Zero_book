# coding=utf-8

import cv2

"""
    import cv2使用了图像处理库OpenCV，需要注意的是OpenCV依赖于numpy。
    pip install opencv-python
"""

"""
    局限性:
        1.阈值不容易设定，阈值太低会导致正常图片被误断为模糊图片；阈值太高会导致模糊图片被误判为正常图片。
        2.背景模糊或虚化的图片可能被误杀。
"""

def getImageVar(imgPath):
    image = cv2.imread(imgPath)  # 使用OpenCV提供的方法读取图片
    img2gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)  # 转化为灰度图
    imageVar = cv2.Laplacian(img2gray, cv2.CV_64F).var()  # 对图片用3*3拉普拉斯算子做卷积，这里的cv2.CV_64F就是拉普拉斯算子

    return imageVar

print getImageVar('image/sharpness_test1.jpeg')


