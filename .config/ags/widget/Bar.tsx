import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Binding, Variable, bind } from "astal"
import Hyprland from "gi://AstalHyprland"
import { range, Bbox } from "./util"

const time = Variable("").poll(5000, "date")

function Workspaces() {
    const hypr = Hyprland.get_default()

    const workspaces: Binding<Array<any>> = bind(hypr, "workspaces").as(wss => wss
        .filter((ws: any) => !(ws.id >= -99 && ws.id <= -2)) // filter out special workspaces
        .sort((a: any, b: any) => a.id - b.id)
    )

    const selected = bind(hypr, "focusedWorkspace").as(fs => fs.id)

    return <box spacing="4" halign="baseline" space-evenly="false" >
        {
            range(10).map(i => i + 1).map(i => {

                return <centerbox valign={Gtk.Align.CENTER} className="workspace-container">
                    {Variable.derive([workspaces, selected], (workspaces, selected) => {

                        const workspace = workspaces
                            .find(ws => ws.id === i)

                        let className = "workspace"
                        className += !(workspace?.clients?.length > 0) ? " empty" : ""
                        className += selected == i ? " current" : ""

                        return <button
                            className={className}
                            onClick={() => workspace.focus()}
                        />
                    })()}

                </centerbox>
            })
        }
    </box>
}

export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor

    return <window
        className="Bar"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | LEFT | RIGHT}
        application={App}>
        <centerbox orientation="h">
            <box orientation="v">
                <Workspaces />
            </box>
            <box>{time()}</box>
        </centerbox>
    </window>
}
