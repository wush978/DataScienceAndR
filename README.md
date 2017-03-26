
![](http://i.imgur.com/81C5LBk.png?v=1)

Linux ![](https://travis-ci.org/wush978/DataScienceAndR.svg?branch=course) Windows [![Build status](https://ci.appveyor.com/api/projects/status/tej2qnpdxwy2r5lp/branch/course?svg=true)](https://ci.appveyor.com/project/wush978/datascienceandr/branch/course)

以下是編譯網站的資訊

## Requirements

- node v6.9.1
- R 3.3.2
  - remotes 1.0.0
- GNU Make 4.1

```sh
npm install
Rscript -e "remotes::install_github('wush978/pvm@master')"
Rscript -e "pvm::import.packages('pvm.yml')"
```

## 編譯

```sh
make
```