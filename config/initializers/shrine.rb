# frozen_string_literal: true

require 'shrine'

HOST_URL = ENV.fetch('HOST_URL')

if Rails.env.test?
  require 'shrine/storage/memory'
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
else
  require 'shrine/storage/file_system'
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'), # temporary
    store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads') # permanent
  }
end

url_options = {
  public: true,
  host: HOST_URL
}

Shrine.plugin :activerecord           # loads Active Record integration
Shrine.plugin :validation_helpers
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :restore_cached_data    # extracts metadata for assigned cached files
# Base64 support
Shrine.plugin :infer_extension
Shrine.plugin :determine_mime_type
Shrine.plugin :data_uri
Shrine.plugin :url_options, cache: url_options, store: url_options
