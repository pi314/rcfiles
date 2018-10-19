tell application "iTerm"
    tell current session of current window
        set session_name to {get name} as text
        set new_session to {split vertically with same profile}
        select new_session
        set cut_point to offset of "(" in session_name
        set cut_point to cut_point - 1
        set session_name to text 1 thru cut_point of session_name
        if session_name ends with " "
            set session_name to text 1 thru -2 of session_name
        end if
        set name to session_name
    end tell
end tell
