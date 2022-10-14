# 嵌套列表解析
# Python的列表还可以嵌套。
# 以下实例展示了3X4的矩阵列表：

matrix = [
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12],
]
# 以下实例将3X4的矩阵列表转换为4X3列表：

[[row[i] for row in matrix] for i in range(4)]
transposed = []
for i in range(4):
    transposed.append([row[i] for row in matrix])

print(transposed)
# 另外一种实现方法：

transposed = []
for i in range(4):
    # the following 3 lines implement the nested listcomp
    transposed_row = []
    for row in matrix:
        transposed_row.append(row[i])
        transposed.append(transposed_row)

print(transposed)
