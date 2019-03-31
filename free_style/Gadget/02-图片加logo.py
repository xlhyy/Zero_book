# coding=utf-8

from PIL import Image

# 需要加水印的图片
img = Image.open('f:1.jpg')

# 水印图片
logo = Image.open('f:2.jpg')

# 图层
layer = Image.new('RGBA', img.size, (255, 255, 255, 0))
layer.paste(logo, (img.size[0] - logo.size[0], img.size[1] - logo.size[1]))

# 覆盖
img_after = Image.composite(layer, img, layer)
img_after.show()
img_after.save('target.jpg')

