---
title       : R語言與資料處理
subtitle    : Johnson Hsieh (johnson@dsp.im)
job         : 
author      : Power by Wush Wu and HJ Hsu
framework   : io2012-dsp
highlighter : highlight.js
hitheme     : zenburn
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
geometry: margin=0in
--- &vcenter .largecontent



## 環境與課程安裝程序
- 請參照R語言翻轉教室 <http://www.datascienceandr.org> 
- 或者舉手發問請講師與助教幫忙處理
- 關於R語言翻轉教室與swirl


---

## 關於swirl

- 使用自己電腦的同學，請依照課程網頁更新教材
<img src='assets/img/Selection_008.png' style='width: 100%'></img>

打開R ，執行`source("http://wush978.github.io/R/init-swirl.R")`

輸入`library(swirl);swirl()`後即進入教學環境

--- .largecontent
## 關於swirl

### 這次新增了以下指令：

- `chat()` 可以打開聊天室
- `issue()` 可以打開issues

--- .dark .segue

## R 的資料處理技術

--- .largecontent

## R 是一套完整的資料科學解決方案

- **資料存讀取**
- **資料處理**
- 資料分析 (Statistics, MLDM)
- 資料視覺化
- 資料儀表盤
- Presentation and storytelling

--- 
## R語言的資料讀取/處理技術

<div style="float:left;width:48%;" class="">
  <h3>讀取儲存於磁碟的資料</h3>

<ul>
<li><code>RBasic-07-Loading-Data</code></li>
</ul>

<h3>讀取來自不同資料源與格式的資料</h3>

<ul>
<li><code>RDataEngineer-02-XML</code></li>
<li><code>RDataEngineer-03-JSON</code></li>
<li><code>RDataEngineer-04-Database</code></li>
</ul>

</div>
<div style="float:right;width:48%;" class="">
  <h3>處理非結構化資料</h3>

<ul>
<li><code>RDataEngineer-01-Parsing</code></li>
</ul>

<h3>處理與進一步整理結構化資料的技術</h3>

<ul>
<li><code>RDataEngineer-05-Data-Manipulation</code></li>
</ul>

<h3>將不同的表格資料融合運用</h3>

<ul>
<li><code>RDataEngineer-06-Join</code></li>
</ul>

</div>

--- .dark .segue

## RBasic-07-Loading-Data

--- .largecontent

## R 預設的讀取資料技術

- 套件中的資料
  - 預設的資料集，如 `iris`
	- 載入套件帶來的資料集，如 `data(spider, package = "iNEXT")`

- CSV (comma-separated values)
  - 以逗號區隔的結構化資料 (structured data)
	- 每一列都有同樣多的資料欄
	
- TSV (Tab Separated Values)

- 中文編碼

--- .largecontent
## CSV 的眉眉角角
<pre><code>
Year,Make,Model, 
1997,Ford,E350 
2000,Mercury,Cougar

"1997","Ford","E350" 

1997,Ford,E350,"super, luxurious truck" 

1997,Ford,E350,"super, ""luxurious"" truck" 

1997, Ford, E350 

1997,Ford,E350,4.9
</code>
</pre>

---
## 字符編碼（Encoding）
- 人類習慣的是 10 進位 (Decimal)    
  - 0, 1, 2, 3, …, 10, …, 15, 16, …, 175

- 電腦用的是 2 進位 (Binary)    
	- 0, 1, 10, 11, …, 1010, …, 1111, 10000, …, 10101111
	  
- 16 進位 (Hexadecimal, Hex)     
	- 0, 1, 2, 3, …, A, …, F, 10, …, AF 
	  
- 1 Byte (位元組) = 8 bit (位元) 是目前電腦計算記憶體的基本單位
- 1 Byte 可以表達 0 – 255 的值，正好可以用兩個 Hex Code 表達 (16 = 24)    
  - 00000001 ==> 0000,0001 ==> 01
  - 00110101 ==> 0011,0101 ==> 35



--- .largecontent

## 範例：文字的"0"與數字的0L

- 整數0L的記憶體，寫成hex code是 00 00 00 00 (佔有四個位元組)
- 文字"0"的記憶體，寫成hex code是 30 (佔有一個位元組)

--- .largecontent

