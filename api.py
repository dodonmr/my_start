#!flask/bin/python
from flask import Flask, jsonify, abort, request, make_response, url_for
from flask_restful import Resource, Api, reqparse

app = Flask(__name__)
api = Api(app)


users = [{'ID': 1, 'Name': 'User1', 'Favorite': ['Very Hungry Caterpillar', 'Baby Touch and Feel: Animals'], 'Wish': ['Potty']},
		 {'ID': 2, 'Name':'User2', 'Favorite': ['The Cat in the Hat'], 'Wish': ['Potty', 'Pete the Cat and His Four Groovy Buttons', 'Very Hungry Caterpillar']},
		 {'ID': 3, 'Name':'User3', 'Favorite': [], 'Wish': ['Potty','The Cat in the Hat']}]

books = [{'ID': 1, 'Book_Name': 'Very Hungry Caterpillar', 'Status': 'In Stock', 'Type': ['Reading'], 'Price': 12,
		  'Discount': 20, 'Publisher':'ABC', 'Author': 'Peter', 'Written':'English','Published': '1987', 'Pages':15},
		 {'ID': 2, 'Book_Name': 'Baby Touch and Feel: Animals', 'Status': 'In Stock', 'Type': ['Activity'], 'Price': 10,
		  'Discount': 5, 'Publisher':'BUBU', 'Author': 'Carl', 'Written':'English','Published': '2000', 'Pages':10},
		 {'ID': 3, 'Book_Name': 'Potty', 'Status': 'Coming Soon', 'Type': ['Reading'], 'Price': 6,
		  'Discount': 0, 'Publisher':'PBS', 'Author': 'Jenny', 'Written':'English','Published': '2008', 'Pages':10},
		 {'ID': 4, 'Book_Name': 'The Cat in the Hat', 'Status': 'In Stock', 'Type': ['Reading'], 'Price': 19,
		  'Discount': 35, 'Publisher':'BUBU', 'Author': 'Peter', 'Written':'English','Published': '2000', 'Pages':20},
		 {'ID': 5, 'Book_Name': 'The Tale Of Peter Rabbit', 'Status': 'Coming Soon', 'Type': ['Reading'], 'Price': 10,
		  'Discount': 15, 'Publisher':'BUBU', 'Author': 'Mike', 'Written':'Romanian','Published': '2002', 'Pages':24},
		 {'ID': 6, 'Book_Name': 'Pete the Cat and His Four Groovy Buttons', 'Status': 'Coming Soon', 'Type': ['Reading','Activity'], 'Price': 10,
		  'Discount': 0, 'Publisher':'Tpwn', 'Author': 'Lulul', 'Written':'Romanian','Published': '2012', 'Pages':40}]


class Users(Resource):
	"""
	ID: User_name: Favorite books- Popularity: Wish list books
	"""
	def get(self):
		"""
		GET method to see user preferences
		:return: data for each user
		"""
		pass

	def post(self):
		"""
		POST method to add new user with preferences and wishes
		:return: data for new user
		"""

class Books(Resource):
	"""
	ID: Book Name:Book_status(available/new_coming):Type(reading/activities):Price:Discount:Publisher:Author
	:Written Language: Published year: Pages no.
	"""
	def get(self):
		pass

# @app.route('/', methods=['GET'])
# def home_bookstore():
# 	return "<h1>Kids BookStore</h1><p>This site is a prototype API for a kids bookstore.</p>"
#

# @auth.get_password
# def get_password(username):
# 	if username == 'miguel':
# 		return 'python'
# 	return None

# @auth.error_handler
# def unauthorized():
# 	return make_response(jsonify( { 'error': 'Unauthorized access' } ), 403)
# 	# return 403 instead of 401 to prevent browsers from displaying the default auth dialog

# @app.errorhandler(400)
# def not_found(error):
# 	return make_response(jsonify( { 'error': 'Bad request' } ), 400)
#
# @app.errorhandler(404)
# def not_found(error):
# 	return make_response(jsonify( { 'error': 'Not found' } ), 404)
#
# tasks = [
# 	{
# 		'id': 1,
# 		'title': u'Buy groceries',
# 		'description': u'Milk, Cheese, Pizza, Fruit, Tylenol',
# 		'done': False
# 	},
# 	{
# 		'id': 2,
# 		'title': u'Learn Python',
# 		'description': u'Need to find a good Python tutorial on the web',
# 		'done': False
# 	}
# ]
#
# def make_public_task(task):
# 	new_task = {}
# 	for field in task:
# 		if field == 'id':
# 			new_task['uri'] = url_for('get_task', task_id = task['id'], _external = True)
# 		else:
# 			new_task[field] = task[field]
# 	return new_task
#
# @app.route('/todo/api/v1.0/tasks', methods = ['GET'])
# @auth.login_required
# def get_tasks():
# 	return jsonify( { 'tasks': map(make_public_task, tasks) } )
#
# @app.route('/todo/api/v1.0/tasks/<int:task_id>', methods = ['GET'])
# @auth.login_required
# def get_task(task_id):
# 	task = filter(lambda t: t['id'] == task_id, tasks)
# 	if len(task) == 0:
# 		abort(404)
# 	return jsonify( { 'task': make_public_task(task[0]) } )
#
# @app.route('/todo/api/v1.0/tasks', methods = ['POST'])
# @auth.login_required
# def create_task():
# 	if not request.json or not 'title' in request.json:
# 		abort(400)
# 	task = {
# 		'id': tasks[-1]['id'] + 1,
# 		'title': request.json['title'],
# 		'description': request.json.get('description', ""),
# 		'done': False
# 	}
# 	tasks.append(task)
# 	return jsonify( { 'task': make_public_task(task) } ), 201
#
# @app.route('/todo/api/v1.0/tasks/<int:task_id>', methods = ['PUT'])
# @auth.login_required
# def update_task(task_id):
# 	task = filter(lambda t: t['id'] == task_id, tasks)
# 	if len(task) == 0:
# 		abort(404)
# 	if not request.json:
# 		abort(400)
# 	if 'title' in request.json and type(request.json['title']) != unicode:
# 		abort(400)
# 	if 'description' in request.json and type(request.json['description']) is not unicode:
# 		abort(400)
# 	if 'done' in request.json and type(request.json['done']) is not bool:
# 		abort(400)
# 	task[0]['title'] = request.json.get('title', task[0]['title'])
# 	task[0]['description'] = request.json.get('description', task[0]['description'])
# 	task[0]['done'] = request.json.get('done', task[0]['done'])
# 	return jsonify( { 'task': make_public_task(task[0]) } )
#
# @app.route('/todo/api/v1.0/tasks/<int:task_id>', methods = ['DELETE'])
# @auth.login_required
# def delete_task(task_id):
# 	task = filter(lambda t: t['id'] == task_id, tasks)
# 	if len(task) == 0:
# 		abort(404)
# 	tasks.remove(task[0])
# 	return jsonify( { 'result': True } )

if __name__ == '__main__':
	app.run(debug = True)

