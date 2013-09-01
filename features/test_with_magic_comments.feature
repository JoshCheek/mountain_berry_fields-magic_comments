Feature: Testing with :magic_comments

  Scenario: Passing magic comments
    Given the file "Readme.mountain_berry_fields.md":
    """
    # Whatever

        <% test 'basic addition', with: :magic_comments do %>
        1 + 1 # => 2
        <% end %>

    More shit here
    """
    When I run "mountain_berry_fields Readme.mountain_berry_fields.md"
    Then it exits with a status of 0
    And I see the file "Readme.md":
    """
    # Whatever

        1 + 1 # => 2

    More shit here
    """

  Scenario: Passing magic comments, abbreviated
    Given the file "Readme.mountain_berry_fields.md":
    """
    # Whatever

      <% test 'lame Fibonacci', with: :magic_comments do %>
      def fib(n)
        if n <= 2
          [1, 1]
        else
          series = fib(n-1)
          series << series[-2] + series[-1]
        end
      end

      fib(2)  # => [1, 1]
      fib(4)  # => [1, 1, 2, 3]
      fib(44) # => [1, 1, 2, 3, 5, 8, 13, ..., 433494437, 701408733]
      fib(45) # => [1, 1, 2, 3, 5, 8, 13, ......
      <% end %>

    More shit here
    """
    When I run "mountain_berry_fields Readme.mountain_berry_fields.md"
    Then it exits with a status of 0
    And I see the file "Readme.md":
    """
    # Whatever

      def fib(n)
        if n <= 2
          [1, 1]
        else
          series = fib(n-1)
          series << series[-2] + series[-1]
        end
      end

      fib(2)  # => [1, 1]
      fib(4)  # => [1, 1, 2, 3]
      fib(44) # => [1, 1, 2, 3, 5, 8, 13, ..., 433494437, 701408733]
      fib(45) # => [1, 1, 2, 3, 5, 8, 13, ......

    More shit here
    """

  Scenario: Failing magic comments
    Given the file "Readme.mountain_berry_fields.md":
    """
    # Whatever

        <% test 'basic addition', with: :magic_comments do %>
        1 + 2 # => 12
        <% end %>

    More shit here
    """
    When I run "mountain_berry_fields Readme.mountain_berry_fields.md"
    Then it exits with a status of 1, and a stderr of:
    """
    FAILURE: basic addition
    Expected: 1 + 2 # => 12
    Actual:   1 + 2 # => 3
    """
    And I do not see the file "Readme.md"


  Scenario: Invalid example
    Given the file "Readme.mountain_berry_fields.md":
    """
    # Whatever

        <% test 'basic addition', with: :magic_comments do %>
        } + { # => 12
        <% end %>

    More shit here
    """
    When I run "mountain_berry_fields Readme.mountain_berry_fields.md"
    Then it exits with a status of 1, and a stderr including:
    """
    FAILURE: basic addition
    -:1: syntax error
    """
    And I do not see the file "Readme.md"
