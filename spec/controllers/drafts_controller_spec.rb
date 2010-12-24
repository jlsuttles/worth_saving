require 'spec_helper'

describe DraftsController do
  before :each do
    @draft = mock('draft')
  end

  describe "POST 'create'" do
    @valid_record_attributes = { :title => 'Valid Title', :body => 'Valid Body' }
    @valid_attributes = { :record_id => 5, :record_type => 'WorthSavingRecord', :content => @valid_record_attributes.to_json }

    it "should be successful when a valid draft is presented as a post" do
      @draft.expects(:attributes=).with(@valid_attributes).returns(@valid_attributes)
      @draft.expects(:save).returns(true)
      Draft.expects(:find_or_initialize_by_record_type_and_record_id).with(@valid_attributes).returns(@draft)
      post 'create', :draft => @valid_attributes
      response.should be_success
    end

    it "should be failure when an invalid draft is presented as a post" do
      @draft.expects(:attributes=).with(@valid_attributes).returns(@valid_attributes)
      @draft.expects(:save).returns(false)
      Draft.expects(:find_or_initialize_by_record_type_and_record_id).with(@valid_attributes).returns(@draft)
      post 'create', :draft => @valid_attributes
      response.should_not be_success
    end
  end

  describe "DELETE 'destroy'" do
    it "should be successful if the record is found" do
      @draft.expects(:destroy).returns(@draft)
      Draft.expects(:find_by_id).with('1').returns(@draft)
      delete 'destroy', :id => '1'
      response.should be_success
    end

    it "should be failure if the record is not found" do
      Draft.expects(:find_by_id).with('1').returns(nil)
      delete 'destroy', :id => '1'
      response.should_not be_success
    end
  end
  
end
