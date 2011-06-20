Factory.define :user do |u|
  u.sequence(:email) {|n| "amit#{n}@gmail.com"}
  u.password "abcdefg"
  u.password_confirmation "abcdefg"
  u.sequence(:login) {|n| "amit#{n}"}
end

Factory.define :permission do |p|
  p.profile_id "1"
  p.permission_field "website"
  p.permission_type "myself"
  #  p.website "x"
  #  p.blog "x"
  #  p.about_me "x"
  #  p.gtalk_name "x"
  #  p.location"x"
  #  p.email "x"
  #  p.date_of_birth "x"
  #  p.anniversary_date "x"
  #  p.relationship_status "x"
  #  p.spouse_name "x"
  #  p.gender "x"
  #  p.activities "x"
  #  p.yahoo_name "x"
  #  p.skype_name "x"
  #  p.educations "x"
  #  p.work_informations "x"
  #  p.delicious_name "x"
  #  p.twitter_username "x"
  #  p.msn_username "x"
  #  p.linkedin_name "x"
  #  p.address "x"
  #  p.landline "x"
  #  p.mobile "x"
  #  p.marker "x"
end

Factory.define :notification do |n|
  n.profile_id "1"
  n.news_notification "true"
  n.event_notification "true"
  n.message_notification "true"
  n.blog_comment_notification "true"
  n.profile_comment_notification "true"
  n.follow_notification "true"
  n.delete_friend_notification "true"
end

Factory.define :education do |b|
  b.profile_id "1"
  b.education_from_year "2006"
  b.education_to_year "2008"
  b.institution "MCA"
  b.association :profile
end