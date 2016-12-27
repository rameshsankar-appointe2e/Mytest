#!/usr/bin/ruby
# See the README for how to use this.

require 'rubygems'
require 'octokit'
require 'faraday'
require 'csv'

# BEGIN INTERACTIVE SECTION
# Comment out this section (from here down to where the end is marked) if you want to use this interactively
=begin
puts "Username:"
username = gets.chomp  
if username == ""
	abort("You need to supply a username. Thank you, come again.")
end

puts "Password:"
password = gets.chomp  
if password == ""
	abort("You need to supply a password. Thank you, come again.")
end

puts "Path for the CSV file you want to use?"
input_file = gets.chomp  
if input_file == ""
	abort("You need to supply a CSV file. Thank you, come again.")
end

puts "Organization?"
org = gets.chomp  
if org == ""
	abort("You need to supply an organization. Thank you, come again.")
end

puts "Repository?"
repo = gets.chomp  
if repo == ""
	abort("You need to supply a repository. Thank you, come again.")
end
=end
# END INTERACTIVE SECTION


# BEGIN HARD-CODED SECTION
# Un-comment out this section (from here down to where the end is marked) if you want to use this without any interaction
# All of these need to be filled out in order for it to work

#input_file = "https://github.com/rameshsankar-appointe2e/Mytest/tree/master/Book1.csv"

input_file = "/home/guestuser/Mytest/Mytest/Book2.csv"
username = "rameshsankar-appointe2e"
password = "Pa55w0rd"
org = "rameshsankar-appointe2e"
repo = "Mytest"

 # END HARD-CODED SECTION

org_repo = org + "/" + repo

#client = Octokit::Client.new(:login => 'ctshryock', :password => 'secret')
#client.authorization(999999)

client = Octokit::Client.new(:login => username, :password => password)
#File.open(File.dirname(__FILE__) + '/text.txt').each {|line| puts line}
csv_text = File.read(input_file)
csv = CSV.parse(csv_text, :headers => true)

csv.each do |row|
	#File.open(File.dirname(__FILE__) + '/text.txt').each {|line| puts line}
	client.close_issue(org_repo,row['number'],options = {
		:number => row['number'],
		:title => row['Title'],
		:description => row['description'],
		:labels => [row['Label1'],row['Label2']],
		:milestone => row['milestone'],
		:state => row['Status'],
		:assignee => row['assignee_username'],
		:mentioned => row['mentioned'],
		:creator => row['creator']}) 
	#Add or remove label columns here.
	
	puts "Imported issue:  #{row['Title']}" 
		
end
