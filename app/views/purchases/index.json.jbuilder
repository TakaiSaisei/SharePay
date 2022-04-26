json.array! @purchases do |purchase|
  json.partial! 'purchase', purchase:
end
