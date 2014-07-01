puts 'Seeding Categories...'
CATEGORIES = {
  'news' => '新闻',
  'talk' => '评论',
  'tech' => {
    _: '科技',
    'desktop' => '桌面应用',
    'sa'      => '系统运维',
    'program' => '软件开发',
  },
}

def create_category hash, super_category = nil
  hash.each do |name, description|
    next if name.is_a? Symbol
    hash = nil

    if description.is_a? Hash
      hash = description
      description = hash[:_]
    end

    c = Category.create! name: name, description: description, super_category: super_category
    puts "category: #{name} - #{description}"

    create_category hash, c if hash
  end
end
create_category CATEGORIES
