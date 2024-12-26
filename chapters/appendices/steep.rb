# rbs_inline: enabled

class App
  # @rbs host: String
  # @rbs port: Integer
  # @rbs debug: bool
  def run(host:, port:, debug: false)
    if debug != true && debug != false
      raise "Argument debug is not Boolean!"
    end
  end
end
app = App.new

# @type var args0: { host: String, port: Integer, debug: bool }
args0 = { host: "0.0.0.0", port: 80, debug: true }
app.run(**args0) # OK!

# @type var args1: { host: String, port: Integer }
args1 = { host: "0.0.0.0", port: 80 }
app.run(**args1) # OK!

# @type var args2: { host: String, port: Integer, debug: String }
args2 = { host: "0.0.0.0", port: 80, debug: "Oops!" }
app.run(**args2) # TypeError: ArgumentTypeMismatch!

class App
  # @rbs args: { host: String, port: Integer, debug: String }
  # @rbs return: { host: String, port: Integer }
  def f(args) = args
end

# @type var args3: { host: String, port: Integer }
args3 = app.f(args2)
app.run(**args3) # Type-checks in Steep, but has a runtime error:
                 # Argument debug is not Boolean!
