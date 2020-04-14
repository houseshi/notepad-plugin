# 编程化方式定位获取table元素中的对象

## 具体说明  

目前web自动化在后台管理系统目前主要以列表管理居多，设置一个公共的方法，传入行、列的值，直接定位获取一个元素，或者一行数据、或者一列数据。

## 使用效果(样例)

```java
    public static final CommonUIBean TAB_MESSAGE_NAME_LIST =getTabCommonUI(3);
    public static final CommonUIBean TAB_MESSAGE_SEND_TYPE_LIST =getTabCommonUI(4);
    public static final CommonUIBean TAB_MESSAGE_SEND_STAUTS_LIST =getTabCommonUI(5);
    public static final CommonUIBean TAB_DETAILS_BTN_LIST =getTabCommonUI(8,"a");
```


## 代码
### 动态生成 selector 

```java

    /**
     * 整列
     * @param td  列 index
     * @return
     */
    private static String  tabSelector(int td){
        return "table > tbody > tr > td:nth-child("+td+") > div ";
    }

    /**
     * 整列
     * @param td 列 index
     * @param element example ： div.cell > span
     * @return
     */
    private static String  tabSelector(int td,String element){
        return "table > tbody > tr > td:nth-child("+td+") > div >" +element;
    }

    /**
     * @param tr  行 index
     * @param td  列 index
     * @return
     */
    private static String  tabSelector(int tr,int td){
        return "table > tbody > tr:nth-child("+tr+") > td:nth-child("+td+") > div ";
    }

    /**
     * @param tr  行 index
     * @param td    列 index
     * @param element   example ： div.cell > span
     * @return
     */
    private static String  tabSelector(int tr,int td,String element){
        return "table > tbody > tr:nth-child("+tr+") > td:nth-child("+td+") > div >" + element ;
    }
```

### 封装返回 CommonUIBean 对象

```java
    public static CommonUIBean getTabCommonUI(int td){
        return new CommonUIBean(GetElementWay.CSS,tabSelector(td),"tab第"+td+"列");
    }

    public static CommonUIBean getTabCommonUI(int td,String element){
        return new CommonUIBean(GetElementWay.CSS,tabSelector(td,element),"tab第"+td+"列");
    }

    public static CommonUIBean getTabCommonUI(int tr,int td){

        return new CommonUIBean(GetElementWay.CSS,tabSelector(tr,td),"tab第"+tr+"行，第"+td+"列");
    }

    public static CommonUIBean getCommonUI(int tr,int td, String element){

        return new CommonUIBean(GetElementWay.CSS,tabSelector(tr,td,element),"tab第"+tr+"行，第"+td+"列");
    }
```

暂时没有添加行的获取方法，可根据实际项目优化代码或增加方法。。
