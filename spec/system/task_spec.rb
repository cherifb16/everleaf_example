require 'rails_helper'
RSpec.describe 'Fonction de gestion des tâches', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end
 
  describe "Nouvelle fonction de création" do
    context "Lors de la création d'une nouvelle tâche" do
      it "La tâche créée s'affiche" do
        visit new_task_path
        fill_in 'Name', with: 'title_test'
        fill_in 'Content', with: 'content_test'
        click_on 'Create Task'
        expect(page).to have_content 'title_test'
      end
    end
  end
  describe "Fonction d'affichage de liste" do
    context "Lors de la transition vers l'écran de liste" do
      it "La liste des tâches créées s'affiche" do
        task = FactoryBot.create(:task, name: 'task')   
        visit tasks_path        
        current_path
        Task.count
        page.html

        expect(page).to have_content 'task'
      end
    end
    context 'Si les tâches sont classées par ordre décroissant de date et de heure de création' do
      it 'Les nouvelles tâches apparaissent en haut de la liste.' do
        task = FactoryBot.create(:task, name: 'new_title1', content: 'new_content')
        task = FactoryBot.create(:task, name: 'new_title2', content: 'new_content')
        task = FactoryBot.create(:task, name: 'new_title3', content: 'new_content')
        task = FactoryBot.create(:task, name: 'new_title4', content: 'new_content4')
        visit tasks_path
        task_test = all('td')
        expect(task_test[0]).to  have_content 'new_title4'
      end
    end
  end
  describe "Fonction d'affichage détaillée" do
     context "Lors de la transition vers un écran de détails de tâche" do
       it "Le contenu de la tâche concernée s'affiche" do
        task = FactoryBot.create(:task, name: 'title', content: 'content')
        visit task_path(task.id)
     
        expect(page).to have_content 'content'
       end
     end
  end
end