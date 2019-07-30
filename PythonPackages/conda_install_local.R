conda_install_local <- function(env,pkg,dir) {
  # Modified version of reticulate's conda_install() function that
  # installs package "pkg" into the conda environment "env" from a package
  # in the directory "dir".
  conda <- conda_binary()
  env <- reticulate:::condaenv_resolve(env)
  python <- conda_python(envname=env)
  args <- reticulate:::conda_args("install",env)
  args <- c(args,"-c",paste0("file:/",dir),pkg)
  result <- system2(conda,shQuote(args))
  if (result != 0L) {
    stop("Error ", result, " occurred installing ",pkg," into conda environment ", 
         env, call. = FALSE)
  }
  invisible(NULL)
}
