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
            availablePettyCashReport: availablePettyCashReport,
            searchFixAssetByCentreIdAssetClassId: searchFixAssetByCentreIdAssetClassId,
            searchStockByDate: searchStockByDate,
            searchMobilizationCountReportBydate: searchMobilizationCountReportBydate,
            searchBankDepositeReportBydate: searchBankDepositeReportBydate,
            searchMobilizationCountReportByMonth: searchMobilizationCountReportByMonth,
            searchMobilizationCountReportByMonthAndYear: searchMobilizationCountReportByMonthAndYear,
            searchBankDepositeReportByMonthAndYear: searchBankDepositeReportByMonthAndYear,
            searchBankDepositeReportByMonth: searchBankDepositeReportByMonth,
            downloadEnquiryCSVByDate: downloadEnquiryCSVByDate,
            downloadMobilizationCSVByDate: downloadMobilizationCSVByDate,
            downloadFollowUpCSVByDate: downloadFollowUpCSVByDate,
            downloadAdmissionCSVByDate: downloadAdmissionCSVByDate,
            downloadRegistrationCSVByDate: downloadRegistrationCSVByDate,
            downloadCounsellingCSVByDate: downloadCounsellingCSVByDate,
            downloadExpenseCSVByDate: downloadExpenseCSVByDate,
            downloadFixAssetByCentreIdAssetClassId: downloadFixAssetByCentreIdAssetClassId,
            downloadStockCSVByDate: downloadStockCSVByDate,
            totalSumOfCountByMonth: totalSumOfCountByMonth,
            totalSumOfCountByDate: totalSumOfCountByDate,
            downloadMobilizationCountReportCSVByMonthAndYear: downloadMobilizationCountReportCSVByMonthAndYear,
            downloadMobilizationCountReportCSVByDate: downloadMobilizationCountReportCSVByDate,
            retrieveBankDepositeByDate: retrieveBankDepositeByDate,
            retrieveCandidateFeeByDate: retrieveCandidateFeeByDate,
            retrieveRegistrationSummaryByDate: retrieveRegistrationSummaryByDate,
            retrieveDownPaymentSummaryByDate: retrieveDownPaymentSummaryByDate,
            retrieveInstallmentSummaryByDate: retrieveInstallmentSummaryByDate,
            retrieveCentrePettyCashByCentreId: retrieveCentrePettyCashByCentreId,
            searchExpenseDetailReportByDate: searchExpenseDetailReportByDate,
            searchCandidateFeeReportByDate: searchCandidateFeeReportByDate,
            searchCandidateOtherFeeReportByDate: searchCandidateOtherFeeReportByDate
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

        function searchStockByDate(FromDate, ToDate, Paging, OrderBy) {
            var url = "/Report/searchStockByDate",
                data = {
                    fromDate: FromDate,
                    toDate: ToDate,
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };

            return $http.post(url, data);
        }

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

        function searchFixAssetByCentreIdAssetClassId(assetClassId, centreId, Paging, OrderBy) {
            var url = "/Report/FixAssetByCentreIdAssetClassId",
                data = {
                    assetClassId: assetClassId,
                    centreId: centreId,
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };

            return $http.post(url, data);
        }

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

        function availablePettyCashReport(Paging, OrderBy) {
            var url = "/Report/AvailablePettyCashReport",
                data = {
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

        function searchBankDepositeReportBydate(centreId, fromMonth, fromYear) {
            var url = "/Report/BankDepositeReportBydate",
                data = {
                    centreId: centreId,
                    month: fromMonth,
                    year: fromYear
                };

            return $http.post(url, data);
        }

        function searchMobilizationCountReportByMonth() {
            var url = "/Report/MobilizationCountReportByCurrentMonth",
                data = {
                    
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

        function searchBankDepositeReportByMonthAndYear(centreId, fromYear, Paging, OrderBy) {
            var url = "/Report/BankDepositeReportByMonthAndYear",
                data = {
                    centreId: centreId,
                    year: fromYear,
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };

            return $http.post(url, data);
        }

        function searchBankDepositeReportByMonth() {
            var url = "/Report/TotalBankDepositeReportByCurrentMonth",
                data = {

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

        function downloadFixAssetByCentreIdAssetClassId(assetClassId, centreId) {
            var url = "/Report/DownloadFixAssetByCentreIdAssetClassId",
                data = {
                    assetClassId: assetClassId,
                    centreId: centreId,
                    fromDate: fromDate,
                    toDate: toDate
                };
            return $http.post(url, data);
        }

        function downloadStockCSVByDate(fromDate, toDate) {
            var url = "/Report/DownloadStockCSVByDate",
                data = {
                    fromDate: fromDate,
                    toDate: toDate
                };
            return $http.post(url, data);
        }

        function downloadMobilizationCountReportCSVByMonthAndYear(centreId,fromYear) {
            var url = "/Report/DownloadMobilizationCountReportCSVByMonthAndYear",
                data = {
                    centreId: centreId,
                    fromYear: fromYear,
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

        function retrieveBankDepositeByDate(centreId, date) {
            var url = "/Report/CentreBankDepositeReportByDate",
                data = {
                    centreId: centreId,
                    date: date
                };

            return $http.post(url, data);
        }

        function retrieveCentrePettyCashByCentreId(centreId, Paging, OrderBy) {
            var url = "/Report/CentrePettyCashList",
                data = {
                    centreId: centreId,
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };

            return $http.post(url, data);
        }

        function retrieveCandidateFeeByDate(centreId, date) {
            var url = "/Report/CentreCandidateFeeSummaryReportByDate",
                data = {
                    centreId: centreId,
                    date: date
                };

            return $http.post(url, data);
        }

        function retrieveRegistrationSummaryByDate(centreId, date) {
            var url = "/Report/RegistrationSummaryByDate",
                data = {
                    centreId: centreId,
                    date: date
                };

            return $http.post(url, data);
        }

        function retrieveDownPaymentSummaryByDate(centreId, date) {
            var url = "/Report/DownPaymentSummaryByDate",
                data = {
                    centreId: centreId,
                    date: date
                };

            return $http.post(url, data);
        }

        function retrieveInstallmentSummaryByDate(centreId, date) {
            var url = "/Report/InstallmentSummaryByDate",
                data = {
                    centreId: centreId,
                    date: date
                };

            return $http.post(url, data);
        }

        function searchExpenseDetailReportByDate(FromDate, ToDate, Paging, OrderBy) {
            var url = "/Report/SearchExpenseDetailReportByDate",
                data = {
                    fromDate: FromDate,
                    toDate: ToDate,
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };

            return $http.post(url, data);
        }

        function searchCandidateFeeReportByDate(FromDate, ToDate, Paging, OrderBy) {
            var url = "/Report/SearchCandidateFeeReportByDate",
                data = {
                    fromDate: FromDate,
                    toDate: ToDate,
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };

            return $http.post(url, data);
        }

        function searchCandidateOtherFeeReportByDate(FromDate, ToDate, Paging, OrderBy) {
            var url = "/Report/SearchCandidateOtherFeeReportByDate",
                data = {
                    fromDate: FromDate,
                    toDate: ToDate,
                    paging: Paging,
                    orderBy: new Array(OrderBy)
                };

            return $http.post(url, data);
        }
    }
})();