require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

def continue
  puts
  print "Appuyez sur ENTREE pour continuer"
  gets
  puts
end


def get_the_email_of_a_townhal_from_its_webpage (url)
liste_temp=Hash.new
url=url[1..-1]
page = Nokogiri::HTML(open("http://annuaire-des-mairies.com"+url))
email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
end

def get_all_the_urls_of_val_doise_townhalls
  liste = Array.new
  page = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))
  array = page.css('a.lientxt')
  array.each do |link|
    liste_temp=Hash.new
    name = link.text
    email = get_the_email_of_a_townhal_from_its_webpage(link['href'])
    liste_temp["name"] = name
    liste_temp["email"] = email
    liste.push(liste_temp)
  end
  puts liste
end


def market_value
  loop do
    i=0
    name_arr=[]
    value_arr=[]
    answer = Array.new
    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
    crypt_data_name = page.css('table#currencies-all tbody a.currency-name-container')
    crypt_data_name.each {|name| name_arr.push(name.text)}
    crypt_data_value = page.css('table#currencies-all tbody a.price')
    crypt_data_value.each {|name| value_arr.push(name.text)}
    name_arr.each do |name|
      temp = Hash.new
      temp['Name'] = name
      temp['Value'] = value_arr[i]
      i+=1
      answer.push(temp)
    end
    puts answer
    sleep(15)
    t=15
    while t !=3600
      system('clear')
      print "Prochaine mise a jour dans 1 heure"
      sleep(1)
      t+=1
      print "."
      sleep(1)
      t+=1
      print "."
      sleep(1)
      t+=1
      print "."
      sleep(1)
      t+=1
      print "."
      sleep(1)
      t+=1
      print "."
      sleep(3)
      t+=3
    end
  end
end



def get_the_email_of_deputee(url)
  temp_email_array=[]
  liste_temp=Hash.new
  page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr"+url))
  linker = page.css('div#deputes-contact a.email')
  linker.each do |mailto|
    t_email = mailto['href']
    temp_email_array.push(t_email[7..-1])
  end
  return temp_email_array
end

def get_deputees
  liste = Array.new
  page = Nokogiri::HTML(open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
  array = page.css('div#deputes-list a')
  array.each do |link|
    temp_hash=Hash.new
    full_name = link.text.split
    if full_name[0] == "M." || full_name[0] == "Mme"
      first_name = full_name[1]
      last_name = full_name[2]
      i=3
      while full_name[i] != nil
        last_name = last_name + " " + full_name[i]
        i+=1
      end
      email = get_the_email_of_deputee(link['href'])
      temp_hash['First name']=first_name
      temp_hash['Last name']=last_name
      temp_hash['Email']=email
      liste.push(temp_hash)
    end
  end
  puts liste
end


get_all_the_urls_of_val_doise_townhalls
continue
get_deputees
continue
market_value
