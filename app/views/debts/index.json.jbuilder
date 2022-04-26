json.array! @debts do |debt|
  json.partial! 'debt', debt:
end
