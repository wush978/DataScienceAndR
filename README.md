測試結果： Linux ![](https://travis-ci.org/wush978/DataScienceAndR.svg?branch=course) Windows [![Build status](https://ci.appveyor.com/api/projects/status/tej2qnpdxwy2r5lp/branch/course?svg=true)](https://ci.appveyor.com/project/wush978/datascienceandr/branch/course)

聊天室： [![Gitter](https://badges.gitter.im/wush978/DataScienceAndR.svg)](https://gitter.im/wush978/DataScienceAndR?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

# Data Science and R

這是一個以[swirl](http://swirlstats.com/)撰寫的**R 語言在地化中文教材**。和其他R 教材相比，這份教材具有以下的特色：

1. **完整**。由於教材是參考CRAN上介紹R 的官方文件：[An Introduction to R](https://cran.r-project.org/doc/manuals/R-intro.pdf)所撰寫的，同學即使只有使用這份教材學R ，即可獲得所有用R 所需要的所有知識。
2. **在地化的中文資料處理**。教材是特別針對處理台灣的Open Data所設計，所以會涵蓋所有要載入中文資料所需要的知識。網路上雖然已經有很多很棒的R 教材，但是他們通常沒有描述如何處理中文資料。
3. **新**。在2012年以後，R 的成長是非常快速的，所以教材會納入許多近年來被R 社群證實很棒的套件們。
4. **套件的使用與探索**。R 的一大優勢就是蓬勃的套件系統。雖然教材中無法介紹所有的套件，但是會教同學如何探索一個第一次接觸的R 套件。

以下的內容是提供給有興趣想利用這些資源做自學的朋友：

## 線上體驗區（需參加實體課程）

請奇數編號的同學打開： <http://140.112.170.201:28787>

請偶數編號的同學打開： <http://www.wush978.idv.tw:28787>

並依照課堂上給的帳號密碼登入

## 環境設定

快速設定區：

```r
source("http://wush978.github.io/R/init-swirl.R")
```

或是前往wiki頁面做更仔細的設定

- [Windows](https://github.com/wush978/DataScienceAndR/wiki/Windows-%E8%A8%AD%E5%AE%9A%E6%8C%87%E5%8D%97)
- [Mac OS X](https://github.com/wush978/DataScienceAndR/wiki/Mac-OS-X-%E8%A8%AD%E5%AE%9A%E6%8C%87%E5%8D%97)
- [Ubuntu](https://github.com/wush978/DataScienceAndR/wiki/Ubuntu-%E8%A8%AD%E5%AE%9A%E6%8C%87%E5%8D%97)

## swirl 快速上手區

### 1. 進入swirl 環境

![Imgur](http://i.imgur.com/sYGDy72.png)

ps. 如果你之前有進行過swirl的課程，swirl會出現下圖的選項詢問你是否要接關。請根據你的需求作答：

![Imgur](http://i.imgur.com/SwlSa3W.png)

如不接關，請選取：`No. Let me start something new.`

### 2. 選擇課程(Course)

![Imgur](http://i.imgur.com/Sfj0K1l.png)

### 3. 選擇你要進行的單元(Lesson)

![Imgur](http://i.imgur.com/OFgU4wM.png)

我建議同學依序進行：

- RBasic-01-Introduction
- RBasic-02-Data-Structure-Vectors
- RBasic-03-Data-Structure-Object
- RBasic-04-Factors
- RBasic-05-Arrays-Matrices
- RBasic-06-List-DataFrame
- RBasic-07-Loading-Dataset

RBasic-02至RBasic-07課程最後都有大魔王要給同學攻克。

## 求助專區

有問題的朋友，歡迎到以下地方討論。由於現在網路上機器人眾多，所以麻煩先註冊一個Github帳號後我才會在網路上和你討論。

- [Issue回報區](https://github.com/wush978/DataScienceAndR/issues)
- Gitter聊天室：[![Gitter](https://badges.gitter.im/wush978/DataScienceAndR.svg)](https://gitter.im/wush978/DataScienceAndR?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

## 緣起

這個Repository主要是為了準備我在臺大的資料科學課程，幫陳老師講的兩堂R 的課程。課程素材主要就是投影片和swirl。內容則是參考CRAN上介紹R 的官方文件：[An Introduction to R](https://cran.r-project.org/doc/manuals/R-intro.pdf)。
另外也要感謝社群中所有有參與籌備資料科學愛好者年會2015的同伴。

## 課程投影片

1. RBasic
  - Introduction [HTML](http://wush978.github.io/DataScienceAndR/slide/RBasic-Introduction.html) [PDF](http://wush978.github.io/DataScienceAndR/slide/RBasic-Introduction.pdf)
  - Data Structure [HTML](http://wush978.github.io/DataScienceAndR/slide/RBasic-DataStructure.html) [PDF](http://wush978.github.io/DataScienceAndR/slide/RBasic-DataStructure.pdf)
1. RDataEngineer
  - Introduction [HTML](http://wush978.github.io/DataScienceAndR/slide/RDataEngineer-Introduction.html) [PDF](http://wush978.github.io/DataScienceAndR/slide/RDataEngineer-Introduction.pdf)

## License

<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/tw/"><img alt="創用 CC 授權條款" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/3.0/tw/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" property="dct:title" rel="dct:type">Data Science and R</span>由<a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/wush978/DataScienceAndR" property="cc:attributionName" rel="cc:attributionURL">Wush Wu和Chih Cheng Liang</a>製作，以<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/tw/">創用CC 姓名標示-相同方式分享 3.0 台灣 授權條款</a>釋出。
