require 'faker'

10.times{User.create!(email: Faker::Internet.email,
                      username: Faker::Name.name,
                      cohort: "Apricots 2015",
                      password: "password")}

5.times{Subreddit.create!(name: Faker::Hacker.noun,
                          moderator: User.all.sample,
                          description: Faker::Lorem.sentence(5))}

git = Subreddit.create!(name: "Git workflow",
                        moderator: User.all.sample,
                        description: "Post your git workflow questions and resources here!")

rspec = Subreddit.create!(name: "Rspec",
                          moderator: User.all.sample,
                          description: "TDD is awesome! TDD is life! Share your favorite rspec stories!")

duke = Subreddit.create!(name: "Duke Greene",
                        moderator: User.all.sample,
                        description: "Favorite Duke quotes and jokes")

gifs = Subreddit.create!(name: "Coding Gifs",
                        moderator: User.all.sample,
                        description: "Sometimes words just don't say enough.")

(rand(20..30)).times { Post.create!(title: Faker::Lorem.words(4).join(" "),
                                    body: Faker::Lorem.paragraph(3),
                                    author: User.all.sample,
                                    subreddit: Subreddit.all.sample)}

(rand(40..50)).times { Post.create!(title: Faker::Lorem.words(4).join(" "),
                                    body: Faker::Lorem.paragraph(3),
                                    author: User.all.sample,
                                    subreddit: Subreddit.all.sample,
                                    image_url: "http://lorempixel.com/140/103/")}


Post.create!(title: "I hate rspec",
            body:"I can't get my rspec tests to pass. They are all red. Are there any gems to fix this?",
            author: User.all.sample,
            subreddit: rspec)
Post.create!(title: "cats playing piano",
            body:"<a href='http://giphy.com/search/keyboard-cat'>http://giphy.com/search/keyboard-cat</a>",
            author: User.all.sample,
            subreddit: gifs,
            image_url: "http://giphy.com/search/keyboard-cat'>http://giphy.com/search/keyboard-cat")
Post.create!(title: "What is a pirate's favorite test?",
            body:"ARspec",
            author: User.all.sample,
            subreddit: duke)
Post.create!(title: "Should I force push everything to master?",
            body:"Seriously. should I? ",
            author: User.all.sample,
            subreddit: git)

# top level comments
(rand(75..100)).times {Comment.create!(post: Post.all.sample,
                                    author: User.all.sample,
                                    body: Faker::Lorem.paragraph(1))}

# nested comments (replies)
(rand(100..125)).times {Comment.create!(comment_id: Comment.all.sample.id,
                                    author: User.all.sample,
                                    body: Faker::Lorem.paragraph(1))}

# Votes on posts
(rand(150..250)).times {Vote.create!(post: Post.all.sample,
                                  voter: User.all.sample,
                                  up: [true, true, false].sample)}

#Votes on comments
(rand(500..600)).times{Vote.create!(comment: Comment.all.sample,
                                  voter: User.all.sample,
                                  up: [true, true, false].sample)}

Post.all.each do |post|
  post.points = post.net_votes
  post.save!
end

Comment.all.each do |comment|
  comment.points = comment.net_votes
  comment.save!
end

100.times{Subscription.create(user: User.all.sample, subreddit: Subreddit.all.sample)}
