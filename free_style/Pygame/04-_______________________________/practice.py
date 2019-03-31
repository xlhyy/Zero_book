# coding=utf-8

# --------------------导包-----------------------
import sys, random, time, pygame
from pygame.locals import *

# --------------------函数-----------------------
def print_text(font, x, y, text, color=(255,255,255)):
    imgText = font.render(text, True, color)
    screen.blit(imgText, (x,y))

# --------------------初始化---------------------
pygame.init()
screen = pygame.display.set_mode((600,500))
pygame.display.set_caption('Zillionaire')
font1 = pygame.font.Font(None, 24)
font2 = pygame.font.Font(None, 18)
font3 = pygame.font.Font(None, 34)

# 设置鼠标光标不可见
pygame.mouse.set_visible(False)

white = 255,255,255
red = 220,50,50
yellow = 230,230,50
black = 0,0,0

pot_img = pygame.image.load('pot.jpg')
width,height = pot_img.get_size()
pot_img = pygame.transform.smoothscale(pot_img, (width//8,height//8))
# ---
coin_img = pygame.image.load('pot.jpg')
width,height = coin_img.get_size()
coin_img = pygame.transform.smoothscale(coin_img, (width//10,height//10))
# ---
boom_img = pygame.image.load('boom.jpg')
boom_img = pygame.transform.smoothscale(boom_img, (width//10,height//10))
# ---
index_img = pygame.image.load('pot.jpg')
index_img = pygame.transform.smoothscale(index_img, (width//3,height//3))

level = 1
life = 10
score = 0
game_over = True

boom_y = -50
coin_y = -50
boom_x = random.randint(50,550)
coin_x = random.randint(50,550)
vel_coin = 0.4
vel_boom = 0.6
coin_width,coin_height = coin_img.get_size()
boom_width,boom_height = boom_img.get_size()
pot_width,pot_height = pot_img.get_size()
pot_top_y = 500-pot_height
pot_y = 500-pot_height

# ---------------------开始轮询-------------------
while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
        elif event.type == MOUSEMOTION:
            mouse_x,mouse_y = event.pos
            move_x,move_y = event.rel
        elif event.type == MOUSEBUTTONUP:
            if game_over:
                game_over = False
                level = 1
                life = 10
                score = 0

    keys = pygame.key.get_pressed()
    if keys[K_ESCAPE]:
        sys.exit()

    screen.fill((0,0,100))

    if game_over:
        screen.blit(index_img,(60,60))
        print_text(font3,200,400,"Clicked to Play!")
    else:
        # 关卡设置
        if score > 300 and score <= 600:
            level = 2
        elif score > 600 and score <= 900:
            level = 3
        elif score > 900 and score <= 1200:
            level = 4
        elif score > 1200 and score <= 1500:
            level = 5
        elif score > 1500:
            level = 6
        
        # 下落速度设置
        if level == 1:
            vel_coin = 0.4
            vel_boom = 0.6
        elif level == 2:
            vel_coin = 0.5
            vel_boom = 0.6
        elif level == 3:
            vel_coin = 0.6
            vel_boom = 0.7
        elif level == 4:
            vel_coin = 0.65
            vel_boom = 0.75
        elif level == 5:
            vel_coin = 0.7
            vel_boom = 0.8
        elif level == 6:
            vel_coin = 0.75
            vel_boom = 0.85

        screen.blit(pot_img,(mouse_x,pot_y))
        screen.blit(coin_img,(coin_x,coin_y))
        screen.blit(boom_img,(boom_x,boom_y))

        # 物体下落
        boom_y += vel_boom
        coin_y += vel_coin

        # 如果没有接住金币
        if coin_y > 500:
            coin_x = random.randint(50,550)
            coin_y = -50
            life -= 1
            if life == 0:
                game_over = True

        # 如果接住了金币
        elif (mouse_x + pot_width) > coin_x+coin_width/2 > mouse_x \
                and coin_y+coin_height > pot_top_y:
            score += 10
            coin_y = -50
            coin_x = random.randint(50,550)

        # 如果接住了炸弹
        elif (mouse_x + pot_width) > boom_x+boom_width/2 > mouse_x \
                and boom_y+boom_height > pot_top_y:
            life -= 1
            boom_y = -50
            boom_x = random.randint(50,550)
            if life == 0:
                game_over = True

    print_text(font1, 0, 0, 'life: '+str(life))
    print_text(font1, 500, 0, 'score: '+str(score))

    pygame.display.update()


