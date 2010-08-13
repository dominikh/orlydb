require "ostruct"

module Orlydb
  # Provides information about a pre-release.
  #
  # Available attributes:
  # - title
  # - section
  # - time
  # - infos
  # - nuked
  class Pre < OpenStruct
    # @return [String] A formatted representation of the pre-release
    def to_s
      s = ""
      s << "[#{self.section}] #{self.title} (#{self.time})"
      if self.infos
        s << " - #{self.infos}"
      end

      if self.nuked
        s << " {Nuked: #{self.nuked}}"
      end

      s
    end
  end
end
