# Usage:
#   Run SupCon on ALL dataset under FIVE streaming settings: iid, seq, seq-bl, seq-cc, seq-im, e.g.,
#     ./run-baseline.sh supcon mnist iid trial# ckpt
#   Criterion choices: supcon
#   Dataset choices: mnist, svhn, cifar10, cifar100, tinyimagenet
#   Data stream choices: iid, seq, seq-bl, seq-cc, seq-im
#   Trial #: the number of trial
#   ckpt: path to the stored model

cd ..;

model=resnet18

lr=0.01;
mem_samples=0;  #128;
mem_size=0;  #256;

if [ $2 = "mnist" ] || [ $2 = "svhn" ]; then
  if [ $3 = "iid" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model cnn --training_data_type iid  \
            --batch_size 256 --mem_samples $mem_samples --mem_size $mem_size \
            --val_batch_size 128 --num_workers 8 --steps_per_batch_stream 20 --epochs 1 \
            --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
            --train_samples_per_cls 4096 --test_samples_per_cls 500 --knn_samples 1000 --trial $4
  fi

  if [ $3 = "seq" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model cnn --training_data_type class_iid \
        --batch_size 256 --mem_samples $mem_samples --mem_size $mem_size \
        --val_batch_size 128 --num_workers 8 --steps_per_batch_stream 20 --epochs 1 \
        --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
        --train_samples_per_cls 4096 --test_samples_per_cls 500 --knn_samples 1000 --trial $4
  fi

  if [ $3 = "seq-bl" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model cnn --training_data_type class_iid --blend_ratio 0.5 \
        --batch_size 256 --mem_samples $mem_samples --mem_size $mem_size \
        --num_workers 8 --steps_per_batch_stream $5 --epochs 1 \
        --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
        --train_samples_per_cls 4096 --test_samples_per_cls 500 --knn_samples 1000 --trial $4
  fi

  if [ $3 = "seq-cc" ]; then
    python3.7 -m pdb main_supcon.py  --criterion $1 --dataset $2 --model cnn --training_data_type class_iid --n_concurrent_classes 2 \
        --batch_size 256 --mem_samples $mem_samples --mem_size $mem_size \
        --val_batch_size 128 --num_workers 8 --steps_per_batch_stream 20 --epochs 1 \
        --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
        --train_samples_per_cls 4096 --test_samples_per_cls 500 --knn_samples 1000 --trial $4
  fi

  if [ $3 = "seq-im" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model cnn --training_data_type class_iid \
        --batch_size 256 --mem_samples $mem_samples --mem_size $mem_size \
        --val_batch_size 128 --num_workers 8 --steps_per_batch_stream 20 --epochs 1 \
        --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
        --train_samples_per_cls 2048 4096 2048 4096 2048 2048 4096 2048 2048 4096 \
        --test_samples_per_cls 500 --knn_samples 1000 --trial $4
  fi
fi


if [ $2 = "cifar10" ] ; then
  if [ $3 = "iid" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model $model --training_data_type iid  \
      --batch_size 128 --mem_samples $mem_samples --mem_size $mem_size \
      --val_batch_size 128 --num_workers 8 --steps_per_batch_stream 10 --print_freq 10 --epochs 1 \
      --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
      --train_samples_per_cls 4096 --test_samples_per_cls 500 --knn_samples 1000 --trial $4
  fi

  if [ $3 = "seq" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model $model --training_data_type class_iid \
      --batch_size 128 --mem_samples $mem_samples --mem_size $mem_size \
      --val_batch_size 128 --num_workers 8 --steps_per_batch_stream 10 --print_freq 10 --epochs 1 \
      --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
      --train_samples_per_cls 4096 --test_samples_per_cls 500 --knn_samples 1000 --trial $4
  fi

  if [ $3 = "seq-bl" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model $model --training_data_type class_iid --blend_ratio 0.5 \
      --batch_size 128 --mem_samples $mem_samples --mem_size $mem_size \
      --val_batch_size 128 --num_workers 8 --steps_per_batch_stream $5 --print_freq 10 --epochs 1 \
      --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
      --train_samples_per_cls 4096 --test_samples_per_cls 500 --knn_samples 1000 --trial $4
  fi

  if [ $3 = "seq-cc" ]; then
    python3.7 -m pdb main_supcon.py --criterion $1 --dataset $2 --model $model --training_data_type class_iid --n_concurrent_classes 2 \
      --batch_size 128 --mem_samples $mem_samples --mem_size $mem_size \
      --val_batch_size 128 --num_workers 8 --steps_per_batch_stream $5 --print_freq 10 --epochs 1 \
      --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
      --train_samples_per_cls 4096 --test_samples_per_cls 500 --knn_samples 1000 --trial $4
  fi

  if [ $3 = "seq-im" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model $model --training_data_type class_iid \
      --batch_size 128 --mem_samples $mem_samples --mem_size $mem_size \
      --val_batch_size 128 --num_workers 8 --steps_per_batch_stream 10 --print_freq 10 --epochs 1 \
      --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
      --train_samples_per_cls 2048 4096 2048 4096 2048 2048 4096 2048 2048 4096 \
      --test_samples_per_cls 500 --knn_samples 1000 --trial $4
  fi
fi


if [ $2 = "cifar100" ] ; then
  if [ $3 = "iid" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model $model --training_data_type iid  \
      --batch_size 128 --mem_samples $mem_samples --mem_size $mem_size \
      --val_batch_size 128 --num_workers 8 --steps_per_batch_stream 10 --print_freq 10 --epochs 1 \
      --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
      --train_samples_per_cls 2560 --test_samples_per_cls 250 --knn_samples 5000 --trial $4
  fi

  if [ $3 = "seq" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model $model --training_data_type class_iid \
      --batch_size 128 --mem_samples $mem_samples --mem_size $mem_size \
      --val_batch_size 128 --num_workers 8 --steps_per_batch_stream 10 --print_freq 10 --epochs 1 \
      --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
      --train_samples_per_cls 2560 --test_samples_per_cls 250 --knn_samples 5000 --trial $4
  fi

  if [ $3 = "seq-bl" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model $model --training_data_type class_iid --blend_ratio 0.5 \
      --batch_size 128 --mem_samples $mem_samples --mem_size $mem_size \
      --val_batch_size 128 --num_workers 8 --steps_per_batch_stream 10 --print_freq 10 --epochs 1 \
      --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
      --train_samples_per_cls 2560 --test_samples_per_cls 250 --knn_samples 5000 --trial $4
  fi

  if [ $3 = "seq-cc" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model $model --training_data_type class_iid --n_concurrent_classes 2 \
      --batch_size 128 --mem_samples $mem_samples --mem_size $mem_size \
      --val_batch_size 128 --num_workers 8 --steps_per_batch_stream 10 --print_freq 10 --epochs 1 \
      --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
      --train_samples_per_cls 2560 --test_samples_per_cls 250 --knn_samples 5000 --trial $4
  fi

  if [ $3 = "seq-im" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model $model --training_data_type class_iid \
      --batch_size 128 --mem_samples $mem_samples --mem_size $mem_size \
      --val_batch_size 128 --num_workers 8 --steps_per_batch_stream 10 --print_freq 10 --epochs 1 \
      --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
      --train_samples_per_cls 1280 2560 2560 2560 1280 2560 2560 2560 2560 1280 2560 2560 2560 2560 1280 2560 2560 2560 2560 1280 \
      --test_samples_per_cls 250 --knn_samples 5000 --trial $4
  fi
fi


if [ $2 = "tinyimagenet" ] ; then
  if [ $3 = "iid" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model $model --training_data_type iid  \
      --batch_size 128 --mem_samples $mem_samples --mem_size $mem_size \
      --val_batch_size 64 --num_workers 8 --steps_per_batch_stream 10 --print_freq 10 --val_freq 4 --epochs 1 \
      --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
      --train_samples_per_cls 500 --test_samples_per_cls 50 --knn_samples_ratio 1.0 --trial $4
  fi

  if [ $3 = "seq" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model $model --training_data_type class_iid \
      --batch_size 128 --mem_samples $mem_samples --mem_size $mem_size \
      --val_batch_size 64 --num_workers 8 --steps_per_batch_stream 10 --print_freq 10 --val_freq 4 --epochs 1 \
      --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
      --train_samples_per_cls 500 --test_samples_per_cls 50 --knn_samples_ratio 1.0 --trial $4
  fi

  if [ $3 = "seq-bl" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model $model --training_data_type class_iid --blend_ratio 0.5 \
      --batch_size 128 --mem_samples $mem_samples --mem_size $mem_size \
      --val_batch_size 64 --num_workers 8 --steps_per_batch_stream 10 --print_freq 10 --val_freq 4 --epochs 1 \
      --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
      --train_samples_per_cls 500 --test_samples_per_cls 50 --knn_samples_ratio 1.0 --trial $4
  fi

  if [ $3 = "seq-cc" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model $model --training_data_type class_iid --n_concurrent_classes 2 \
      --batch_size 128 --mem_samples $mem_samples --mem_size $mem_size \
      --val_batch_size 64 --num_workers 8 --steps_per_batch_stream 10 --print_freq 10 --val_freq 4 --epochs 1 \
      --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
      --train_samples_per_cls 500 --test_samples_per_cls 50 --knn_samples_ratio 1.0 --trial $4
  fi

  if [ $3 = "seq-im" ]; then
    python3.7 main_supcon.py --criterion $1 --dataset $2 --model $model --training_data_type class_iid \
      --batch_size 128 --mem_samples $mem_samples --mem_size $mem_size \
      --val_batch_size 64 --num_workers 8 --steps_per_batch_stream 10 --print_freq 10 --val_freq 4 --epochs 1 \
      --learning_rate_stream $lr --temp_cont 0.1 --mem_w_labels \
      --train_samples_per_cls 250 500 500 500 250 500 500 500 500 500 \
      --test_samples_per_cls 50 --knn_samples_ratio 1.0 --trial $4
  fi
fi
