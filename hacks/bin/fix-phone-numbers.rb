def normalize_number(original_number)
  # First, strip everything except for digits
  number = original_number.gsub(/\D/, "")
  if (number.length == 10)
    number = "1" + number
  end
  if ((number[0] == "1") and (number.length == 11))
    # format is +1 (234) 567-8901
    number = "+1 (" + number[1,3] + ") " + number[4,3] + "-" + number[7,4]
  else
    return original_number
  end
  return number
end

ARGF.each_line do |l|
  if l =~ /^TEL;/
    m = /:(?<tel>.*)$/.match(l)
    number = normalize_number(m[:tel].chomp)
    l = l.rpartition(":").first
    line = l + ":" + number + "\r\n"
  else
    line = l
  end
  print line
end

