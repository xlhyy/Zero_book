============================================
1. 为什么使用集合框架?
如果并不知道程序运行时会需要多少对象，或者需要更复杂方式存储对象时，可以使用Java集合框架。


﻿============================================
2. Java集合框架包含的内容
Java集合框架提供了一套性能优良，使用方便的接口和类，它们位于java.util包中。

Collection(List(ArrayList, LinkedList), Set(HashSet, TreeSet))
Map(HashMap, TreeMap)

1) 接口--Collection, List, Set, Map。
Collection接口存储一组不唯一，无序的对象。
List接口存储一组不唯一，有序(插入顺序)的对象。
Set接口存储一组唯一，无序的对象。
Map接口存储一组键值对象，提供key到value的映射。

2) 具体类--ArrayList, LinkedList, HashSet, TreeSet, HashMap, TreeMap。
ArrayList实现了长度可变的数组，在内存中分配连续的空间。遍历元素和随机访问元素的效率比较高。
LinkedList采用链表存储方式。插入，删除元素时效率比较高。

例1: ArrayList类
List dogs = new ArrayList();
dogs.add(ououDog);
dogs.add(yayaDog);
dogs.add(meimeiDog);
dogs.add(2,feifeiDog);  //添加feifeiDog到指定位置
System.out.println("共计有"+dogs.size()+"条狗狗");
System.out.println("分别是: ");
for(int i=0; i<dogs.size(); i++){
    Dog dog = (Dog)dogs.get(i);
    ...
}

注1: ArrayList类的特殊方法
-------------------------------------------------------------------
方法名				说 明
-------------------------------------------------------------------
boolean add(Object o)		在列表的末尾顺序添加元素,起始索引位置从0开始
-------------------------------------------------------------------
void add(int index,Object o)	在指定的索引位置添加元素。索引位置必须介于 0 和列表中元素个数之间
-------------------------------------------------------------------
int size() 			返回列表中的元素个数
-------------------------------------------------------------------
Object get(int index) 		返回指定索引位置处的元素。取出的元素是Object类型,使用前需要进行强制类型转换
-------------------------------------------------------------------
boolean contains(Object o)	判断列表中是否存在指定元素
-------------------------------------------------------------------
boolean remove(Object o)	从列表中删除元素
-------------------------------------------------------------------
Object remove(int index)	从列表中删除指定位置元素,起始索引位置从 0 开始
-------------------------------------------------------------------

例2: LinkedList类
LinkedList dogs = new LinkedList();
dogs.add(ououDog);
dogs.add(yayaDog);
dogs.addLast(meimeiDog);
dogs.addFirst(feifeiDog);

Dog dogFirst=(Dog)dogs.getFirst();
System.out.println("第一条狗狗的昵称是"+dogFirst.getName());

Dog dogLast=(Dog)dogs.getLast();
System.out.println("最后一条狗狗的昵称是"+dogLast.getName());

dogs.removeFirst();
dogs.removeLast();

注2: LinkedList类的特殊方法
--------------------------------------------------------
方法名				说 明
--------------------------------------------------------
void add(Object o) 
--------------------------------------------------------
void addFirst(Object o) 	在列表的首部添加元素
--------------------------------------------------------
void addLast(Object o) 		在列表的末尾添加元素
--------------------------------------------------------
Object getFirst() 		返回列表中的第一个元素
--------------------------------------------------------
Object getLast() 		返回列表中的最后一个元素
--------------------------------------------------------
Object removeFirst() 		删除并返回列表中的第一个元素
--------------------------------------------------------
Object removeLast() 		删除并返回列表中的最后一个元素
--------------------------------------------------------


例3: HashMap类
Map countries = new HashMap();
countries.put("CN","中华人民共和国");
countries.put("RU","俄罗斯联邦");
countries.put("FR", " 法兰西共和国 ");
countries.put("US", " 美利坚合众国 ");

