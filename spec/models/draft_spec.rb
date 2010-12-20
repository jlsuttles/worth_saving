require 'spec_helper'

describe Draft do
  Column = ActiveRecord::ConnectionAdapters::Column  
  before :each do
    @valid_record_attributes = { :title => 'Valid Title', :body => 'Valid Body' }
    @valid_attributes = { :record_type => 'WorthSavingRecord', :record_id => nil, :content => @valid_record_attributes.to_json }
    WorthSavingRecord.stubs(:columns).returns([
      Column.new("id",nil,"integer",false), 
      Column.new("title",'Default Title',"string",false), 
      Column.new("body",'Default Body',"text",false)
    ])
  end
  
  it "should recognize a valid record" do
    @draft = Factory.build(:draft, @valid_attributes)
    @draft.should be_valid
  end
  
  it "should recognize a record as invalid when no record_type is provided" do
    @draft = Factory.build(:draft, @valid_attributes.merge(:record_type => 'NonExistentRecordType'))    
    @draft.should_not be_valid
    @draft.errors.should == {:record_type => ['is invalid.']}
  end
  
  it "should recognize a record as invalid if its 'record_id' doesn't correspond to a record in the DB" do
    @draft = Factory.build(:draft, @valid_attributes.merge(:record_type => 'WorthSavingRecord', :record_id => 1234))    
    WorthSavingRecord.expects(:first).with(:conditions => { :id => 1234 }).returns(nil)
    @draft.should_not be_valid
    @draft.errors.should == {:record_id => ['does not correspond to a valid record.']}
  end

  describe 'reconstitution' do
    before :each do
      @unsaved_record_attributes = { 'title' => 'Unsaved Title', 'body' => 'Unsaved Body' }
      @record = Factory.build :worth_saving_record
    end

    it "should return a new record with correct type and attributes when 'record_id' is nil" do
      @draft = Factory.build(:draft, {:record_type => 'WorthSavingRecord', :record_id => nil, :content => @unsaved_record_attributes.to_json })    
      recon_record = @draft.reconstitute
      recon_record.attributes.should == @record.attributes.merge(@unsaved_record_attributes)
      recon_record.should be_new_record
      recon_record.class.should == WorthSavingRecord
    end

    it "should return a non-new record with correct type and attributes when 'record_id' is valid" do
      @draft = Factory.build(:draft, {:record_type => 'WorthSavingRecord', :record_id => 1234, :content => @unsaved_record_attributes.to_json })    
      @record.stubs(:new_record?).returns(false)
      @record.stubs(:id).returns(1234)
      WorthSavingRecord.expects(:first).twice.with(:conditions => { :id => 1234 }).returns(@record)
      recon_record = @draft.reconstitute
      recon_record.attributes.should == @record.attributes.merge(@unsaved_record_attributes)
      recon_record.should_not be_new_record
      recon_record.class.should == WorthSavingRecord
    end

    it "should return false when 'record_id' is not valid" do
      @draft = Factory.build(:draft, {:record_type => 'WorthSavingRecord', :record_id => 2222, :content => @unsaved_record_attributes.to_json })    
      @record.stubs(:new_record?).returns(false)
      @record.stubs(:id).returns(1234)
      WorthSavingRecord.expects(:first).with(:conditions => { :id => 2222 }).returns(nil)
      recon_record = @draft.reconstitute
      recon_record.should == false
    end  
  end
end
