ConfigParam::VALID_PARAMS.each do |v|
  ConfigParam.where(name: v).first_or_create
end
