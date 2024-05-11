function parents = Select(individuals,N)
    sumfitness = sum(individuals.fitness);
    sumf = individuals.fitness./sumfitness;
    %%转两次转盘获得两个父代
    index = [];
    for i = 1:2
        pick = rand;
        while pick == 0
            pick = rand;
        end
        for j = 1:N
            pick = pick-sumf(j);
            if pick < 0
                index = [index j];
                break;
            end
        end
     end
     parents = individuals.chrom(index,:);
end

