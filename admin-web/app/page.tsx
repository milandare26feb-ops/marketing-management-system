'use client';

import { useEffect, useState } from 'react';
import { databases, DATABASE_ID, COLLECTIONS } from '@/lib/appwrite';
import { Query } from 'appwrite';

interface DashboardStats {
  totalUsers: number;
  pendingUsers: number;
  totalVisits: number;
  totalCampaigns: number;
}

export default function Home() {
  const [stats, setStats] = useState<DashboardStats>({
    totalUsers: 0,
    pendingUsers: 0,
    totalVisits: 0,
    totalCampaigns: 0,
  });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchDashboardStats();
  }, []);

  const fetchDashboardStats = async () => {
    try {
      const [users, pending, visits, campaigns] = await Promise.all([
        databases.listDocuments(DATABASE_ID, COLLECTIONS.USERS),
        databases.listDocuments(DATABASE_ID, COLLECTIONS.USERS, [
          Query.equal('status', 'pending')
        ]),
        databases.listDocuments(DATABASE_ID, COLLECTIONS.VISITS),
        databases.listDocuments(DATABASE_ID, COLLECTIONS.CAMPAIGNS),
      ]);

      setStats({
        totalUsers: users.total,
        pendingUsers: pending.total,
        totalVisits: visits.total,
        totalCampaigns: campaigns.total,
      });
    } catch (error) {
      console.error('Error fetching stats:', error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen p-8">
      <div className="max-w-7xl mx-auto">
        <div className="mb-8">
          <h1 className="text-4xl font-bold mb-2">MarketTrack Admin</h1>
          <p className="text-gray-400">Field Force Management Dashboard</p>
        </div>

        <nav className="mb-8 flex gap-4 border-b border-gray-700 pb-4">
          <a href="/" className="px-4 py-2 bg-blue-600 rounded-lg">Dashboard</a>
          <a href="/users" className="px-4 py-2 hover:bg-gray-800 rounded-lg">Users</a>
          <a href="/visits" className="px-4 py-2 hover:bg-gray-800 rounded-lg">Visits</a>
          <a href="/campaigns" className="px-4 py-2 hover:bg-gray-800 rounded-lg">Campaigns</a>
        </nav>

        {loading ? (
          <div className="text-center py-12">
            <div className="inline-block animate-spin rounded-full h-12 w-12 border-b-2 border-blue-500"></div>
            <p className="mt-4 text-gray-400">Loading...</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            <div className="bg-gray-800 rounded-lg p-6 border border-gray-700">
              <p className="text-gray-400 text-sm mb-1">Total Users</p>
              <h3 className="text-3xl font-bold">{stats.totalUsers}</h3>
            </div>
            <div className="bg-gray-800 rounded-lg p-6 border border-gray-700">
              <p className="text-gray-400 text-sm mb-1">Pending Approvals</p>
              <h3 className="text-3xl font-bold text-yellow-500">{stats.pendingUsers}</h3>
            </div>
            <div className="bg-gray-800 rounded-lg p-6 border border-gray-700">
              <p className="text-gray-400 text-sm mb-1">Total Visits</p>
              <h3 className="text-3xl font-bold text-green-500">{stats.totalVisits}</h3>
            </div>
            <div className="bg-gray-800 rounded-lg p-6 border border-gray-700">
              <p className="text-gray-400 text-sm mb-1">Active Campaigns</p>
              <h3 className="text-3xl font-bold text-purple-500">{stats.totalCampaigns}</h3>
            </div>
          </div>
        )}

        <div className="mt-8 text-center text-gray-500 text-sm">
          <p>MarketTrack Admin • Powered by Appwrite & Next.js</p>
        </div>
      </div>
    </div>
  );
}
