# Read about factories at http://github.com/thoughtbot/factory_girl
Factory.define :page do |f|
  f.title 'Page Title'
  f.permalink 'page-title'
  f.meta_title 'Page Meta Title'
  f.body 'This page is about some stuff...'
  f.visible true
end

Factory.define :page_draft, :class => Draft do |f|
  f.record_type "Page"
  f.sequence(:record_id) { |n| "page-title#{n}" }
  f.sequence(:content) { |n| Factory.create(:page, {:permalink => "page-title#{n}"}).to_json }
end

Factory.define :draft do |f|
  f.record_type nil
  f.record_id nil
  f.content nil
end

Factory.define :worth_saving_record do |f|
  f.title 'Default Title'
  f.body 'Default Body'
end