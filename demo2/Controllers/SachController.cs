using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using demo2.Models;
namespace demo2.Controllers
{
    public class SachController : Controller
    {
        // GET: Sach
        QLNSDataContext db = new QLNSDataContext();
        public PartialViewResult SachPartial()
        {
            var ListSach = db.Saches.ToList();
            return PartialView(ListSach);
        }

        public ActionResult SachTheoChuDe(int macd)
        {
            var SachCD = db.Saches.Where(s => s.MaChuDe == macd).ToList();
            if (SachCD.Count == 0)
            {
                ViewBag.TB = "kHÔNG CÓ SÁCH NÀY!";
            }
            return View(SachCD);
        }


        public ActionResult SachTheoNXB(int manxb)
        {
            var SachNXB = db.Saches.Where(s => s.MaNXB == manxb).ToList();
            if (SachNXB.Count == 0)
            {
                ViewBag.TB = "kHÔNG CÓ SÁCH NÀY!";
            }
            return View(SachNXB);
        }



        public ActionResult SachTheoTG(int? matg)
        {
            var sach = db.Saches.AsQueryable();

            if (matg.HasValue)
            {
                sach = sach.Where(b => db.ThamGias.Any(ab => ab.MaSach == b.MaSach && ab.MaTacGia == matg));
            }

            return View(sach.ToList());
        }
        public ActionResult SachHOT()
        {
            return View(db.Saches.Take(30).ToList());
        }

        public ActionResult SachTuTruyen()
        {

            return View(db.Saches.Where(s => s.MaChuDe == 2).ToList());
        }

        public ActionResult XemChiTiet(int ms)
        {
            Sach sach = db.Saches.Single(s => s.MaSach == ms);
            if (sach == null)
            {
                return HttpNotFound();
            }
            return View(sach);
        }


    }
}