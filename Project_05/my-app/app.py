from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "This is for Phase 02 Project 05 \n Okay this line is for CI/CD cross check"
if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000)
