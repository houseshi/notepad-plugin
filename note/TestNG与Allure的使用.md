## 管方文档
官方文档 https://testng.org/doc/documentation-main.html

## pom.xml
```xml
<!-- https://mvnrepository.com/artifact/org.testng/testng -->
<dependency>
    <groupId>org.testng</groupId>
    <artifactId>testng</artifactId>
    <version>7.1.0</version>
    <scope>test</scope>
</dependency>

```

## mvn测试报告

```xml
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>2.22.2</version>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>2.12</version>
                <inherited>true</inherited>
                <configuration>
                    <suiteXmlFiles>
                        <suiteXMLfile>testNG.xml</suiteXMLfile>
                    </suiteXmlFiles>
                </configuration>
            </plugin>
        </plugins>
    </build>

```
## testNG.xml

```xml

<?xml version="1.0" encoding="UTF-8"?>
<suite name="youlu" parallel="false">
<test name="youlu" preserve-order="true">
	<!--  选择组-->
	<!--	<groups>-->
	<!--		<run name="group1">-->
	<!--		</run>-->
	<!--	</groups>-->
	
	<!--选择包-->
	<!--		<packages>-->
	<!--			<package name = "com.youlu.demo.cases.*" />-->
	<!--		</packages>-->
	
	<!--选择类-->
	<classes>
		<class name="com.test.demo" />
	</classes>

	<!--		选择方法-->
	<!--		<classes>-->
	<!--			<class name = "className" />-->
	<!--			<methods>-->
	<!--				<include name = "methodName" />-->
	<!--			</methods>-->
	<!--			</class>-->
	<!--		</classes>-->
</test>
</suite>

```


## TestNG 集成 Allure Framework 测试报告工具



## Allure 官方文档
   
[Allure 官方文档](https://docs.qameta.io/allure/#_testng)


## Allure环境

1. https://github.com/allure-framework/allure2/releases/tag/2.13.2 Lins下载。
2. 解压到本地。
3. 环境变量Path增加 D:\allure2.13.2\bin

## 检查环境

`allure --version`

## pom.xml 引入

```xml
`pom.xml`

```xml

<properties>
    <aspectj.version>1.8.10</aspectj.version>
</properties>

<dependencies>
    <dependency>
        <groupId>io.qameta.allure</groupId>
        <artifactId>allure-testng</artifactId>
        <version>2.13.2</version>
        <scope>test</scope>
    </dependency>
</dependencies>

<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-surefire-plugin</artifactId>
            <version>2.20</version>
            <configuration>
                <argLine>
                    -javaagent:"${settings.localRepository}/org/aspectj/aspectjweaver/${aspectj.version}/aspectjweaver-${aspectj.version}.jar"
                </argLine>
            </configuration>
            <dependencies>
                <dependency>
                    <groupId>org.aspectj</groupId>
                    <artifactId>aspectjweaver</artifactId>
                    <version>${aspectj.version}</version>
                </dependency>
            </dependencies>
        </plugin>
    </plugins>
</build>

```

## allure.properties
resources 可增加 allure.properties 配置文件。
`allure.link.issue.pattern=http://git.test.com/houseshi/testProject/issues/{}`
{}可作为注解中指定的值替换占位符

## 显示名称

```java
@Test(description = "CaseName")
public void loginWith(User user) {
     ...
}

```

## 描述
```java

@Test(description = "CaseName")
@Description("用例描述")
public void loginWith(User user) {
     ...
}

```

## 步骤

```java
@Step("Type {user.name} / {user.password}.")
public void loginWith(User user) {
     ...
}

```

## 增加附件（错误截图）

```java

@Attachment
public String performedActions(ActionSequence actionSequence) {
    return actionSequence.toString();
}

@Attachment(value = "Page screenshot", type = "image/png")
public byte[] saveScreenshot(byte[] screenShot) {
    return screenShot;
}


/*
 * 或者
 */

...

Allure.addAttachment("My attachment", "My attachment content");

```

实战
```java


 /**
     * 读取错误截图
     * @param filename
     * @throws Exception
     */
    public void readScreenshot(String filename) throws Exception {
        FileInputStream fis;
        fis = new FileInputStream(filename);
        byte[] read = new byte[1024*1024];
        fis.read(read);
        this.testScreenshot(read);
        fis.close();
    }
    /**
     * 将错误截图添加到测试报告
     * @param screenShot
     * @return
     */
    @Attachment(value = "Error screenshot", type = "image/png")
    public byte[] testScreenshot(byte[] screenShot){
        return screenShot;
    }

```

## 链接

可配合allure.properties 使用， allure.link.issue.pattern=http://git.youlu.com/niaoshuai/biz_manage/issues/{}

```java
@Issue("432")
@TmsLink("test-2")
public void testSomething() {
     ...
}

```

## 严重程度

```java
    @Test
    @Severity(SeverityLevel.CRITICAL)
    public void testSomething() throws Exception {
        // ...
    }

```

## 模块名或增加Story
Epic Story 暂时没用，不知道究竟效果如何。
```java
@Epic("Allure examples")
@Feature("审核日志")
public class MyTest {
    @Test
    @Story("Base support for bdd annotations")
    @Story("Advanced support for bdd annotations")
    public void testSomething() throws Exception {
        // ...
    }
}

```

## 运行
先清除test构建。
mvn clean test

mvn test完毕后检查工程目录是否生成 arrure-results

控制台执行命令 ,运行成功后，自动打开测试报告页面。
allure serve target/allure-result 
