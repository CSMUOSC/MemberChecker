import pymysql
import json

class db():
    def __init__(self):
        db_settings = {
            "host": "",
            "port": 3306,
            "user": "",
            "password": "",
            "db": "",
            "charset": "utf8"
        }

        try:
            self.conn = pymysql.connect(**db_settings)
        except Exception as ex:
            print(ex)
            exit(1)

    def formatResult(self, res):
        sex_map = ["其他", "男", "女"]

        resDict = {
                "status":True,
                "Id":res[0],
                "StuId":res[1],
                "Name":res[2],
                "Sex":sex_map[res[3]],
                "Department":res[4],
                "Type":res[5]
        }

        return(resDict)

    def search(self, StuId, year):
        with self.conn.cursor() as cursor:
            cmd='SELECT * FROM `{}` WHERE StudentId={}'.format(year, StuId)
            cursor.execute(cmd)
            # 取得第一筆資料
            result = cursor.fetchone()

            if(result == None):
                return {"status":False}

            return self.formatResult(result)

if __name__ == "__main__":
    d = db()
    print(d.search("0771012", "109"))
