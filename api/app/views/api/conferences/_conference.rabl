object @conference
attributes :neo_id, :name

child :division_one => :division_one do
  extends "divisions/division"
end

child :division_two => :division_two do
  extends "divisions/division"
end

child :division_three => :division_three do
  extends "divisions/division"
end



