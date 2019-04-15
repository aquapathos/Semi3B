import datetime
import urllib.request
import cv2
import os
 
def timestr():
  d = datetime.datetime.today()
  h = d.hour
  m = d.minute
  s = str(h)
  if h<10 :
    s = "0"+s
  if m<10 :
    s = s+"0"
  s = s+str(m)
  return s
 
def bijin(fname):
  url = 'http://www.bijint.com/assets/pict/osaka/pc/'
  url = url+timestr()+'.jpg'
  file = open(fname,'wb')
  opener = urllib.request.build_opener()
  req = urllib.request.Request(url)
  req.add_header('Referer', "http://bijint.com/assets/pict/osaka/pc")
  file.write(opener.open(req).read())
  file.close()
 
def main():
  fname = "pic_tmp_tmp.png"
  bijin(fname) # 美人時計の現時刻の画像を カレントディレクトリのfname に一時保存
  img = cv2.imread(fname,1) # fnameの画像を読み込み
  cv2.imshow("BC",img)
  cv2.waitKey(0)
  cv2.destroyWindow("BC")
  os.remove(fname) # 一時ファイルの削除
 
if __name__ == '__main__':
  main()