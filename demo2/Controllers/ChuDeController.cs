using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using demo2.Models;

namespace demo2.Controllers
{
    public class ChuDeController : Controller
    {
        // GET: ChuDe
        QLNSDataContext db = new QLNSDataContext();
        public ActionResult ChuDePartial()
        {
            return View(db.ChuDes.Take(10).ToList());
        }
    }
}