## 編碼(Encoding)

- 把位元組的組合轉換成文字的規則
- ASCII
    - 30 => "0"、41 => "A"、0D => Enter(\r)、0A => 換行(\n)

--- .largecontent

## 中文編碼

- UTF-8    
    - E4 B8 AD => "中"
    - E6 96 87 => "文"
 
- BIG5    
    - A4 A4 => "中"
    - A4 E5 => "文"

- 以 UTF-8 編碼寫成的 「中文」二字，在電腦看來是    
	- E4 B8 AD E6 96 87
- 若是以 BIG5 編碼讀入，會變成 「銝剜  」
- 讀取中文檔案時，必須先確定編碼，否則無法正確讀取


--- .largecontent

## 編碼101

- `iconv`    
  - R 環境中轉換字元的函式，請以 `?iconv` 閱讀其說明文件

- `Encoding`, `fileEncoding`    
  - R 環境中用來讀取資料的函式常見的參數，用來設定來源資料的編碼型態

- `Sys.getlocale()`, `Sys.setlocale(locale = "cht")`    
  - R 環境用來設定語境的環境變數，可以減少部分編碼帶來的困擾

---  &vcenter .largecontent
## Let’s do it
- 實際利用 R 讀取中文編碼的檔案
- 請同學們完成 `RBasic-07-Loading-Data`



--- .dark .segue

## RDataEngineer-01-Parsing

--- largecontent

## 非結構化的資料

- 請問電腦如何知道以下資訊的意義？

<pre><code>
64.242.88.10 - - [07/Mar/2004:16:05:49 -0800] "GET /twiki/bin/edit/Main/Double_bounce_sender?topicparent=Main.ConfigurationVariables HTTP/1.1" 401 12846

64.242.88.10 - - [07/Mar/2004:16:06:51 -0800] "GET /twiki/bin/rdiff/TWiki/NewUserTemplate?rev1=1.3&rev2=1.2 HTTP/1.1" 200 4523
</code></pre>

--- .largecontent

## 什麼是Parsing?

- 根據Domain Knowledge，告訴電腦資料的規則
    - 位置，如經緯度 121**E**25**N**
    - 分隔符號，如逗號、分號、冒號等
    - *Regular Expression* 正規表示式
		  - 身分證字號的正規表示式: 
			- `^[A-Z]{1}[1-2]{1}[0-9]{8}$`


---  &vcenter .largecontent
## Let’s do it
- 實際利用 R 處理非結構化的資料
- 請同學們完成 `RDataEngineer-01-Parsing`



--- .dark .segue

## 讀取格式迥異的資料 (02-04)

--- .largecontent

## RDataEngineer-02-XML
### XML(eXtensible Markup Language)
- 讓電腦能理解資料意義的資料格式
    - 標籤
    - 屬性
    - 內容

```
<?xml version="1.0"?>
<小紙條>
 <收件人>大元</收件人>
 <發件人>小張</發件人>
 <主題>問候</主題>
 <具體內容>早啊，飯吃了沒？ </具體內容>
</小紙條>
```

<small>出自：<https://zh.wikipedia.org/wiki/XML#.E4.BE.8B></small>

--- .largecontent

## HTML (HyperText Markup Language)

- 有規範的標籤
- HTML用於撰寫網頁、XML用於傳輸資料

<pre><code>
&lt;html&gt;

&lt;head&gt;
  &lt;script type=&quot;text/javascript&quot; src=&quot;loadxmldoc.js&quot;&gt;
&lt;/script&gt;
&lt;/head&gt;

&lt;body&gt;

  &lt;script type=&quot;text/javascript&quot;&gt;
    xmlDoc=<a href="dom_loadxmldoc.asp">loadXMLDoc</a>(&quot;books.xml&quot;);
    document.write(&quot;xmlDoc is loaded, ready for use&quot;);
  &lt;/script&gt;

&lt;/body&gt;

&lt;/html&gt;
</code></pre>

<small>出自：<http://www.w3school.com.cn/tags/tag_pre.asp></small>

--- .largecontent

## XPath(XML Path Language)

```
<A>
  <B>
    <C/>
  </B>
</A>
```

- `/A/B/C`
- `//B`

--- .largecontent
## RDataEngineer-03-JSON

