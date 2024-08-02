using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using demo2.Models;
namespace demo2.Controllers
{
    public class NhaXuatBanController : Controller
    {
        // GET: NhaXuatBan
        QLNSDataContext db = new QLNSDataContext();
        public ActionResult NhaXuatBanPartial()
        {
            return View(db.NhaXuatBans.Take(6).ToList());
        }

    }
}