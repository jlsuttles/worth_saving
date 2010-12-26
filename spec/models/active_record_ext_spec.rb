require 'spec_helper'
require 'worth_saving'

describe ActiveRecord::Base do
  before :each do
    class Record < ActiveRecord::Base
    end
    @valid_record_attributes = { :title => 'Valid Title', :body => 'Valid Body' }
    @valid_attributes = { :record_type => 'WorthSavingRecord', :record_id => nil, :content => @valid_record_attributes.to_json }
    Record.stubs(:columns).returns([
      Column.new("id",nil,"integer",false), 
      Column.new("title",'Default Title',"string",false), 
      Column.new("body",'Default Body',"text",false)
    ])
  end
  
  describe 'inheriting classes' do
    before :each do
      class WorthSavingRecord < ActiveRecord::Base
        worth_saving
      end
      WorthSavingRecord.stubs(:columns).returns([
        Column.new("id",nil,"integer",false), 
        Column.new("title",'Default Title',"string",false), 
        Column.new("body",'Default Body',"text",false)
      ])
    end
    
    it "should respond to worth_saving" do
      Record.should respond_to(:worth_saving)
    end
    
    describe "that are worth_saving" do      
      it "should respond to :worth_saving? with true" do
        WorthSavingRecord.should be_worth_saving
      end
      
      it "should respond to the :draft method" do
        WorthSavingRecord.new.should respond_to(:draft)
      end
      
      describe "(instances)" do
        it "should respond to :worth_saving? with true" do
          WorthSavingRecord.new.should be_worth_saving
        end
      end
    end
    
    describe "that are not worth saving" do
      it "should respond to :worth_saving? with false" do
        Record.should_not be_worth_saving
      end
      
      it "should respond to :worth_saving? with false" do
        Record.new.should_not be_worth_saving
      end
    end
  end
end