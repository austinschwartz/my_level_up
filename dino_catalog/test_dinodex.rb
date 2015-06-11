require "minitest/autorun"
require './dinodex'

class TestDinoDex < Minitest::Test
  def setup
    @dinodex = DinoDex.new('dinodex.csv', 'african_dinosaur_export.csv')
  end

  def test_carnivores
    assert_equal ["Afrovenator", "Albertosaurus", "Carcharodontosaurus", "Deinonychus", "Diplocaulus", "Giganotosaurus", "Megalosaurus", "Quetzalcoatlus", "Suchomimus", "Yangchuanosaurus"].sort, @dinodex.clear.filter(Diet: "Carnivore").to_names
  end

  def test_chaining
    assert_equal ["Diplocaulus", "Quetzalcoatlus"].sort, @dinodex.clear.filter(Diet: "Carnivore").filter(Walking: "Quadruped").to_names
  end
  
  def test_biped
    assert_equal ["Abrictosaurus", "Afrovenator", "Albertonykus", "Albertosaurus", "Baryonyx", "Carcharodontosaurus", "Deinonychus", "Giganotosaurus", "Megalosaurus", "Suchomimus", "Yangchuanosaurus"].sort, @dinodex.clear.filter(Walking: "Biped").to_names
  end

  def test_period
    assert_equal ["Albertonykus", "Albertosaurus", "Baryonyx", "Deinonychus", "Dracopelta", "Giganotosaurus", "Paralititan", "Quetzalcoatlus", "Suchomimus"].sort, @dinodex.clear.filter(Period: "Cretaceous").to_names
  end

  def test_big
    assert_equal ["Baryonyx", "Giganotosaurus", "Giraffatitan", "Paralititan", "Suchomimus", "Yangchuanosaurus"].sort, @dinodex.clear.filter(Weight_in_lbs: DinoDex::BIG_SIZE).to_names
  end

  def test_small
    assert_equal ["Abrictosaurus", "Albertosaurus", "Carcharodontosaurus", "Deinonychus", "Megalosaurus", "Melanorosaurus", "Quetzalcoatlus"].sort, @dinodex.clear.filter(Weight_in_lbs: DinoDex::SMALL_SIZE).to_names
  end

  def test_json
    assert_equal "[{\"Name\": \"Albertosaurus\", \"Period\": \"Late Cretaceous\", \"Continent\": \"North America\", \"Diet\": \"Carnivore\", \"Weight_in_lbs\": 2000, \"Walking\": \"Biped\", \"Description\": \"Like a T-Rex but smaller.\"}, {\"Name\": \"Megalosaurus\", \"Period\": \"Jurassic\", \"Continent\": \"Europe\", \"Diet\": \"Carnivore\", \"Weight_in_lbs\": 2200, \"Walking\": \"Biped\", \"Description\": \"Originally thought to be a Quadruped. First dinosaur to be named.\"}, {\"Genus\": \"Melanorosaurus\", \"Period\": \"Triassic\", \"Carnivore\": \"No\", \"Weight\": 2400, \"Walking\": \"Quadruped\"}]",@dinodex.clear.filter(Weight_in_lbs: (525..2422)).to_json
  end

  def test_facts
    assert_equal "Name: Albertonykus\n - period: Early Cretaceous\n - continent: North America\n - diet: Insectivore\n - walking: Biped\n - description: Earliest known Alvarezsaurid.\n\nGenus: Paralititan\n - period: Cretaceous\n - carnivore: No\n - weight: 120000\n - walking: Quadruped", @dinodex.clear.filter(Period: "Cretaceous").filter(Diet: "Insectivore").facts
  end
end
