# coding: utf-8
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

feature "Sending a Form" do 
  scenario "should be able to send basic info" do 
    visit '/'
    fill_in('nombre', :with => 'Test')
    fill_in('email',  :with => 'test@host.com')
    click_on('Si, avisenme')
    page.should have_content("sugerirnos")
  end

  it "should show the suggestion page" do 
    fill_in('nombre', :with => 'Test2')
    click_on('Enviar')
    page.should have_content("GRACIAS")
  end

  it "should accept accent or other characters on inputs" do
    visit '/'

    fill_in('nombre', :with => "Os Bäzó")
    fill_in('email',  :with => 'test@host.com')
    click_on('Si, avisenme')
    page.should have_content("sugerirnos")

    fill_in('nombre', :with => 'Os Bäzó')
    click_on('Enviar')
    page.should have_content("GRACIAS")
  end
end

