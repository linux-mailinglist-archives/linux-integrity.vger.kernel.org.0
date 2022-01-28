Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD5049FBD0
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jan 2022 15:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245058AbiA1OeL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Jan 2022 09:34:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40178 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349306AbiA1OeJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Jan 2022 09:34:09 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SDgegv001030;
        Fri, 28 Jan 2022 14:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Bisv7qYFSopht4bvbLB1oB0IQLppMtLv0i9x2kv2OuY=;
 b=cpku7C2CCrGJ26gpGUegJFkTs4kow5YkdqbYIQkH33Le7AJAl2i3XbRWxl2CQQKPFzGJ
 ApjtPGs78MFrrHG6KhMpCLSggZHjb8D7crrZG8A7+Ly+OpfeOONePWwzhqpo7vH40eOd
 7C9WVqeIUpmL2pFZFtgpjtfoZS8Hlck2Gk8wE7/eyuWzYYUB6AbHRlfRN+Ir6D41Gt36
 0Gg1OEMsWqJZV6PtRhgBqeDjrfDRxHEz42UmvkTOJKSxkFasru8WBToVyil2XBbKLXDK
 LzcRsErxQSlvUqIbj59VbpohG9JRW1Z4hd07N+JEyaQ2OlZGJU75/PU+fcTonazZNwIs iA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dvhm3h456-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 14:34:01 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20SERH1f012837;
        Fri, 28 Jan 2022 14:34:00 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3dr9ja7vm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 14:33:59 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20SEXvXk44695906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 14:33:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63A2FAE055;
        Fri, 28 Jan 2022 14:33:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9CBFAE059;
        Fri, 28 Jan 2022 14:33:55 +0000 (GMT)
Received: from sig-9-65-83-59.ibm.com (unknown [9.65.83.59])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jan 2022 14:33:55 +0000 (GMT)
Message-ID: <9714e2824b35d12ee2f8ad70d65d8c9230be86e4.camel@linux.ibm.com>
Subject: Re: [RESEND][PATCH] Documentation: added order requirement for
 ima_hash=
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "Guozihua (Scott)" <guozihua@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wangweiyang <wangweiyang2@huawei.com>,
        Xiujianfeng <xiujianfeng@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Fri, 28 Jan 2022 09:33:55 -0500
In-Reply-To: <ee116b29c27740119d98bc64e55f61e7@huawei.com>
References: <20220125090237.120357-1-guozihua@huawei.com>
         <36b6058f2cdf6bead917c06ecc6e8769bb88130c.camel@linux.ibm.com>
         <3933adf5-4e9d-6b22-2e46-55643c504f52@huawei.com>
         <71508a72b042da330d07a624cf499561c46195f0.camel@linux.ibm.com>
         <97142483-d7e7-e310-0cb0-30a81414cb57@huawei.com>
         <c1bfe53abaf24feacb676ce940edcb8899924ffc.camel@linux.ibm.com>
         <ee116b29c27740119d98bc64e55f61e7@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b2MYNIcrZFuMk6KSGpgcDfFno8qu1A0q
X-Proofpoint-ORIG-GUID: b2MYNIcrZFuMk6KSGpgcDfFno8qu1A0q
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_04,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280092
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-01-28 at 10:24 +0000, Roberto Sassu wrote:
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Wednesday, January 26, 2022 1:48 PM
> > On Wed, 2022-01-26 at 15:41 +0800, Guozihua (Scott) wrote:
> > >
> > >
> > > The main issue lies in ima_template_desc_current called by hash_setup,
> > > which does not just read ima_template global variable, but also tries to
> > > set it if that hasn't been done already. Causing ima_template_setup to quit.
> > 
> > Right, which calls ima_init_template_list().  So part of the solution
> > could be to conditionally call ima_init_template_list()
> > in ima_template_setup().
> > 
> > -       if (ima_template)
> > -               return 1;
> > -
> > -       ima_init_template_list();
> > +       if (!ima_template
> > +               ima_init_template_list();
> 
> 
> is it still necessary to call ima_init_template_list() in
> template_setup()? I saw it is called in init_ima().

All of these options are at __setup().

thanks,

Mimi

