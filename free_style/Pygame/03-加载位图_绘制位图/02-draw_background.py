# coding=utf-8

# -------------------导包--------------------
import sys, random, math, pygame
from pygame.locals import *

# -------------------初始化------------------
pygame.init()
screen = pygame.display.set_mode((800,600))
pygame.display.set_caption('星空')
font = pygame.font.Font(None,18)

# 加载图片
space = pygame.image.load('254.png').convert_alpha()\
# 改变图片大小
width,height = space.get_size()
space = pygame.transform.smoothscale(space, (int(width//1.5),int(height//1.5)))

# ------------------开始轮询-----------------
while True:
    for event in pygame.event.get():
        if event.type == QUIT:
            pygame.quit()
            sys.exit()
        
        keys = pygame.key.get_pressed()
        if keys[K_ESCAPE]:
            sys.exit()
            
        screen.blit(space, (0,0))

        pygame.display.update()


