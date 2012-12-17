#!/usr/bin/env ruby

require 'base64'
require 'awesome_print'

NAME = 'Decode Rails Session'

module SessionTools

  def decode_session(session)
    return unless session
    decoded = Base64.decode64(session)
    demarshalled = Marshal.load(decoded)
    $burp.alert(demarshalled)
  end
  
  def encode_session(session)
    return unless session
    marshalled = Marshal.dump(session)
    decoded = Base64.encode64(marshalled)
  end

end

class CustomMenuItem
include SessionTools

  def menu_item_clicked(*params)
    menu_item_caption, message_info = params
    
    message_info.each do |itm|
      if menu_item_caption == NAME
        decode_session(itm.response_headers)
      end
    end
  end
end

$burp.registerMenuItem(NAME, CustomMenuItem.new)
