const express = require('express');
const bcrypt = require('bcryptjs');
const sqlite3 = require('sqlite3').verbose();
const nJwt = require('njwt');
const config = require('./config');

const db = new sqlite3.Database(':memory:');
const mysql = require('mysql');
const conn = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: '123',
  database: 'nodeapp_db'
});
const jwtAuth = require('./auth');

//connect to database
conn.connect((err) =>{
  if(err) throw err;
  console.log('Mysql Connected...');
});
// db.serialize(() => {
//   db.run("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)");
// });

const router = express.Router();

router.post('/register', function(req, res) {
  var random_password =Math.random().toString(36).substring(7);

  var hashedPassword = bcrypt.hashSync(random_password, 8);
  console.log(random_password) ;
 
  var sql = "INSERT INTO users (username,password, email, date_of_joining, type, report_to, ex_seafarer, group_id, rank, mobile_number, contact_number, permanent_address, temporary_address, active) VALUES ? ";
  var field=req.body;
      //for testing
      // var values =[ ["sree",hashedPassword ,"sreekala11@tricta.com" ,'2020-02-26 17:17:59' ,1,1, 1, 1, 1, '9944949494', '9944949494', 
      //    'field.permanent_address', ' field.permanent_address 2', 1   ] ] ;
       conn.query(sql, [values], function (err, result) {
    if (err){ console.log("err",err);  return res.status(500).send("An error occurred during registration");} 
    
      email_id=field.email;
      content_text1='Your details has been added successfully ';
      content_text2='Your Username :   ' +field.username;
      content_text3=' Your temporary Password'+random_password ;
      content_text4='Please login and change your password.  ' ;
      subject="Welcome "+ field.username ;
      const sgMail = require('@sendgrid/mail');
      sgMail.setApiKey('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');
      const msg = {
        to: email_id,
        from: 'sreekalaanirudhan1020@gmail.com',
        subject: subject,
        text: content_text1,
        html: '<div style="paddingg:20;">'+content_text1+'<div><div style="paddingg:20;">'+content_text2+'<div><div style="paddingg:20;">'+content_text3+'<div><div style="paddingg:20;">'+content_text4+'<div>',
      };
     
          sgMail
              .send(msg)
              .then(() => {}, console.error);
              //ES8
              (async () => {
              try {
              await sgMail.send(msg);
              } catch (err) {
              console.error(err.toString());
              }
          })();

    res.status(200).send({ status: 'ok' });
});
});
router.post('/testnail', function(req, res) {
 
email_id="sreekala@tricta.com";
content_text1='Your details has been added successfully ';
content_text2='Your Username : abc  ' ;
content_text3=' Your temporary Password' ;
content_text4='Please login and change your password.  ' ;
subject="Welcome Sri"
const sgMail = require('@sendgrid/mail');
sgMail.setApiKey('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');
const msg = {
  to: email_id,
  from: 'sreekalaanirudhan1020@gmail.com',
  subject: subject,
  text: content_text1,
  html: '<div style="paddingg:20;">'+content_text1+'<div><div style="paddingg:20;">'+content_text2+'<div><div style="paddingg:20;">'+content_text3+'<div><div style="paddingg:20;">'+content_text4+'<div>',
};
sgMail.send(msg);

});

router.post('/login', function(req, res) {

  let sql = "SELECT * FROM users WHERE email= ? ";
    conn.query(sql, [req.body.email], function (err, user) {
    
     
     
    if (err) return res.status(500).send({status: 'Server error', err:err});
     if (user.length <= 0 ){ console.log("User not found");  return res.status(404).send('User not found'); }

     user = JSON.parse(  JSON.stringify(user[0]) );
     
    if (!bcrypt.compareSync(req.body.password, user.password)) {
      console.log("User PW checking,Not passwrod");
      return res.status(401).send({ auth: false, token: null });
    }

    var jwt = nJwt.create({ id: user.id }, config.secret);
    jwt.setExpiration(new Date().getTime() + (24*60*60*1000));
    console.log("Successfully Logged in");
    res.status(200).send({ auth: true, token: jwt.compact() });
    });
 
});


router.get('/profile1', jwtAuth, function(req, res, next) {
  let sql = "SELECT * FROM users WHERE id= ?  ";
  console.log(req.userId);
  conn.query(sql, [ req.userId ], function (err, user) {
    if (err) {
      return res.status(500).send("There was a problem finding the user.");
    }
   
    if (!user) {
      return res.status(404).send("No user found.");
    }
    user = JSON.parse(  JSON.stringify(user[0]) );
    console.log("user",user);
    res.status(200).send(user);
  });
  
});

router.get('/profile', jwtAuth, function(req, res, next) {
  let sql = "SELECT users.id,username,email,rank_name,firstname,middlename,lastname,active,profile_image,rank_name  FROM users  LEFT JOIN user_profile ON user_id = users.id LEFT JOIN ranks ON rank = ranks.id LEFT JOIN types ON users.type = types.id " ;
  console.log(req.userId);
  conn.query(sql,  function (err, user) {
    if (err) {
      return res.status(500).send("There was a problem getting the user.");
    }
    if (!user) {
      return res.status(404).send("No user found.");
    }
    user = JSON.parse(  JSON.stringify(user) );
    // console.log("user",user);
    res.status(200).send(user);
  });
  
});
module.exports = router;
