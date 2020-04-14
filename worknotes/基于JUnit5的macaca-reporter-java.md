# Macaca Reporter For Java 

## 环境准备

完成当前脚本，您可能以下这些环境。

* java 1.8
* nodejs
* macaca-cli  （npm i -g macaca-cli）
* macaca-chrome （npm i -g macaca-chrome）
* macaca-reporter （npm i -g macaca-reporter）


## 官方样例：
https://github.com/macaca-sample/sample-java.git

以`H5SampleTest`为例进行，引入macaca-reporter-java与JUnit5的集成使用。

**当前代码**

```java
package macaca.client;

import com.alibaba.fastjson.JSONObject;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;


public class H5SampleTest {
    MacacaClient driver = new MacacaClient();

    @Before
    public void setUp() throws Exception {
        // platform: android or ios
        String platform = "android";

        /*
           Desired Capabilities are used to configure webdriver when initiating the session.
           Document URL: https://macacajs.github.io/desired-caps.html
         */
        JSONObject porps = new JSONObject();
        porps.put("platformName", platform);
        porps.put("browserName", "Chrome");
        JSONObject desiredCapabilities = new JSONObject();
        desiredCapabilities.put("desiredCapabilities", porps);
        driver.initDriver(desiredCapabilities);
    }

    @Test
    public void testCaseOne() throws Exception {

        System.out.println("------------#1 h5 web test-------------------");

        /*
        driver.get("http://www.baidu.com");
        driver.elementById("index-kw").sendKeys("macaca");
        driver.elementById("index-bn").click();
        driver.sleep(5000);
        String source = driver.source();
        Assert.assertThat(source, containsString("macaca"));
        */
    }

    @After
    public void tearDown() throws Exception {
        driver.quit();
    }
}

```

因为操作方便，先将其修改为 web端基于chrome运行代码。

**修改后的@Befor代码**
```java

    @Before
    public void setUp() throws Exception {

        JSONObject porps = new JSONObject();
        porps.put("autoAcceptAlerts", true);
        porps.put("browserName", "Chrome");
        porps.put("platformName", "desktop"); // android or ios
        porps.put("javascriptEnabled", true);
        porps.put("platform", "ANY");
        JSONObject desiredCapabilities = new JSONObject();
        desiredCapabilities.put("desiredCapabilities", porps);
        driver.initDriver(desiredCapabilities)
                .maximize();
    }

```

**修改后的@Test代码**
```java

    @Test
    public void testCaseOne() throws Exception {

        System.out.println("------------#1 h5 web test-------------------");

        driver.get("http://www.baidu.com");
        String source = driver.title();
        Assert.assertEquals(source,"百度一下，你就知道");

    }

```

**修改后的@After代码**，因为环境chrome版本与驱动的问题，浏览器退出目前存在一些问题，所以退出的代码暂时先将其注掉了。

```java

    @After
    public void tearDown() throws Exception {
//        driver.quit();
    }

```

**运行一下试试结果**：（不要忘记启动macaca server）
![image](/uploads/a3db21b97e53aa942f426a329530fbf9/image.png)


## 开始进行JUnit5的改造

`pom.xml`

**找到JUnit4 将其删除。**

```xml
        <!--     删除     -->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.12</version>
        </dependency>
```

**引入新的包**

```xml
      
        <!--        JUnit 5        -->
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-api</artifactId>
            <version>5.6.0</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-params</artifactId>
            <version>5.6.0</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-engine</artifactId>
            <version>5.6.0</version>
            <scope>test</scope>
        </dependency>
        <!--        Macaca Reporter        -->
        <dependency>
            <groupId>com.macacajs</groupId>
            <artifactId>macaca-reporter-java-plugin</artifactId>
            <version>1.0</version>
        </dependency>

```

修改完毕后，因为删除掉了JUnit4的引入，之前使用的方法已经开始提示错误。接下来开始使用JUnit5修改我们的代码，

* 删除无效的import，
* 将@Berfor 修改为@BeforeEach
* 将@After 修改为 @AfterEach
* 断言方法修改为JUnit5的断言`Assertions.assertEquals(source,"百度一下，你就知道");`


## 改造后的完整代码

```java

package macaca.client;

import com.alibaba.fastjson.JSONObject;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;


public class H5SampleTest {
    MacacaClient driver = new MacacaClient();


    @BeforeEach
    public void setUp() throws Exception {

        JSONObject porps = new JSONObject();
        porps.put("autoAcceptAlerts", true);
        porps.put("browserName", "Chrome");
        porps.put("platformName", "desktop"); // android or ios
        porps.put("javascriptEnabled", true);
        porps.put("platform", "ANY");
        JSONObject desiredCapabilities = new JSONObject();
        desiredCapabilities.put("desiredCapabilities", porps);
        driver.initDriver(desiredCapabilities)
                .maximize();
    }

    @Test
    public void testCaseOne() throws Exception {

        System.out.println("------------#1 h5 web test-------------------");

        driver.get("http://www.baidu.com");
        String source = driver.title();
        Assertions.assertEquals(source,"百度一下，你就知道");

    }

    @AfterEach
    public void tearDown() throws Exception {
//        driver.quit();
    }
}

```

## 执行测试

因为我们只修改了这一个测试类，其他的测试类的错误我们似乎忘记修改了， 可以暂时将不需要的测试类代码全部注释，或删掉。


## 再次执行测试

日志中显示了`正在生成报告`


检查目录，多出一个/reports目录和一个report.js文件

使用浏览器打开/reports/index.html


## 修改后的demo
JUnit5整合MacacaReport示例 https://github.com/houseshi/sample-java.git
