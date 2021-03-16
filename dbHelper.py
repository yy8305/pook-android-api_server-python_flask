import pymysql

class dbHelper():
    def __init__(self):
        self.host="127.0.0.1"
        self.user="admin"
        self.passwd="123"
        self.db="pook"
        self.charset="utf8"
    def connection(self):
        self.conn = pymysql.connect(host=self.host, user=self.user, passwd=self.passwd, db=self.db,charset=self.charset,cursorclass=pymysql.cursors.DictCursor)
        self.cur = self.conn.cursor()
    def closeconnection(self):
        self.cur.close()
        self.conn.close()
    def getonedata(self,sql):
        try:
            self.connection()
            self.cur.execute(sql)
            result=self.cur.fetchone()
            self.closeconnection()
        except Exception:
            print(Exception)    
        return result
    def getalldata(self,sql):
        try:
            self.connection()
            self.cur.execute(sql)
            result=self.cur.fetchall()
            self.closeconnection()
        except Exception:
            print(Exception)      
        return result
    def executedata(self,sql):
        try:
            self.connection()
            self.cur.execute(sql)
            self.conn.commit()
            self.closeconnection()
        except Exception:
            print(Exception)