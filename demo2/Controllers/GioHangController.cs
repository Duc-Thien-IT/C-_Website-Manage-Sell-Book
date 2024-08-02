using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using demo2.Models;
namespace demo2.Controllers
{
    public class GioHangController : Controller
    {
        #region giohang
        // GET: GioHang
        QLNSDataContext db = new QLNSDataContext();
        public ActionResult Index()
        {
            return View();
        }
        public List<GioHang> LayGioHang()
        {
            List<GioHang> ListGioHang = Session["GioHang"] as List<GioHang>;
            if (ListGioHang == null)
            {
                ListGioHang = new List<GioHang>();
                Session["GioHang"] = ListGioHang;
            }
            return ListGioHang;
        }

        public ActionResult ThemGioHang(int ms, string strURl)
        {
            //Lấy ra giỏ hàng
            List<GioHang> ListGioHang = LayGioHang();
            //kIỂM TRA SÁCH CÓ TỒN TẠI TRONG SESSION GIỎ HÀNG CHƯA
            GioHang SanPham = ListGioHang.Find(sp => sp.iMaSach == ms);
            {
                if (SanPham == null)
                {
                    SanPham = new GioHang(ms);
                    ListGioHang.Add(SanPham);
                    return Redirect(strURl);
                }
                else
                {
                    SanPham.iSoLuong++;
                    return Redirect(strURl);
                }
            }
        }

        private int TongSoLuong()
        {
            int tsl = 0;
            List<GioHang> ListGioHang = Session["GioHang"] as List<GioHang>;
            if (ListGioHang != null)
            {
                tsl = ListGioHang.Sum(sp => sp.iSoLuong);
            }
            return tsl;
        }

        private double TongThanhTien()
        {
            double ttt = 0;
            List<GioHang> ListGioHang = Session["GioHang"] as List<GioHang>;
            if (ListGioHang != null)
            {
                ttt += ListGioHang.Sum(sp => sp.dThanhTien);
            }
            return ttt;
        }

        public ActionResult GioHang()
        {
            if (Session["GioHang"] == null)
            {
                return RedirectToAction("Index1", "Home");
            }
            List<GioHang> ListGioHang = LayGioHang();

            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongThanhTien = TongThanhTien();

            return View(ListGioHang);
        }


        public ActionResult XoaGioHang(int masp)
        {
            List<GioHang> ListGioHang = LayGioHang();
            GioHang sp = ListGioHang.Single(s => s.iMaSach == masp);
            if (sp != null)
            {
                ListGioHang.RemoveAll(s => s.iMaSach == masp);
                return RedirectToAction("GioHang", "GioHang");
            }

            if (ListGioHang.Count == 0)
            {
                return RedirectToAction("Index1", "Home");
            }
            return RedirectToAction("GioHang", "GioHang");
        }

        public ActionResult XoaGioHangALL(int masp)
        {
            List<GioHang> ListGioHang = LayGioHang();
            GioHang sp = ListGioHang.Single(s => s.iMaSach == masp);
            if (sp != null)
            {
                ListGioHang.Clear();

                return RedirectToAction("GioHang", "GioHang");
            }

            if (ListGioHang.Count == 0)
            {
                return RedirectToAction("Index1", "Home");
            }
            return RedirectToAction("Index1", "Home");
        }

        public ActionResult SuaGioHang()
        {
            if (Session["GioHang"] == null)
            {
                return RedirectToAction("Index1", "Home");
            }
            List<GioHang> ListGioHang = LayGioHang();

            return View(ListGioHang);
        }

        public ActionResult CapNhatGioHang(int masp, FormCollection f)
        {
            //Kiểm tra sản phẩm
            Sach sach = db.Saches.SingleOrDefault(s => s.MaSach == masp);
            //Lấy sai mã thì trả về trang lỗi
            if(sach == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            //Lấy giỏ hàng ra từ session
            List<GioHang> ListGioHang = LayGioHang();
            //Kiểm tra sản phẩm có tồn tại trong session giỏ hàng không
            GioHang sanpham = ListGioHang.SingleOrDefault(s => s.iMaSach == masp);
            if(sanpham != null)
            {
                sanpham.iSoLuong = int.Parse(f["txtSoLuong"].ToString());
            }
            return RedirectToAction("GioHang");
        }

        #endregion

        #region dathang
        [HttpPost]
        public ActionResult DatHang()
        {
            //Kiểm tra đăng nhập
            if (Session["TaiKhoan"] == null || Session["TaiKhoan"].ToString() == "")
            {
                return RedirectToAction("DangNhap", "Home");
            }
            //kiểm tra giỏ hàng
            if (Session["Giohang"] == null)
            {
                RedirectToAction("Index", "Home");
            }
            //Thêm đơn hàng
            DonHang ddh = new DonHang();
            KhachHang kh = (KhachHang)Session["TaiKhoan"];
            List<GioHang> gh = LayGioHang();
            ddh.MaKH = kh.MaKH;
            ddh.NgayDat = DateTime.Now;
            //Thêm chi tiết đơn hàng
            db.DonHangs.InsertOnSubmit(ddh);
            db.SubmitChanges();
            //Thêm đơn hàng
            foreach (var item in gh)
            {
                ChiTietDonHang ctdh = new ChiTietDonHang();
                ctdh.MaDonHang = ddh.MaDonHang;
                ctdh.MaSach = item.iMaSach;
                ctdh.SoLuong = item.iSoLuong;
                ctdh.DonGia = (decimal)item.dDonGia;
                db.ChiTietDonHangs.InsertOnSubmit(ctdh);
            }
            db.SubmitChanges();
            return RedirectToAction("TT_TC", "Home");
        }
        #endregion
    }
}