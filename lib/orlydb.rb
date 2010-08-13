# -*- coding: utf-8 -*-
require "open-uri"
require "nokogiri"

require "orlydb/pre"
module Orlydb
  # @param [String] query Search query
  # @param [Number] pages How many pages to traverse
  # @return [Array<Pre>] An array of pre-releases
  def self.search(query, pages = 1)
    pre_structs = []

    i = 0
    another_page = true
    while i < pages && another_page
      i += 1

      code = open("http://www.orlydb.com/#{i}?q=#{CGI.escape(query)}").read
      doc = Nokogiri::HTML(code)
      another_page = code.include?("Next Page ►")

      pres = doc.css("#releases > div")
      pres.each do |pre|
        h = {}
        [:timestamp, :section, :release, :inforight, :nukeright].each do |key|
          value = pre.css(".#{key}").first
          h[key] = value && value.content
        end

        pre_structs << Pre.new({
                                 :time => h[:timestamp],
                                 :section => h[:section],
                                 :title => h[:release],
                                 :infos => h[:inforight],
                                 :nuked => h[:nukeright],
                               })
      end
    end
    pre_structs
  end
end
