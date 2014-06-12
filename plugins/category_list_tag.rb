# module Jekyll
#   class CategoryListTag < Liquid::Tag
#     def render(context)
#       html = ""
#       categories = context.registers[:site].categories.keys
#       categories.sort.each do |category|
#         posts_in_category = context.registers[:site].categories[category].size
#         category_dir = context.registers[:site].config['category_dir']
#         category_url = File.join(category_dir, category.gsub(/_|\P{Word}/, '-').gsub(/-{2,}/, '-').downcase)
#         html << "<li class='category'><a href='/#{category_url}/'>#{category} (#{posts_in_category})</a></li>\n"
#       end
#       html
#     end
#   end
# end

# Liquid::Template.register_tag('category_list', Jekyll::CategoryListTag)
module Jekyll

  class CategoryCloud < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      @opts = {}
      if markup.strip =~ /\s*counter:(\w+)/iu
        @opts['counter'] = ($1 == 'true')
        markup = markup.strip.sub(/counter:\w+/iu,'')
      end
      super
    end

    def render(context)
      lists = {}
      max, min = 1, 1
      config = context.registers[:site].config
      category_dir = config['root'] + config['category_dir'] + '/'
      categories = context.registers[:site].categories
      categories.keys.sort_by{ |str| str.downcase }.each do |category|
        count = categories[category].count
        lists[category] = count
        max = count if count > max
      end

      html = ''
      lists.each do | category, counter |
        url = category_dir + category.gsub(/_|\P{Word}/u, '-').gsub(/-{2,}/u, '-').downcase
        style = "font-size: #{100 + (60 * Float(counter)/max)}%"
        html << "<a href='#{url}' style='#{style}'>#{category}"
        if @opts['counter']
          html << "(#{categories[category].count})"
        end
        html << "(#{posts_in_category})</a> "
      end
      html
    end
  end

  class CategoryList < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      @opts = {}
      if markup.strip =~ /\s*counter:(\w+)/iu
        @opts['counter'] = ($1 == 'true')
        markup = markup.strip.sub(/counter:\w+/iu,'')
      end
      super
    end

    def render(context)
      html = ""
      config = context.registers[:site].config
      category_dir = config['root'] + config['category_dir'] + '/'
      categories = context.registers[:site].categories
      categories.keys.sort_by{ |str| str.downcase }.each do |category|
        url = category_dir + category.gsub(/_|\P{Word}/u, '-').gsub(/-{2,}/u, '-').downcase
        html << "<li><a href='#{url}'>#{category}(#{categories[category].count})"
        if @opts['counter']
          html << " (#{categories[category].count})"
        end
        html << "</a></li>"
      end
      html
    end
  end

  class TopCategoryList < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      @opts = {}
      if markup.strip =~ /\s*counter:(\w+)/iu
        @opts['counter'] = ($1 == 'true')
        markup = markup.strip.sub(/counter:\w+/iu,'')
      end
      if markup.strip =~ /\s*include_all:(\w+)/iu
        @opts['include_all'] = ($1 == 'true')
        markup = markup.strip.sub(/include_all:\w+/iu,'')
      end
      super
    end
    def render(context)
      html = ""
      config = context.registers[:site].config
      category_dir = config['root'] + config['category_dir'] + '/'
      categories = context.registers[:site].categories
      cat_limit = config['top_category_limit'] || 10
      if (@opts['include_all'] || config['top_category_limit'] == 0)
  top_categories = categories.keys.sort_by{ |cat| categories[cat].count  }.reverse
      else
  top_categories = categories.keys.sort_by{ |cat| categories[cat].count  }.reverse.take(cat_limit)
      end
      top_categories.each do |category|
        url = category_dir + category.gsub(/_|\P{Word}/u, '-').gsub(/-{2,}/u, '-').downcase
        html << "<li><a href='#{url}'>#{category}"
        if @opts['counter']
          html << " (#{categories[category].count})"
        end
        html << "</a></li>"
      end
      html
    end
  end

end

Liquid::Template.register_tag('category_cloud', Jekyll::CategoryCloud)
Liquid::Template.register_tag('category_list', Jekyll::CategoryList)
Liquid::Template.register_tag('top_category_list', Jekyll::TopCategoryList)