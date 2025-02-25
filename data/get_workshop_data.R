get_workshop_data <- function(force_reload = FALSE) {

  data_fn <- here("data/workshop_data.rds")

  if (!file.exists(data_fn) | force_reload) {
    # connect to internal db with demo data
    conn <-
      DBI::dbConnect(
        odbc::odbc(),
        .connection_string =
          "Driver={ODBC Driver 18 for SQL Server};
                        Server=phsqlrpdr154.partners.org;
                        Database=i2b2demodata;
                        Trusted_Connection=yes"
      )

    readSql <- function(sourcefile) {
      readChar(sourcefile, file.info(sourcefile)$size)
    }

    # load sql query
    sql <- readSql(here("data/workshop_data.sql"))

    # execute sql in database and retrieve data
    d <- DBI::dbGetQuery(conn, sql)

    # save the file to an R dataset file
    saveRDS(d, file = data_fn)

  } else {
    d <- readRDS(file = data_fn)

  }

  d

}