String country = (String) countries.get("CN");
...
System.out.println("Map中共有"+countries.size() +"组数
据");

countries.remove("FR");
System.out.println("Map中包含FR的key吗?"+countries.containsKey("FR"));

System.out.println(countries.keySet());
System.out.println(countries.values());
System.out.println(countries);

注3: HashMap类常用方法
-------------------------------------------------------------
方法名					说 明
-------------------------------------------------------------
Object put(Object key, Object val) 	以“键-值对”的方式进行存储
-------------------------------------------------------------
Object get(Object key) 	根		据键返回相关联的值,如果不存在指定的键,返回null
-------------------------------------------------------------
Object remove(Object key) 		删除由指定的键映射的“键-值对”
-------------------------------------------------------------
int size() 				返回元素个数
-------------------------------------------------------------
Set keySet() 				返回键的集合
-------------------------------------------------------------
Collection values() 			返回值的集合
-------------------------------------------------------------
boolean containsKey(Object key) 	如果存在由指定的键映射的“键-值对”,返回true
-------------------------------------------------------------
boolean containsValue(value) 		判断集合中是否存在值 value
-------------------------------------------------------------
boolean isEmpty()			判断集合中是否有存在元素
-------------------------------------------------------------
void clear()				清除集合中所有元素
-------------------------------------------------------------

3) 算法--Collections。	18页
Collections和Collection不同,前者是集合的操作类,后者是集合接口。

注: Collections提供的静态方法:
sort(): 排序
binarySearch(): 查找
fill(): 替换

例: Collections.sort(list);

﻿============================================
3. 集合类对比
1) Vector和ArrayList的异同:
实现原理，功能相同，可以互用。
主要区别:
Vector线程安全,ArrayList重速度轻安全,线程非安全。
长度需增长时,Vector默认增长一倍,ArrayList增长50%。

2) Hashtable和HashMap的异同:
实现原理，功能相同，可以互用。
主要区别:
Hashtable继承Dictionary类,HashMap实现Map接口。
Hashtable线程安全,HashMap线程非安全。
Hashtable不允许null值,HashMap允许null值。

注: 开发过程中，最好使用ArrayList和HashMap。


﻿============================================
4. 迭代器Iterator

1) 如何遍历Map集合呢?
方法1: 通过迭代器Iterator实现遍历
获取Iterator: Collection接口的iterator()方法。
Iterator的方法：
boolean hasNext(): 判断是否存在另一个可访问的元素。
Object next(): 返回要访问的下一个元素。

方法2: 增强型for循环

例1:
Set keys = dogMap.keySet();  //取出所有key的集合
Iterator it = keys.iterator();  //获取Iterator对象
while(it.hasNext()){
    String key = (String)it.next();  //取出key
    Dog dog = (Dog)dogMap.get(key);  //根据key取出对应的值
    System.out.println(key + "\t" + dog.getStrain());
}

例2:
for(元素类型t 元素变量x:数组或集合对象){
    引用了x的java语句
}

注: 两者同样可以遍历其他集合类，通常使用增强型for循环。


﻿============================================
5. 泛型集合
(
顾名思义，泛型就是不指定类型，集合中可以放各种类型的数据；
而传统集合必须首先指定集合类型，比如int型集合只能放int，str集合只能放str；
泛型比较方便，而传统的更加严谨。
)

常用定义泛型集合:
1) List<T> list = new ArrayList<T>();
(存储类型必须是T类型，可以用Object,来使用这样就可以存储所有类型对象，拿出来时需要强制转型)

2) Map<K,V> map = new HashMap<K,V>();
(K是键值(Key)，V是值(Values)，可以通过map.put()来添加成员，通过String str = map.get(键值);来获取键值相应的值)

例1: Map实例
//Map的基础使用
import java.util.HashMap;
import java.util.Map;

public class MapTest {
	public static void main(String[] args) {
		String[] names = { "花儿", "小花", "喊我" };
		String[] ifo = { "小女孩", "小狗", "大班", "年轻人" };
		Map<String, String> map = new HashMap<String, String>();
		for (int i = 0; i < names.length; i++) {
			map.put(names[i], ifo[i]);
		}
		String ifoString = map.get("小花");
		System.out.println(ifoString);
	}
}

例2: List实例
//List基础使用
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

