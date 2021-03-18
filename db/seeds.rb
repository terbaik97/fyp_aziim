migrate_id = "[migrate:data-seed:#{DateTime.current.to_i}]"

def log(message)
  Rails.logger.info("#{@migrate_id} #{message}")
  puts message
end

Dir[Rails.root.join("db", "methods", "**/*.rb")].each do |file|
  load(file)
end

load(Rails.root.join( "db", "seeds", "seed-shared.rb"))
log("Done shared seed ~")

env = ENV["ENV"]&.downcase || Rails.env.downcase

load(Rails.root.join( "db", "seeds", "seed-#{env}.rb"))

log("Done #{env} seed ~")
