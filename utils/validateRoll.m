function isValid = validateRoll(roll)

    isValid = false;  % Default
    
    % Check length
    if length(roll) ~= 12
        return;
    end
    
    % Extract parts
    part1 = roll(1:4);
    part2 = roll(5:6);
    part3 = roll(7:8);
    part4 = roll(9:12);
    
    % Conditions
    cond1 = all(isstrprop(part1, 'digit'));
    cond2 = all(isstrprop(part2, 'alpha'));
    cond3 = all(isstrprop(part3, 'digit'));
    cond4 = all(isstrprop(part4, 'digit'));
    
    if cond1 && cond2 && cond3 && cond4
        isValid = true;
    end
    
end
