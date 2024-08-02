using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using demo2.Models;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using PagedList;
using PagedList.Mvc;

namespace demo2.Controllers
{
    public class QuanLySanPhamController : Controller
    {
        QLNSDataContext db = new QLNSDataContext();
        // GET: QuanLySanPham
        public ActionResult Index(int? page)
        {
            int pageSize = 20;
            int pageNumber = (page ?? 1);
            return View(db.Saches.ToPagedList(pageNumber, pageSize));
        }

        [HttpGet]
        public ActionResult ThemMoi()
        {
            ViewBag.MaChuDe = new SelectList(db.ChuDes.ToList().OrderBy(s => s.TenChuDe), "MaChuDe", "TenChuDe");
            ViewBag.MaNXB = new SelectList(db.NhaXuatBans.ToList().OrderBy(s => s.TenNXB), "MaNXB", "TenNXB");
            return View();
        }
        [HttpPost]
        public ActionResult ThemMoi(Sach sach, HttpPostedFileBase fileUpLoad)
        {
            if (!ModelState.IsValid)
            {
                return RedirectToAction("ThemMoi");
            }

            sach.MaSach = 1;
            sach.SoLuongTon = 0;
            db.Saches.InsertOnSubmit(sach);
            db.SubmitChanges();
            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult ChinhSua(int masach)
        {
            Sach sach = db.Saches.SingleOrDefault(s => s.MaSach == masach);
            if (sach == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            ViewBag.MaChuDe = new SelectList(db.ChuDes.ToList().OrderBy(s => s.TenChuDe), "MaChuDe", "TenChuDe", sach.MaChuDe);
            ViewBag.MaNXB = new SelectList(db.NhaXuatBans.ToList().OrderBy(s => s.TenNXB), "MaNXB", "TenNXB", sach.MaNXB);
            return View(sach);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ChinhSua(Sach collection, int masach)
        {
            //Thêm vào csdl
            try
            {
                Sach mas = db.Saches.Single(x => x.MaSach == masach);
                mas.TenSach = collection.TenSach;
                mas.GiaBan = collection.GiaBan;
                mas.MoTa = collection.MoTa;
                mas.NgayCapNhat = collection.NgayCapNhat;
                mas.AnhBia = collection.AnhBia;
                mas.SoLuongTon = collection.SoLuongTon;
                mas.MaChuDe = collection.MaChuDe;
                mas.MaNXB = collection.MaNXB;
                //mas.Moi = collection.Moi;
                db.SubmitChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        [HttpGet]
        public ActionResult ChiTiet(int masach)
        {
            Sach sach = db.Saches.SingleOrDefault(s => s.MaSach == masach);
            if (sach == null)
            {
                Response.StatusCode = 404;
                return null;
            }

            return View(sach);
        }

        [HttpGet]
        public ActionResult Xoa(int masach)
        {
            Sach sach = db.Saches.SingleOrDefault(s => s.MaSach == masach);
            if (sach == null)
            {
                Response.StatusCode = 404;
                return null;
            }

            return View(sach);
        }

        [HttpPost, ActionName("Xoa")]
        public ActionResult XacNhanXoa(int masach)
        {
            Sach sach = db.Saches.SingleOrDefault(s => s.MaSach == masach);
            if (sach == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            db.Saches.DeleteOnSubmit(sach);
            db.SubmitChanges();

            return RedirectToAction("Index");
        }
    }
}