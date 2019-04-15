import urllib.request
import cv2
import os
from google.colab.patches import cv2_imshow
 
def loadNetImg(url,fname):
  file = open(fname,'wb') # バイナリ書き込みモードで一時ファイルをオープン
  opener = urllib.request.build_opener() # おまじない
  req = urllib.request.Request(url) # URL によるリクエスト
 
  file.write(opener.open(req).read())
  file.close()
 
def main():
  fname = "tmp_tmp_pic.png" # 一時出力ファイル名
  url = 'https://goo.gl/eZaYdE' # 画像URL
  loadNetImg(url,fname)
 
  # ファイルの読み込みは以上 以下は復習
 
  img = cv2.imread(fname,1)
  cv2_imshow(img)
  os.remove(fname) # 一時ファイルの削除
 
if __name__ == '__main__':
  main()