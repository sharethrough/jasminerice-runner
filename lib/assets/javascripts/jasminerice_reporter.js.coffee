class JasminericeReporter

  jasmineStarted: =>
    @failedSpecs = []
    @totalCount = 0
    @failedCount = 0

  jasmineDone: () ->
    @finished = true

  specDone: (result) =>
    @totalCount++
    if result.failedExpectations.length > 0
      @failedCount++
      console.log result.failedExpectations
      for expectation in result.failedExpectations
        if !expectation.passed
          failure =
            id: result.id
            fullName: result.fullName
            message: expectation.message
          @failedSpecs.push(failure)

# make sure this exists so we don't have timing issue
# when capybara hits us before the onload function has run
window.jasmineRiceReporter = new JasminericeReporter()

document.addEventListener 'DOMContentLoaded', ->
  jasmine.getEnv().addReporter window.jasmineRiceReporter
