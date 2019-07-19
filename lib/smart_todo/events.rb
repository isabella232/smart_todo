# frozen_string_literal: true

module SmartTodo
  # This module contains all the methods accessible for SmartTodo comments.
  # It is meant to be reopened by the host application in order to define
  # its own events.
  #
  # An event needs to return a +String+ containing the message that will be
  # sent to the TODO assignee or +false+ in case the event hasn't been met.
  #
  # @example Adding a custom event
  #   module SmartTodo
  #     module Events
  #       def trello_card_close(card)
  #         ...
  #       end
  #     end
  #   end
  #
  #   TODO(on: trello_card_close(381), to: 'john@example.com')
  module Events
    extend self

    # Check if the +date+ is in the past
    #
    # @param date [String] a correctly formatted date
    # @return [false, String]
    def date(date)
      Date.met?(date)
    end

    # Check if a new version of +gem_name+ was released with the +requirements+ expected
    #
    # @param gem_name [String]
    # @param requirements [Array<String>] a list of version specifiers
    # @return [false, String]
    def gem_release(gem_name, *requirements)
      GemRelease.new(gem_name, requirements).met?
    end

    # Check if the Pull Request or issue +pr_number+ is closed
    #
    # @param organization [String] the GitHub organization name
    # @param repo [String] the GitHub repo name
    # @param pr_number [String, Integer]
    # @return [false, String]
    def pull_request_close(organization, repo, pr_number)
      PullRequestClose.new(organization, repo, pr_number).met?
    end
    alias_method :issue_close, :pull_request_close
  end
end
