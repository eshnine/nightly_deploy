# nightly delpoy
allow you to merge and deploy a branch to production and have a good night sleep

# requirements
below commands needs to be on your path
 - drone - offical drone cli to deploy a build
 - gh - offical github cli to merge a PR

# prepare enviroment
open drone > user setting and export DRONE_SERVER and DRONE_TOKEN to your
enviroment, also install gh command which allows you to merge a PR using CLI

# configure
you can edit the script it self and configure BRANCH, REPO and TARGET in first
lines or just pass them as argument

# run
`
./nightly_deploy BRANCH REPO TARGET
`

# example
`
./nightly_deploy feature/xxx-0000-awesome my/app mycompany/production/main
`

# schedule to be run
you can add this as a cron job or simply run using bash and combine it with `sleep`

consider right now is 10:00PM and you want to sleep, and deployment is at 2:00AM

`
sleep 4h && ./nightly_deploy feature/xxx-0000-awesome my/app mycompany/production/main
`
