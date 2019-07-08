category_size_array = [
  ["2", "1"],
  ["22", "1"],
  ["45", "1"],
  ["59", "1"],
  ["66", "1"],
  ["72", "29"],
  ["84", "1"],
  ["190", "1"],
  ["191", "1"],
  ["192", "1"],
  ["220", "1"],
  ["234", "1"],
  ["259", "1"],
  ["270", "12"],
  ["296", "1"],
  ["297", "1"],
  ["298", "1"],
  ["299", "1"],
  ["361", "1"],
  ["362", "1"],
  ["373", "1"],
  ["374", "1"],
  ["379", "69"],
  ["392", "69"],
  ["402", "69"],
  ["412", "52"],
  ["432", "52"],
  ["448", "52"],
  ["458", "60"],
  ["1022", "75"],
  ["1015", "86"],
  ["1016", "86"],
  ["1148", "137"],
  ["1150", "12"],
  ["1151", "29"],
  ["1152", "60"],
  ["1153", "1"],
  ["1154", "1"],
  ["1155", "52"],
  ["1161", "129"],
  ["1162", "12"],
  ["1163", "29"],
  ["1164", "60"],
  ["1166", "1"],
  ["1167", "1"],
  ["1168", "52"],
  ["1331", "115"],
  ["1367", "99"],
  ["1389", "106"],  
]

category_size_array.each do |size_category|
  CategorySize.create!(category_id: size_category[0], products_size_id: size_category[1])
end