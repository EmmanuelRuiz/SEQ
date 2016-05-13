var express = require('express');
var mongoose = require('mongoose');
var multer = require('multer');
var cloudinary = require('cloudinary');
var http = require('http');

cloudinary.config({
  cloud_name: "epikode",
  api_key: "958628741753562",
  api_secret: "f39ked47HMDj32r5XbanZ7o_WbQ"
});

// initialize our app
var app = express();


var db = 'seq';
mongoose.connect('mongodb://localhost/'+db);

app.set("view engine", "jade");
app.use(express.static("public"));
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.cookieParser());
app.use(express.session({secret: 'coloft'}));

// port that server will listen on
var port = 8080;

var server = http.createServer(app);
var io = require('socket.io').listen(server);
server.listen(port);
console.log('Express server listening on port '+port);

//create supervisor model
var Supervisor = mongoose.model('Supervisor', {
	username: String,
	lastName: String,
  image: String,
	email: String,
  password: String,
  RFC: String,
  zonaEscolar: String,
  bio: String
});

//create status model
var Status = mongoose.model('Status', {
  body: String,
	time: Number,
	username: String,
	image: String,
	comments: Array,
	likes: Array
});


app.get('/', function (req, res) {
	if (req.session.supervisor){
		Status.find({}).sort({time: -1}).exec(function (err, statuses){
			res.render('homepage', {user: req.session.supervisor, statuses: statuses});
		});
	} else {
		res.render('welcome');
	}
});

app.get('/logout', function (req, res) {
	if (req.session.supervisor) {
		console.log(req.session.supervisor.username+' has logged out');
		delete req.session.supervisor;
	}
	res.redirect('/');
});

app.get('/login', function (req, res) {
	var error1 = null;
	var error2 = null;

	if (req.query.error1) {
		error1 = "Intenta de nuevo porfavor";
	}
	if (req.query.error2) {
		error2 = "Intenta de nuevo porfavor";
	}
	res.render('login', {error1: error1, error2: error2});
});

app.post('/login', function (req, res) {
	var username = req.body.username.toLowerCase();
	var password = req.body.password;

	var query = {username: username, password: password};

		Supervisor.findOne(query, function (err, user) {
		if (err || !user) {
			res.redirect('/login?error2=1');
		} else {
			req.session.supervisor = user;
			console.log(username+' has logged in');
			res.redirect('/');
		}
	});
});

app.get("/registrar",function(req, res){
  res.render("signup");
});

app.post('/signup', function (req, res){

	var username = req.body.username.toLowerCase();
	var password = req.body.password;
	var confirm = req.body.confirm;

	if(password != confirm) {
		res.redirect('/login?error1=1');
	} else {
		var query = {username: username};
		Supervisor.findOne(query, function (err, user) {
			if (user) {
				res.redirect('/login?error1=1');
			} else {
				var supervisorData = {
					username: username,
					password: password,
					image: 'http://leadersinheels.com/wp-content/uploads/facebook-default.jpg',
					bio: 'Hola, soy nuevo en este sistema',
					hidden: false,
					wall: []
				};

				var newSupervisor = new Supervisor(supervisorData).save(function (err){
					req.session.supervisor = supervisorData;
					console.log('New user '+username+' has been created!');
					res.redirect('/users/'+username);

				});
			}
		});
	}
});

// user profile
app.get('/users/:username', function (req, res) {
	if (req.session.supervisor) {
		var username = req.params.username.toLowerCase();
		var query = {username: username};
		var currentUser = req.session.supervisor;

		Supervisor.findOne(query, function (err, user) {
			if (err || !user) {
        res.send('No user found by id '+username);
			} else {
				Status.find(query).sort({time: -1}).exec(function(err, statuses){
					res.render('profile', {
						user: user,
						statuses: statuses,
						currentUser: currentUser
					});
				});
			}
		});
	} else {
		res.redirect('/registrar');
	}
});

app.post('/profile', function (req, res) {
	if (req.session.supervisor) {
		var username = req.session.supervisor.username;
		var query = {username: username};
		var newBio = req.body.bio;
		var newImage = req.body.image;
		var change = {bio: newBio, image: newImage};

		Supervisor.update(query, change, function (err, user) {
			Status.update(query, {image: newImage}, {multi: true}, function(err, statuses){
				console.log(username+' has updated their profile');
				req.session.supervisor.bio = newBio;
				req.session.supervisor.image = newImage;
			    res.redirect('/users/'+username);
			});
		});
	} else {
		res.redirect('/login');
	}
});

app.post('/statuses', function (req, res) {
	if (req.session.supervisor) {
			var status = req.body.status;
			var username = req.session.supervisor.username;
			var pic = req.session.supervisor.image;
			var statusData = {
				body: status,
				time: new Date().getTime(),
				username: username,
				image: pic,
				comments: [],
				likes: []
			};
			var newStatus = new Status(statusData).save(function (err) {
				console.log(username+' has posted a new status');
				io.sockets.emit('newStatus', {statusData: statusData});
				res.redirect('/users/'+username);
			});
	} else {
		res.redirect('/login');
	}
});

 
