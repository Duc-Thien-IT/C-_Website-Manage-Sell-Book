using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using demo2.Models;

namespace demo2.Controllers
{
    public class SearchController : Controller
    {
        // GET: Search
        QLNSDataContext db = new QLNSDataContext();
        [HttpPost]
        public ActionResult KetQuaTimKiem(FormCollection f)
        {
            string sTuKhoa = f["txtTimKiem"].ToString();
            List<Sach> listKQTK = db.Saches.Where(s => s.TenSach.Contains(sTuKhoa)).ToList();
            if(listKQTK == null)
            {
                ViewBag.ThongBao = "Không tìm thấy kết quả";
            }
            return View(listKQTK.OrderBy(s => s.TenSach));
        }
    }
}