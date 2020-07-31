=begin
After we added the code to load the students from file,
we ended up with adding the students to @students in two places.
The lines in load_students() and input_students() are almost the same.
This violates the DRY (Don't Repeat Yourself) principle.
How can you extract them into a method to fix this problem?
=end

@students = [] #empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" #9 because we'll add more items
end

def interactive_menu
  loop do
    print_menu # print the menu and ask the user what to do
    process(STDIN.gets.chomp) # read the input and do what the user has asked
  end
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit # this will cause program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    add_students(@students, name)
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
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
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  #open the file for writing
  file = File.open("students.csv", "w")
  #iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]] #create array of student
    csv_line = student_data.join(",") #convert to string
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    add_students(@students, name, cohort.to_sym)
  end
  file.close
end

def add_students(file, name, cohort = :november)
  file << {name: name, cohort: cohort}
end

def try_load_students
  filename = ARGV.first #first argument from the command line
  return if filename.nil? # get out of method if it isn't given
  if File.exists?(filename) #if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist"
    exit #quit the progam
  end
end

try_load_students
interactive_menu
