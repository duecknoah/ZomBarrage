var name = string(current_year) + "_" + string(current_month) + "_" + string(current_day) + "_" + string(current_minute) +"_" + string(current_time) + ".png";

screen_save(working_directory + "/screenshots/" + name);
show_debug_message("Screenshot taken: " + name);