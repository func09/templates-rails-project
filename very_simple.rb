# Copy database.yml
run "cp config/database.yml config/database.sample.yml"

# Delete unnecessary files
run "rm README"
run "rm public/index.html"

# Set up git
git :init

# Install plugins

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

# Execute generator
generate :rspec

# Commit git
git :add => "."
git :commit => "-a -m 'First commit.'"
