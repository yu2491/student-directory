# Once you complete the previous exercise, change the way the users are displayed:
# print them grouped by cohorts.
# To do this, you'll need to get a list of all existing cohorts
# (the map() method may be useful but it's not the only option),
# iterate over it and only print the students from that cohort.

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  cohorts = ['January','February','March','April','May','June',
    'July', 'August','September','October','November','December']
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: ""}
    puts "Cohort?"
    cohort = gets.chomp
    until cohorts.include?(cohort)
      cohort = gets.chomp
    end
    students[-1][:cohort] = cohort.to_sym
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
  students_by_cohort = {}
  students.each do |student|
    cohort = student[:cohort]
    if students_by_cohort[cohort] == nil
      students_by_cohort[cohort] = []
    end
    students_by_cohort[cohort].push(student[:name])
  end
  students_by_cohort.each do |cohort,names|
    puts "#{cohort} cohort: #{names.join(", ")}"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

#nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
