class BlogController < ApplicationController
  def post
    render "/#{self.controller_name}/#{params[:title]}/index.html"
  end

  def proxy
    path = params[:id] || ""
    path += "/index.html" if path.match(/\S+\.\S+$/).nil?
    render "/blog" + path
  end

end