
###
Module dependencies.
###
express = require("express")
routes = require("./routes")
user = require("./routes/user")
http = require("http")
path = require("path")
api = require("./routes/api")
login = require("./routes/login")

app = express()


#expose templates to all views
app.set 'partials',
  head: 'partials/head'

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", path.join(__dirname, "views")
app.engine "html", require("hogan-express")
app.set "view engine", "html"
app.use express.favicon()
app.use express.logger("dev")
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use app.router
app.use express.static(path.join(__dirname, "public"))
app.use express.static(path.join(__dirname, 'bower_components'))

# development only
app.use express.errorHandler()  if "development" is app.get("env")
app.get "/", routes.index
app.get "/users", user.list
app.get "/api", api.api
app.get "/login", login.login
http.createServer(app).listen app.get("port"), ->
    console.log "Express server listening on port " + app.get("port")