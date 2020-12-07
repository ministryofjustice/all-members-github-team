class AllMembers
  class Logger
    def log(msg)
      puts [
        Time.now.strftime("%Y-%m-%d %H:%M:%S"),
        msg,
      ].join(" ")
    end
  end
end
