import numpy as np

n = 100000
print(np.sum(4.0 / np.r_[1:n:4, -3:-n:-4]))
g = lambda x: x + 1
