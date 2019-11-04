#!flask/bin/python
from flask import Flask, jsonify
from ingestion import *

app = Flask(__name__)

@app.route('/api/v1.0/search/<string:keywords>/api=<string:api>', methods=['POST'])
def get_info(keywords, api):

    ingest = ingestion()
    val = ingest.getInfoJSON(keywords,api)
    return val

if __name__ == '__main__':
    app.run(debug=True)


