conda_install_local <- function(env,pkg,dir,conda="auto") {
  # Modified version of reticulate's conda_install() function that
  # installs package "pkg" into the conda environment "env" from a package
  # in the directory "dir" using the conda executable "conda".
  conda <- conda_binary(conda)
  env <- reticulate:::condaenv_resolve(env)
  python <- conda_python(envname=env,conda)
  args <- reticulate:::conda_args("install",env)
  args <- c(args,"-c",paste0("file:/",dir),
            "-c","conda-forge",
            pkg)
  result <- system2(conda,shQuote(args))
  if (result != 0L) {
    stop("Error ", result, " occurred installing ",pkg," into conda environment ", 
         env, call. = FALSE)
  }
  invisible(NULL)
}
