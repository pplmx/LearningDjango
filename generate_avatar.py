from PIL import Image

# 读取图片
guoqi = Image.open("hq.png").convert("RGBA")
touxiang = Image.open("441b991a3fa1e3ddef8c80d73e31bdf.jpg").convert("RGBA")

# 获取国旗的尺寸
x, y = guoqi.size
print(x, y)

# 设置左上角坐标和右下角坐标（截取的微信头像是正方形）
quyu = guoqi.crop((65, 30, y + 15, y - 30))

# 获取头像的尺寸
w, h = touxiang.size
# 将区域尺寸重置为头像的尺寸
quyu = quyu.resize((w, h))
# 透明渐变设置 - 颗粒度
for i in range(w):
    for j in range(h):
        color = quyu.getpixel((i, j))
        alpha = 255 - i // 3
        if alpha < 0:
            alpha = 0
        color = color[:-1] + (alpha,)
        quyu.putpixel((i, j), color)

# 粘贴到头像并保存
touxiang.paste(quyu, (0, 0), quyu)
touxiang.save("National_FLAG1.png")
