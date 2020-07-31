=begin
The filename we use to save and load data (menu items 3 and 4) is hardcoded.
Make the script more flexible by asking for the filename if the user chooses these menu items.
=end

@students = [] #empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file"
  puts "4. Load a list from a file"
  puts "9. Exit" #9 because we'll add more items
end

def interactive_menu
  loop do
    puts "What would you like to do? (select a number)"
    print_menu # print the menu and ask the user what to do
    process(STDIN.gets.chomp) # read the input and do what the user has asked
  end
end

def choose_a_file
  puts "Please enter a filename or press enter for the default file 'students.csv':"
  file = gets.strip
  if file == ""
    file = "students.csv"
  end
  file
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students(choose_a_file)
    when "4"
      load_students(choose_a_file)
    when "9"
      puts "Exiting program"
      exit # this will cause program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

def choose_cohort
  cohorts = ['January','February','March','April','May','June',
    'July', 'August','September','October','November','December']
  puts "Cohort?"
  cohort = gets.chomp
  until cohorts.include?(cohort)
    cohort = gets.chomp
  end
  cohort
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp # get the first name
  # while the name is not empty, repeat this code
  while !name.empty? do
    update_student_array(name,choose_cohort)
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp # get another name from the user
  end
end

def update_student_array(name, cohort)
  @students << {name: name, cohort: cohort}
end

def show_students
  print_header
  print_student_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each_with_index do |student, index|
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have 1 great student" if @students.count == 1
  puts "Overall, we have #{@students.count} great students" if @students.count > 1
  puts "Currently we have 0 students" if @students.count == 0
end

def save_students(filename)
  file = File.open(filename, "w") #open the file for writing
  @students.each do |student| #iterate over the array of students
    student_data = [student[:name], student[:cohort]] #create array of student
    csv_line = student_data.join(",") #convert to string
    file.puts csv_line
  end
  file.close
  puts "Students saved to #{filename}"
end

def load_students(filename)
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    update_student_array(name, cohort)
  end
  file.close
  puts "Students uploaded from #{filename}"
end

def try_load_students
  ARGV.first.nil? ? filename = "students.csv" : filename = ARGV.first #first argument from the command line
  if File.exists?(filename) #if it exists
    load_students(filename)
    puts "Loaded #{@students.count} students from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist"
    exit #quit the progam
  end
end

try_load_students
interactive_menu
