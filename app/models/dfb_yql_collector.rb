# like camera
require 'uri'
require 'nokogiri'
require 'open-uri'

class DfbYqlCollector
  def initialize(target)
    @target = target
    # @doc = Nokogiri::HTML(open(yql_url))
  end
  
  attr_accessor :notebook, :target, :doc
  ## eventual methods: scan_for_addendums, scan_for_tips, scan_for_bloggings, scan_for_affinities, scan_review_details, yql_url
  
  def yql_url
    url =[]
    url << _yql_base_url
    url << _yql_query
    "#{url.join("?")}"
  end

  # build parts for yql url
  def _dfb_link
    link = []
    link << "http://www.disneyfoodblog.com"
    link << target.path
    "#{link.join("/")}"
  end
  
  def _css_selectors
    target.yql_css_parse
  end
  def _yql_select_statement
    # select * from data.html.cssselect where url="http://www.disneyfoodblog.com/whispering-canyon-cafe" and css="article .entry-content p"
    ["q", "select * from data.html.cssselect where url='#{_dfb_link}' AND css='#{_css_selectors}'"]
  end
  
  def _yql_base_url
    "https://query.yahooapis.com/v1/public/yql"
  end
  
  def _yql_diagnostics
    ['diagnostics',true]
  end
  
  def _yql_datatables_env
    ['env', 'store://datatables.org/alltableswithkeys']
  end
  
  def _yql_query
    query_array = []
    query_array << _yql_select_statement
    query_array << _yql_diagnostics
    query_array << _yql_datatables_env
    URI.encode_www_form(query_array)
  end
end