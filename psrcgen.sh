# function definitions
function git_root_dir(){
    echo $(git rev-parse --show-toplevel)
}

function cur_dir(){
    echo $(pwd)
}

# read arguments
BASEDIR=$(dirname $0)
package_name_original=$1
module_name_original=$2
file_name_original=$3
git_root=$(git_root_dir)

# generate capital names
module_name_capital=$(echo ${module_name_original} | tr '[:lower:]' '[:upper:]')
file_name_capital=$(echo ${file_name_original} | tr '[:lower:]' '[:upper:]')
package_name_capital=$(echo ${package_name_original} | tr '[:lower:]' '[:upper:]')

# generate directory names
header_dir=${git_root}/include/${package_name_original}/${module_name_original}
source_dir=${git_root}/src/${package_name_original}/${module_name_original}
test_dir=${git_root}/test/${package_name_original}/${module_name_original}

# generate year
YEAR=$(date +%Y)

# Create top level CMakeLists.txt file if the files does not exists.
if [ ! -f "${git_root}/CMakeLists.txt" ]; then
  sed \
  -e "s/\${module_name_capital}/${module_name_capital}/" \
  -e "s/\${module_name_original}/${module_name_original}/" \
  -e "s/\${file_name_original}/${file_name_original}/" \
  -e "s/\${file_name_capital}/${file_name_capital}/" \
  -e "s/\${package_name_original}/${package_name_original}/" \
  -e "s/\${package_name_capital}/${package_name_capital}/" \
  -e "s/\${year}/${YEAR}/" \
  ${BASEDIR}/CMakeLists.txt.template > ${git_root}/CMakeLists.txt
fi


# Initialize include dir
if [ ! -d "${git_root}/include" ]; then
  mkdir -p ${git_root}/include
fi

# Initialize src dir
if [ ! -d "${git_root}/src" ]; then
  mkdir -p ${git_root}/src
fi

if [ ! -f "${git_root}/src/CMakeLists.txt" ]; then
  touch "${git_root}/src/CMakeLists.txt"
fi

# Initialize test dir
if [ ! -d "${git_root}/test" ]; then
  mkdir -p ${git_root}/test
fi

if [ ! -f "${git_root}/test/CMakeLists.txt" ]; then
  touch "${git_root}/test/CMakeLists.txt"
fi


# Initialize header dir
if [ ! -d "${header_dir}" ]; then
  mkdir -p ${header_dir}
fi

# Initialize source dir
if [ ! -d "${source_dir}" ]; then
  mkdir -p ${source_dir}
fi
if [ ! -f "${source_dir}/CMakeLists.txt" ]; then
  touch "${source_dir}/CMakeLists.txt"
  echo "add_subdirectory(${package_name_original}/${module_name_original})" >> "${git_root}/src/CMakeLists.txt"
fi

# Initialize test dir
if [ ! -d "${test_dir}" ]; then
  mkdir -p ${test_dir}
fi
if [ ! -f "${test_dir}/CMakeLists.txt" ]; then
  touch "${test_dir}/CMakeLists.txt"
  echo "add_subdirectory(${package_name_original}/${module_name_original})" >> "${git_root}/test/CMakeLists.txt"
fi


# Create *.cpp, *.h, *_test.cpp files if the files does not exists.
if [ ! -f "${header_dir}/${file_name_original}.h" ]; then
  sed \
  -e "s/\${module_name_capital}/${module_name_capital}/" \
  -e "s/\${module_name_original}/${module_name_original}/" \
  -e "s/\${file_name_original}/${file_name_original}/" \
  -e "s/\${file_name_capital}/${file_name_capital}/" \
  -e "s/\${package_name_original}/${package_name_original}/" \
  -e "s/\${package_name_capital}/${package_name_capital}/" \
  -e "s/\${year}/${YEAR}/" \
  ${BASEDIR}/header.template > ${header_dir}/${file_name_original}.h
fi

if [ ! -f "${source_dir}/${file_name_original}.cpp" ]; then
  sed \
  -e "s/\${module_name_capital}/${module_name_capital}/" \
  -e "s/\${module_name_original}/${module_name_original}/" \
  -e "s/\${file_name_original}/${file_name_original}/" \
  -e "s/\${file_name_capital}/${file_name_capital}/" \
  -e "s/\${package_name_original}/${package_name_original}/" \
  -e "s/\${package_name_capital}/${package_name_capital}/" \
  -e "s/\${year}/${YEAR}/" \
  ${BASEDIR}/source.template > ${source_dir}/${file_name_original}.cpp
fi

if [ ! -f "${test_dir}/${file_name_original}_test.cpp" ]; then
  sed \
  -e "s/\${module_name_capital}/${module_name_capital}/" \
  -e "s/\${module_name_original}/${module_name_original}/" \
  -e "s/\${file_name_original}/${file_name_original}/" \
  -e "s/\${file_name_capital}/${file_name_capital}/" \
  -e "s/\${package_name_original}/${package_name_original}/" \
  -e "s/\${package_name_capital}/${package_name_capital}/" \
  -e "s/\${year}/${YEAR}/" \
  ${BASEDIR}/gtest.template > ${test_dir}/${file_name_original}_test.cpp
fi


# deprecated. use libgtest_main.a
# if [ ! -f "${test_dir}/${module_name_original}_gtest_main_test.cpp" ]; then
#   sed \
#   -e "s/\${module_name_capital}/${module_name_capital}/" \
#   -e "s/\${module_name_original}/${module_name_original}/" \
#   -e "s/\${file_name_original}/${file_name_original}/" \
#   -e "s/\${file_name_capital}/${file_name_capital}/" \
#   -e "s/\${package_name_original}/${package_name_original}/" \
#   -e "s/\${package_name_capital}/${package_name_capital}/" \
#   -e "s/\${year}/${YEAR}/" \
#   ${BASEDIR}/gtest_main.template > ${test_dir}/${module_name_original}_test.cpp
# fi
