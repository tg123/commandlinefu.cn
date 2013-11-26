
module Jekyll

    class ContributorsPageGenerator < Generator

        def generate(site)

            contributors = {}

            site.posts.each do | post |

                if post.data['translator'].is_a? Hash and post.data['translator']['weibo']
                    translator_weibo = post.data['translator']['weibo']
                    contributors[translator_weibo] = 0 if not contributors[translator_weibo]
                    contributors[translator_weibo] += 1
                end

            end

            contributors_page = site.pages.detect {|page| page.name == 'contributors.html'}
            contributors_page.data['contributors'] = contributors.sort_by {|k, v| -v }

        end

    end
end
