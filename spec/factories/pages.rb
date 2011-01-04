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

