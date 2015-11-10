

namespace :debweb do

  task :setup => :environment do

    `dpkg -l aptly`
    puts "You need to install aptly!\n\n" unless $?.success?

    puts "Setting up a new user"

    setup_user = false
    while !setup_user
      username = "admin"
      print "Username: (#{username}): "
      username = (STDIN.gets.chomp.empty?) ? username : STDIN.gets.chomp

      email = "admin@example.com"
      print "Email: (#{email}): "
      email = (STDIN.gets.chomp.empty?) ? email : STDIN.gets.chomp

      print "Password: "
      password = STDIN.noecho(&:gets).chomp
      puts ""

      print "Confirm: "
      confirm = STDIN.noecho(&:gets).chomp

      puts ""
      puts ""

      puts "ERROR: Passwords don't match\n" or next unless password == confirm

      begin
        User.new(name: username, email: email, password: password).save!
      rescue => e
        puts "ERROR: #{e.message} \n\n"
        next
      end

      puts "DONE! Login with #{email} and your password."

      setup_user = true
    end


  end

end