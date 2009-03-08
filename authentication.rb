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
plugin 'restful-authentication', :git => 'git://github.com/technoweenie/restful-authentication.git', :submodule => true
plugin 'open_id_authentication', :git => 'git://github.com/rails/open_id_authentication.git', :submodule => true
plugin 'role_requirement', :git => 'git://github.com/timcharper/role_requirement.git', :submodule => true

# Add .gitignore
run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run %{find . -type d -empty | grep -v "vendor" | grep -v ".git" | grep -v "tmp" | xargs -I xxx touch xxx/.gitignore}
file '.gitignore', <<-END
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
db/schema.rb
END

# gems
gem 'ruby-openid'

# Execute generator
generate :rspec
generate("authenticated", "user session")
generate :i18n, "ja" 
generate :roles, "Role User" 

# Commit git
git :submodule => "init"
git :add => "."
git :commit => "-a -m 'First commit.'"
