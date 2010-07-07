# Delete unnecessary files
run "rm README"
run "rm public/index.html"

# gitignore
file '.gitignore', <<-END
.DS_Store
log/*.log
tmp/**/*
db/*.sqlite3
db/schema.rb
END

# Commit git
git :init
git :add => "."
git :commit => "-a -m 'First commit.'"

