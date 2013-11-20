module Jekyll


    class CommandLinePost < Post
        

        def toname(x)
            x = x.downcase.gsub(/[^a-z0-9]/, "_").gsub(/_{2,}/, "_").gsub(/(^[_]*)|([_]*$)/, "")
            x[0..68]
        end

        def initialize(site, source, d)

            @command_data = d

            @name = toname(d['command'])
            dir = @name.split('_')[0]

            super(site, source, "/" + dir, d['summary'])

            self.date = Time.now
            self.ext = ".html"


            #puts self.site.permalink_style
        end

        def process(name)
        end

        def read_yaml(base, name, opts = {})
            self.content = "aa"
            self.slug = toname(@name)
            self.data = @command_data
            self.extracted_excerpt = self.extract_excerpt
        end

        def title
            @name
        end


    end

    
    class ArchiveGenerator < Generator
        priority :highest

        def generate(site)
            site.data.each do | d | 
                site.posts << CommandLinePost.new(site,site.dest,d[1])
            end
        end

    end
end
