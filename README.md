## Getting Started

To get the Shiny app running on your local machine, follow the steps below:

### 1. Clone the Repository

First, clone the repository to your local machine using the following command:

```bash
git clone https://github.com/mehdi-naji/BC-Economic-Development.git
cd BC-Economic-Development
```

### 2. Set Up the R Environment

This project uses `{renv}` to manage dependencies. To set up the required environment, open R or RStudio in the project directory and run the following commands:

```r
# Install the renv package if you don't have it already
install.packages("renv")

# Restore the project environment
renv::restore()
```

This will install all the packages required to run the app, using the exact versions specified in the `renv.lock` file.

### 3. Run the Shiny App

Once the environment is set up, you can start the Shiny app by running the following command in R:

```r
runApp("app_homepage.R")
```

This will launch the Shiny app in your default web browser.

### 4. Additional Notes

- Ensure that your R version is compatible with the versions specified in the `renv` environment.
- No additional steps are required after setting up the environment and running the app script.
