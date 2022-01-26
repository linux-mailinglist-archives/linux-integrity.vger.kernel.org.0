Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E61749CC68
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 15:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242132AbiAZOfL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 09:35:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235539AbiAZOfK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 09:35:10 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QE60PS015989;
        Wed, 26 Jan 2022 14:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+GObsJxIW/3TliXx0z3KPe4N/3vn48rMKUn+yBtYzE8=;
 b=Pm9QBvpnxwowgyL8B2KVq/pkxNIM1T0IAEt++lm1U7PzZWczHHqdAWxhRQUORs/k7c0F
 SWV0aZBnU6CuIRdJjg5hUejAb+Vna117n2G155jdY/+8lgx+VgMSuvWf58lcz+gHPBVz
 f3rcP6zdlkJQ4wmwSDAoRnNCQgOkSAz4i0F3AEg5v54azb5HAAZs78jqsQHHL/zJIwi9
 XqhbNZs/j5VC1OJ10+QqgrEe13IpzoWbHtKAnfzg4R4rJPfiRYQVwADQIAKd/B8p8ADb
 1p+pNOvUbNncSyH+l/CVfeRQ0P9Zmz5NasL4Ylw5Zy0cK616h23/xyRccEkesYhTYypi vw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3du6hf295g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 14:35:03 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20QEVwaG029857;
        Wed, 26 Jan 2022 14:35:01 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3dr9j9esyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 14:35:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20QEYxqA41615680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 14:34:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D1B211C04A;
        Wed, 26 Jan 2022 14:34:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2246111C05B;
        Wed, 26 Jan 2022 14:34:58 +0000 (GMT)
Received: from sig-9-65-92-33.ibm.com (unknown [9.65.92.33])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jan 2022 14:34:58 +0000 (GMT)
Message-ID: <6f0890f135b61c41d81b03bf084ebab1b3e551e1.camel@linux.ibm.com>
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
Date:   Wed, 26 Jan 2022 09:34:57 -0500
In-Reply-To: <173fffb6cde54ae4ac7676d18a84c79f@huawei.com>
References: <20220125090237.120357-1-guozihua@huawei.com>
         <36b6058f2cdf6bead917c06ecc6e8769bb88130c.camel@linux.ibm.com>
         <3933adf5-4e9d-6b22-2e46-55643c504f52@huawei.com>
         <71508a72b042da330d07a624cf499561c46195f0.camel@linux.ibm.com>
         <97142483-d7e7-e310-0cb0-30a81414cb57@huawei.com>
         <c1bfe53abaf24feacb676ce940edcb8899924ffc.camel@linux.ibm.com>
         <173fffb6cde54ae4ac7676d18a84c79f@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Cx__iswed3ggtw-NR834h7GMmk2w5f-M
X-Proofpoint-GUID: Cx__iswed3ggtw-NR834h7GMmk2w5f-M
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_04,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260089
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-01-26 at 13:24 +0000, Roberto Sassu wrote:
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
> > 
> > Roberto, what do you think?
> 
> Hi Mimi
> 
> I think we wanted to prevent to set a digest algorithm
> incompatible with the chosen template.
> 
> If we have in the kernel command line:
> 
> ima_template=ima ima_hash=sha256
> 
> ima_hash_algo would be set to HASH_ALGO_SHA1 despite
> the user choice and the template would be set to 'ima'.
> 
> In the opposite case:	
> 
> ima_hash=sha256 ima_template=ima
> 
> if the default template is 'ima', then ima_hash_algo would be
> set to HASH_ALGO_SHA1. Otherwise, it would be
> HASH_ALGO_SHA256. If we allow the template to be set after
> the digest algorithm is evaluated, the template selection will
> be rejected if the algorithm is incompatible with the template.

The only time that would occur is in the unlikely case that the
template is being set to "ima".   That sounds reasonable.  In fact we
should consider preventing the template format being set to "ima".

> 
> I'm trying to remember why we still have the digest recalculation
> in ima_eventdigest_init(). Maybe the only possibility is if we
> set the template from the policy?

The recalculation was relatively recently added in commit 6cc7c266e5b4
("ima: Call ima_calc_boot_aggregate() in ima_eventdigest_init()").

thanks,

Mimi

