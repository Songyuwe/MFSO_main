


function [A1, A2, Abest,C1,C2,Cm] = updateValues(A1, A2, A3, C1, C2, Positions)
    % 检查A3是否小于A1和A2
    if A3 < A1 && A3 < A2
        % A3小于A1和A2，将A3赋予给A1和A2中较大的那个
        if A1 > A2
            A2 = A3; C2=Positions;
        else
            A1 = A3; C1=Positions;
        end
    % 检查A3是否大于A1且小于A2
    elseif A3 > A1 && A3 < A2
        % A3大于A1且小于A2，将A3赋予给A2
        A2 = A3; C2=Positions;
    % 检查A3是否大于A2且小于A1
    elseif A3 > A2 && A3 < A1
        % A3大于A2且小于A1，将A3赋予给A1
        A1 = A3; C1=Positions;
    end
    % 确定A1和A2中较小的值作为Abest
    if A1 < A2
        Abest = A1; Cm=C1;
    else
        Abest = A2; Cm=C2;
    end
end


