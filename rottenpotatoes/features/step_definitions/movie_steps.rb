# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
  #fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  #Movie.count.should be n_seeds.to_i   #deprecated
  expect(Movie.count).to eq n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1)<page.body.index(e2))
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

#When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
Given /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(', ').each do |rating|
    # Check or uncheck rating
    step "I #{uncheck.blank? ? '':'un'}check \"ratings_#{rating}\""
  end
  #fail "Unimplemented"
end

#Then /I should( not )?see movies with the following ratings: (.*)/ do |not_see, rating_list|
Then /I should see movies with the following ratings: (.*)/ do |rating_list|
  rating_list.split(', ').each do |rating|
    #Movie.where(rating: rating).each do |movie|
      #step "I should#{not_see.blank? ? ' ':' not '}see #{movie.title}"
      #step "I should see #{movie.title}"
    #end
    Movie.all_ratings.include?(rating)
  end
end

Then /I should not see movies with the following ratings: (.*)/ do |rating_list|
  rating_list.split(', ').each do |rating|
    Movie.all_ratings.exclude?(rating)
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  ['G','PG','PG-13','R'].each do |rating|
    Movie.all_ratings.include?(rating)
  end
  #fail "Unimplemented"
end
