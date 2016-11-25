This is currently not working in any meaningful way.

**Notice:**

Postrgres will complain about dot files being placed in the data volume, so
there's currently no way to add the postgres/pgdata plain directory to the git
repository, hence you must create it by hand before starting the container.
