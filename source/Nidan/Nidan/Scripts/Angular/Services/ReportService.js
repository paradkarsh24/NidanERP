﻿(function () {
    'use strict';

    angular
        .module('Nidan')
        .factory('ReportService', ReportService);

    ReportService.$inject = ['$http'];

    function ReportService($http) {
        var service = {
            //retrieveEnquiryReports: retrieveEnquiryReports,
            searchEnquiryByDate: searchEnquiryByDate,
            //retrieveMobilizationReports: retrieveMobilizationReports,
            searchMobilizationByDate: searchMobilizationByDate,
            //retrieveFollowUpReports: retrieveFollowUpReports,
            searchFollowUpByDate: searchFollowUpByDate,
            searchAdmissionByDate: searchAdmissionByDate,
            searchRegistrationByDate: searchRegistrationByDate,
            searchCounsellingByDate: searchCounsellingByDate,
            searchExpenseByDate: searchExpenseByDate,
            searchMobilizationCountReportBydate: searchMobilizationCountReportBydate,
            searchMobilizationCountReportByMonthAndYear: searchMobilizationCountReportByMonthAndYear,
            downloadEnquiryCSVByDate: downloadEnquiryCSVByDate,
            downloadMobilizationCSVByDate: downloadMobilizationCSVByDate,
            downloadFollowUpCSVByDate: downloadFollowUpCSVByDate,
            downloadAdmissionCSVByDate: downloadAdmissionCSVByDate,
            downloadRegistrationCSVByDate: downloadRegistrationCSVByDate,
            downloadCounsellingCSVByDate: downloadCounsellingCSVByDate,
            downloadExpenseCSVByDate: downloadExpenseCSVByDate,
            totalSumOfCountByMonth: totalSumOfCountByMonth,
            totalSumOfCountByDate: totalSumOfCountByDate,
            downloadMobilizationCountReportCSVByMonthAndYear: downloadMobilizationCountReportCSVByMonthAndYear,
            downloadMobilizationCountReportCSVByDate: downloadMobilizationCountReportCSVByDate
        };

        return service;

        //function retrieveEnquiryReports(Paging, OrderBy) {

        //    var url = "/Report/EnquiryList",
        //        data = {
        //            paging: Paging,
        //            orderBy: new Array(OrderBy)
        //        };

        //    return $http.post(url, data);
        //}

        function searchEnquiryByDate(FromDate, ToDate, Paging, OrderBy) {
            var url = "/Report/SearchEnquiryByDate",
                data = {
                    fromDate: FromDate,
                    toDate: ToDate,
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };

            return $http.post(url, data);
        }

        //function retrieveMobilizationReports(Paging, OrderBy) {

        //    var url = "/Report/MobilizationList",
        //        data = {
        //            paging: Paging,
        //            orderBy: new Array(OrderBy)
        //        };

        //    return $http.post(url, data);
        //}

        function searchMobilizationByDate(FromDate, ToDate, Paging, OrderBy) {
            var url = "/Report/SearchMobilizationByDate",
                data = {
                    fromDate: FromDate,
                    toDate: ToDate,
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };

            return $http.post(url, data);
        }

        //function retrieveFollowUpReports(Paging, OrderBy) {

        //    var url = "/Report/FollowUpList",
        //        data = {
        //            paging: Paging,
        //            orderBy: new Array(OrderBy)
        //        };

        //    return $http.post(url, data);
        //}

        function searchFollowUpByDate(FromDate, ToDate, Paging, OrderBy) {
            var url = "/Report/SearchFollowUpByDate",
                data = {
                    fromDate: FromDate,
                    toDate: ToDate,
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };

            return $http.post(url, data);
        }

        function searchAdmissionByDate(FromDate, ToDate, Paging, OrderBy) {
            var url = "/Report/SearchAdmissionByDate",
                data = {
                    fromDate: FromDate,
                    toDate: ToDate,
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };

            return $http.post(url, data);
        }


        function searchRegistrationByDate(FromDate, ToDate, Paging, OrderBy) {
            var url = "/Report/SearchRegistrationByDate",
                data = {
                    fromDate: FromDate,
                    toDate: ToDate,
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };

            return $http.post(url, data);
        }

        function searchCounsellingByDate(FromDate, ToDate, Paging, OrderBy) {
            var url = "/Report/SearchCounsellingByDate",
                data = {
                    fromDate: FromDate,
                    toDate: ToDate,
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };
            return $http.post(url, data);
        }

        function searchExpenseByDate(FromDate, ToDate, Paging, OrderBy) {
            var url = "/Report/ExpenseReportByDate",
                data = {
                    fromDate: FromDate,
                    toDate: ToDate,
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };

            return $http.post(url, data);
        }

        function searchMobilizationCountReportBydate(centreId, fromMonth, fromYear) {
            var url = "/Report/MobilizationCountReportBydate",
                data = {
                    centreId: centreId,
                    month: fromMonth,
                    year: fromYear
                };

            return $http.post(url, data);
        }

        function searchMobilizationCountReportByMonthAndYear(centreId, fromYear, Paging, OrderBy) {
            var url = "/Report/MobilizationCountReportByMonthAndYear",
                data = {
                    centreId: centreId,
                    year: fromYear,
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };

            return $http.post(url, data);
        }

        function downloadEnquiryCSVByDate(fromDate, toDate) {
            var url = "/Report/DownloadEnquiryCSVByDate",
                data = {
                    fromDate: fromDate,
                    toDate: toDate
                };
            return $http.post(url, data);
        }

        function downloadFollowUpCSVByDate(fromDate, toDate) {
            var url = "/Report/DownloadFollowUpCSVByDate",
                data = {
                    fromDate: fromDate,
                    toDate: toDate
                };
            return $http.post(url, data);
        }

        function downloadAdmissionCSVByDate(fromDate, toDate) {
            var url = "/Report/DownloadAdmissionCSVByDate",
                data = {
                    fromDate: fromDate,
                    toDate: toDate
                };
            return $http.post(url, data);
        }

        function downloadMobilizationCSVByDate(fromDate, toDate) {
            var url = "/Report/DownloadMobilizationCSVByDate",
                data = {
                    fromDate: fromDate,
                    toDate: toDate
                };
            return $http.post(url, data);
        }

        function downloadRegistrationCSVByDate(fromDate, toDate) {
            var url = "/Report/DownloadRegistrationCSVByDate",
                data = {
                    fromDate: fromDate,
                    toDate: toDate
                };
            return $http.post(url, data);
        }

        function downloadCounsellingCSVByDate(fromDate, toDate) {
            var url = "/Report/DownloadCounsellingCSVByDate",
                data = {
                    fromDate: fromDate,
                    toDate: toDate
                };
            return $http.post(url, data);
        }

        function downloadExpenseCSVByDate(fromDate, toDate) {
            var url = "/Report/DownloadExpenseCSVByDate",
                data = {
                    fromDate: fromDate,
                    toDate: toDate
                };
            return $http.post(url, data);
        }

        function downloadMobilizationCountReportCSVByMonthAndYear(centreId, fromMonth, toMonth, fromYear, toYear) {
            var url = "/Report/DownloadMobilizationCountReportCSVByMonthAndYear",
                data = {
                    centreId: centreId,
                    fromMonth: fromMonth,
                    toMonth: toMonth,
                    fromYear: fromYear,
                    toYear: toYear
                };
            return $http.post(url, data);
        }

        function downloadMobilizationCountReportCSVByDate(centreId, month, year) {
            var url = "/Report/DownloadMobilizationCountReportCSVByDate",
                data = {
                    centreId: centreId,
                    month: month,
                    year: year
                };
            return $http.post(url, data);
        }

        function totalSumOfCountByMonth(centreId, fromMonth, toMonth, fromYear, toYear) {
            var url = "/Report/TotalSumOfCountReportByMonthAndYear",
                data = {
                    centreId: centreId,
                    fromMonth: fromMonth,
                    toMonth: toMonth,
                    fromYear: fromYear,
                    toYear: toYear
                };

            return $http.post(url, data);
        }

        function totalSumOfCountByDate(centreId, fromMonth, fromYear) {
            var url = "/Report/TotalMobilizationCountReportBydate",
                data = {
                    centreId: centreId,
                    month: fromMonth,
                    year: fromYear
                };

            return $http.post(url, data);
        }
    }
})();