int kludge_argc = 1;
char *kludge_argv[] = { "kludge", "argv" };
char *kludge_env = "";

int
main(int argc, char** argv)
{
    rump_pub_lwproc_releaselwp();
    gomaincaller(argc, argv);
}