###  JSON (JavaScript Object Notation)

```
{
     "firstName": "John",
     "lastName": "Smith",
     "sex": "male",
     "age": 25
 }
```

--- .largecontent

## JSON (JavaScript Object Notation)

- 字串：`"firstName"`, `"John"`
- 數字： `25`
- 陣列： `[1, 2, "3"]`
- 物件： `{ "a" : 1, "b" : "string", "c" : { "c1" : 1 } }`


--- .largecontent

## 結構化資料

- 非結構化資料：純文字
- 半結構化資料：CSV、XML、JSON
- 結構化資料：關聯式資料庫（`data.frame`）

--- .largecontent

## R 的物件導向系統


```r
library(RSQLite)
```

```
Loading required package: DBI
```

```r
methods("dbConnect")
```

```
[1] dbConnect,SQLiteConnection-method dbConnect,SQLiteDriver-method    
see '?methods' for accessing help and source code
```


--- &vcenter .largecontent
## Let’s do it
實際利用 R 來讀取來自不同型態資料源的資料
請同學們完成 

- `RDataEngineer-02-XML`
- `RDataEngineer-03-JSON`
- `RDataEngineer-04-Database`


--- .dark .segue

## RDataEngineer-05-Data-Manipulation

--- &vcenter .largecontent

## R 的結構化資料來源

- 內部：`data.frame`、`data.table`
- 外部：關聯式資料庫

--- &vcenter .largecontent

## Grouped Operation

- `group_by`
    - 分類
- 對`group_by`的輸出做操作  
    - 同步操作

--- &vcenter .largecontent

## Grouped Operation

- `summarise(flights, mean(dep_delay, na.rm = TRUE))`
    - `######## == summarise ==> result`
- `group_by(flights, month) %>% summarise(flight, mean(dep_delay, na.rm = TRUE))`
    - ######### == group_by ==> ### ### ###
        - ### == summarise ==> result1
        - ### == summarise ==> result2
        - ### == summarise ==> result3

--- &vcenter .largecontent

## 程式碼的壓縮

```
x1 <- filter(flights, ...)
x2 <- select(x1, ...)
x3 <- summarise(x2, ...)
```

--- &vcenter .largecontent

## 程式碼的壓縮

- 把`x1`用`filter(flights, ...)`取代

```
x2 <- select(filter(flights, ...), ...)
x3 <- summarise(x2, ...)
```

--- &vcenter .largecontent

## 程式碼的壓縮

```
summarise(select(filter(flights, ...), ...), ...)
```

--- &vcenter .largecontent

## Pipeline Operator

把`filter`的結果放到`select`的第一個參數

```
x2 <-
  filter(flights, ...) %>%
  select(...)
x3 <- summarise(x2, ...)
```

--- &vcenter .largecontent

## Pipeline Operator

把`filter`的結果放到`select`的第一個參數
把`select`的結果放到`summarise`的第一個參數

```
x3 <-
  filter(flights, ...) %>%
  select(...) %>%
  summarise(...)
```

--- .segue .dark

## RDataEngineer-06-Join

--- &vcenter .largecontent

## 多資料源能激盪出更高的價值

- flights
- flights + weather
- flights + weather + airports

--- &vcenter .largecontent

## `left_join`

![](http://i.imgur.com/K8EKfm4.png)

--- &vcenter .largecontent

## `right_join`

![](http://imgur.com/ttI9e0s.png)

--- &vcenter .largecontent

## `inner_join`

![](http://imgur.com/4d64EXX.png)

--- &vcenter .largecontent

## `full_join`

![](http://imgur.com/IHm04sD.png)

--- &vcenter .largecontent

## `anti_join`

![](http://imgur.com/QxcF0Fk.png)

--- &vcenter .largecontent

## `semi_join`

![](http://i.imgur.com/M2UF1mM.png)

--- .segue .dark

## 結束之後...

--- &vcenter .largecontent

## 你已經是一個初階的資料科學家

<center><img src='assets/img/Data_Science_VD.png' style='width: 50%'></img></center>
<small>出處：<www.forbes.com></small>

- 政府採購資料 v.s. 公司基本資料
- 各里開票結果 v.s. 各里收入中位數
- 登革熱病例變化 v.s. 電子發票
