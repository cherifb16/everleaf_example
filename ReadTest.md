
# codes qui sont en japonais
***


describe 'Addition' do
  it 'La solution 5 + 5 doit être 10.' do
    expect(5 + 5).to eq 10
  end
end

..............................................................................

it '(une description de it confirme)Que la solution de 5 + 5 est 10 .）' do
  ##Le code de test réel. attendez, (5 + 5) signifie .to eq, 10.
  expect(5 + 5).to eq 10
end

...............................................................................

expect(5 + 5).to eq 10
# expect(5 + 5) -> exécute le contenu de () (dans ce cas 5 + 5)
# .to -> "dont le résultat est"
# eq 10 -> "devrait être égal à 10", ce qui signifie.

...............................................................................

describe 'Addition' do
  it 'La solution 5 + 5 doit être 10.' do
    expect(5 + 5).to eq 10
  end
end

...............................................................................

describe 'Divers ajouts' do
  it 'La solution 5 + 5 doit être 10.' do
    expect(5 + 5).to eq 10
  end
  it '3 + 3 la solution doit être 6' do
    expect(3 + 3).to eq 6
  end
  it 'La solution 100 + 100 doit être 200.' do
    expect(100 + 100).to eq 200
  end
end

---------------------------------------------------------------------------------

describe 'Addition' do
  it 'La solution 5 + 5 doit être 10.' do
    expect(5 + 5).to eq 10
  end
end