GITINFO_BRANCH=""
GITINFO_COMMIT_ID=""
GITINFO_COMMIT_SHORTID=""
GITINFO_COMMIT_COUNT=0
GITINFO_DELETED_FILES=""
GITINFO_MODIFIED_FILES=""
GITINFO_NEW_FILES=""
GITINFO_RECHECK=0
GITINFO_REMOTES=""
GITINFO_STASHES_COUNT=0
GITINFO_TOPLEVEL_DIR=""
GITINFO_UNTRACKED_COUNT=0

######################################################################
# Main function.
######################################################################
function gitinfo()
{
    GITINFO_RECHECK=1

    gitinfo_internal_checks
    if [ $? -eq 1 ]; then
        echo "This is not a git repository."
        return 1
    fi

    gitinfo_get_info

    gitinfo_check
    if [ $? -eq 0 ]; then
        echo "Git repository information:"
        echo "======================================================================"
        echo "| Branch        | $fg[yellow]${GITINFO_BRANCH}$reset_color"
        echo "| Commit        | $fg[green]${GITINFO_COMMIT_ID}$reset_color"
        echo "| Commits count | ${GITINFO_COMMIT_COUNT}"
        echo "| Changes       | $fg[green]${GITINFO_NEW_FILES}$reset_color new, $fg[yellow]${GITINFO_MODIFIED_FILES}$reset_color modified, $fg[red]${GITINFO_DELETED_FILES}$reset_color deleted, $fg[gray]${GITINFO_UNTRACKED_COUNT}$reset_color untracked"
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
    precmd_functions=(${precmd_functions[@]} "gitinfo_get_info")
}

######################################################################
# Checks if variables was set.
# Useful to call if we're using this app in prompt configuration.
######################################################################
function gitinfo_check()
{
    curdir=`pwd`

    GITINFO_TOPLEVEL_DIR=`git rev-parse --show-toplevel 2>/dev/null`
    if [ $? -ne 0 ]; then
        GITINFO_TOPLEVEL_DIR=""
        return 1
    fi

    if [ "${curdir/${GITINFO_TOPLEVEL_DIR}}" != "${curdir}" ]; then
        GITINFO_RECHECK=1
        gitinfo_internal_checks

        if [ $? -eq 0 ]; then
            return 0
        else
            return 1
        fi
    else
        GITINFO_RECHECK=0
        return 1
    fi
}

######################################################################
# Gets current repo branch.
######################################################################
function gitinfo_get_branch()
{
    GITINFO_BRANCH=`git branch | grep "*" | cut -d " " -f 2`
}

######################################################################
# Gets current changes, if any.
######################################################################
function gitinfo_get_changes()
{
    GITINFO_NEW_FILES=`LC_ALL=C git status | grep "new" | wc -l`
    GITINFO_MODIFIED_FILES=`LC_ALL=C git status | grep "modified" | wc -l`
    GITINFO_DELETED_FILES=`LC_ALL=C git status | grep "deleted" | wc -l`
}

######################################################################
# Gets current repo commit info, like long hash, short hash,
# commits count.
######################################################################
function gitinfo_get_commit_data()
{
    GITINFO_COMMIT_SHORTID=`git rev-parse --short HEAD`
    GITINFO_COMMIT_ID=`git log | head -n 1 | cut -d " " -f 2`
    GITINFO_COMMIT_COUNT=`git log | grep "commit " | wc -l`
}

######################################################################
# This function should be called to obtain neccessary data.
######################################################################
function gitinfo_get_info()
{
    gitinfo_check
    if [ $? -eq 0 ]; then
        gitinfo_get_branch
        gitinfo_get_changes
        gitinfo_get_commit_data
        gitinfo_get_remotes
        gitinfo_get_stashes
        gitinfo_get_untracked
    else
        GITINFO_BRANCH=""
        GITINFO_COMMIT_ID=""
        GITINFO_COMMIT_SHORTID=""
        GITINFO_COMMIT_COUNT=0
        GITINFO_DELETED_FILES=""
        GITINFO_MODIFIED_FILES=""
        GITINFO_NEW_FILES=""
        GITINFO_RECHECK=0
        GITINFO_REMOTES=""
        GITINFO_STASHES_COUNT=0
        GITINFO_TOPLEVEL_DIR=""
        GITINFO_UNTRACKED_COUNT=0
    fi
}

######################################################################
# Gets remotes
######################################################################
function gitinfo_get_remotes()
{
    GITINFO_REMOTES=$(git remote -v | awk {' print $2 '} | uniq | wc -l)
}

######################################################################
# Gets current repo stashes count.
######################################################################
function gitinfo_get_stashes()
{
    GITINFO_STASHES_COUNT=`git stash list 2>/dev/null | wc -l`
}

######################################################################
# Gets current repo untracked files and directories count.
######################################################################
function gitinfo_get_untracked()
{
    GITINFO_UNTRACKED_COUNT=`LC_ALL=C git status | grep -v "be\ committed\|On\ branch\|nothing\ added\|Untracked\ files\|git\ add\|Your\ branch\|new\ file\|git\ reset\|nothing\ to\ commit\|not\ staged\|git\ checkout\|modified\:" | sed '/^$/d' | wc -l`

}

######################################################################
# Some common checks that is used everywhere.
######################################################################
function gitinfo_internal_checks()
{
    if [ ${GITINFO_RECHECK} -eq 0 ]; then
        return 1
    fi

    if [ ${#GITINFO_TOPLEVEL_DIR} -ne 0 ]; then
        objects=`ls ${GITINFO_TOPLEVEL_DIR}/.git/objects | grep -v "info\|pack" | wc -l`
        if [ ${objects} -lt 1 ]; then
            return 1
        fi
    else
        return 1
    fi

    GITINFO_RECHECK=0
}
