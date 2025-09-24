# .Rprofile — safely auto-open quick-start.R in RStudio

local({
  if (interactive() && identical(Sys.getenv("RSTUDIO"), "1")) {
    setHook(
      "rstudio.sessionInit",
      function(newSession) {
        try(
          {
            if (
              isTRUE(newSession) &&
                file.exists("quick-start.R") &&
                requireNamespace("rstudioapi", quietly = TRUE)
            ) {
              rstudioapi::navigateToFile("quick-start.R", line = 1)
            }
          },
          silent = TRUE
        )
      },
      action = "append"
    )
  }
})
