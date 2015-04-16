require 'spec_helper'

describe ResponsesController do
  describe 'routing' do

    it 'recognizes and generates #index' do
      expect(get: '/responses').to route_to(controller: 'responses', action: 'index')
    end

    it 'recognizes and generates #new' do
      expect(get: '/responses/new').to route_to(controller: 'responses', action: 'new')
    end

    it 'recognizes and generates #show' do
      expect(get: '/responses/1').to route_to(controller: 'responses', action: 'show', id: '1')
    end

    it 'recognizes and generates #edit' do
      expect(get: '/responses/1/edit').to route_to(controller: 'responses', action: 'edit', id: '1')
    end

    it 'recognizes and generates #create' do
      expect(post: '/responses').to route_to(controller: 'responses', action: 'create')
    end

    it 'recognizes and generates #update' do
      expect(put: '/responses/1').to route_to(controller: 'responses', action: 'update', id: '1')
    end

    it 'recognizes and generates #destroy' do
      expect(delete: '/responses/1').to route_to(controller: 'responses', action: 'destroy', id: '1')
    end

  end
end
