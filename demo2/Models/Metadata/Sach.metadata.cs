using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace demo2.Models
{
    [MetadataTypeAttribute(typeof(SachMetadata))]
    public partial class Sach
    {
        internal sealed class SachMetadata
        {
            [Required(ErrorMessage = "Vui lòng nhập dữ liệu")]
            [Display(Name = "Mã sách")]
            public int MaSach { get; set; }


            [Display(Name = "Tên sách")]
            [Required(ErrorMessage = "Vui lòng nhập dữ liệu")]
            public string TenSach { get; set; }

            [Display(Name = "Giá bán")]
            public Nullable<decimal> GiaBan { get; set; }

            [Display(Name = "Mô tả")]
            [Required(ErrorMessage = "Vui lòng nhập dữ liệu")]
            public string MoTa { get; set; }

            [DataType(DataType.Date)]
            [DisplayFormat(DataFormatString = "{0:dd/MM/YYYY}", ApplyFormatInEditMode = true)]
            [Display(Name = "Ngày cập nhật")]
            [Required(ErrorMessage = "Vui lòng nhập dữ liệu")]
            public Nullable<System.DateTime> NgayCapNhat { get; set; }

            [Display(Name = "Ảnh bìa")]
            [Required(ErrorMessage = "Vui lòng nhập dữ liệu")]
            public string AnhBia { get; set; }

            [Display(Name = "Số lượng tồn")]
            [Required(ErrorMessage = "Vui lòng nhập dữ liệu")]
            public Nullable<int> SoLuongTon { get; set; }

            [Display(Name = "Chủ đề")]
            [Required(ErrorMessage = "Vui lòng nhập dữ liệu")]
            public Nullable<int> MaChuDe { get; set; }

            [Display(Name = "Nhà xuất bản")]
            [Required(ErrorMessage = "Vui lòng nhập dữ liệu")]
            public Nullable<int> MaNXB { get; set; }

            //[Display(Name = "Mới")]
            //[Required(ErrorMessage = "Vui lòng nhập dữ liệu")]
            //public Nullable<int> Moi { get; set; }
            
        }
    }
}