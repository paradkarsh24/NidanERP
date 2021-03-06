﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Nidan.Entity;

namespace Nidan.Models
{
    public class ActivityTaskViewModel : BaseViewModel
    {
        public ActivityTask ActivityTask { get; set; }
        public Activity Activity { get; set; }
        public ActivityTaskDataGrid ActivityTaskDataGrid { get; set; }
        public ActivityDataGrid ActivityDataGrid { get; set; }
        public SelectList AssignToList { get; set; }
        public SelectList Centres { get; set; }
        public SelectList TaskStates { get; set; }
        public SelectList MonitoredByList { get; set; }
        public IEnumerable<SelectListItem> HoursList { get; set; }
        public IEnumerable<SelectListItem> MinutesList { get; set; }
        public IEnumerable<SelectListItem> TaskPriorityList { get; set; }
        public int Hours { get; set; }
        public int Minutes { get; set; }
        public int ActivityTaskId { get; set; }
        public int MonitoredById { get; set; }
        public string MonitoredByName { get; set; }
        public string ActivityTaskStatus { get; set; }
        public double NumberOfDays { get; set; }
        public TimeSpan NumberOfHours { get; set; }
        public List<HoursType> HoursType => new List<HoursType>()
        {
            new HoursType() { Id = 01,Name = "01"},
            new HoursType() { Id = 02,Name = "02"},
            new HoursType() { Id = 03,Name = "03"},
            new HoursType() { Id = 04,Name = "04"},
            new HoursType() { Id = 05,Name = "05"},
            new HoursType() { Id = 06,Name = "06"},
            new HoursType() { Id = 07,Name = "07"},
            new HoursType() { Id = 08,Name = "08"},
            new HoursType() { Id = 09,Name = "09"},
            new HoursType() { Id = 10,Name = "10"},
            new HoursType() { Id = 11,Name = "11"},
            new HoursType() { Id = 12,Name = "12"},
            new HoursType() { Id = 13,Name = "13"},
            new HoursType() { Id = 14,Name = "14"},
            new HoursType() { Id = 15,Name = "15"},
            new HoursType() { Id = 16,Name = "16"},
            new HoursType() { Id = 17,Name = "17"},
            new HoursType() { Id = 18,Name = "18"},
            new HoursType() { Id = 19,Name = "19"},
            new HoursType() { Id = 20,Name = "20"},
            new HoursType() { Id = 21,Name = "21"},
            new HoursType() { Id = 22,Name = "22"},
            new HoursType() { Id = 23,Name = "23"},
            new HoursType() { Id = 24,Name = "24"}
        };

        public List<MinutesType> MinutesType => new List<MinutesType>()
        {
            new MinutesType() {Id = 00,Name = "00"},
            new MinutesType() {Id = 01,Name = "01"},
            new MinutesType() {Id = 02,Name = "02"},
            new MinutesType() {Id = 03,Name = "03"},
            new MinutesType() {Id = 04,Name = "04"},
            new MinutesType() {Id = 05,Name = "05"},
            new MinutesType() {Id = 06,Name = "06"},
            new MinutesType() {Id = 07,Name = "07"},
            new MinutesType() {Id = 08,Name = "08"},
            new MinutesType() {Id = 09,Name = "09"},
            new MinutesType() {Id = 10,Name = "10"},
            new MinutesType() {Id = 11,Name = "11"},
            new MinutesType() {Id = 12,Name = "12"},
            new MinutesType() {Id = 13,Name = "13"},
            new MinutesType() {Id = 14,Name = "14"},
            new MinutesType() {Id = 15,Name = "15"},
            new MinutesType() {Id = 16,Name = "16"},
            new MinutesType() {Id = 17,Name = "17"},
            new MinutesType() {Id = 18,Name = "18"},
            new MinutesType() {Id = 19,Name = "19"},
            new MinutesType() {Id = 20,Name = "20"},
            new MinutesType() {Id = 21,Name = "21"},
            new MinutesType() {Id = 22,Name = "22"},
            new MinutesType() {Id = 23,Name = "23"},
            new MinutesType() {Id = 24,Name = "24"},
            new MinutesType() {Id = 25,Name = "25"},
            new MinutesType() {Id = 26,Name = "26"},
            new MinutesType() {Id = 27,Name = "27"},
            new MinutesType() {Id = 28,Name = "28"},
            new MinutesType() {Id = 29,Name = "29"},
            new MinutesType() {Id = 30,Name = "30"},
            new MinutesType() {Id = 31,Name = "31"},
            new MinutesType() {Id = 32,Name = "32"},
            new MinutesType() {Id = 33,Name = "33"},
            new MinutesType() {Id = 34,Name = "34"},
            new MinutesType() {Id = 35,Name = "35"},
            new MinutesType() {Id = 36,Name = "36"},
            new MinutesType() {Id = 37,Name = "37"},
            new MinutesType() {Id = 38,Name = "38"},
            new MinutesType() {Id = 39,Name = "39"},
            new MinutesType() {Id = 40,Name = "40"},
            new MinutesType() {Id = 41,Name = "41"},
            new MinutesType() {Id = 42,Name = "42"},
            new MinutesType() {Id = 43,Name = "43"},
            new MinutesType() {Id = 44,Name = "44"},
            new MinutesType() {Id = 45,Name = "45"},
            new MinutesType() {Id = 46,Name = "46"},
            new MinutesType() {Id = 47,Name = "47"},
            new MinutesType() {Id = 48,Name = "48"},
            new MinutesType() {Id = 49,Name = "49"},
            new MinutesType() {Id = 50,Name = "50"},
            new MinutesType() {Id = 51,Name = "51"},
            new MinutesType() {Id = 52,Name = "52"},
            new MinutesType() {Id = 53,Name = "53"},
            new MinutesType() {Id = 54,Name = "54"},
            new MinutesType() {Id = 55,Name = "55"},
            new MinutesType() {Id = 56,Name = "56"},
            new MinutesType() {Id = 57,Name = "57"},
            new MinutesType() {Id = 58,Name = "58"},
            new MinutesType() {Id = 59,Name = "59"},
            new MinutesType() {Id = 60,Name = "60"}
        };

        public List<TaskPriority> TaskPriority => new List<TaskPriority>()
        {
            new TaskPriority() {Name = "High",Value = "High"},
            new TaskPriority() {Name = "Medium",Value = "Medium"},
            new TaskPriority() {Name = "Low",Value = "Low"}
        };
    }

    public class TaskPriority
    {
        public string Name { get; set; }
        public string Value { get; set; }
    }
}