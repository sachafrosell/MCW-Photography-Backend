# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

`rails db:reset`
run Rails.application
Cloudinary::Api.root_folders(Rails.application.credentials.cloudinary)["folders"].each do |n|
  Album.create(title: n["name"])
end
#
Cloudinary::Api.resources(Rails.application.credentials.cloudinary)["resources"].each do |n|
  album = n["public_id"].scan(/\d+|[A-Za-z]+/)[0]
  puts n["public_id"]
  url = n["url"]
  id = Album.find_by(title: album).id
  Image.create(url: url, album_title: album, album_id: id)
end
