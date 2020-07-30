# Our code only works with the student name and cohort. Add more information: hobbies, country of birth, height, etc.

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november, hobbies: '', country_of_birth: '', height: ''}
    puts "Add hobbies?"
    students[-1][:hobbies] = gets.chomp
    puts "Add country of birth?"
    students[-1][:country_of_birth] = gets.chomp
    puts "Add height?"
    students[-1][:height] = gets.chomp
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end
def print(students)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort):
    hobbies: #{student[:hobbies]}, born: #{student[:country_of_birth]}, height: #{student[:height]}"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great student(s)"
end

#nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
