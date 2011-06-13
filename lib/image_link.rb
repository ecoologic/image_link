require "image_link/version"

# gives a link with an image
module ImageLink

  # creates a link with an image
  # image_name => { nil -> default image
  #                 Symbol -> image from image_link
  #                 string -> considered as full_path
  #                 false -> no image used }
  # title  -> image_name and title build the title
  # path 
  # opts hash
  #   :id == opts[:a][:id]
  #   :label_text -> a label on the right
  #   :img => { ... }
  #   {:new_page => true} == [:a][:target] = '_blank'
  def image_link(image_name, title, path, *args)

    ############ local functions

        # the anchor with title remote and new_page
        def link(path, _opts)
          opts            = _opts[:a] || {}
          opts[:class]    = "#{_opts[:class]} image_link"
          opts[:target] ||= '_blank' if _opts[:new_page]
          opts[:title]  ||= _opts[:title]
          opts[:id]     ||= _opts[:id]
          opts[:remote] ||= _opts[:remote]

          link_to(path, opts) {yield}
        end

        # the image with alt
        def image(image_name, _opts)
          opts         = _opts[:img] || {}
          opts[:alt] ||= _opts[:title]

          # TODO: understand === if you want to use case statement
          image_path = if image_name.class == String
            image_name
          elsif image_name.class == Symbol
            "image_link/#{image_name}.png"
          elsif image_name == false
            false
          else
            'image_link/default.png'
          end

          image_path ? image_tag(image_path, opts) : raw('')
        end

        # eventually joins action and title
        def build_title(action, title)
          if !!action &&
             ([:edit, :show, :list, :back, :cancel].include? action.to_sym)
            prev = action.to_s.humanize
            title.blank? ? prev : "#{prev} #{title}"
          else
            title.to_s
          end
        end

        # the name 'label' itself gives problems, I allow myself a name exception
        # gives a label to the image_link
        def label_for_image_link(_opts)
          return raw('') unless _opts[:label_text]
          text = _opts[:label_text]
          opts = _opts[:label]
          
          content_tag :span, text, opts
        end

  ######################## actual body
  # def image_link(image_name, title, path, *args)

    opts           = args.extract_options!
    opts[:title] ||= build_title(image_name, title)

    link(path, opts) do
      image(image_name, opts) << label_for_image_link(opts)
    end

  end

end

