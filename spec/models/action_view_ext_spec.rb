require 'spec_helper'
require 'worth_saving'

describe ActionView::Base do
  before :each do
    class WorthSavingRecord < ActiveRecord::Base
      worth_saving
    end
    WorthSavingRecord.stubs(:columns).returns([
      Column.new("id",nil,"integer",false), 
      Column.new("title",'Default Title',"string",false), 
      Column.new("body",'Default Body',"text",false)
    ])

    class Record < ActiveRecord::Base
    end
    Record.stubs(:columns).returns([
      Column.new("id",nil,"integer",false), 
      Column.new("title",'Default Title',"string",false), 
      Column.new("body",'Default Body',"text",false)
    ])
  end
  
  # Some missing specs: test for what happens if we feed in an options hash other than {}
  #   Currently a worth_saving record will always have data-draft="true" b/c of the options.merge!('data-draft' => true)
  #   Quite possbily, however, we would like for a developer to be able to override this in a given form for a given field
  #     by feeding in 'data-draft' => false
  describe "when creating a form for a worth_saving record" do
    
    it "text_field should include a data-draft attribute with value true" do
      ActionView::Base.new.text_field('worth_saving_record', :title).should =~ /data-draft="true"/
    end
    
    it "text_field should not include a data-draft attribute if it is fed :draft => false in the options hash" do
      ActionView::Base.new.text_field('worth_saving_record', :title, { :draft => false }).should_not =~ /data-draft/      
    end

    it "select should include a data-draft attribute with value true" do
      @select_options_array = [1,2,3]
      ActionView::Base.new.select('worth_saving_record', :title, @select_options_array).should =~ /data-draft="true"/
    end
    
    it "select should include a data-draft attribute with value true" do
      @select_options_array = [1,2,3]
      ActionView::Base.new.select('worth_saving_record', :title, @select_options_array, :draft => false).should_not =~ /data-draft="true"/
    end
    
  end

  describe "when creating a form for a record that is NOT worth_saving" do
    
    it "text_field should not include a data-draft attribute" do
      ActionView::Base.new.text_field('record', :title, {}).should_not =~ /data-draft="true"/
    end
    
    it "select should not include a data-draft attribute" do
      @select_options_array = [1,2,3]
      ActionView::Base.new.select('record', :title, @select_options_array).should_not =~ /data-draft/
    end
    
  end
  
end