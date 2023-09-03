<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="student.aspx.cs" Inherits="Student" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <div class="container-fluid">
                        <div class="row align-items-center mb-30 pt-30">
                            <div class="col-md-12 mr-auto ml-auto">
                                <div class="mb-0">
                                    <a href='#' class='float-right btn btn-sm btn-info btn-icon'><i class="fa fa-cog mr-2"></i>View Settings</a>
                                    <h4>Welcome back, <%= FirstName %></h4>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-3 mb-6 col-md-6 mb-30">
                                <div class="list border1 rounded overflow-hidden">
                                    <div class="list-item">
                                        <div class="list-thumb bg-primary text-primary-light avatar rounded-circle avatar60 shadow-sm">
                                            <i class="icon-Add-Basket"></i>
                                        </div>
                                        <div class="list-body text-right">
                                            <span class="list-title fs-2x"><%= TotalAssets %></span>
                                            <span class="list-content fs14">My Assets</span>

                                        </div>
                                    </div>
                                </div>
                            </div><!--col-->
                            <div class="col-lg-3 mb-6 col-md-6 mb-30">
                                <div class="list border1 rounded overflow-hidden">
                                    <div class="list-item">
                                        <div class="list-thumb bg-warning-active text-warning-light avatar rounded-circle avatar60 shadow-sm">
                                            <i class="icon-Truck"></i>
                                        </div>
                                        <div class="list-body text-right">
                                            <span class="list-title fs-2x"><%= TotalRepairs %></span>
                                            <span class="list-content  fs14">Repair Status</span>
                                        </div>
                                    </div>
                                </div>
                            </div><!--col-->
                            <div class="col-lg-3 mb-6 col-md-6 mb-30">
                                <div class="list border1 rounded overflow-hidden">
                                    <div class="list-item">
                                        <div class="list-thumb bg-danger-active text-danger-light avatar rounded-circle avatar60 shadow-sm">
                                            <i class="icon-Remove-Basket"></i>
                                        </div>
                                        <div class="list-body text-right">
                                            <span class="list-title fs-2x"><%= TotalLost %></span>
                                            <span class="list-content  fs14">Lost/Stolen</span>

                                        </div>
                                    </div>
                                </div>
                            </div>
<%--                            <div class="col-lg-3 mb-6 col-md-6  mb-30">
                                <div class="list border1 rounded overflow-hidden">
                                    <div class="list-item">
                                        <div class="list-thumb bg-success-active text-success-light avatar rounded-circle avatar60 shadow-sm">
                                            <i class="icon-Money-Bag"></i>
                                        </div>
                                        <div class="list-body text-right">
                                            <span class="list-title fs-2x">6830</span>
                                            <span class="list-content fs14">Earnings</span>

                                        </div>
                                    </div>
                                </div>
                            </div>--%>
                        </div>

                        <div class="row">
                            <div class="col-lg-12">
                                <div class="portlet-box portlet-fullHeight mb-30">
                                    <div class="portlet-header bg-light flex-row flex d-flex align-items-center">
                                        <div class="flex d-flex flex-column">
                                            <h3>Recent Item Activity</h3> 
                                        </div>
                                        <div class="portlet-tools">
                                            <ul class="nav">

                                                <li class="nav-item">
                                                    <select class="custom-select bg-light hidden-search" data-placeholder="Filter Orders">
                                                        <option value="1" selected>Recent Orders</option>
                                                        <option value="2">Pending Orders</option>
                                                        <option value="3">Canceled Orders</option>
                                                        <option value="4">Return Orders</option>
                                                    </select>
                                                </li>
                                                <li class="nav-item pl-3">
                                                    <a href="#" class="btn btn-link">
                                                        View all orders
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="portlet-body no-padding">

                                        <div class="table-responsive">
                                            <asp:Literal ID ="UserList" runat="server"></asp:Literal>
                                        </div>

                                    </div>
                                </div><!--portlet-->
                            </div><!--col-->
                        </div>
                    </div>
    </asp:Content>

