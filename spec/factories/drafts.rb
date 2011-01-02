# Read about factories at http://github.com/thoughtbot/factory_girl
Factory.define :draft do |f|
  f.record_type nil
  f.record_id nil
  f.content nil
end

Factory.define :worth_saving_record do |f|
  f.title 'Default Title'
  f.body 'Default Body'
end
