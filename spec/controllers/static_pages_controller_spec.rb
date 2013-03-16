require 'spec_helper'

describe StaticPagesController do

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'privacy'" do
    it "should be successful" do
      get 'privacy'
      response.should be_success
    end
  end

  describe "GET 'thanks'" do
    it "should be successful" do
      get 'thanks'
      response.should_not be_success
    end
  end


end