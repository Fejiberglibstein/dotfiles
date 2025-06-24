import { Gtk } from "astal/gtk3"

export const range = (n: number) => [...Array(n).keys()]

export const Bbox = ({ child, children }) => <centerbox valign={Gtk.Align.CENTER}>
    {child ?? children}
</centerbox>
