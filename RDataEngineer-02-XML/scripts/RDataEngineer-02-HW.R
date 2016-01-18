
# 這個段落的程式碼，是先幫助同學觀察資料的，不包含在作答的檢查範圍
if (FALSE) {
  # 我們先來看看政府電子採購網<http://web.pcc.gov.tw>所爬下來的決標資料。
  # 這個檔案的路徑已經設定到tender_path了。首先，請同學先用`readLines`
  # 來看這個檔案的前100行。

  readLines(tender_path, n = 100)

  # 這樣的內容要直接處理是很挑戰的
  # 但是我們可以先透過瀏覽器來觀察這個HTML文件所夾帶的內容

  browseURL(tender_path)

  # 同學的預設瀏覽器應該會打開這個網頁
}

# 透過
