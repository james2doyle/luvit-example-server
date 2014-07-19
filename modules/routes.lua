local function switch (t)
  t.case = function (self,x)
    local f = self[x] or self.default
    if f then
      if type(f) == "function" then
        f(x,self)
      else
        error("case "..tostring(x).." not a function")
      end
    end
  end
  return t
end

return function (app)
  return function (req, res)
    local routes = switch {
      ['/greet'] = function ()
        return res(200, {
            ["Content-Type"] = "text/plain",
            ["Content-Length"] = 12
        }, "Hello World\n")
      end,
      ['/dismiss'] = function ()
        return res(200, {
            ["Content-Type"] = "text/plain",
            ["Content-Length"] = 17
        }, "Goodbye Universe\n")
      end,
      default = function ()
        res(404, {
            ["Content-Type"] = "text/plain",
            ["Content-Length"] = 10
        }, "Not Found\n")
      end,
    }
    routes:case(req.url.path)
  end
end