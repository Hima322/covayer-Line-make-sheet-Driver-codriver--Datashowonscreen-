//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebApplication2
{
    using System;
    using System.Collections.Generic;
    
    public partial class ReworkTable
    {
        public long ID { get; set; }
        public string BuildLabelNumber { get; set; }
        public string InspectionName { get; set; }
        public string InspectionType { get; set; }
        public string StationNameID { get; set; }
        public string OperatorName { get; set; }
        public Nullable<System.DateTime> InspectionDateTime { get; set; }
        public string SeatID { get; set; }
        public string SeatStatus { get; set; }
        public Nullable<System.DateTime> ReworkDatetime { get; set; }
    }
}
