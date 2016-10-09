var connect = require('connect');


function restrict(req , res , next){
	  var authorization = req.headers.authorization;
	  if(!authorization) return next(new Error('unauthor'));
	  var parts = authorization.split('');
	  var scheme = parts[0]
	  var auth = new Buffer(parts[1] , 'base64').toString().split(':')
	  var user = auth[0]
	  var pass = auth[1];

	  authenticateWithDatabase(user , pass , function(err){
	  	  if(err) return next(err);

	  	  next();
	  });
}

function helloworld(req , res){
	   res.end('hello world');
}


var app = connect();
app.use('/admin' , restrict);
app.use(helloworld);

app.listen(8080);