public class ListTest {
	static Pet cat2;
	static List<Pet> pets;
	public static void main(String[] args) {
		pets = new ArrayList<Pet>();
		Pet cat1 = new Pet("小猫", "猫");
		cat2 = new Pet("大猫", "猫");
		Pet cat3 = new Pet("老猫", "猫");
		Dog dog1 = new Dog("小黄", "我饿了");
		Dog dog2 = new Dog("小白", "我饿了");
		Dog dog3 = new Dog("小金", "我饿了");
		pets.add(cat1);
		pets.add(cat2);
		pets.add(cat3);
		ArrayList<Object> list = new ArrayList<Object>();
		list.add(cat1);
		list.add(dog1);
		list.add(dog2);
		list.add(cat2);
		list.add(cat3);
		list.add(dog3);
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i) instanceof Pet) {
				Pet p1 = (Pet) list.get(i);
				System.out.println(p1.name + ":" + p1.type);
			} else {
				Dog dog = (Dog) list.get(i);
				System.out.println(dog.name + ":" + dog.say);
			}
		}
		for (Pet p : pets) {
			if (p.name.equals("大猫")) {
				System.out.println(p.name + ":" + p.type);
			}
		}
		search(pets);
		Iterator<Pet> iterator = pets.iterator();
		while (iterator.hasNext()) {
			Pet pet = (Pet) iterator.next();
			System.out.println(pet.name + "::" + pet.type);
		}

	}

	public static <T> void search(T t) {
		Vector<Pet> vPets = new Vector<>();
		vPets.addAll(pets);
		if (vPets.contains(cat2)) {
			System.out.println("存在cat2");
		}
		System.out.println(vPets);
	}
}


补充: 除泛型集合外，泛型的其他应用
1) 泛型接口
语法:
public interface 接口名 <类型形参>{
	方法名(类型形参 类型形参实例);
}
例:
public interface TestInterface<T>{
	public T print(T x);
}
注: 不具体指定数据类型，由使用此接口的用户决定数据类型。

2) 泛型类
语法:
public class 类名 <类型形参>{
	方法名(类型形参 类型形参实例){
		方法执行体
	}
}
例:
public class Student<T>{
	public T print(T x){
		//方法体	
	}
}
注: 不具体指定数据类型，由使用此接口的用户决定数据类型。

3) 泛型方法
语法:
修饰符 <类型形参> 返回值 方法名(不指定|整数形参|正常参数,...){
	方法体
}
例:
public <T> void fromArrayToList(T[] t, List<T> list){
	//执行方法
}
注: 不指定具体的返回类型或者参数，由使用此方法的用户决定。

4) 多参数泛型类
语法: HashMap<K, V> 属于多个参数的泛型类
例:
class GenericDemo<T, V>{
	private T a;
	private V b;
	public GenericDemo(T a, V b){
		this.a = a;
		this.b = b;
	}
	public void showType(){
		System.out.println("a的类型是"+a.getClass().getName());
		System.out.println("b的类型是"+b.getClass().getName());
	}
}

5) 泛型类的继承
面向对象的特性同样适用于泛型类，所以泛型类也可以被继承。
继承了泛型类的子类，必须也是泛型类。
语法:
class 子类 <T> extends 父类 <T>
{}

﻿============================================
6. 总结
1) Collection, List, Set, Map接口的联系和区别:
简单的说一下, Collection 是一个较高的抽象，List, Set 和 Map都是Collection的子接口。
List的特征： 允许重复元素，存储顺序与插入元素顺序一致
Set 特征： 不允许重复元素(和数学中的集合一样)，不保证元素存储顺序
Map: 存储元素是一系列 Key => Value (键=>值)

2) ArrayList和LinkedList的异同之处及各自的应用场合:
    ArrayList是由数组后推得到的；而LindedLsit是由常规的双向链表实现的，每个元素都包含了数据和指向前后元素的句柄。
    假如想在一个列表中进行大量的插入和删除操作，那么LindedList无疑是最恰当的选择；如果是想频繁的遍历链表，那么ArrayList的速度要快上很多。
(
补充:
---------------------------------------
1. Vector与ArrayList的区别:
1) Vector的方法都是同步的(Synchronized),是线程安全的(thread-safe)，而ArrayList的方法不是，由于线程的同步必然要影响性能，因此，ArrayList的性能比Vector好。 
2) 当Vector或ArrayList中的元素超过它的初始大小时,Vector会将它的容量翻倍,而ArrayList只增加50%的大小，这样,ArrayList就有利于节约内存空间。
---------------------------------------
2. Hashtable与HashMap的区别: 
Hashtable和HashMap它们的性能方面的比较类似Vector和ArrayList。
)

3) List集合使用泛型与不使用泛型有什么区别?
    从list中取出的值不一样，第一种的话取出来是object类型的，需要强制类型转换；而第二个不用，取出来之后直接就是string类型的。
    泛型比较方便，而传统的更加严谨。


