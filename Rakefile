
NAME = "I-demand-food-human"
APP_NAME = "I demand food, human!.app"
EXE_NAME = "#{NAME}.exe"
LOVE_NAME = "#{NAME}.love"
MAC_ZIP_NAME = "#{NAME}-MacOS.zip"
WIN_ZIP_NAME = "#{NAME}-Win64.zip"


task default: %w[package_mac package_win]


desc "Create .love file"
task :zip do
  FileUtils.rm "dist/#{LOVE_NAME}", force: true

  puts `zip -9 -r "dist/#{LOVE_NAME}" . --include \\*.lua \\*.png --exclude test/*`
end


desc "List contents of the zip file"
task :ls => :zip do
  puts `unzip -vl "dist/#{LOVE_NAME}"`
end


desc "Inject the zip into the mac app bundle"
task :inject_mac => :zip do
  FileUtils.rm "dist/#{APP_NAME}/Contents/Resources/#{LOVE_NAME}", force: true
  FileUtils.cp "dist/#{LOVE_NAME}", "dist/#{APP_NAME}/Contents/Resources/"
end


desc "Generate a mac app, packaged inside a zip file"
task :package_mac => :inject_mac do
  FileUtils.cd "dist" do
    FileUtils.rm MAC_ZIP_NAME, force: true
    puts `zip -9 -r "#{MAC_ZIP_NAME}" "#{APP_NAME}"`
  end
end


desc "Inject the zip into the windows exe"
task :inject_win => :zip do
  FileUtils.rm "dist/win64/#{EXE_NAME}", force: true
  puts `cat dist/win64/love.exe "dist/#{LOVE_NAME}" > "dist/win64/#{EXE_NAME}"`
end


desc "Generate a windows exe, packaged inside a zip file"
task :package_win => :inject_win do
  FileUtils.cd "dist/win64" do
    FileUtils.rm "../#{WIN_ZIP_NAME}", force: true
    puts `zip -9 -r "../#{WIN_ZIP_NAME}" "#{EXE_NAME}" *.dll`
  end
end
