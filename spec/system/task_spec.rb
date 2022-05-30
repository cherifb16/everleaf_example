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
        select '2024', from: 'task[dead_line(1i)]'
        select 'June', from: 'task[dead_line(2i)]'
        select '6', from: 'task[dead_line(3i)]'
        select 'completed', from: 'task[status]'
        select 'high', from: 'task[priority]'
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
        task = FactoryBot.create(:task, name: 'new_title4', content: 'new_content')
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
  context 'Si une recherche floue est effectuée sur le titre' do
    it "Réduit par les tâches contenant des termes de recherche." do
    sleep 1.0
    visit tasks_path
    fill_in 'name', with: 'title1'
    click_on 'Search'
    expect(page).to have_content '1'
    end
  end
  context 'Lorsqu-une recherche de statut est effectuée.' do
    it "Les tâches dont le statut correspond exactement sont réduites." do
      visit tasks_path
      select "completed", from: "number"
      click_on 'Search'
      expect(page).to have_content 'completed'
    end
  end
  context 'Lorsque des recherches de titres et de statuts ambigus sont effectuées' do
    it "Les tâches sont réduites à celles qui contiennent des termes de recherche dans le titre et qui correspondent exactement au statut." do

    visit tasks_path
    fill_in 'name', with: 'title2'
    select "inprogress", from: "number"
    click_on 'Search'
    expect(page).to have_content '2'
    expect(page).to have_content 'inprogress'
    end
  end
end

describe 'fonction de triage' do
  context 'Cliquez sur le lien Trier par date limite.' do
    it "Une liste de tâches triées par ordre décroissant de date de fin s'affiche." do
      task = FactoryBot.create(:task),FactoryBot.create(:second_task)
      visit tasks_path
      click_on "Deadline"
      sleep 1.0
      task_list = all('td')
      expect(task_list[0]).to have_content 'title2'
    end
  end
  context 'Appuyez sur le lien Trier par priorité' do
    it "Une liste de tâches triées par ordre de priorité croissant s'affiche." do
      task = FactoryBot.create(:task),FactoryBot.create(:second_task)
      visit tasks_path
      click_on "Priority"
      sleep 1.0
      task_list = all('td')
      expect(task_list[0]).to have_content 'title1'
    end
  end
end