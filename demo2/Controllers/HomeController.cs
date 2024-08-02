using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using demo2.Models;
using System.Data.Linq;
using System.Data.SqlClient;
using PagedList;
using PagedList.Mvc;
namespace demo2.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        QLNSDataContext db = new QLNSDataContext();


        public ActionResult Index(int? page)
        {
            int pageSize = 20;
            int pageNumber = (page ?? 1);
            return View(db.Saches.ToPagedList(pageNumber, pageSize));
        }

        public ActionResult Index1()
        {
            return View();
        }

        public ActionResult TT_TC()
        {
            return View();
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

        [HttpGet]
        public ActionResult DangKy()
        {

            return View();
        }
        [HttpPost]

        public ActionResult DangKy(FormCollection f, KhachHang kh)
        {
            var hoten = f["HoTenKH"];
            var tendn = f["TenDN"];
            var matkhau = f["MatKhau"];
            var nhaplaimatkhau = f["NhapLaiMatKhau"];
            var dienthoai = f["DienThoai"];
            var ngaysinh = string.Format("{0:MM/dd/yyyy}", f["NgaySinh"]);
            var email = f["Email"];
            var diachi = f["DiaChi"];
            if (String.IsNullOrEmpty(hoten))
            {
                ViewData["Loi1"] = "(Họ Tên không được bỏ trống)";
            }
            if (String.IsNullOrEmpty(tendn))
            {
                ViewData["Loi2"] = "(Tên đăng nhập không được bỏ trống)";
            }
            if (String.IsNullOrEmpty(matkhau))
            {
                ViewData["Loi3"] = "(Vui lòng nhập mật khẩu)";
            }
            if (string.IsNullOrEmpty(nhaplaimatkhau))
            {
                ViewData["Loi4"] = "(Vui lòng nhập lại Mật khẩu)";
            }
            else if (matkhau != nhaplaimatkhau)
            {
                ViewData["Loi4"] = "(Mật khẩu không khớp)";
            }

            if (String.IsNullOrEmpty(dienthoai))
            {
                ViewData["Loi5"] = "(Vui lòng nhập số điện thoại)";
            }
            else
            {
                kh.HoTen = hoten;
                kh.TaiKhoan = tendn;
                kh.MatKhau = matkhau;
                kh.Email = email;
                kh.DienThoai = dienthoai;
                kh.DiaChi = diachi;
                kh.NgaySinh = DateTime.Parse(ngaysinh);
                db.KhachHangs.InsertOnSubmit(kh);
                db.SubmitChanges();
                //ViewBag.ThongBao = "Đăng ký thành công!";
                return RedirectToAction("DangNhap");
            }
            ViewBag.ThongBao = "Đăng ký không thành công!";
            return this.DangKy();
        }

        [HttpGet]
        public ActionResult DangNhap()
        {
            return View();
        }
        [HttpPost]
        public ActionResult DangNhap(FormCollection f)
        {
            var tendn = f["TenDN"];
            var matkhau = f["MatKhau"];
            if (String.IsNullOrEmpty(tendn))
            {
                ViewData["Loi1"] = "(Tên đăng nhập không được bỏ trống)";
            }
            if (String.IsNullOrEmpty(matkhau))
            {
                ViewData["Loi2"] = "(Vui lòng nhập mật khẩu)";
            }
            else
            {
                KhachHang kh = db.KhachHangs.SingleOrDefault(n => n.TaiKhoan == tendn && n.MatKhau == matkhau);
                if (kh != null)
                {
                    ViewBag.ThongBao = "(Đăng nhập thành công !!!)";
                    Session["TaiKhoan"] = kh;
                }
                else
                    ViewBag.ThongBao = "(Sai Tên DN hoặc sai Mật Khẩu. Vui lòng nhập lại)";
            }
            return RedirectToAction("Index", "Home");
        }

        public ActionResult DangXuat()
        {
            Session["TaiKhoan"] = null;
            return RedirectToAction("Index", "Home");

        }

    }
}