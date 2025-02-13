export TASK=$1
export seed=$2
export comment=$3
export max_seq_len=$4
export gen_ratio=$5
export model_path=$6
export exp_num=$7
export feat_type=$8

EPOCHS=1
TRAIN_BATCH_SIZE=1
LOGGING_STEPS=50
WARMUP_RATIO=0.1
LEARNING_RATE=2e-5

if [ $TASK = 'MELD' ]; then
    EPOCHS=1
    TRAIN_BATCH_SIZE=1
    LOGGING_STEPS=80 #80
    WARMUP_RATIO=0.6
    LEARNING_RATE=2e-5
elif [ $TASK = 'DailyDialog' ]; then
    EPOCHS=1
    TRAIN_BATCH_SIZE=1
    LOGGING_STEPS=500
    WARMUP_RATIO=0.3
    LEARNING_RATE=2e-5
elif [ $TASK = 'IEMOCAP' ]; then
    EPOCHS=4
    TRAIN_BATCH_SIZE=1
    LOGGING_STEPS=80
    WARMUP_RATIO=0.6
    LEARNING_RATE=2e-5
fi

EVAL_BATCH_SIZE=$(expr 3 \* $TRAIN_BATCH_SIZE)

python main_stage2.py \
--model_name_or_path $model_path \
--do_train \
--task_name $TASK \
--num_train_epochs $EPOCHS \
--learning_rate $LEARNING_RATE \
--output_dir ./save/$TASK \
--overwrite_output_dir \
--per_device_train_batch_size $TRAIN_BATCH_SIZE \
--per_device_eval_batch_size $EVAL_BATCH_SIZE \
--logging_steps $LOGGING_STEPS \
--warmup_ratio $WARMUP_RATIO \
--adam_epsilon 1e-6 \
--weight_decay 0.01 \
--seed $seed \
--diff_lr \
--comment $comment \
--max_seq_len $max_seq_len \
--gen_ratio $gen_ratio \
--use_exp_prompt \
--use_hist_prompt \
--exp_demon_num $exp_num \
--max_history_feat_len 20 \
--feat_type $feat_type \
