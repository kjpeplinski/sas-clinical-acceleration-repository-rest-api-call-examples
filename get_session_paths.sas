/*-----------------------------------------------------------------------------------------*/
/* Copyright (c) 2026 by SAS Institute Inc., Cary, NC, USA.                                */
/*                                                                                         */
/* Licensed under the Apache License, Version 2.0 (the "License");                         */
/* you may not use this file except in compliance with the License.                        */
/* You may obtain a copy of the License at                                                 */
/*                                                                                         */
/* http://www.apache.org/licenses/LICENSE-2.0                                              */
/*                                                                                         */
/* Unless required by applicable law or agreed to in writing, software                     */
/* distributed under the License is distributed on an "AS IS" BASIS,                       */
/* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.                */
/* See the License for the specific language governing permissions and                     */
/* limitations under the License.                                                          */
/*-----------------------------------------------------------------------------------------*/
/* Program      : get_session_paths.sas                                                    */
/* Description  : Instantiates macro variables to capture the current SAS program path,    */
/* workspace location, and client application instance.                                    */
/* Usage        : %include "get_session_paths.sas";                                        */
/*                                                                                         */
/* Copyright    2025, SAS Institute Inc., Cary, NC, USA.  All Rights Reserved.             */
/* SPDX-License-Identifier: Apache-2.0                                                     */
/*-----------------------------------------------------------------------------------------*/

%let _sasws_ = /clinical/workspaces;

%if %length(%bquote(&_sasprogramfile)) > 0 %then %do;
    /* Clean the file path by removing the workspace prefix */
    %let _sasfilepath_ = %sysfunc(transtrn(%bquote(&_sasprogramfile), %bquote(&_sasws_),));
    
    /* Identify the directory by finding the last forward slash */
    %let _sasfilelocation = %substr(%bquote(&_sasfilepath_), 1, %sysfunc(find(%bquote(&_sasfilepath_), /, -%length(%bquote(&_sasfilepath_))))-1);
%end;
%else %do;
    %let _sasfilepath_ = %nrquote(%nrstr());
    %let _sasfilelocation = %nrquote(%nrstr());
%end;

/* Capture the application context (e.g., SASStudio, Viya) */
%let _sasinstance_ = %bquote(&_clientapp);
