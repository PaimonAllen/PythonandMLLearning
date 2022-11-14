import os
import sys

# 获取当前代码文件绝对路径
# current_dir = os.path.dirname(os.path.abspath("__file__"))
# 将需要导入模块代码文件相对于当前文件目录的绝对路径加入到sys.path中
# sys.path.append(os.path.join(current_dir, ".."))
# from utils.tools import tools

# tools.print_msg("hello world")

from VGGmodel import *

print("ok")
print(VGG)
