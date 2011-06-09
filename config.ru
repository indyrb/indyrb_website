use Rack::Static,
  :urls => ["/css", "/images", "/javascripts"],
  :root => "output"
  
@root = File.expand_path(File.dirname(__FILE__)) + '/output/'

run lambda { |env|
  path = Rack::Utils.unescape(env['REQUEST_PATH'])
  file = @root + "#{path}.html"
  index = @root + "index.html"
  headers = { 'Content-Type'  => 'text/html', 'Cache-Control' => 'public, max-age=86400' }
  
  if File.exists?(file)
    [200, headers, File.read(file)]
  else
    [200, headers, File.read(index)]
  end
}
