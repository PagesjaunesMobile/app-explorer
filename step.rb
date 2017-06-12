require 'open3'
def fail_with_message(message)
  puts "\e[31m#{message}\e[0m"
  exit(1)
end


#puts ARGV[0]
stdin, stdout, stderr, wait_thr = Open3.popen3("find $ANDROID_HOME  -regex '.*/25.*/aapt'")
aapts = stdout.gets(nil)
aapt = aapts.lines.last.chomp
stdout.close
stderr.close
cmd = "#{aapt} dump badging #{ARGV[0]}"
puts cmd
stdin, stdout, stderr, wait_thr = Open3.popen3(cmd)
result = stdout.gets(nil)
stdout.close
stderr.gets(nil)
stderr.close

exit_code = wait_thr.value
version = nil
if exit_code.success?
  match = result.match /versionCode=\'([^\']*)\'/
  version = match[1]
end

begin
  fail 'Failed to export APK_BUILD_VERSION' unless system("envman add --key APK_BUILD_VERSION --value '#{version}'")

  puts
  puts '## Success'
  puts "(i) the current build version #{version}"
rescue => ex
  fail_with_message(ex)
end

exit 0