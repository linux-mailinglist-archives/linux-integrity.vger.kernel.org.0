Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AB549E227
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jan 2022 13:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbiA0MSp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jan 2022 07:18:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231872AbiA0MSo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jan 2022 07:18:44 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RCBi20016900;
        Thu, 27 Jan 2022 12:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Do8FEFGbYoo3lnA3Z1lDEMymvPkDEEQGl16XdeBo8L4=;
 b=Qh1M6oWLna47fyrcMWdG+05p3g7yPIvL9zB/KkxDTVNLVGP2oT5dyFJh+ZxlGMlMleIM
 N+BLLzeut2xm8N39KkoUnoWxdwIgdeh6yMGBY6bsClJ5HQFx36ObnEGrLcRD7wEWRPr/
 bSNbGkBzq659zL6pL7PxepNXs4FVPrEG0GC/J/DonEDuNcraGzVi/MxhSLuLJPbh7zeF
 Uw8keu0OHH6eQAq6nX80bmzflyuJEHpzc17EfUtzclZ61gAy2L4splMywm2yIOqeAOe/
 3ZR3NRK2xHt+iQ/ErLl3om1kDnE2cxvCw+R1ZBwVvwTPBjD3Ee27aTVl7lodejFuKlup Qg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duu6a040y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 12:18:38 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20RCDvDL022465;
        Thu, 27 Jan 2022 12:18:36 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3dr9j9nmeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 12:18:36 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20RCIYs147186414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 12:18:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34AF142049;
        Thu, 27 Jan 2022 12:18:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14BC742047;
        Thu, 27 Jan 2022 12:18:33 +0000 (GMT)
Received: from sig-9-65-89-165.ibm.com (unknown [9.65.89.165])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 12:18:32 +0000 (GMT)
Message-ID: <4626844528c5accb70a57870168091e002affb36.camel@linux.ibm.com>
Subject: Re: [RESEND][PATCH] Documentation: added order requirement for
 ima_hash=
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wangweiyang <wangweiyang2@huawei.com>,
        Xiujianfeng <xiujianfeng@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Thu, 27 Jan 2022 07:18:32 -0500
In-Reply-To: <df7fffa1-2068-cb0c-e43e-141ccd125b39@huawei.com>
References: <20220125090237.120357-1-guozihua@huawei.com>
         <36b6058f2cdf6bead917c06ecc6e8769bb88130c.camel@linux.ibm.com>
         <3933adf5-4e9d-6b22-2e46-55643c504f52@huawei.com>
         <71508a72b042da330d07a624cf499561c46195f0.camel@linux.ibm.com>
         <97142483-d7e7-e310-0cb0-30a81414cb57@huawei.com>
         <c1bfe53abaf24feacb676ce940edcb8899924ffc.camel@linux.ibm.com>
         <173fffb6cde54ae4ac7676d18a84c79f@huawei.com>
         <6f0890f135b61c41d81b03bf084ebab1b3e551e1.camel@linux.ibm.com>
         <220a8c9f3ab34f2183c0a88941c145d0@huawei.com>
         <df7fffa1-2068-cb0c-e43e-141ccd125b39@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5hfRO9Tb1kJG8NDYaY-EWPFVyOztTvQH
X-Proofpoint-ORIG-GUID: 5hfRO9Tb1kJG8NDYaY-EWPFVyOztTvQH
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270072
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-01-27 at 14:35 +0800, Guozihua (Scott) wrote:
> 
> On 2022/1/26 22:43, Roberto Sassu wrote:
> >> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> >> Sent: Wednesday, January 26, 2022 3:35 PM
> >> On Wed, 2022-01-26 at 13:24 +0000, Roberto Sassu wrote:
> >>>> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> >>>> Sent: Wednesday, January 26, 2022 1:48 PM
> >>>> On Wed, 2022-01-26 at 15:41 +0800, Guozihua (Scott) wrote:
> >>>>>
> >>>>>
> >>>>> The main issue lies in ima_template_desc_current called by hash_setup,
> >>>>> which does not just read ima_template global variable, but also tries to
> >>>>> set it if that hasn't been done already. Causing ima_template_setup to quit.
> >>>>
> >>>> Right, which calls ima_init_template_list().  So part of the solution
> >>>> could be to conditionally call ima_init_template_list()
> >>>> in ima_template_setup().
> >>>>
> >>>> -       if (ima_template)
> >>>> -               return 1;
> >>>> -
> >>>> -       ima_init_template_list();
> >>>> +       if (!ima_template
> >>>> +               ima_init_template_list();
> >>>>
> >>>> Roberto, what do you think?
> >>>
> >>> Hi Mimi
> >>>
> >>> I think we wanted to prevent to set a digest algorithm
> >>> incompatible with the chosen template.
> >>>
> >>> If we have in the kernel command line:
> >>>
> >>> ima_template=ima ima_hash=sha256
> >>>
> >>> ima_hash_algo would be set to HASH_ALGO_SHA1 despite
> >>> the user choice and the template would be set to 'ima'.
> >>>
> >>> In the opposite case:
> >>>
> >>> ima_hash=sha256 ima_template=ima
> >>>
> >>> if the default template is 'ima', then ima_hash_algo would be
> >>> set to HASH_ALGO_SHA1. Otherwise, it would be
> >>> HASH_ALGO_SHA256. If we allow the template to be set after
> >>> the digest algorithm is evaluated, the template selection will
> >>> be rejected if the algorithm is incompatible with the template.
> >>
> >> The only time that would occur is in the unlikely case that the
> >> template is being set to "ima".   That sounds reasonable.  In fact we
> >> should consider preventing the template format being set to "ima".
> > 
> > Ok.

< snip >

> 
> I understand that the solution proposed here is to decommission template 
> "ima" and potentially removing related algo checks altogether?

Eventually we might decide to do that, but right now we just want to
address not being able to set "ima_template" after setting "ima_hash".

thanks,

Mimi


