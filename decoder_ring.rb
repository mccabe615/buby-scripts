#!/usr/bin/env ruby

require 'java'
require 'base64'

import java.awt.Dimension
import java.awt.FlowLayout
import javax.swing.JFrame
import javax.swing.JPanel
import java.awt.Dimension
import javax.swing.JTabbedPane
import javax.swing.JButton
import javax.swing.JTextArea
import javax.swing.GroupLayout
import javax.swing.JScrollPane
import javax.swing.JOptionPane
import javax.swing.JComboBox;

class EncodeButtonAndCbPanel < JPanel
  
  def initialize
    super(FlowLayout.new(FlowLayout::RIGHT))
    initUI
  end
  
  def initUI
     @jc1 = JComboBox.new
     ["Marshal", "Base64", "Rails Session Cookie"].each {|x| @jc1.addItem(x)}
     
      @encode_button = JButton.new("encode")
      @decode_button = JButton.new("decode")
     # add(@jc1)
     # add(@encode_button)
     # add(@decode_button)
   
      layout = GroupLayout.new self
      self.setLayout layout
      
      layout.setAutoCreateGaps true
      layout.setAutoCreateContainerGaps true
      
      sh1 = layout.createSequentialGroup
      sv1 = layout.createSequentialGroup
      p1 = layout.createParallelGroup
      
      layout.setHorizontalGroup sh1
      layout.setVerticalGroup sv1
      
      p1.addComponent(@jc1)
      p1.addComponent(@encode_button)
      p1.addComponent(@decode_button)
      sh1.addGroup(p1)
      
      sv1.addComponent(@jc1)
      sv1.addComponent(@encode_button)
      sv1.addComponent(@decode_button)
        
  end  
    
end

class MessagePanel < JPanel
  
  def initialize
    super()
    initUI
  end
  
  def initUI
    @exit_button = JButton.new("exit")
    @ta1 = JTextArea.new
    @ta1.editable = false
    @sp1 = JScrollPane.new(@ta1)
    
    @exit_button.add_action_listener do |e|
       $frame.close_it
    end
    
    layout = GroupLayout.new self
    self.setLayout layout
    
    layout.setAutoCreateGaps true
    layout.setAutoCreateContainerGaps true
     
    
    sh1 = layout.createSequentialGroup
    sv1 = layout.createSequentialGroup
    sv2 = layout.createSequentialGroup
    sv3 = layout.createSequentialGroup
    
    layout.setHorizontalGroup sh1
    layout.setVerticalGroup sv1
    
    sv2.addComponent(@sp1)
    sv3.addComponent(@exit_button)
    sv1.addGroup(sv2)
    sv1.addGroup(sv3)
    
    sh1.addComponent(@sp1)
    sh1.addComponent(@exit_button)
    
  end
  
end

class DecoderPanel < JPanel
  
  def initialize
    super()
    initUI
  end
  
  def initUI
    
    @ep = EncodeButtonAndCbPanel.new
    
    @jt1 = JTextArea.new
    @jt2 = JTextArea.new
    @jt1.setPreferredSize(Dimension.new(700,200))
    @jt2.setPreferredSize(Dimension.new(700,200))
    @js1 = JScrollPane.new(@jt1)
    @js2 = JScrollPane.new(@jt2)
    
    
    layout = GroupLayout.new self
    self.setLayout layout
    
    layout.setAutoCreateGaps true
    layout.setAutoCreateContainerGaps true
    
    sh1 = layout.createSequentialGroup
    sv1 = layout.createSequentialGroup
    sv2 = layout.createSequentialGroup
    sv3 = layout.createSequentialGroup
    sh2 = layout.createSequentialGroup
    sh3 = layout.createSequentialGroup
    p1 = layout.createParallelGroup
    p2 = layout.createParallelGroup
    p3 = layout.createParallelGroup
    
    layout.setHorizontalGroup sh1
    layout.setVerticalGroup sv1


    p1.addComponent(@js1)
    p1.addComponent(@ep)
    sv2.addGroup(p1)
    sv2.addComponent(@js2)
    sv1.addGroup(sv2)
    
    p2.addComponent(@js1)
    p2.addComponent(@js2)
    sh2.addGroup(p2)
    sh2.addComponent(@ep)
    sh1.addGroup(sh2)

  end
  
end

class MDecoderTabs < JTabbedPane
  
  def initialize
   super(JTabbedPane::TOP, JTabbedPane::SCROLL_TAB_LAYOUT) 
   add("Message", MessagePanel.new)
   add("Decoder", DecoderPanel.new)
  end 
    
end

class MDecoder < JFrame
  
  def initialize
    super('@mccabe615\'s Decoder Ring')
    initUI
  end
  
  def initUI
     $frame = self
     add(MDecoderTabs.new)
     
     self.setPreferredSize Dimension.new(1300, 900)
     self.pack
     
     # TODO Change the exit method so that you can only do it through a) menu or b) exit button
     self.setDefaultCloseOperation JFrame::EXIT_ON_CLOSE
     self.setLocationRelativeTo nil
     self.setVisible true
  end
  
  def close_it
    jo = JOptionPane.showConfirmDialog(nil, 
    "Close this window?", 
    "Confirmation", 
    javax.swing.JOptionPane::YES_NO_OPTION, 
    javax.swing.JOptionPane::QUESTION_MESSAGE)
    if jo == JOptionPane::YES_OPTION
         self.dispose()
    end
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
