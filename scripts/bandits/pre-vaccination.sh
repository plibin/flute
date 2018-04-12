work_dir=$1
flute_rl_dir=$2
flute_rl_bin=$3
config_template=$4
seed=$5
r0=$6
run_length=$7
geo=$8
doses=$9
priorities=${10}
priorities_no_commas=`echo ${priorities} | sed 's/,//g'`

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#echo "workdir:${workdir}"
#echo "flute_rl_dir:${flute_rl_dir}"
#echo "flute_rl_bin:${flute_rl_bin}"
#echo "config_template:${config_template}"
#echo "seed:${seed}"
#echo "r0:${r0}"
#echo "run_length:${run_length}"
#echo "geo:${geo}"
#echo "doses:${doses}"
#echo "priorities:${priorities}"

cd ${work_dir}

#create config file
python ${flute_rl_dir}/configs/mako-render.py ${config_template} --label="l0" --seed=${seed} --R0=${r0} --run_length=${run_length} --data_file=${flute_rl_dir}/data/${geo}/${geo} --doses=${doses} --vaccine_priorities=${priorities} > pre.config

#run flute
${flute_rl_bin} pre.config > ${work_dir}/out 2> ${work_dir}/err

#parse attack rate
ar=`python ${script_dir}/parse_attack_rate.py ${work_dir}/Summary0`
echo $ar
