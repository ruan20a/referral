module WhitelistsHelper

  def level_access
    [["User", 1], ["Admin",2], ["Main Admin",3]]
  end

  def translate_level(level)
    case level
    when 3
      "Main Admin"
    when 2
      "Admin"
    else
      "User"
    end
  end
end