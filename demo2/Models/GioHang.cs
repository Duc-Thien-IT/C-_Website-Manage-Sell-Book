using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using demo2.Models;

namespace demo2.Models
{
    public class GioHang
    {
        QLNSDataContext db = new QLNSDataContext();
        public int iMaSach { set; get; }
        public string sTenSach { set; get; }
        public string sAnhBia { set; get; }
        public double dDonGia { set; get; }
        public int iSoLuong { set; get; }
        public double dThanhTien { get { return iSoLuong * dDonGia; } }

        public GioHang(int masach)
        {
            iMaSach = masach;
            Sach sach = db.Saches.Single(s => s.MaSach == iMaSach);
            sTenSach = sach.TenSach;
            sAnhBia = sach.AnhBia;
            dDonGia = double.Parse(sach.GiaBan.ToString());
            iSoLuong = 1;
        }
    }
}