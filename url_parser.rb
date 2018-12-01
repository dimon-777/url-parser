class UrlParser
  REGEX = %r{
      ^
      (?: (?<scheme> \* | [a-zA-Z][A-Za-z+.-]+) ://)?
      (?<domain> [a-zA-Z0-9\.\*\-_]+?)?
      (?: : (?<port> \* | \d+))?
      (?<path> / [^\?\#]*)?
      (?: \? (?<query_string> [^\#]*) )?
      (?: \# (?<fragment_id> .*) )?
      $
  }x.freeze

  def initialize(url)
    @url = url
    @match = REGEX.match(url)
  end

  def scheme
    p @match[:scheme]
  end

  def domain
    p @match[:domain]
  end

  def port
    if @match[:port].nil?
      case @match[:scheme]
      when 'http'
        p '80'
      when 'https'
        p '443'
      else
        p '80'
      end
    else
      p @match[:port]
    end
  end

  def path
    if @match[:path].eql? '/'
      p nil
    else
      t = @match[:path]
      t[0] = '' unless t.nil?
      p t
    end
  end

  def query_string
    if @match[:query_string].nil?
      p nil
    else
      t = {}
      @match[:query_string].split('&').each do |x|
        v = x.split('=')
        t[v[0]] = v[1]
      end
      p t
    end
  end

  def fragment_id
    p @match[:fragment_id]
  end
end
