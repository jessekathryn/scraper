class Scraper::Job
  
attr_accessor :job, :name, :url, :summary, :date, :qualifications, :description

  @@all = []

  def initialize(job_hash)
    job_hash.each {|key, value| self.send(("#{key}="), value)}
        @@all << self
  end

  def self.create_from_collection(jobs_array)
    jobs_array.each do |job|
      self.new(job)
    end
  end

  def add_job_attributes(job_page)
    job_page.each {|key, value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all
  end 
end