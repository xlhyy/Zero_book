# coding=utf-8

# ---------------------导包-------------------
import sys
import pygame
import time
import random
from pygame.locals import *

# --------------------定义打印文本函数---------------
def print_text(font, x, y, text, color=(255,255,255)):
    imgText = font.render(text, True, color)
    screen.blit(imgText, (x,y))

# --------------------初始化---------------------
pygame.init()
screen = pygame.display.set_mode((600,500))
pygame.display.set_caption('Type Speed Test')
font1 = pygame.font.Font(None, 24)
font2 = pygame.font.Font(None, 200)
white = 255, 255, 255
yellow = 255, 255, 0
color = 125, 100, 210

key_flag = False
correct_answer = 97
seconds = 10
score = 10
clock_start = 0
game_over = True

# ---------------------轮询开始-------------------
while True:
    for event in pygame.event.get():
        if event.type == QUIT:
            pygame.quit()
            sys.exit()
        elif event.type == KEYDOWN:
            key_flag = True
        elif event.type == KEYUP:
            key_flag = False

    keys = pygame.key.get_pressed()
    if keys[K_ESCAPE]:
        sys.exit()

    if keys[K_RETURN]:
        if game_over:
            game_over = False
            score = 0
            seconds = 11
            clock_start = time.clock()

    current = time.clock() - clock_start
    speed = score * 6

    if seconds-current < 0:
        game_over = True
    elif current <= 10:
        if keys[correct_answer]:
            correct_answer = random.randint(97,122)
            score += 1

    # 清屏
    screen.fill(color)

    print_text(font1,0,20,"Try to keep up for 10 seconds ...")
    
    if key_flag:
        print_text(font1,450,0,'you are keying ...')
    
    if not game_over:
        print_text(font1,0,80,'Time: ' + str(int(seconds-current)))
    
    print_text(font1,0,100,'Speed: ' + str(speed) + ' letters/min')

    if game_over:
        print_text(font1,0,160,'Press Enter to start ...')

    print_text(font2,0,240,chr(correct_answer-32), yellow)

    # 更新
    pygame.display.update()


