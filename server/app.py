#!flask/bin/python
from flask import Flask, jsonify
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address
from ingestion import *

app = Flask(__name__)

limiter = Limiter(
    app,
    key_func=get_remote_address,
    default_limits=["30 per minute"],
)

@app.route('/api/v1.0/search/<string:keywords>/api=<string:api>', methods=['POST', 'GET'])
def get_info(keywords, api):

    ingest = ingestion()
    val = ingest.getInfoJSON(keywords,api)
    return val

if __name__ == '__main__':
    app.run(debug=True)


