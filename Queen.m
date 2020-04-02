function Solution = Queen()

numberOfSamples = 50;
samples = zeros(numberOfSamples,8);
rolletWheel = zeros(1,numberOfSamples);
winners = zeros(50,8);
children = zeros(50,8);

mainEpochs = 0;
check = true;
while check
   % inititialization
    for i=1:numberOfSamples
        for j=1:8
            samples(i,j) = randi([1,8]);
        end
    end

    % evaluation
    fitness = fitnessCalculator(samples, numberOfSamples);

    epochs = 0;
    while check

        % selection
        res = 0;
        for i=1:numberOfSamples
            res = res + fitness(i) / sum(fitness');
            rolletWheel(i) = res;
        end
        for i=1:numberOfSamples
            randomNum = rand();
            for j=1:numberOfSamples
                if randomNum < rolletWheel(j)
                    break;
                end
            end

            for k=1:8
                winners(i,k) = samples(j,k);
            end
        end

        % crossover
        for i=1:2:50
            randNum = randi([1,8]);
            for j=1:randNum
                children(i,j) = winners(i,j);
                children(i+1,j) = winners(i+1,j);
            end
            for j=randNum+1:8
                children(i,j) = winners(i+1,j);
                children(i+1,j) = winners(i,j);
            end
        end

        % Jahesh
        probability = 0.02;
        for i=1:size(children,1)
            random = rand();
            if random < probability
                randIndexInside = randi([1,8]);
                replacementValue = randi([1,8]);
                children(i,randIndexInside) = replacementValue;
            end
        end

        % replacement
        chosenCount = 5;
        topParents = zeros(chosenCount,8);
        worstChildren = zeros(chosenCount,8);

        % choose top parents to replace
        parentsFitness = fitnessCalculator(winners, numberOfSamples);
        indexes = sortFitness(parentsFitness, numberOfSamples);

        n = size(indexes,2);
        for i=1:chosenCount
            for j=1:8
                topParents(i,j) = winners(indexes(n),j);
            end
            n = n-1;
        end

        % choose worst children to replace
        childrenFitness = fitnessCalculator(children, numberOfSamples);
        indexes = sortFitness(childrenFitness, numberOfSamples);

        n = 1;
        for i=1:chosenCount
            for j=1:8
                children(indexes(n),j) = topParents(i,j);
            end
            n = n+1;
        end

        currentFitness = fitnessCalculator(children, numberOfSamples);
        for i=1:numberOfSamples
            if currentFitness(i) == 28
                indexSolution = i;
                check = false;
                break;
            end
        end

        epochs = epochs + 1;
        if epochs > 200
            break;
        end
    end
    mainEpochs = mainEpochs + 1;
end

Solution = children(indexSolution,:);
disp(['main epochs = ', num2str(mainEpochs)]);
disp(['epochs = ', num2str(epochs)]);
disp(['Solution: ', mat2str(Solution)]);

end
