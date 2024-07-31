const express = require('express');
const mysql = require('mysql2');
const app = express();
const multer = require('multer');
const path = require('path');
const bodyParser = require('body-parser');

// Create MySQL connection
const connection = mysql.createConnection ({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'webapplication_database'
});
connection.connect((err) => {
    if (err) {
        console.error('Error connecting to MySQL:', err);
        return;
    }
    console.log('Connected to MySQL database');
});

// Set up view engine
app.set('view engine', 'ejs');

// enable static files
app.use(express.static('public'));
// enable form processing
app.use(express.urlencoded({
    extended: false}));

//set up image 
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'public/images'); // Directory to save uploaded files
  },
  filename: (req, file, cb) => {
    cb(null, file.originalname);
  }
});

const upload = multer({ storage: storage });

module.exports = upload;




//Setting the routes
app.get('/', function(req, res) {
  res.render('homePage');
});


app.get('/searchLocation', (req, res) => {
  const sql = 'SELECT * FROM locations_table';
  connection.query(sql, (error, results) => {
    if (error) {
      // ... error handling as before
    } else if (results.length === 0) {
      // No locations found, send appropriate response
      return res.status(200).send('No locations found.');
    } else {
      res.render('searchLocation', { locations_table: results });
    }
  });
});


app.get('/locationInformation/:id', (req, res) => {
  // Extract the location ID from the request parameters
  const locationId = req.params.id;
  const sql = 'SELECT * FROM locations_table WHERE locationId = ?';
  // Fetch data from MySQL based on the location ID
  connection.query(sql,[locationId], (error, results) => {
      if (error) {
          console.error('Database query error:', error.message);
          return res.status(500).send('Error Retrieving location by ID');}
      // Check if any location with the given ID was found
      if (results.length > 0) {
          // Render HTML page with the location data
          res.render('locationInformation', { locations_table: results[0]});
      } else {
          // If no location with the given ID was found, render a 404 page or handle it accordingly
          res.status(404).send('location not found');
      }
  });
});

app.get('/favLocations', (req, res) => {
  const sql = 'SELECT * FROM fav_locations';
  connection.query(sql, (error, results) => {
    if (error) {
      // error handling 
    } 
     else {
      res.render('favouriteLocations', { fav_locations: results });
    }
  });
});



app.get('/addLocation', (req, res) => {
  res.render('addLocation');
});

app.post('/addLocation',upload.single('image'), (req, res) => {
  // Extract data from the request body
 
  let image; 
  if (req.file){image = req.file.filename;} 
  else{image = null;} 

  const { location_name,weather_condition,temperature,humidity,wind,proverb } = req.body;

  const sql = 'INSERT INTO locations_table (location_name,weather_condition,temperature,humidity,wind,image,proverb) VALUES (?, ?, ?, ?, ?, ?, ?)';

  // Insert into the database
  connection.query(sql, [location_name, weather_condition,temperature,humidity,wind,image,proverb], (error, results) => {
      if (error) {
          // Handle any error that occurs during the database operation
          console.error('Error adding location:', error);
          res.status(500).send('Error adding location Data');
      } else {
          // Send a success response
          res.redirect('/searchLocation');
      }
  });
});

app.get('/addFavLocation', (req, res) => {
  const sql = 'SELECT * FROM locations_table';
  connection.query(sql, (error, results) => {
    if (error) {
      // ... error handling as before
    } else if (results.length === 0) {
      // No locations found, send appropriate response
      return res.status(200).send('No locations found.');
    } else {
      res.render('addFavLocation', { locations_table: results });
    }
  });
});

app.get('/addFavLocation/:id', (req, res) => {
  // Extract the location ID from the request parameters
  const locationId = req.params.id;
  const sql = 'INSERT INTO fav_locations (locationId, name) SELECT locationId, location_name FROM locations_table WHERE locationId = ? ';
  // Insert the new product into the database
  connection.query(sql, [locationId], (error, results) => {
      if (error) {
          // Handle any error that occurs during the database operation
          console.error('Error adding Location:', error);
          res.status(500).send('Error inserting data');
      } else {
          // Send a success response
          res.redirect('/favLocations');
      }
  });
});


app.get('/deleteLocation/:id', (req, res) => {
  const locationId = req.params.id;

  const sql = 'DELETE FROM locations_table WHERE locationId = ?';
  connection.query(sql, [locationId], (error, results) => {
    if (error) {
      console.error("Error deleting location:", error);
      return res.status(500).send('Error deleting location');
    }
    res.redirect('/searchLocation');
  });
});



app.get('/editLocation/:id', (req, res) => {
  const locationId = req.params.id;
  const sql = 'SELECT * FROM locations_table WHERE locationId = ?';
  // Fetch data from MySQL based on the student ID
  connection.query(sql, [locationId], (error, results) => {
      if (error) {
  console.error('Database query error:', error.message);
  return res.status(500).send('Error retrieving location by ID');}
  // Check if any location with the given ID was found
  if (results.length > 0) {            // Render HTML page with the student data
  res.render('editLocation', { locations_table: results [0] });
  } else { // If no location with the given ID was found, render a 404 page or handle it accordingly
  res.status (404).send('Location not found');}
  
  });                                
  
  });
  
  app.post('/editLocation/:id',upload.single('image') ,(req, res) => {
  const locationId = req.params.id;

  let image = req.body.currentImage;
  if (req.file){image = req.file.filename;}
  
  const { location_name,weather_condition,temperature,humidity,wind,proverb } = req.body;

  const sql = 'UPDATE locations_table SET location_name=?, weather_condition=?, temperature=?, humidity=?, wind=?, proverb=?, image=? WHERE locationId = ?';
  connection.query(sql,[location_name,weather_condition,temperature,humidity,wind,proverb,image, locationId], (error, results) => {
      if (error) {
      console.error("Error updating location:", error);
      return res.status(500).send('Error updating location');
      }
      res.redirect('/searchLocation');
  });
  });





app.get('/quiz', (req, res) => {
const randomNumber = Math.floor(Math.random() * 13) + 1;
const quizID = `/quiz/${randomNumber}`
res.redirect(quizID)
})

app.get('/quiz/:id', (req, res) => {
  // Extract the location ID from the request parameters
  const quizId = req.params.id;
  const sql = 'SELECT * FROM quiz_table WHERE quizId = ?';
  // Fetch data from MySQL based on the location ID
  connection.query(sql,[quizId], (error, results) => {
      if (error) {
          console.error('Database query error:', error.message);
          return res.status(500).send('Error Retrieving Quiz by ID');}
      // Check if any location with the given ID was found
      if (results.length > 0) {
          // Render HTML page with the location data
          res.render('quiz', { quiz_table: results[0]});
      } else {
          // If no location with the given ID was found, render a 404 page or handle it accordingly
          res.status(404).send('Quiz not found');
      }
  });
});



const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
  