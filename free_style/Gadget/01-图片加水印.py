from PIL import Image, ImageDraw, ImageFont

image = Image.open("f:1.jpg") # 图片文件
text = "日常学python"

# 指定要使用的字体和大小
font = ImageFont.truetype('C:\Windows\Fonts\simhei.ttf', 100) # 字体及大小
layer = image.convert('RGBA') # 将图像转为RGBA图像

# 生成同等大小的图片
text_overlay = Image.new('RGBA', layer.size, (255, 255, 255, 0))
image_draw = ImageDraw.Draw(text_overlay) # 画图

# 获取文本大小
text_size_x, text_size_y = image_draw.textsize(text, font=font)

# 设置文本文字位置
text_xy = (layer.size[0] - text_size_x, layer.size[1] - text_size_y)

# 设置文本颜色和透明度和位置
image_draw.text(text_xy, text, font=font, fill=(255, 255, 255, 50))

# 将新生成的图片覆盖到需要加水印的图片上
after = Image.alpha_composite(layer, text_overlay)
after.save('im_after.png')
