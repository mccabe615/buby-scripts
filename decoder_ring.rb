#!/usr/bin/env ruby

require 'java'
require 'base64'

import javax.swing.JFrame
import javax.swing.JPanel
import java.awt.Dimension

class MDecoder < JFrame
  
  def initialize
    super('@mccabe615\'s Decoder Ring')
    initUI
  end
  
  def initUI
    
     self.setPreferredSize Dimension.new(1300, 900)
     self.pack
     
     self.setDefaultCloseOperation JFrame::DO_NOTHING_ON_CLOSE
     self.setLocationRelativeTo nil
     self.setVisible true
  end
  
end

MDecoder.new

=begin

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
       
      end
    end
  end
end

$burp.registerMenuItem(NAME, CustomMenuItem.new)
=end
