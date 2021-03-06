require 'rubygems'
require 'bundler/setup'
require 'tilt'
require 'erb'
require 'webrick'
require 'yaml'

ROOT = File.dirname(__FILE__)

PORT = ENV["PORT"] || 8000

server = WEBrick::HTTPServer.new(:Port => PORT)

server.mount '/assets', WEBrick::HTTPServlet::FileHandler, "#{ROOT}/assets"

server.mount_proc '/' do |req, res|
  # data = YAML.load_file('data.yml')
  template = Tilt.new("#{ROOT}/assets/index.slim")
  res.body = template.render
end

server.mount_proc '/index.css' do |req, res|
  res.body = Tilt.new("#{ROOT}assets/styles/index.sass").render
end

trap 'INT' do
  server.shutdown
end

server.start