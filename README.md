<!-- title: R 語言翻轉教室 -->
<!-- subtitle: 版本號：v1.0 -->

<script>
  ((window.gitter = {}).chat = {}).options = {
    room: 'wush978/DataScienceAndR'
  };
</script>
<script src="https://sidecar.gitter.im/dist/sidecar.v1.js" async defer></script>
<script src="http://momentjs.com/downloads/moment-with-locales.min.js" async defer></script>

<script>

function showRegistrationRecords() {
  $("#records").empty();
  var url1 = "http://api.datascienceandr.org:3000/api/getManyRecords";
  var url2 = "http://api2.datascienceandr.org:3000/api/getManyRecords";
  var used_records = [];
  function successOperation(data) {
    data.forEach(function(record) {
      used_records.push(record);
    });
  }
  function getManyRecordsOperation(url, completeOperation) {
    return function(jqXHR, status) {
      $.ajax({
        url:url,
        type:"POST",
        data:{num:5},
        dataType:"json",
        success: successOperation,
        complete: completeOperation
      });
    };
  }
  var operation = getManyRecordsOperation(url1, getManyRecordsOperation(url2, function() {
    used_records.sort(function(r1, r2) {
      if (r1.created_at < r2.created_at)
        return 1;
      else if (r1.created_at > r2.created_at)
        return -1;
      else
        return 0;
    });
    used_records.forEach(function(record) {
      m = moment(record.created_at);
      if (record.type == 0) {
        li = "<li>" + record.user_id  + "在" + m.fromNow() + "進入了" + record.course  + "</li>"
      } else {
        li = "<li>" + record.user_id  + "在" + m.fromNow() + "完成了" + record.course  + "</li>"
      }
      $("#records").append(li);
    });
  }));
  operation();
}



window.onload =function(){
  moment.locale("zh-tw");
  moment.updateLocale("zh-tw", {
    relativeTime : {
      future : '%s內',
      past : '%s前',
      s : '幾秒',
      m : '1分鐘',
      mm : '%d分鐘',
      h : '1小時',
      hh : '%d小時',
      d : '1天',
      dd : '%d天',
      M : '1個月',
      MM : '%d個月',
      y : '1年',
      yy : '%d年'
    }});
  showRegistrationRecords();
}
</script>


