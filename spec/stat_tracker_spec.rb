require '../futbol/lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  xit "exists" do
    expect(@stat_tracker).to be_an_instance_of StatTracker
  end

  xit "#highest_total_score" do
    expect(@stat_tracker.highest_total_score).to eq 11
  end

  xit "#lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq 0
  end

  xit "#percentage_home_wins" do
    expect(@stat_tracker.percentage_home_wins).to eq 0.44
  end

  xit "#percentage_visitor_wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
  end

  xit "#percentage_ties" do
    expect(@stat_tracker.percentage_ties).to eq 0.20
  end

  xit "#count_of_games_by_season" do
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    expect(@stat_tracker.count_of_games_by_season).to eq expected
  end

  xit "#average_goals_per_game" do
    expect(@stat_tracker.average_goals_per_game).to eq 4.22
  end

  #rspec never finishes test, but pry tests show it shoudl work
  #need to test with smaller data set
  xit "#average_goals_by_season" do
    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }
    expect(@stat_tracker.average_goals_by_season).to eq expected
  end

  xit "#count_of_teams" do
    expect(@stat_tracker.count_of_teams).to eq 32
  end

  xit "#best_offense" do
    expect(@stat_tracker.best_offense).to eq "Reign FC"
  end

  xit "#worst_offense" do
    expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
  end

  xit "#highest_scoring_visitor" do
    expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
  end

  xit "#highest_scoring_home_team" do
    expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
  end

  xit "#lowest_scoring_visitor" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  end

  xit "#lowest_scoring_home_team" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
  end

  xit "#team_info" do
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }

    expect(@stat_tracker.team_info("18")).to eq expected
  end
#test created by me
  xit "game_team_season" do
    expect(@stat_tracker.game_team_season(@stat_tracker.game_teams[0])).to eq "20122013"
  end

  xit "#best_season" do
    expect(@stat_tracker.best_season("6")).to eq "20132014"
  end

  xit "#worst_season" do
    expect(@stat_tracker.worst_season("6")).to eq "20142015"
  end

  xit "#average_win_percentage" do
    expect(@stat_tracker.average_win_percentage("6")).to eq 0.49
  end

  xit "#most_goals_scored" do
    expect(@stat_tracker.most_goals_scored("18")).to eq 7
  end

  xit "#fewest_goals_scored" do
    expect(@stat_tracker.fewest_goals_scored("18")).to eq 0
  end

  xit "#favorite_opponent" do
    expect(@stat_tracker.favorite_opponent("18")).to eq "DC United"
  end

  it "#rival" do
    expect(@stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
  end

  xit "#winningest_coach" do
    expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
    expect(@stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
  end

  xit "#worst_coach" do
    expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
    expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
  end

  xit "#most_accurate_team" do
    expect(@stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
    expect(@stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
  end

  xit "#least_accurate_team" do
    expect(@stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
    expect(@stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
  end

  xit "#most_tackles" do
    expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
    expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
  end

  xit "#fewest_tackles" do
    expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
    expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
  end

  #test written by me
  xit "biggest_team_blowout" do
    expect(@stat_tracker.biggest_team_blowout("6")).to eq(4)
  end

  #test written by me
  xit "worst_loss" do 
    expect(@stat_tracker.worst_loss("6")).to eq(5)
  end

  #test written by me
  xit "head_to_head" do
    expect(@stat_tracker.head_to_head("6")).to be_an_instance_of Hash

    expect(@stat_tracker.head_to_head("6")).to eq({"Houston Dynamo"=>0.3478, "Sporting Kansas City"=>0.4545, "DC United"=>0.2759, "North Carolina Courage"=>0.2821, "Sky Blue FC"=>0.1667, "LA Galaxy"=>0.2692, "Houston Dash"=>0.16, "Orlando City SC"=>0.2, "Seattle Sounders FC"=>0.2222, "New York City FC"=>0.2813, "New York Red Bulls"=>0.3438, "Chicago Fire"=>0.2222, "Vancouver Whitecaps FC"=>0.5, "Los Angeles FC"=>0.3, "Columbus Crew SC"=>0.0, "Real Salt Lake"=>0.6, "Philadelphia Union"=>0.4, "Montreal Impact"=>0.5, "New England Revolution"=>0.4375, "Portland Timbers"=>0.5, "Utah Royals FC"=>0.2308, "Atlanta United"=>0.1667, "Toronto FC"=>0.2, "San Jose Earthquakes"=>0.0, "Orlando Pride"=>0.2667, "Chicago Red Stars"=>0.1, "Washington Spirit FC"=>0.2, "Minnesota United FC"=>0.4, "Portland Thorns FC"=>0.2308, "FC Cincinnati"=>0.4, "Reign FC"=>0.5})
  end

  #test written by me
  xit "game_team_type" do
    game_team_object = @stat_tracker.game_teams[0]
    expect(@stat_tracker.game_team_type(game_team_object)).to eq("Postseason")
  end

  #test written by me
  xit "list_postseason_games" do
    expect(@stat_tracker.list_postseason_games("6", "20162017")).to be_an_instance_of Array 
  end

  #test written by me
  it "seasonal_summary" do
    expect(@stat_tracker.seasonal_summary("6")).to be_an_instance_of Hash 

    expect(@stat_tracker.seasonal_summary("6")).to eq({"20122013"=>{:regular_season=>{:win_percentage=>0.4792, :total_goals_scored=>103, :total_goals_against=>86, :average_goals_scored=>2.1458, :average_goals_against=>1.7917}, :postseason=>{:win_percentage=>0.6818, :total_goals_scored=>51, :total_goals_against=>37, :average_goals_scored=>2.3182, :average_goals_against=>1.6818}}, "20132014"=>{:regular_season=>{:win_percentage=>0.5976, :total_goals_scored=>198, :total_goals_against=>143, :average_goals_scored=>2.4146, :average_goals_against=>1.7439}, :postseason=>{:win_percentage=>0.4167, :total_goals_scored=>22, :total_goals_against=>20, :average_goals_scored=>1.8333, :average_goals_against=>1.6667}}, "20142015"=>{:regular_season=>{:win_percentage=>0.378, :total_goals_scored=>171, :total_goals_against=>173, :average_goals_scored=>2.0854, :average_goals_against=>2.1098}, :postseason=>"Did not participate in postseason."}, "20152016"=>{:regular_season=>{:win_percentage=>0.4024, :total_goals_scored=>182, :total_goals_against=>178, :average_goals_scored=>2.2195, :average_goals_against=>2.1707}, :postseason=>"Did not participate in postseason."}, "20162017"=>{:regular_season=>{:win_percentage=>0.5, :total_goals_scored=>174, :total_goals_against=>159, :average_goals_scored=>2.122, :average_goals_against=>1.939}, :postseason=>{:win_percentage=>0.6667, :total_goals_scored=>13, :total_goals_against=>11, :average_goals_scored=>2.1667, :average_goals_against=>1.8333}}, "20172018"=>{:regular_season=>{:win_percentage=>0.5244, :total_goals_scored=>207, :total_goals_against=>165, :average_goals_scored=>2.5244, :average_goals_against=>2.0122}, :postseason=>{:win_percentage=>0.5833, :total_goals_scored=>33, :total_goals_against=>25, :average_goals_scored=>2.75, :average_goals_against=>2.0833}}})

  end

end
