#!flask/bin/python
from flask import Flask, jsonify, abort, request, make_response, url_for
from flask_httpauth import HTTPBasicAuth
from flask_restful import Resource, Api, reqparse

app = Flask(__name__, static_url_path = "")
auth = HTTPBasicAuth()

