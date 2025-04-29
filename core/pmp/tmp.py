def func(base, size_i):
    i = 29
    print("00", end='')
    while (i >= 0):
        if (i + 3 > size_i) :
            print(base[i+2], end='')
        elif (i + 3 == size_i) :
            print(0, end='')
        else:
            print(1, end='')
        i -= 1

base1 = 16*[0] + [0,0,0,1,1,0,0,1,0,0,0,0,0,0,0,0]
size1 = 8
base2 = 16*[0] + [0,0,0,1,1,0,0,1,1,0,1,1,0,0,0,0]
size2 = 4
base3 = 16*[0] + [0,0,0,1,1,0,0,1,1,0,1,1,1,0,0,0]
size3 = 3

func(base1, size1)
print()
func(base2, size2)
print()
func(base3, size3)
print()

00000000001001100000000000011111
00000011011001100000000000000001
00000111011001100000000000000000
