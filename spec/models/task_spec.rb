require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'fonction de recherche' do
    let!(:task) { FactoryBot.create(:task)}
    let!(:second_task) { FactoryBot.create(:second_task) }
    context 'Si une recherche floue dun titre est effectuée à laide de la méthode scope' do
      it "Les tâches contenant des termes de recherche sont réduites." do
        expect(Task.search_name('1')).to include(task)
        expect(Task.search_name('1')).not_to include(second_task)
        expect(Task.search_name('1').count).to eq 1
      end
    end
    context 'Si une recherche détat est effectuée à laide de la méthode scope' do
      it "Les tâches dont le statut correspond exactement sont réduites." do
        expect(Task.search_status('completed')).to include(task)
        expect(Task.search_status('completed')).not_to include(second_task)
        expect(Task.search_status('completed').count).to eq 1
      end
    end
    context 'Recherches de titres et de statuts ambigus dans la méthode du champ dapplication' do
      it "Les tâches sont réduites à celles qui contiennent des termes de recherche dans le titre et qui correspondent exactement au statut." do
        expect(Task.search_name('1').search_status('completed')).to include(task)
        expect(Task.search_name('1').search_status('completed')).not_to include(second_task)
        expect(Task.search_name('1').search_status('completed').count).to eq 1
      end
    end
  end
  describe 'Task model test' do
    context 'Si le Title la tâche est vide' do
      it "C'est difficile à Validation" do
        task = Task.new(name: '', content: 'content test')
        expect(task).not_to be_valid
      end
    end
  end
  describe "fonction de validation taches vides" do
    context 'Si les détails de la tâche sont vides' do
      it 'Validation est intercepté' do
        task = Task.new(name: 'title test', content: '')
        expect(task).not_to be_valid
      end
    end
  end
    
  describe "fonction de validation des taches décrites" do
    context 'Si le Title et les détails de la tâche sont décrits' do
      it 'Validation passes' do
        task = Task.new(name: 'title test', content: 'content test')
        expect(task).to be_valid
      end
    end
  end
end
