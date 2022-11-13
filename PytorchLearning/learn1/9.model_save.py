# -*- coding: utf-8 -*-

import torch
import torchvision
from torch import nn

vgg16 = torchvision.models.vgg16(pretrained=False)
# 保存方式1,模型结构+模型参数
# torch.save(vgg16, "vgg16_method1.pth")

# 保存方式2，模型参数（官方推荐）
torch.save(vgg16.state_dict(), "vgg16_method12.pth")

# 陷阱
# 即要将模型定义写到load里
# class MyNN(nn.Module):
#     def __init__(self):
#         super(MyNN, self).__init__()
#         self.conv1 = nn.Conv2d(3, 64, kernel_size=3)
#
#     def forward(self, x):
#         x = self.conv1(x)
#         return x
#
# myNN = MyNN()
# torch.save(myNN, "myNN_method1.pth")