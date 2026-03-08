// DEFAULT_API_URL: The default API URL to use when no API_BASE_URL found in environment
const DEFAULT_API_URL = 'http://localhost:5000';

export const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || DEFAULT_API_URL;
