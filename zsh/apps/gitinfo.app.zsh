GITINFO_BRANCH=""
GITINFO_COMMIT_ID=""
GITINFO_COMMIT_SHORTID=""
GITINFO_COMMIT_COUNT=0
GITINFO_NEW_FILES=""
GITINFO_MODIFIED_FILES=""
GITINFO_REMOTES=""
GITINFO_STASHES_COUNT=0

######################################################################
# Main function.
######################################################################
function gitinfo()
{
    curdir=`pwd`
    if [ ! -d "${curdir}/.git" ]; then
        echo "This is not a git repository."
        return 1
    fi

    gitinfo_get_branch
    gitinfo_get_changes
    gitinfo_get_commit_data
    gitinfo_get_remotes
    gitinfo_get_stashes

    gitinfo_check
    if [ $? -eq 0 ]; then
        echo "Git repository information:"
        echo "======================================================================"
        echo "| Branch        | $fg[yellow]${GITINFO_BRANCH}$reset_color"
        echo "| Commit        | $fg[green]${GITINFO_COMMIT_ID}$reset_color"
        echo "| Commits count | ${GITINFO_COMMIT_COUNT}"
        echo "| Stashes       | ${GITINFO_STASHES_COUNT}"
        echo "======================================================================"
    else
        echo "This is not a git repository. But you seeing this message. So it's a bug in 'gitinfo' application. Please, report to developer!"
    fi
}

######################################################################
# Adds some of gitinfo's functions into chpwd array.
######################################################################
function gitinfo_chpwd()
{
    emulate -L zsh
    precmd_functions=(${precmd_functions[@]} "gitinfo_get_branch" "gitinfo_get_commit_data" "gitinfo_get_changes" "gitinfo_get_remotes" "gitinfo_get_stashes")
}

######################################################################
# Checks if variables was set.
# Useful to call if we're using this app in prompt configuration.
######################################################################
function gitinfo_check()
{
    curdir=`pwd`
    if [ "${#GITINFO_BRANCH}" -eq 0 ]; then
        return 1
    fi
}

######################################################################
# Gets current directory's branch.
######################################################################
function gitinfo_get_branch()
{
    curdir=`pwd`
    if [ ! -d "${curdir}/.git" ]; then
        GITINFO_BRANCH=""
        return 1
    fi
    GITINFO_BRANCH=`git branch | cut -d " " -f 2`
}

######################################################################
# Gets current changes, if any.
######################################################################
function gitinfo_get_changes()
{
    curdir=`pwd`
    if [ ! -d "${curdir}/.git" ]; then
        GITINFO_NEW_FILES=""
        GITINFO_MODIFIED_FILES=""
        return 1
    fi
    GITINFO_NEW_FILES=`LC_ALL=C git status | grep "new" | wc -l`
    GITINFO_MODIFIED_FILES=`LC_ALL=C git status | grep "modified" | wc -l`
}

######################################################################
# Gets current directory's commit info, like long hash, short hash,
# commits count.
######################################################################
function gitinfo_get_commit_data()
{
    curdir=`pwd`
    if [ ! -d "${curdir}/.git" ]; then
        GITINFO_COMMIT_SHORTID=""
        GITINFO_COMMIT_ID=""
        GITINFO_COMMIT_COUNT=""
        return 1
    fi
    GITINFO_COMMIT_SHORTID=`git rev-parse --short HEAD`
    GITINFO_COMMIT_ID=`git log | head -n 1 | cut -d " " -f 2`
    GITINFO_COMMIT_COUNT=`git log | grep "commit " | wc -l`
}

######################################################################
# Gets remotes
######################################################################
function gitinfo_get_remotes()
{
    curdir=`pwd`
    if [ ! -d "${curdir}/.git" ]; then
        GITINFO_REMOTES=""
        return 1
    fi
    GITINFO_REMOTES=$(git remote -v | awk {' print $2 '} | uniq | wc -l)
}

######################################################################
# Gets current directory's stashes count.
######################################################################
function gitinfo_get_stashes()
{
    curdir=`pwd`
    if [ ! -d "${curdir}/.git" ]; then
        GITINFO_STASHES_COUNT=""
        return 1
    fi
    GITINFO_STASHES_COUNT=$(git stash list 2>/dev/null | wc -l)
}
