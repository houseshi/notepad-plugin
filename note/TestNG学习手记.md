## 目录
* [注释介绍](#user-content-注解介绍)
* [运行顺序测试](#user-content-运行顺序测试)
* [数据池 @DataProvider](#user-content-数据池-dataprovider)
* [忽略测试](#user-content-忽略测试)
* [依赖测试](#user-content-依赖测试)
* [异常测试](#user-content-异常测试)
* [用例分组](#user-content-用例分组)
* [用例执行顺序](#user-content-用例执行顺序)
* [Case过程监听](#user-content-case过程监听)
* [@parameters  利用testng.xml传递参数](#user-content-@parameters-利用testng.xml传递参数)
* [拓展学习](#user-content-拓展学习)

## 注解介绍
### @BeforeSuite  
在此套件中的所有测试运行之前，将运行带注释的方法。  
### @AfterSuite  
在此套件中的所有测试运行后，将运行带注释的方法。  
### @BeforeTest  
在运行属于<test>标记内的类的任何测试方法之前，将运行带注释的方法。  
### @AfterTest  
在运行了属于<test>标记内的类的所有测试方法之后，将运行带注释的方法。  
### @BeforeClass  
在调用当前类中的第一个测试方法之前，将运行带注释的方法。  
### @AfterClass  
在运行当前类中的所有测试方法之后，将运行带注释的方法。  
### @BeforeMethod  
每次调用@Test方法之前运行，即执行用例之前进行的初始化  
### @AfterMethod  
每次调用@Test方法之后运行  
### @DataProvider  
标志着一个方法，提供数据的一个测试方法。注解的方法必须返回一个Object[] []，其中每个对象[]的测试方法的参数列表中可以分配。  
该@Test 方法，希望从这个DataProvider的接收数据，需要使用一个dataProvider名称等于这个注解的名字。

## 运行顺序测试

```java


    @BeforeSuite
    public void berforSuite() {
        System.out.println("我是 ： berforSuite ");
    }
    @AfterSuite
    public void afterSuite() {
        System.out.println("我是 ： afterSuite");
    }
    @BeforeTest
    public void beforeTest () {
        System.out.println("我是 ： beforeTest");
    }
    @AfterTest
    public void afterTest() {
        System.out.println("我是 ： afterTest");
    }
    @BeforeClass
    public void beforeClass() {
        System.out.println("我是 ： beforeClass");
    }
    @AfterClass
    public void afterClass() {
        System.out.println("我是 ： afterClass");
    }
    @BeforeMethod
    public void beforeMethod() {
        System.out.println("我是 ： beforeMethod");
    }
    @AfterMethod
    public void afterMethod() {
        System.out.println("我是 ： afterMethod");
    }
    @Test
    public void test1(){
        System.out.println("我是 ： test1");
    }
    
    @Test
    public void test2(){
        System.out.println("我是 ： test2" );
    }

/*
 *控制台输出结果：
 */

1. 我是 ： berforSuite 
2. 我是 ： beforeTest
3. 我是 ： beforeClass
4. 我是 ： beforeMethod
5. 我是 ： test1
6. 我是 ： afterMethod
7. 我是 ： beforeMethod
8. 我是 ： test2
9. 我是 ： afterMethod
10. 我是 ： afterClass
11. 我是 ： afterTest
12. 我是 ： afterSuite

```


## 数据池 @DataProvider

```java

    @Test(dataProvider = "testCase")
    public void test2(String name){
        System.out.println("我是 ： "+ name );
    }

    @DataProvider(name = "testCase")
    public Object[] dataProvider() {
        System.out.println("我是 ： dataProvider");
        return new Object[]{"小红"};
    }

/*
 *控制台输出结果：
 */
我是 ： 小红

```

## 忽略测试

```java
    @Test(enabled = false)
    public void test1() {
        System.out.println("ignore");
    }
```

## 依赖测试

```java
    @Test(enabled = false)
    public void test1 () {
        System.out.print("我是 ： test1");
    }
    @Test(dependsOnMethods = {"test1"})
    public void test2() {
        System.out.print("我是 ： test2");
    }

/*
 *运行 test2方法 控制台输出结果：
 */

org.testng.TestNGException: 
com.youlu.demo.TestNG.test2() is depending on method public void com.youlu.demo.TestNG.test1(), which is not annotated with @Test or not included.


/*
 *test1 去除 忽略后 运行 test2 方法 控制台输出结果
 *
 */

我是 ： test1
我是 ： test2


```
## 异常测试

```java

@Test(expectedExceptions = {ReservationException.class, FlightCanceledException.class}

```

## 用例分组 

```java

@Test(groups=”group1”)

@Test(groups = {"group1", "group2", "group3"})

```

``` html
<?xml version="1.0" encoding="UTF-8"?>
<suite name="youlu" parallel="false">
   <test name="youlu" preserve-order="true">
		<!--选择一个组-->
       <groups>
         <run name="group1">
         </run>
       </groups>
   </test>
</suite>

```


## 用例执行顺序

```java

    @Test(priority = 2)
    public void test2() {
        System.out.println("我是 ： test2");

    }

    @Test(priority = 1)
    public void test3() {
        System.out.println("我是 ： test3");

    }

/*
 * 控制台输出结果：
 */

我是 ： test3
我是 ： test2

```

## Case过程监听

*  实现监听

```java

/**
  * 继承 TestListenerAdapter ，并添加 @Listeners 注解
  *
 **/

@Listeners(BaseTest.class)
public class BaseTest extends TestListenerAdapter {
   // …… 其他代码 省略

   /**
     * 监听过程  Case失败进行截图
     * @param tr
     */
    @Override
    public void onTestFailure(ITestResult tr) {
        super.onTestFailure(tr);
        saveScreen(tr.getMethod().getMethodName()+"_"+new SimpleDateFormat("yyyy_MM_dd_HH_mm_ss").format(new Date()));
    }

}


```


*  测试类

```java

public class EducationAuditTest extends BaseTest {

@Test
 public void test() {}

}

```
## @parameters  利用testng.xml传递参数

```html
<suite name="Parameters">
　　<parameter name="xml-file" value="testNG.xml" />
　　<parameter name="host" value="192.168.10.62" />
 
　　<test name="ParameterTest">
　　　　<parameter name="hostname" value="www.xxx.com" />
　　　　...
　　</test>
　　...
</suite>
```

```java
@Test(parameters = {"xml-file"})
public void validateFile(String xmlFile)
{
　　// xmlFile value "testNG.xml"
}

```


## 拓展学习

* TestNG官方文档推荐一个入门级别的TestNG视频教程：http://www.iqiyi.com/w_19rth5swkd.html
* TestNG官方文档：https://testng.org/doc/documentation-main.html#parameters-testng-xml

<span id = "m"></span>
