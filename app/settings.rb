require 'settingslogic'
require 'environments'

class Settings < Settingslogic
  source "#{Dir.pwd}/config/application.yml"
  namespace Environments.current
end