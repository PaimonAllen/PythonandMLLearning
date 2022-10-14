def change(a):
    print(id(a))
    a=10
    print(id(a))

a=1
print(id(a))
change(a)