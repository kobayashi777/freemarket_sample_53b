class Credit < ApplicationRecord
  enum validated_date_year: {
    "--":0,"19":19,"20":20,"21":21,"22":22,"23":23,"24":24,"25":26
  }, _suffix: true
  enum validated_date_month: {
    "--":0,"1":1,"2":2,"3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9,"10":10,"11":11,"12":12
  }, _suffix: true

  belongs_to :user, optional: true
end
