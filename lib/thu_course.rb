require 'thu_course/version'
require 'thu_course/date'

require 'open-uri'
require 'nokogiri'
module ThuCourse
  def self.all(year, semester)
    uri = URI("http://course.service.thu.edu.tw/view-dept/#{year}/#{semester}/everything").normalize
    doc = Nokogiri::HTML(open(uri))
    hash = []
    a_tags = doc.css('.b a') # => array of node
    a_tags.each do |a_tag|
      name = a_tag.text.gsub(/\s+/, ' ').strip
      dp_uri = uri.merge(a_tag['href'].gsub('view-dept', 'view-ge'))
      dp_doc = Nokogiri::HTML(open(dp_uri))
      tr_tag = dp_doc.css('#no-more-tables tr')

      tr_tag.each do |tr|
        td_tag = tr.css('td')
        next unless td_tag[0]
        course_id = td_tag[0].css('a').text.strip
        name	= td_tag[1].text.strip
        credit	= td_tag[2].text.strip
        date	= td_tag[3].text.strip
        teacher = td_tag[4].text.strip
        num	= td_tag[5].text.strip.gsub(/\s+/, '')
        note	= td_tag[6].text.strip

        hash << { id: course_id,
                  name: name,
                  credit: credit,
                  date: date,
                  teacher: teacher,
                  num: num,
                  note: note }
      end
    end
    hash
  end

  def self.department_id(year, semester)
    uri = URI("http://course.service.thu.edu.tw/view-dept/#{year}/#{semester}/everything").normalize
    doc = Nokogiri::HTML(open(uri))
    a_tags = doc.css('.b a') # => array of node
    hash = []
    a_tags.each do |a_tag|
      name = a_tag.text.strip
      id = a_tag['href'].split('/').last
      hash << { id: id,
                name: name }
    end
    hash
  end

  def self.department(year, semester, id)
    uri = "http://course.thu.edu.tw/view-ge/#{year}/#{semester}/#{id}"
    dp_doc = Nokogiri::HTML(open(uri))
    tr_tag = dp_doc.css('#no-more-tables tr')
    hash = []
    tr_tag.each do |tr|
      td_tag = tr.css('td')
      next unless td_tag[0]
      course_id = td_tag[0].css('a').text.strip
      name    = td_tag[1].text.strip
      credit  = td_tag[2].text.strip
      date    = td_tag[3].text.strip
      date = date_change(date)
      teacher = []
      teacher_data = td_tag[4].css('a')
      teacher_data.each do |td|
        teacher_id = ''
        teacher_id = td['href'].split('/').last if td['href'].split('/').last != 'view-teacher-profile'
        teacher_name = td.text.strip
        teacher << { teacher_id: teacher_id, teacher_name: teacher_name }
      end
      num     = td_tag[5].text.strip.gsub(/\s+/, '')
      note    = td_tag[6].text.strip

      hash << { id: course_id,
                name: name,
                credit: credit,
                date: date,
                teacher: teacher,
                num: num,
                note: note }
    end
    hash
  end
end
