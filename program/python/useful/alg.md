### 算法

- 二分法查找
```
# coding=utf-8

def bin_search(listx,element):
    '二分法查找(要求参数listx是有序序列)'
    low = 0
    high = len(listx) - 1
    while low <= high:
        mid = (low+high) // 2
        if element == listx[mid]:
            print('list[{0}]={1}'.format(mid,element))
            return
        elif element > listx[mid]:
            low = mid + 1
        else:
            high = mid -1
    return 'not found'

if __name__ == '__main__':
    listx = [1,2,3,4,5,6,7,8,9]
    element = 7
    bin_search(listx,element)
```


- 顺序查找
```
# coding=utf-8

def order_search(listx,element):
    '''顺序查找'''
    for i in range(len(listx)):
        if listx[i] == element:
            print('listx[{0}]={1}'.format(i,element))
            return
    print('not found')

if __name__ == '__main__':
    listx = [3,1,2,4,6,5,8,9,7]
    element = 7
    order_search(listx,element)
```


- 冒泡排序
```
# coding=utf-8

def bubble_sort(listx):
    '''冒泡排序'''
    high = len(listx) - 1
    while high > 0:
        for i in range(0, high):
            if listx[i] > listx[i+1]:
                listx[i], listx[i+1] = listx[i+1], listx[i]
            high -= 1
    return listx

if __name__ == '__main__':
    listx = [2,41,5,8,22,11,47,89,65,66]
    result = bubble_sort(listx)
    print result
```


- 插入排序
```
# coding=utf-8

# 插入排序: 将列表分为有序区和无序区，最开始的有序区只有一个元素，每次从无序区选择一个元素按大小插到有序区中
# 左边第一个元素在初始的时候算是有序区，后来的元素要与有序区的元素比较，然后放到合适的位置

def insert_sort(listx):
    '''插入排序'''
    count = len(listx)
    for i in range(1,count):
        temp = listx[i]
        j = i - 1
        while j >= 0:
            if listx[j] > temp:
                listx[j+1] = listx[j]
                listx[j] = temp
            j -= 1
    return listx

if __name__ == '__main__':
    listx = [213,123,12,56,77,84,3,5]
    result = insert_sort(listx)
    print result
```


- 直接选择排序
```
# coding=utf-8

def direct_select_sort(listx):
    '''
    直接选择排序 基本思想:
        第一趟，在待排序记录r1~r[n]中选出最小的记录，将它与r1交换；
        第二趟，在待排序记录r2~r[n]中选出最小的记录，将它与r2交换；
        以此类推...，最终使有序序列增长直到全部排序完毕。
    '''
    count = len(listx)
    for i in range(0, count):
        min_index = i
        for j in range(i+1, count):
            if listx[min_index] > listx[j]:
                min_index = j
            listx[min_index], listx[i] = listx[i], listx[min_index]
        return listx

if __name__ == '__main__':
    listx = [2,1,4,3,7,6,8,9]
    result = direct_select_sort(listx)
    print result
```


- 快速排序
```
# coding=utf-8

def quick_sort(listx,left,right):
    '''
    快速排序:
        通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列。
    '''
    if left >= right:
        return listx
    temp = listx[left]
    low = left
    high = right
    while left < right:
        while left < right and listx[right] >= temp: # 当右边值较大时，值不动
            right -= 1
        listx[left] = listx[right] # 否则移动到左边
        while left < right and listx[left] <= temp:
            left += 1
        listx[right] = listx[left]
    listx[right] = temp
    quick_sort(listx,low,left-1)
    quick_sort(listx,left+1,high)
    return listx

if __name__ == '__main__':
    listx = [3,1,5,6,7,2,0,9,5]
    left = 0
    right = len(listx)-1
    result = quick_sort(listx,left,right)
    print result
```
