namespace :blog do
  desc "Generate a new blog post with a title. Ex: rake blog:post['My New Post'] or rake blog:post['Blog post title',2014-09-21]. Defaults to today's date if none provided."
  task :post, [:title, :date] => [:environment] do |t, args|
    if args[:date]
      date = (DateTime.parse args[:date]).strftime("%G-%m-%d")
    else
      date = Time.now.strftime("%G-%m-%d")
    end
    title = args[:title].to_s.strip
    if title.blank?
      fail 'Please supply a title.'
    else
      slug = title.split(' ').map{ |s| s.downcase }.join('-')
      file = Rails.root.join 'app', 'views', 'blog', "#{date}-#{slug}.md"
      File.open(file,'w') { |f| f.write("---\ntitle: #{title}\n---\n\n\n") }
    end
  end
end
