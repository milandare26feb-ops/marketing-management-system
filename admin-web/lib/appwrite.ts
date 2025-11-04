import { Client, Databases, Storage, Account } from 'appwrite';

const client = new Client()
  .setEndpoint(process.env.NEXT_PUBLIC_APPWRITE_ENDPOINT!)
  .setProject(process.env.NEXT_PUBLIC_APPWRITE_PROJECT_ID!);

export const databases = new Databases(client);
export const storage = new Storage(client);
export const account = new Account(client);

export const DATABASE_ID = process.env.NEXT_PUBLIC_APPWRITE_DATABASE_ID!;

export const COLLECTIONS = {
  USERS: process.env.NEXT_PUBLIC_APPWRITE_USERS_COLLECTION_ID!,
  VISITS: process.env.NEXT_PUBLIC_APPWRITE_VISITS_COLLECTION_ID!,
  CAMPAIGNS: process.env.NEXT_PUBLIC_APPWRITE_CAMPAIGNS_COLLECTION_ID!,
  REPORTS: process.env.NEXT_PUBLIC_APPWRITE_REPORTS_COLLECTION_ID!,
};

export { client };
