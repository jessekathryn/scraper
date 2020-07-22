class Scraper::Job
  
  attr_accessor :job, :name, :url, :summary, :date, :qualifications, :description
    
   def self.scrape_search_page
    page = Nokogiri::HTML(open("https://careers.google.com/jobs/results/?company=Google&company=Google%20Fiber&company=YouTube&employment_type=FULL_TIME&hl=en_US&jlo=en_US&location=New%20York,%20NY,%20USA&q=software%20engineering&sort_by=relevance"))
    jobs = []
    page.css("div.gc-card__header").each do |a|
    job_hash = {}
      job_hash[:name] = h2.text.strip  
      job_hash[:url] = a.attribute("href").value
      jobs << job_hash
      jobs
    end 
    jobs
  end
  
 
  def self.scrape_job_page(url)
    page = Nokogiri::HTML(open(url))
    job_page = {}
    #job_page[:name] = page.css("h1.headline").text
    #job_page[:url] = page.css("div.taxonomy-seo-links a").attr("href")
    job_page[:summary] = page.css("p").text.strip
    job_page[:qualifications] = page.css("ul").text.strip
    # job_page[:date] = page.css("div.timestamp").text.strip
    # job_page[:text] = page.css("p").text.chomp.strip.split.join(" ")
    job_page
  end
end 