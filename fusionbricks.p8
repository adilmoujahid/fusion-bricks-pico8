pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- pico-8 color palette
cp_1 = {3, 8}
cp_2 = {6, 7}
cp_3 = {10, 11, 12}
limits = {2,3,3,4,4,4,5,5,5,6,6}

rects = {}

function _init()

	cls()
	local colors = rnd({cp_2, cp_2, cp_2})
	local limit = rnd(limits)

    local canvassize = 128
    rect_split(0, 0, canvassize , canvassize, 1, limit)


    for i = 1, #rects do
        local r = rects[i]
        local x = r[1]
        local y = r[2]
        local w = r[3]
        local h = r[4]
        local r_num = rnd({0,1})
	    if r_num == 0 then
	    	if (w > 8 and h > 8) then
	    		rectsize = rnd({4, 8, 16})
	    	else
	    		rectsize = rnd({4, 8})
	    	end
	    	--rectfill(x, y, x+w, y+h, 0)
	        draw_rectangles(x, y, w, h, rectsize, colors)
	    else
	    	linesize = rnd({4, 8})
	    	--rectfill(x, y, x+w, y+h, 0)
	    	draw_lines(x, y, w, h, linesize, colors)
	    end
    end
end

function _update()
end

function _draw()
end

function rect_split(x, y, w, h, depth, limit)

    if (depth == limit) then
        return
    end

    local sizeoptions = {64, 32, 16, 8}

    if w > h then
        local index = flr(rnd(4)) + 1
        local rw = sizeoptions[index]
        rect_split(x, y, rw, h,  depth + 1, limit)
        rect_split(x + rw, y, w - rw, h,  depth + 1, limit)
        if depth == limit-1 then
        	add(rects, {x, y, rw, h})
        	add(rects, {x + rw, y, w - rw, h})
        end
    else
        local index = flr(rnd(4)) + 1
        local rh = sizeoptions[index]
        rect_split(x, y, w, rh, depth + 1, limit)
        rect_split(x, y + rh, w, h - rh, depth + 1, limit)
         if depth == limit-1 then
        	add(rects, {x, y, w, rh})
        	add(rects, {x, y + rh, w, h - rh})
        end
    end
end

function rnd_color(colors)
    return colors[flr(rnd(#colors)) + 1]
end


function draw_rectangles(x, y, w, h, rectsize, colors)
    local count1 = 0
    local count2 = 0
    for i = 0, w - 1, rectsize do
        for j = 0, h - 1, rectsize do
            if (count1%2 == 0) then
                local color = rnd_color(colors)
                rectfill(x + i, y + j, x + i + rectsize - 1, y + j + rectsize - 1, color)
            end
            count1 += 1
        end
        count2 += 1
        count1 = count2
    end
end


function draw_lines(x, y, w, h, linesize, colors)

	if (h < 8) or (w < 8) then
		return
	end

	local count = 1
    local r_num = rnd({0,1})
    
    if (r_num == 0) then
	    for i = 0, w-1, linesize do
	        if (count%2 == 0) then
	        	local color = rnd_color(colors)
	            rectfill(x + i, y, x + i + linesize - 1, y + h - 1, color)
	        end
	        count += 1
	    end

	else
	    for j = 0, h-1, linesize do
	        if (count%2 == 0) then
	        	local color = rnd_color(colors)
	            rectfill(x, y + j, x + w - 1, y + j + linesize - 1, color)
	        end
	        count += 1
	    end
	end
end

	
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
