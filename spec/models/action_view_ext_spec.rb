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
    
    @view = ActionView::Base.new
    @view.stubs(:worth_saving_records_path).returns('/worth_saving_records')
    @view.stubs(:records_path).returns('/records')
    @view.stubs(:protect_against_forgery?).returns(false)
  end
  
  # Some missing specs: test for what happens if we feed in an options hash other than {}
  #   Currently a worth_saving record will always have data-draft="worth_saving_record" b/c of the options.merge!('data-draft' => worth_saving_record)
  #   Quite possbily, however, we would like for a developer to be able to override this in a given form for a given field
  #     by feeding in :draft => false
  describe "when using form_for on a model that is worth_saving" do
    before :each do
      @worth_saving_record = WorthSavingRecord.new
    end
    
    describe "and the record is new" do
      @worth_saving_record.stubs(:persisted?).returns(false)
      it "text_field should include a data-draft attribute with value equal to the name of the model" do
        @view.form_for @worth_saving_record do |f|
          f.text_field(:title).should =~ /data-draft="worth_saving_record"/
        end
      end

      it "select should include a data-draft attribute with value equal to the name of the model" do
        @select_options_array = [1,2,3]
        @view.form_for @worth_saving_record do |f|
          f.select(:title, @select_options_array).should =~ /data-draft="worth_saving_record"/
        end
      end

      it "check_box should include a data-draft attribute with value equal to the name of the model" do
        @view.form_for @worth_saving_record do |f|
          f.check_box(:title).should =~ /data-draft="worth_saving_record"/
        end
      end

      it "text_area should include a data-draft attribute with value equal to the name of the model" do
        @view.form_for @worth_saving_record do |f|
          f.text_area(:title).should =~ /data-draft="worth_saving_record"/
        end
      end

      it "radio_button should include a data-draft attribute with value equal to the name of the model" do
        @view.form_for @worth_saving_record do |f|
          f.radio_button(:title, 1).should =~ /data-draft="worth_saving_record"/
        end
      end
    end
    
    describe "and the record is from the database" do
      before :each do
        @worth_saving_record.id = 1254
      end
      
      it "text_field should include a data-draft attribute with value equal to the name of the model with its to_param" do
        @view.form_for @worth_saving_record do |f|
          f.text_field(:title).should =~ /data-draft="worth_saving_record_1254"/
        end
      end
      
      it "select should include a data-draft attribute with value equal to the name of the model with its to_param" do
        @select_options_array = [1,2,3]
        @view.form_for @worth_saving_record do |f|
          f.select(:title, @select_options_array).should =~ /data-draft="worth_saving_record_1254"/
        end
      end

      it "check_box should include a data-draft attribute with value equal to the name of the model with its to_param" do
        @view.form_for @worth_saving_record do |f|
          f.check_box(:title).should =~ /data-draft="worth_saving_record_1254"/
        end
      end

      it "text_area should include a data-draft attribute with value equal to the name of the model with its to_param" do
        @view.form_for @worth_saving_record do |f|
          f.text_area(:title).should =~ /data-draft="worth_saving_record_1254"/
        end
      end

      it "radio_button should include a data-draft attribute with value equal to the name of the modelwith its to_param" do
        @view.form_for @worth_saving_record do |f|
          f.radio_button(:title, 1).should =~ /data-draft="worth_saving_record_1254"/
        end
      end
    end  # describe "and the record is from the database"

    it "text_field should not include a data-draft attribute if it is fed :draft => false in the options hash" do
      @view.form_for @worth_saving_record do |f|
        f.text_field(:title, :draft => false ).should_not =~ /data-draft/      
      end
    end

    it "select should not include a data-draft attribute if it is fed :draft => false in the options hash" do
      @select_options_array = [1,2,3]
      @view.form_for @worth_saving_record do |f|
        f.select(:title, @select_options_array, :draft => false).should_not =~ /data-draft/
      end
    end
        
    it "check_box should not include a data-draft attribute if it is fed :draft => false in the options hash" do
      @view.form_for @worth_saving_record do |f|
        f.check_box(:title, :draft => false).should_not =~ /data-draft/
      end
    end
        
    it "text_area should not include a data-draft attribute if it is fed :draft => false in the options hash" do
      @view.form_for @worth_saving_record do |f|
        f.text_area(:title, :draft => false).should_not =~ /data-draft/
      end
    end
        
    it "radio_buton should not include a data-draft attribute if it is fed :draft => false in the options hash" do
      @view.form_for @worth_saving_record do |f|
        f.radio_button(:title, 1, :draft => false).should_not =~ /data-draft/
      end
    end
        
  end

  describe "when creating a form for a record that is NOT worth_saving" do
    
    it "text_field should not include a data-draft attribute" do
      ActionView::Base.new.text_field('record', :title, {}).should_not =~ /data-draft/
    end
    
    it "select should not include a data-draft attribute" do
      @select_options_array = [1,2,3]
      ActionView::Base.new.select('record', :title, @select_options_array).should_not =~ /data-draft/
    end
    
    it "check_box should not include a data-draft attribute" do
      ActionView::Base.new.check_box('record', :title, {}).should_not =~ /data-draft/
    end
    
    it "text_area should not include a data-draft attribute" do
      ActionView::Base.new.text_area('record', :title, {}).should_not =~ /data-draft/
    end
    
    it "radio_button should not include a data-draft attribute" do
      ActionView::Base.new.radio_button('record', :title, 1, {}).should_not =~ /data-draft/
    end
    
  end
  
end