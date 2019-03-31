# coding=utf-8

# -----------------初始化部分--------------

# 导包
import pygame
import sys
# 引入pygame中的所有常量
from pygame.locals import *

# 初始化
pygame.init()
# 创建窗口
screen = pygame.display.set_mode((600,500))
# 设置窗口标题
pygame.display.set_caption('author-li')

'''
# -----------------功能1:打印字体------------------
# 创建文字对象
myfont = pygame.font.Font(None, 60)

# 将文本当作一个图像来渲染(render函数第一个参数是文本，第二个参数是抗锯齿字体，第三个参数是一个颜色值(RGB值))
white = 255, 255, 255
blue = 0, 0, 200
textImage = myfont.render('Hello Pygame', True, white)

# 使用screen.blit()来绘制textImage对象(要绘制文本，通常的过程是清屏，绘制，刷新)
while True:
    for event in pygame.event.get():
        if event.type in (QUIT, KEYDOWN):
            sys.exit()

    screen.fill(blue)
    screen.blit(textImage, (100,100))
    pygame.display.update()
'''

# --------------------功能2:绘制图形----------------------
'''
# --------1) 圆形
color = 255, 255, 0
position = 300, 250
radius = 100
width = 10

while True:
    for event in pygame.event.get():
        if event.type in (QUIT, KEYDOWN):
            sys.exit()

    screen.fill((0,0,0))
    pygame.draw.circle(screen, color, position, radius, width)
    pygame.display.update()
'''
'''
# ---------2) 会移动的矩形
pos_x = 300
pos_y = 250
vel_x = 2
vel_y = 1

while True:
    for event in pygame.event.get():
        if event.type in (QUIT, KEYDOWN):
            pygame.quit()
            sys.exit()

    screen.fill((0,0,0))
    
    # 移动
    pos_x += vel_x
    pos_y += vel_y

    # 使举行保持在窗口内
    if pos_x > 500 or pos_x < 0:
        vel_x = -vel_x
    if pos_y > 400 or pos_y < 0:
        vel_y = -vel_y

    # 绘制矩形
    color = 255,255,0
    width = 0  # solid fill
    pos = pos_x, pos_y, 100, 100
    pygame.draw.rect(screen, color, pos, width)
    
    pygame.display.update()
'''
'''
# -------3) 线条
color = 255, 255, 0
width = 8
while True:
    for event in pygame.event.get():
        if event.type in (QUIT, KEYDOWN):
            pygame.quit()
            sys.exit()

    screen.fill((0,0,0))
    pygame.draw.line(screen,color,(100,100),(500,400),width)
    pygame.display.update()
'''

# ---------4) 弧形
import math

while True:
    for event in pygame.event.get():
        if event.type in (QUIT, KEYDOWN):
            pygame.quit()
            sys.exit()

    screen.fill((0,0,0))
    
    # 绘制弧形的代码
    color = 255,0,255
    position = 200,150,200,200
    start_angle = math.radians(0)
    end_angle = math.radians(180)
    width = 8
    pygame.draw.arc(screen,color,position,start_angle,end_angle,width)

    pygame.display.update()



