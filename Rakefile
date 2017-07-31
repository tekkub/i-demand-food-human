
NAME = "I demand food, human!"
APP_NAME = "#{NAME}.app"
LOVE_NAME = "#{NAME}.love"
ZIP_NAME = "#{NAME}.zip"


task default: %w[package]


desc "Create .love file"
task :zip do
  FileUtils.rm "dist/#{LOVE_NAME}", force: true

  puts `zip -9 -r "dist/#{LOVE_NAME}" . --include \\*.lua \\*.png --exclude test/*`
end


desc "List contents of the zip file"
task :ls => :zip do
  puts `unzip -vl "dist/#{LOVE_NAME}"`
end


desc "Inject the zip into the app bundle"
task :inject => :zip do
  FileUtils.rm "dist/#{APP_NAME}/Contents/Resources/#{LOVE_NAME}", force: true
  FileUtils.cp "dist/#{LOVE_NAME}", "dist/#{APP_NAME}/Contents/Resources/"
end


desc "Generate an OSX app, packaged inside a zip file"
task :package => :inject do
  FileUtils.cd "dist" do
    FileUtils.rm ZIP_NAME, force: true
    puts `zip -9 -r "#{ZIP_NAME}" "#{APP_NAME}"`
  end
end