測試結果： Linux ![](https://travis-ci.org/wush978/DataScienceAndR.svg?branch=course) Windows [![Build status](https://ci.appveyor.com/api/projects/status/tej2qnpdxwy2r5lp/branch/course?svg=true)](https://ci.appveyor.com/project/wush978/datascienceandr/branch/course)

## 簡介

這是一個以著重於實作，一個動態的**R 語言在地化中文教材**。這份教材的內容涵蓋：

1. 使用R 的基本使用知識
2. 如何用R 讀取資料與讀取中文
3. 如何用R 從公開資料中萃取資訊
4. 如何用R 整理資訊
5. 如何利用R 將整理好的資訊繪製統計圖表與地圖

這個教材具有挑戰性，每一個關卡的大魔王都有一定的難度。如果你已經有程式語言的基礎或是喜歡自我挑戰，那這份教材很適合同學自學，並且大概會花你12~18小時的時間。

如果你已經有R 語言的基礎，我建議你可以先完成Hello-DataScienceAndR之後，從01-RBasic-07開始學習中文處理與資料處理相關的知識，這段內容我自以為勝過大部分的R 教材。

如果你完全沒有程式的經驗，我建議你可以挑戰看看，但是請儘量善用聊天室（你可以點選右下角的Open Chat或造訪：<http://gitter.im/wush978/DataScienceAndR>）。如果仍然完全無法理解R 語言的邏輯，就麻煩你先參加其他的實體課程後再回來學習。

這份教材具有以下的特色：

1. **完整**。由於教材是參考CRAN上介紹R 的官方文件：[An Introduction to R](https://cran.r-project.org/doc/manuals/R-intro.pdf)所撰寫的，同學即使只有使用這份教材學R ，即可獲得所有用R 所需要的所有知識。
2. **在地化的中文資料處理**。教材是特別針對處理台灣的Open Data所設計，所以會涵蓋所有要載入中文資料所需要的知識。網路上雖然已經有很多很棒的R 教材，但是他們通常沒有描述如何處理中文資料。
3. **新**。在2012年以後，R 的成長是非常快速的，所以教材會納入許多近年來被R 社群證實很棒的套件們。
4. **套件的使用與探索**。R 的一大優勢就是蓬勃的套件系統。雖然教材中無法介紹所有的套件，但是會教同學如何探索一個第一次接觸的R 套件。
5. **互動**。我們基於R Community貢獻的R 語言套件swirl 所撰寫的互動式學習環境，可以讓同學以最貼近實際使用R 的狀況來學R
6. **教材設計**。每個單元的開始，我們設計大量的操作讓同學是透過用**肌肉**來記憶R 的指令。並且在單元的最後都擁有來自實務且具有挑戰性的關卡。
7. **自由**。老師們可以很方便與自由地將本教材整合至您的教案之中。有興趣的老師請參考：[教師專區](teacher.html)

## 即時動態

<div class="well" style="height: 14em;"><ul id="records"></ul></div>

## 線上體驗區（需參加實體課程）

請有參加實體課程的同學打開： <http://server.datascienceandr.org:28787>

並依照課堂上給的帳號密碼登入。

有興趣的同學也歡迎聯繫我們（無論是在聊天室或是來信：[wush@datascienceandr.org](mailto:wush@datascienceandr.org)），取得線上體驗的帳號密碼。

## 快速安裝區

同學可以參考以下的上手影片：

<iframe width="560" height="315" src="https://www.youtube.com/embed/fcd6zSk0yd8" frameborder="0" allowfullscreen></iframe>

或是依照以下的動作快速設定學習環境：

1. 安裝R
2. 安裝Rstudio(Windows 使用者請安裝Rstudio或自備能夠編輯UTF-8 編碼的編輯器，OS X 與Linux使用者可依據自己喜好決定是否使用Rstudio)
3. 打開R ，執行：`source("http://wush978.github.io/R/init-swirl.R")`（如果是網路環境受到限制，只能使用80 port 的同學，請參考 <https://gist.github.com/wush978/957d8bee92f78f6c0aead949609f921d>中的指令進行安裝）
4. 輸入`library(swirl);swirl()`後即進入教學環境。
5. 進入00-Hello-DataScienceAndR課程檢查你的電腦能不能執行本教材的所有功能，並瞭解本教材所提供的功能。

有興趣了解安裝細節的同學，請操考：

- [Windows](https://github.com/wush978/DataScienceAndR/wiki/Windows-%E8%A8%AD%E5%AE%9A%E6%8C%87%E5%8D%97)
- [Mac OS X](https://github.com/wush978/DataScienceAndR/wiki/Mac-OS-X-%E8%A8%AD%E5%AE%9A%E6%8C%87%E5%8D%97)
- [Ubuntu](https://github.com/wush978/DataScienceAndR/wiki/Ubuntu-%E8%A8%AD%E5%AE%9A%E6%8C%87%E5%8D%97)

安裝上有問題，或是在執行00-Hello-DataScienceAndR不順利的同學請到[求助專區](#求助專區)取得協助

## 互動式學習環境快速上手區

在輸入`swirl()`之後，同學即進入R 的互動式學習環境(swirl環境)。請參考以下動作做操作：

### 1. 進入學習環境

![Imgur](http://i.imgur.com/sYGDy72.png)

ps. 如果你之前有進行過swirl的課程，swirl會出現下圖的選項詢問你是否要接關。請根據你的需求作答：

![Imgur](http://i.imgur.com/SwlSa3W.png)

如不接關，請選取：`No. Let me start something new.`

### 2. 選擇課程(Course)

![Imgur](http://i.imgur.com/Sfj0K1l.png)

### 3. 選擇你要進行的單元(Lesson)

![Imgur](http://i.imgur.com/OFgU4wM.png)

目前主要課程分成以下三塊：

- 01-RBasic區：講解R 語言的基礎知識與使用方法。所有以下的課程都需要知道RBasic的知識。
- 02-RDataEngineer區：講解載入資料至R 語言，以及清理、整理資料的所需知識。
- 03-RVisualization區：介紹R的視覺化功能

其他的課程，同學可以視自己的興趣決定要不要完成

- Optional-RProgramming區：介紹R 語言的程式功能。
- Optional-RDataMining區：介紹R 語言在Data Mining中常用的套件。
- Optional-RStatistic區：搭配實體課程所使用的swirl課程，不建議同學自行使用

## 求助專區

有問題的朋友，麻煩先註冊一個Github帳號後，可以到以下地方討論：

- [Issue回報區](https://github.com/wush978/DataScienceAndR/issues)
- Gitter聊天室：[![Gitter](https://badges.gitter.im/wush978/DataScienceAndR.svg)](https://gitter.im/wush978/DataScienceAndR?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

## 緣起

這個Repository主要是為了準備我在臺大的資料科學課程，幫陳老師講的兩堂R 的課程。課程素材主要就是投影片和swirl。內容則是參考CRAN上介紹R 的官方文件：[An Introduction to R](https://cran.r-project.org/doc/manuals/R-intro.pdf)。
另外也要感謝社群中所有有參與籌備資料科學愛好者年會2015的同伴。

## 課程筆記

以下連結記載swirl中的課程內容(sha-hash: 4636e186 版本)

- [00-Hello-DataScienceAndR](note/00-Hello-DataScienceAndR.html)
- [01-RBasic-01-Introduction](note/01-RBasic-01-Introduction.html)
- [01-RBasic-02-Data-Structure-Vectors](note/01-RBasic-02-Data-Structure-Vectors.html)
- [01-RBasic-03-Data-Structure-Object](note/01-RBasic-03-Data-Structure-Object.html)
- [01-RBasic-04-Factors](note/01-RBasic-04-Factors.html)
- [01-RBasic-05-Arrays-Matrices](note/01-RBasic-05-Arrays-Matrices.html)
- [01-RBasic-06-List-DataFrame](note/01-RBasic-06-List-DataFrame.html)
- [01-RBasic-07-Loading-Dataset](note/01-RBasic-07-Loading-Dataset.html)
- [02-RDataEngineer-01-Parsing](note/02-RDataEngineer-01-Parsing.html)
- [02-RDataEngineer-02-XML](note/02-RDataEngineer-02-XML.html)
- [02-RDataEngineer-03-JSON](note/02-RDataEngineer-03-JSON.html)
- [02-RDataEngineer-04-Database](note/02-RDataEngineer-04-Database.html)
- [02-RDataEngineer-05-Data-Manipulation](note/02-RDataEngineer-05-Data-Manipulation.html)
- [02-RDataEngineer-06-Join](note/02-RDataEngineer-06-Join.html)
- [03-RVisualization-01-One-Variable-Visualization](note/03-RVisualization-01-One-Variable-Visualization.html)
- [03-RVisualization-02-Multiple-Variables-Visualization](note/03-RVisualization-02-Multiple-Variables-Visualization.html)
- [03-RVisualization-03-ggplot2](note/03-RVisualization-03-ggplot2.html)
- [03-RVisualization-04-Javascript-And-Maps](note/03-RVisualization-04-Javascript-And-Maps.html)
- [Optional-RProgramming-01-Loop-And-Condition](note/Optional-RProgramming-01-Loop-And-Condition.html)
- [Optional-RProgramming-02-Function](note/Optional-RProgramming-02-Function.html)
- [Project-ROpenData-Power-GDP](note/Project-ROpenData-Power-GDP.html)

## 課程投影片

以下連結是課程中使用的投影片

- [RBasic-Introduction](slide/RBasic-Introduction.html)
- [RBasic-DataStructure](slide/RBasic-DataStructure.html)
- [RDataEngineer-Introduction](slide/RDataEngineer-Introduction.html)
- [RVisualization-Introduction](slide/RVisualization-Introduction.html)

## License

<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/tw/"><img alt="創用 CC 授權條款" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/3.0/tw/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" property="dct:title" rel="dct:type">Data Science and R</span>由<a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/wush978/DataScienceAndR" property="cc:attributionName" rel="cc:attributionURL">Wush Wu、Chih Cheng Liang和Johnson Hsieh</a>製作，以<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/tw/">創用CC 姓名標示-相同方式分享 3.0 台灣 授權條款</a>釋出。

## 捐贈

如果你認為這份教材有**確實**幫助到你，很歡迎捐贈一元以上的金額並留言給我們。

了解這份教材對大家的貢獻，是我們開發這套教材的動力。

<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="hidden" name="hosted_button_id" value="KEREK4GYLJ7ZL">
<input type="image" src="http://i.imgur.com/hHGKvOZ.gif" border="0" name="submit" alt="PayPal － 更安全、更簡單的線上付款方式！">
<img alt="" border="0" src="https://www.paypalobjects.com/zh_TW/i/scr/pixel.gif" width="1" height="1">
</form>

