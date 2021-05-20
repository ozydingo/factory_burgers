FactoryBot.define do
  factory :factory_without_sequences, class: "Object" do
    foo { 1 }
    bar { 2 }
    baz { 3 }
    qux { 4 }
  end

  factory :factory_with_one_sequence, class: "Object" do
    foo { generate :foo_name }
    bar { 2 }
    baz { 3 }
    qux { 4 }
  end

  factory :factory_with_multiple_sequences, class: "Object" do
    foo { 1 }
    bar { generate :bar_name }
    baz { generate :baz_name }
    qux { generate :qux_name }
  end

  sequence :sequence do |n|
    "foo#{n}"
  end

  sequence :sequence_with_numeric_behavior do |n|
    "bar#{n - 10}"
  end

  factory :fake_model, class: "Object" do
    foo { generate :sequence }
    bar { generate :sequence_with_numeric_behavior }
  end
end
