import matplotlib.pyplot as plt
import itertools
import json
import sys
import shutil


def plotting_acc(filename,figname=None):
    
    with open(filename) as file:
        data = json.load(file)



    ratioOfTPAndTN = {int(key):data["(TP+TN)/N"][key] for key in data["(TP+TN)/N"].keys()}
    acc_val_set = {int(key):data["acc_val_set"][key] for key in data["acc_val_set"].keys()}
    precision = {int(key):data["precision"][key] for key in data["precision"].keys()}
    FMeasure = {int(key):data["F-Measure"][key] for key in data["F-Measure"].keys()}


    times_cls = {int(key):data["times_cls"][key] for key in data["times_cls"].keys()}
    data ={"(TP+TN)/N":ratioOfTPAndTN,
        "acc_val_set":acc_val_set,
        "times_cls":times_cls,
        "precision":precision,
        "F-Measure":FMeasure
        }


    colors = ['r', 'g', 'b', 'c', 'm', 'y', 'k', 'orange', 'purple', 'brown']  # 10 different colors
    linestyles = ['-', '--',':','dashdot']  # 2 line styles for key2 and key3

    num_of_acc_curves = len(data["(TP+TN)/N"][0])

    fig, axs = plt.subplots(num_of_acc_curves+1, 1, sharex=True, figsize=(20, 8))
    #increase height of every subplot
    for ax in axs:
        box = ax.get_position()
        ax.set_position([box.x0, box.y0, box.width * 0.8, box.height])

    x_shared = list(data["(TP+TN)/N"].keys())  # x values for key2 and key3
    for i in range(num_of_acc_curves):
        # if i+1 == 11:
        #     continue
        ax2 = axs[i+1]
        color = colors[i % len(colors)]
        y2 = [data["(TP+TN)/N"][k][i] for k in x_shared]

        y3 = [data["acc_val_set"][k][i] for k in x_shared]
        y4 = [data["precision"][k][i] for k in x_shared]
        y5 = [data["F-Measure"][k][i] for k in x_shared]
        if i+1 == 11:
            label1 = '(TP+TN)/N Overall'
            label2 = 'knn val Overall'
            label3 = 'dist'
            label4 = 'precision'
            label5 = 'F-Measure'
        else:
            label1 = f'(TP+TN)/N cls:{i+1}'
            label2 = f'knn val cls:{i+1}'
            label3 = f'dist cls:{i+1}'
            label4 = f'precision cls:{i+1}'
            label5 = f'F-Measure cls:{i+1}'
        if i == 0:
            ax2.plot(x_shared, y2, color=color, linestyle=linestyles[0], label=label1)
            ax2.plot(x_shared, y3, color=color, linestyle=linestyles[1], label=label2)
            ax2.plot(x_shared, y4, color=color, linestyle=linestyles[2], label=label4)
            ax2.plot(x_shared, y5, color=color, linestyle=linestyles[3], label=label5)
        else:        
            ax2.plot(x_shared, y2, color=color, linestyle=linestyles[0])
            ax2.plot(x_shared, y3, color=color, linestyle=linestyles[1])
            ax2.plot(x_shared, y4, color=color, linestyle=linestyles[2])
            ax2.plot(x_shared, y5, color=color, linestyle=linestyles[3])
        # 1ax2.set_xlabel('index of batch')
        ax2.set_ylabel('ACC')
        ax2.grid(True)
        ax2.legend(loc='center left', bbox_to_anchor=(1, 0.5))

    ax1 = axs[0]
    x1 = list(data["times_cls"].keys())
    for i in range(10):
        color = colors[i % len(colors)]
        y1 = [data["times_cls"][k][i] for k in x1]
        ax1.plot(x1, y1, color=color, label=f'counts cls:{i+1}')
        ax1.set_xticks(x1)
    ax1.set_ylabel('Counts/Batch')
    ax1.grid(True)

    ax2.legend(loc='center left', bbox_to_anchor=(1, 0.5))
    xticks = ax2.get_xticks()   
    xticklabels = [''] * len(xticks)   
    xticklabels[0] = f'{xticks[0]:.0f}'   
    xticklabels[len(xticks)//2] = f'{xticks[len(xticks)//2]:.0f}'  
    xticklabels[-1] = f'{xticks[-1]:.0f}'   
    ax2.set_xticklabels(xticklabels)  

    #plt.tight_layout(rect=[0, 0, 0.85, 1]) 
    fig.set_size_inches(20, 10)  
    #plt.show()

    if figname != None:
        fig.savefig(figname+".2.svg", format='svg', dpi=300, bbox_inches='tight')
    else:
        figname = filename.split(".json")[0]
        fig.savefig(figname+".2.svg", format='svg', dpi=300, bbox_inches='tight')
    #shutil.copyfile(filename,figname+".json")


if __name__ == '__main__':
    filename = sys.argv[1]
    plotting_acc(filename,None)
