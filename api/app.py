from flask import Flask, abort
from dbcontroller import db

app = Flask(__name__)
dbcon = db()
key = ""

@app.route("/y=<year>&stuId=<stuId>&k=<auth>", methods=['GET'])
def dbSearch(year, stuId, auth):
    #超爛的驗證
    if(auth != key):
        abort(403)

    return dbcon.search(StuId=stuId, year=year)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3000)