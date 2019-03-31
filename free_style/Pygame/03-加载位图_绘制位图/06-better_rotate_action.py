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
space = pygame.image.load('254.png').convert_alpha()
# 改变图片大小
width,height = space.get_size()
space = pygame.transform.smoothscale(space, (int(width//1.5),int(height//1.5)))

earth = pygame.image.load('work_day.png').convert_alpha()
width,height = earth.get_size()
earth = pygame.transform.smoothscale(earth, (int(width//2.5),int(height//2.5)))

superman = pygame.image.load('work_day.png').convert_alpha()
width,height = superman.get_size()
superman = pygame.transform.smoothscale(superman, (int(width//5),int(height//5)))

# ------------------函数---------------------
# ----1) 角度
def wrap_angle(angle):
    return angle % 360

# ----2) 位置
class Point(object):
    def __init__(self, x, y):
        self.__x = x
        self.__y = y

    # X property
    def getx(self):
        return self.__x
    def setx(self, x):
        self.__x = x
    x = property(getx, setx)

    # Y property
    def gety(self):
        return self.__y
    def sety(self, y):
        self.__y = y
    y = property(gety, sety)

radius = 250
angle = 0.0
pos = Point(0,0)
old_pos = Point(0,0)

# ------------------开始轮询-----------------

while True:
    for event in pygame.event.get():
        if event.type == QUIT:
            pygame.quit()
            sys.exit()
        
        keys = pygame.key.get_pressed()
        if keys[K_ESCAPE]:
            sys.exit()
        
    angle = wrap_angle(angle - 0.1)
    pos.x = math.sin(math.radians(angle))*radius
    pos.y = math.cos(math.radians(angle))*radius

    screen.blit(space, (0,0))

    width,height = earth.get_size()
    screen.blit(earth, (400-width/2,300-height/2))

    # -----------------------
    '''
    1) 运用math.atan2()这个函数，它用于计算反正切函数，需要传递两个参数:delta_x,delta_y。
    delta_x,delta_y分别表示与两个坐标轴x，y之间的距离。
    2) 运用pygame.transform.rotate()，旋转位图。需要传两个参数:图像，旋转角度。
    '''
    # delta_x = (pos.x - old_pos.x)
    delta_x = pos.x
    # delta_y = (pos.y - old_pos.y)
    delta_y = pos.y
    rangle = math.atan2(delta_y, delta_x)
    rangled = wrap_angle(-math.degrees(rangle))
    superman_rotate = pygame.transform.rotate(superman,rangled)
    # -----------------------

    width,height = superman.get_size()
    # screen.blit(superman, (400+pos.x-width//2,300+pos.y-height//2))
    # -----------------------
    screen.blit(superman_rotate, (400+pos.x-width//2,300+pos.y-height//2))
    # -----------------------

    pygame.display.update()

    old_pos.x = pos.x
    old_pos.y = pos.y


