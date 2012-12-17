require 'rubygems'
require 'savon'
require 'nokogiri'


class CustomMenuItem
  
  
  def enum_wsdl(rhost)
    client = Savon::Client.new("#{rhost}")
    # Comment out the client.http.auth.basic line below if not required.
    client.http.auth.basic("guest", "guest")
    client.http.proxy = "http://127.0.0.1:8080"
    if (client.respond_to?('wsdl')) and (client.wsdl.respond_to?('soap_actions'))
      puts("\n\e[1m\e[35m-{*}-\e[0m List of available action(s):" + "\n")
      client.wsdl.soap_actions.each do |action|
        puts("\n\e[1m\e[32m-{+}-\e[0m #{action}" + "\n")         
      end
    end       
  rescue => $!
    puts("\e[1;31m-{-}-\e[0m #{$!}")
  end
  
  def parse_wsdl(wsdl)
    wsdl_element_hash = {}
    doc = Nokogiri::XML(wsdl)
    msg = doc.xpath("//wsdl:message")
    test_m1 = nil
    test_m2 = nil
    msg.each do |m|
     m1 = m.to_s.match(/name="(.*)Request"/)
     m2 = m.to_s.match(/name="(.*)" type="(.*)"/)
     test_m1 = m1.kind_of?(MatchData) ? m1[1] : nil
     test_m2 = m2.kind_of?(MatchData) ? m2[1] : nil
     
     if !test_m1.nil? and !test_m2.nil?
         wsdl_element_hash[test_m1] = test_m2
     end
    end
    return wsdl_element_hash
  end
  
  def form_request(rhost)
    client = Savon::Client.new("#{rhost}")
    client.http.auth.basic("guest", "guest")
    client.http.proxy = "http://127.0.0.1:8080"
    wsdl = client.wsdl.to_xml
    wsdl_hash = parse_wsdl(wsdl)
    client.wsdl.soap_actions.each {|itm|
      if wsdl_hash.has_key?(itm.to_s.lower_camelcase)
        begin
        k = ":" + "#{itm}"
        v = ":" + "#{wsdl_hash[itm.to_s.lower_camelcase]}"
         eval("client.request #{k} do
          soap.body = { #{v} => 101 }
         end")
        rescue
        end
    end 
    }
  end
  
  def menu_item_clicked(*params)
    menu_item_caption, message_info = params
            
    message_info.each do |itm|
      if menu_item_caption == "enumerate wsdl"
        enum_wsdl(itm.url)
      elsif menu_item_caption == "form SOAP request"
        form_request(itm.url)
      end  
    end
  end
  
end

$burp.registerMenuItem("enumerate wsdl", CustomMenuItem.new)
$burp.registerMenuItem("form SOAP request", CustomMenuItem.new)



