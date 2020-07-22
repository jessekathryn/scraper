class Scraper::CLI 
  
    def home
      puts "
                              Google Search SDE 
  _________________________________________________________________________
  Find the latest jobs at Google (entry-level positions with limited 
  experience required to apply)
  _________________________________________________________________________
  "
  
      input = nil
       while input != "exit"
        input = gets.strip
        case input
         when "EXIT" 
           exit
         when "NO"
           exit
         when "YES"
           puts "_________________________________________________________________________
  Loading..."
           jobs
           menu
        end
      end
    end
  
    def jobs 
     jobs_data = Scraper::Scraper.scrape_search_page
      Scraper::Jobs.create_from_collection(jobs_data)
        display_jobs
    end
  
    def menu 
      input = nil
       while input != "exit"
        input = gets.strip
         if input == "exit"
           exit_cli
         elsif input.to_i <= 0 || input.to_i > @all.count
           puts "Please enter a number between 1-#{@all.count}"
           display_jobs
         elsif  input.to_i > 0 && input.to_i <= @all.count
           display_details(input.to_i)
           puts "Complete!...
            
  SCROLL UP to read entire job posting
  _________________________________________________________________________
  - EXIT to quit or - BACK to return to job list
  "
          else 
            puts "Please pick a number to proceed"
            display_jobs
        end        
      end
    end 
        
    def display_jobs
      puts "_________________________________________________________________________
  New Jobs:
                                    "   
  
        @all = Scraper::Job.all
        @all.each.with_index(1) do |a, i|
          puts "|#{i}|  #{a.name}"
        end
      puts"
  Enter a number to read the job desciption and view details
  _________________________________________________________________________"
     end
   
   def display_details(input)  
  
    if input.to_i <= @all.count
       the_job = @all[input.to_i - 1]
  
    puts "
  _________________________________________________________________________
  
  Loading...
  _________________________________________________________________________"
      #the_job = Scraper::job.all
     if !the_job.summary
      attributes = Scraper::Scraper.scrape_job_page(the_job.url)
      the_job.add_job_attributes(attributes)
     end
  puts"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  '#{the_job.name}: 
  #{the_job.summary}'
  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -    
  #{the_job.qualifications}      
  #{the_job.date}  
  
  Text: '#{the_job.description}' 
  _________________________________________________________________________" 
       end
     end
     
      
    def exit_cli
      puts "
  _________________________________________________________________________
  Thank you for using Google Scraper!  Have a nice day~
  _________________________________________________________________________"
  
      exit
    end 
  end
  