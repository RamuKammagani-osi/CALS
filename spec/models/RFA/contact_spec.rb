# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

include RSpec

describe Helpers::Rfa::ContactHelper do
  before(:all) do
    @contact = file_fixture('contact.json').read
    @contacts = file_fixture('contacts.json').read
    @contact_helper = Helpers::Rfa::ContactHelper.new(auth_header: 'token')
  end

  def validate(result)
    expect(result.date).to eq('2000-12-31')
    expect(result.id).to eq(1)
    expect(result.title).to eq('title')
    expect(result.notes).to eq('notes')
  end

  def validateMap(result)
    validate (Rfa::Contact.new result)
  end

  it 'Test find contact by id' do
    begin
      allow(FaradayCals).to receive(:get) do |path, auth_header|
        expect(path).to eq('/contacts/1')
        expect(auth_header).to eq('token')
        env = Faraday::Env.from status: 200, body: @contact
        Faraday::Response.new env
      end
      result = @contact_helper.find_by_id(1)
      validate(result)
    ensure
      allow(FaradayCals).to receive(:get).and_call_original
    end
  end

  it 'Test create contact' do
    begin
      allow(FaradayCals).to receive(:post) do |path, auth_header, body|
        expect(path).to eq('/rfa-1a-forms/1/contacts')
        expect(auth_header).to eq('token')
        expect(body).to eq(@contact)
        env = Faraday::Env.from status: 201, body: @contact
        Faraday::Response.new env
      end
      result = @contact_helper.create_contact(1, @contact)
      validate(result)
    ensure
      allow(FaradayCals).to receive(:post).and_call_original
    end
  end

  it 'Test update contact' do
    begin
      allow(FaradayCals).to receive(:put) do |path, auth_header, body|
        expect(path).to eq('/contacts/1')
        expect(auth_header).to eq('token')
        expect(body).to eq(@contact)
        env = Faraday::Env.from status: 200, body: @contact
        Faraday::Response.new env
      end
      result = @contact_helper.update_contact(1, @contact)
      validate(result)
    ensure
      allow(FaradayCals).to receive(:put).and_call_original
    end
  end

  it 'Test delete contact' do
    begin
      allow(FaradayCals).to receive(:delete) do |path, auth_header|
        expect(path).to eq('/contacts/1')
        expect(auth_header).to eq('token')
        env = Faraday::Env.from status: 200, body: @contact
        Faraday::Response.new env
      end
      result = @contact_helper.delete_contact(1)
      validate(result)
    ensure
      allow(FaradayCals).to receive(:delete).and_call_original
    end
  end

  it 'Test create contact for rfa' do
    begin
      allow(FaradayCals).to receive(:post) do |path, auth_header, body|
        expect(path).to eq('/rfa-1a-forms/1/contacts')
        expect(auth_header).to eq('token')
        expect(body).to eq(@contact)
        env = Faraday::Env.from status: 201, body: @contact
        Faraday::Response.new env
      end
      result = @contact_helper.create(1, @contact)
      validate(result)
    ensure
      allow(FaradayCals).to receive(:post).and_call_original
    end
  end

  it 'Test find contacts by rfa' do
    begin
      allow(FaradayCals).to receive(:get) do |path, auth_header|
        expect(path).to eq('/rfa-1a-forms/1/contacts')
        expect(auth_header).to eq('token')
        env = Faraday::Env.from status: 200, body: @contacts
        Faraday::Response.new env
      end
      result = @contact_helper.find_items_by_application_id(1)
      result.each { |item| validateMap(item) }
    ensure
      allow(FaradayCals).to receive(:get).and_call_original
    end
  end
end
