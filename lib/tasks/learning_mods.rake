namespace :test do

  desc 'Measures test coverage'
  task :coverage do
    rm_f "coverage"
    rm_f "coverage.data"
    rcov = "rcov --rails --aggregate coverage.data --text-summary -Itest"
    system("#{rcov} --no-html test/unit/*_test.rb")
    system("#{rcov} --html test/functional/*_test.rb")
    #system("#{rcov} --html test/integration/*_test.rb")
    system("firefox coverage/index.html") if PLATFORM.include? "linux"
  end

end