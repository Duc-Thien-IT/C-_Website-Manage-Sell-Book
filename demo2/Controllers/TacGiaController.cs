using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using demo2.Models;
namespace demo2.Controllers
{
    public class TacGiaController : Controller
    {
        // GET: TacGia
        QLNSDataContext db = new QLNSDataContext();
        public ActionResult TacGiaPartial()
        {

            return View(db.TacGias.Take(6).ToList());
        }

    }
}