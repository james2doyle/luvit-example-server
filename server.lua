local pathJoin = require('path').join
local createServer = require('web').createServer
local static = require('static')
local rootdir = pathJoin(__dirname, 'public')

-- Define a simple custom app
local function app(req, res)
end

app = require('routes')(app)

-- Serve static files and index directories
app = static(app, {
    root = rootdir,
    index = "index.html",
    autoIndex = true
  })

-- Log all requests
app = require('log')(app)

-- Add in missing Date and Server headers, auto chunked encoding, etc..
app = require('cleanup')(app)

local server = createServer("0.0.0.0", 8888, app)
p("http server listening on ", server:getsockname())

