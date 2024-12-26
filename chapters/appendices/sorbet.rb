# typed: true
require "sorbet-runtime"

class App
  extend T::Sig

  sig {params(host: String, port: Integer, debug: T::Boolean).void}
  def run(host:, port:, debug: false)
    if debug != true && debug != false
      raise "Argument debug is not Boolean!"
    end
  end
end
app = App.new

args0 = { host: "0.0.0.0", port: 80, debug: true }
app.run(**args0) # OK!

args1 = { host: "0.0.0.0", port: 80 }
app.run(**args1) # OK!

args2 = { host: "0.0.0.0", port: 80, debug: "Oops!" }
app.run(**args2) # TypeError: Expected T::Boolean
                 # but found String("Oops!") for argument debug!
class App
  sig do
    params(args: { host: String, port: Integer, debug: String })
    .returns({ host: String, port: Integer })
  end
  def f(args) = args
end

args3 = app.f(args2)
app.run(**args3)
# This call passes Sorbet's static type checking,
# but the Sorbet runtime raises a dynamic type error in App#f:
# Return value expected type {host: String, port: Integer},
# but got type {host: String, port: Integer, debug: String}!
