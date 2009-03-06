# Copy database.yml
run "cp config/database.yml config/database.sample.yml"

# Delete unnecessary files
run "rm README"
run "rm public/index.html"

# Set up git
git :init
git :add => '.'

# Install plugins
plugin 'rspec', :git => 'git://github.com/dchelimsky/rspec.git', :submodule => true
plugin 'rspec-rails', :git => 'git://github.com/dchelimsky/rspec-rails.git', :submodule => true
plugin 'i18n_generators', :git => 'git://github.com/amatsuda/i18n_generators.git', :submodule => true

# Add .gitignore
run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
file '.gitignore', <<-END
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
db/schema.rb
END

# Execute generator
generate("rspec")
generate("i18n ja")

# Commit git
git :submodule => "init"
git :add => "."
git :commit => "-a -m 'First commit.'"
