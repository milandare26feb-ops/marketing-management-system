import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "MarketTrack Admin",
  description: "Admin panel for MarketTrack field force management",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className="antialiased bg-gray-900 text-gray-100">
        {children}
      </body>
    </html>
  );
}
