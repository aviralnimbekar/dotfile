#!/bin/bash 

# It makes the script exit immediately if any command fails
set -e 

# loading color code lib/script into this file
source /Users/aviralnimbekar/projects/personal/scripts/shell/color-code.sh

# assigning Absolute Path
absPath=$1

cd $absPath

enable_bright_yellow_text_color
dirName=$(basename $absPath)
echo "Changed dir to \"$dirName\""
enable_bright_cyan_text_color

file=available_dependency_updates.txt

# If file done not exists then only run below cmd 
# -e check if a file exists and `!` negates 
if [[ ! -e $file ]]; then 
    ./gradlew dependencyUpdate > available_dependency_updates.txt
fi

found_later_milestone_version_line=0

while read -r line;
do
    if  [[ $found_later_milestone_version_line == 1 && $line == -* ]]; then
        # assigning all the index from awk cmd to variables
        enable_bright_cyan_text_color
        read dash dependency_name version <<< $(echo $line | awk -F'[][]' '{print $1, $2, $3}')
        echo "processing ->> $dependency_name"
        echo "with versions ->> $version"
        
        enable_bright_yellow_text_color
        read old_version new_version <<< $(echo $version | awk -F'->' '{print $1, $2}')
        
        # -i → Edits the file in place (modifies file.txt directly).
        # s/oldword/newword/g → Substitutes "oldword" with "newword" globally (g).
        sed -i '' "s/$old_version/$new_version/g" gradle.properties
        echo "replaced $old_version with $new_version for $dependency_name" 

        set +e
        read old_major old_minor old_patch <<< $(echo $old_version | awk -F'.' '{print $1, $2, $3}')
        read new_major new_minor new_patch <<< $(echo $new_version | awk -F'.' '{print $1, $2, $3}')
        
        if  [[ $old_major != $new_major || $old_minor != $new_minor ]]; then 
            enable_normal_text_color
            ./gradlew clean build test -x check -x installLocalGitHook -x jacocoTestCoverageVerification -x jacocoTestReport
        fi

        if [ $? -eq 0 ]; then
            # create file if doesnt exist
            if [[ ! -e "succeeded_dependency.txt" ]];then 
                echo -e "The following dependencies upgrades are successful:\n" > succeeded_dependency.txt
            fi
            # add dependency in succeeded_dependency.txt for backup
            sed -i '' -e '$a\'$'\n'"$dependency_name $old_version $new_version" succeeded_dependency.txt
        else
            sed -i '' "s/$new_version/$old_version/g" gradle.properties
            enable_bright_red_text_color
            echo "reverted $new_version back to $old_version for $dependency_name" 
            # create file if doesnt exist
            if [[ ! -e "failed_dependency.txt" ]];then 
                echo -e "The following dependencies upgrade breaking the app:\n" > failed_dependency.txt
            fi
            # add dependency in failed_dependency.txt for review
            sed -i '' -e '$a\'$'\n'"$dependency_name $old_version $new_version" failed_dependency.txt            
        fi
        set -e
        
        sed -i '' "/$new_version/d" available_dependency_updates.txt

    elif [[ $line == "The following dependencies have later milestone versions:" ]]; then
        found_later_milestone_version_line=1
    fi
done < $file

enable_bright_yellow_text_color
echo "Running Final build"
./gradlew clean build test -x check -x installLocalGitHook -x jacocoTestCoverageVerification -x jacocoTestReport
