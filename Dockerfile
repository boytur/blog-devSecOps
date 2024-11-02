# ขั้นตอนที่ 1: ใช้ Node.js image เพื่อสร้าง environment
FROM node:18 AS build

# กำหนด working directory
WORKDIR /app

# คัดลอก package.json และ package-lock.json ไปยัง container
COPY package*.json ./

# ติดตั้ง dependencies
RUN npm install

# คัดลอกไฟล์โปรเจกต์ทั้งหมดไปยัง container
COPY . .

# สร้าง production build ของ Next.js
RUN npm run build

# ขั้นตอนที่ 2: ใช้ lightweight Node.js image เพื่อรัน application
FROM node:18-alpine AS runner

# กำหนด working directory
WORKDIR /app

# คัดลอก node_modules และ build ที่สร้างจากขั้นตอนแรก
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/.next ./.next
COPY --from=build /app/public ./public
COPY --from=build /app/package.json ./package.json

# กำหนด environment variables
ENV NODE_ENV=production
ENV PORT=3000

# เปิดพอร์ตที่ใช้รัน application
EXPOSE 3000

# คำสั่งสำหรับรัน application
CMD ["npm", "start"]
