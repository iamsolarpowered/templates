run "echo TODO > README"

# Gems
rake "rails:freeze:gems" if yes?('Freeze Rails?')

# Plugins
plugin 'authlogic', :git => 'git://github.com/binarylogic/authlogic.git'
plugin 'tapioca', :git => 'git://github.com/iamsolarpowered/tapioca.git'

# Welcome Controller
run 'rm public/index.html'
generate :controller, 'Welcome', 'index'
route "map.root :controller => 'welcome'"

# Migrate Database and Copy Standard Files
rake 'bootstrap'

# Git
git :init
file ".gitignore", <<-END
.DS_Store
config/database.yml
config/deploy.rb
config/initializers/session_store.rb
config/initializers/email.rb
db/*.db
db/*.sqlite3
log/*
public/system/*
tmp/**/*
END
run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run "cp config/database.yml config/example_database.yml"
git :add => ".", :commit => "-m 'initial commit'"
