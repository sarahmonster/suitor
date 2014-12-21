class BlogPost
  include ActionView::Helpers::TextHelper

  attr_reader :slug

  class << self

    def all
      all_slugs.map{ |slug| new(slug) }.sort
    end

    def find(slug)
      all.detect { |post| post.slug == slug }
    end

    def directory
      Rails.root.join 'app', 'views', 'blog'
    end

    private

    def all_slugs
      @all_slugs ||= Dir.glob("#{directory}/*.md").map { |f| File.basename(f,'.md') }
    end

  end

  def initialize(slug)
    @slug = slug
    @data = {}
    parse_file
  end

  def title
    @data['title'] || slug.sub(/\d{4}-\d{2}-\d{2}-/, '').titleize
  end

  def date
    Date.parse(slug)
  end

  def date_formatted
    day_format = ActiveSupport::Inflector.ordinalize(date.day)
    date.strftime "%B #{day_format}, %G"
  end

  def html
    Rails.cache.fetch("#{cache_key}/html") { to_html }
  end

  def excerpt
    if @data['excerpt']
      @data['excerpt']
    else
      first_ptag = Nokogiri::HTML(html).css('p:first').text.squish
      truncate strip_tags(first_ptag), length: 400, separator: ' '
    end
  end

  def path
    "/blog/#{slug}"
  end

  def permalink
    # TODO: Use a hostname variable here.
    "http://mrsuitor.com/blog/#{slug}"
  end

  def inspect
    "<#{self.class.name} date: #{date.iso8601}, title: #{title.inspect}, slug: #{slug.inspect}>"
  end

  def <=> other
    other.date <=> date
  end

  def updated_at
    File.mtime(file_path)
  end

  def cache_key
    ActiveSupport::Cache.expand_cache_key ['blog', slug, updated_at.to_i]
  end

  private

    def parse_file
      @markdown = Tilt::ErubisTemplate.new do
        fdata = file_data
        if fdata =~ /\A(---\s*\n.*?\n?)^(---\s*$\n?)/m
          @data = SafeYAML.load($1)
          $POSTMATCH
        else
          fdata
        end
      end.render(scope, post: self)
    end

    def file_path
      self.class.directory.join "#{slug}.md"
    end

    def file_data
      Rails.cache.fetch("#{cache_key}/markdown") { File.read(file_path) }
    end

    def markdown
      @markdown
    end

    def to_html
      Jekyll::Converters::Markdown::RedcarpetParser.new({
        'highlighter' => 'rouge',
        'redcarpet' => {
          'extensions' => ["no_intra_emphasis", "fenced_code_blocks", "autolink", "strikethrough", "lax_spacing", "superscript", "with_toc_data", "smart"]
        }
      }).convert(markdown)
    end

    def scope
      ApplicationController.helpers.clone.tap do |h|
        h.singleton_class.send :include, Rails.application.routes.url_helpers
      end
    end
end
