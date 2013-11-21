require 'rake'

module Jekyll


    class CommandLinePost < Post
        

        def toname(x)
            x = x.downcase.gsub(/[^a-z0-9]/, "_").gsub(/_{2,}/, "_").gsub(/(^[_]*)|([_]*$)/, "")
            x[0..68]
        end

        def initialize(site, source, d)

            @command_data = d

            @slug = toname(d['command'])
            dir = @slug.split('_')[0]

            super(site, source, "/" + dir, d['summary'])

            self.date = d['date']
            self.ext = ".html"

        end

        def process(name)
        end

        def read_yaml(base, name, opts = {})
            self.content = @command_data['command']
            self.slug = @slug
            self.data = @command_data
            self.data['layout'] = 'command'
            self.extracted_excerpt = self.extract_excerpt
        end

        def title
            @name
        end


    end

    
    class ArchiveGenerator < Generator
        priority :highest

        def ts(dir)
            th = {}
            curt = 0

            `git log --pretty=format:%ct --name-only #{dir}`.each_line do | l |

                if l.strip.end_with?('.yaml') 
                    key = l.pathmap("%n")
                    th[key] = curt if not th.has_key?(key)
                else
                    curt = l.to_i
                end

            end

            th
        end

        def generate(site)

            th = ts(site.config['data_source'])

            site.data.each_pair do | name, cmds | 
                [cmds].flatten.each do | cmd |
                
                    next if cmd['hide']

                    cmd['date'] = Time.at(th[name]) 
                    site.posts << CommandLinePost.new(site,site.dest, cmd)

                end
            end

            site.posts.sort! { | x, y | th.fetch(y.slug, 0) <=> th.fetch(x.slug, 0) }

        end

    end
end
