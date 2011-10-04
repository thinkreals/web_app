class Util
  def self.to_array(str)
    ret = []
    if str
      ret = str.split(",").map{|s| s.strip }
    end     
    ret
  end
  
  def self.to_string(array)
    array.map{|s| s.strip }.join(",")
  end
end