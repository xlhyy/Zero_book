# 算法

```
时间复杂度和空间复杂度如何计算
```

- 二分法查找

```
二分法查找适用于数据量较大时，但是数据需要先排好顺序。
```

```
# coding=utf-8

def bin_search(listx,element):
    '''二分法查找'''
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
按照序列原有顺序对数组进行遍历比较查询的基本查找算法。
```

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
重复地走访过要排序的元素列表，依次比较两个相邻的元素，如果他们的顺序错误就把他们交换过来。
```

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
将列表分为有序区和无序区，最开始的有序区只有一个元素，每次从无序区选择一个元素按大小插到有序区中。
左边第一个元素在初始的时候算是有序区，后来的元素要与有序区的元素比较，然后放到合适的位置。
```

```
# coding=utf-8

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
基本思想:
    第一趟，在待排序记录r1~r[n]中选出最小的记录，将它与r1交换；
    第二趟，在待排序记录r2~r[n]中选出最小的记录，将它与r2交换；
    以此类推，最终使有序序列增长直到全部排序完毕。
```

```
# coding=utf-8

def direct_select_sort(listx):
    '''直接选择排序'''
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
(1)首先设定一个分界值，通过该分界值将数组分成左右两部分。
(2)将大于或等于分界值的数据集中到数组右边，小于分界值的数据集中到数组的左边。此时，左边部分中各元素都小于或等于分界值，而右边部分中各元素都大于或等于分界值。
(3)然后，左边和右边的数据可以独立排序。对于左侧的数组数据，又可以取一个分界值，将该部分数据分成左右两部分，同样在左边放置较小值，右边放置较大值。右侧的数组数据也可以做类似处理。
(4)重复上述过程，可以看出，这是一个递归定义。通过递归将左侧部分排好序后，再递归排好右侧部分的顺序。当左、右两个部分各数据排序完成后，整个数组的排序也就完成了。
```

```
# coding=utf-8

def quicksort(a, left, right):
    '''
    快速排序
    '''
    
    if left>right:
        return -1
    temp=a[left]
    i=left
    j=right
    while i!=j:
        while a[j]>=temp and i<j:
            j-=1
        while a[i]<=temp and i<j:
            i+=1
        if i<j:
            a[i],a[j]=a[j],a[i]
    a[left]=a[i]
    a[i]=temp    
    quicksort(a,left,i-1)
    quicksort(a,i+1,right)


a=[4, 2, 7,8, 0, 1, 5,23]
quicksort(a,0,len(a)-1)
print(a)
```
