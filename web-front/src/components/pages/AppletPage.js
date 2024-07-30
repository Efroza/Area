import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import Applet from "../service/utils_components/Applet";

function AppletPage() {
    const token = sessionStorage.getItem('Token')
    const navigate = useNavigate()

    useEffect(() => {
        if (token == null)
            navigate('/login')
    }, [token])

    return (
        <>
            <Applet reload={0} token={token}/>
        </>
    );
}

export default AppletPage;