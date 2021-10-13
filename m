Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7606B42C36B
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Oct 2021 16:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbhJMOhV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Oct 2021 10:37:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234988AbhJMOhS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Oct 2021 10:37:18 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DCFwQg024558;
        Wed, 13 Oct 2021 10:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=QGlHDHPVRiAwMf25YnI3tDKg0d58JIxd71RdPlTkpvc=;
 b=HmJYM+cPlGWI+72Y86hNlUhoBhEQCw7jeh55kdHsS7Tq4gmnmhOrAsa+KAeOb66gP1ok
 O6+aVjH302Vck6Eb4L9kx5ikAhPWdkyXi991ub5buHTk0P3zJY3pT2nhZZ3c9CuXIANA
 MrbQvPuYXtcyrIT6Dw2sT7A4Q67ZJ5B3xX5WW7uJvHpGvhy8BUGdOgT1KBuHuhNcJRq5
 mG7HGlAmoocdLbJWYlvE10/ZqmCQhY6nAm2qezDSRmvHS1EDWNQ46NxUi4J0Ks4yxQdJ
 hvNWSwae5l+Jeys9+N5hs5xJtzAo48A2GAc/rElm2HkfTdGTOXAwgH4VOyCOYvhrJKQQ kw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnpw7660u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 10:35:11 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19DETd57000629;
        Wed, 13 Oct 2021 14:35:08 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3bk2qa1cjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 14:35:08 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19DEYuxZ64553380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 14:34:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3161AE061;
        Wed, 13 Oct 2021 14:34:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45ACDAE045;
        Wed, 13 Oct 2021 14:34:52 +0000 (GMT)
Received: from sig-9-65-208-89.ibm.com (unknown [9.65.208.89])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Oct 2021 14:34:51 +0000 (GMT)
Message-ID: <922a8f6f8cc85b04be574c4dcb5430559af67618.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] ima: define ima_trusted_for hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 13 Oct 2021 10:34:49 -0400
In-Reply-To: <20211013110113.13239-1-zohar@linux.ibm.com>
References: <20211013110113.13239-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XjItlPWt1DCCexpaDCejeb0Bf7mXrTnD
X-Proofpoint-GUID: XjItlPWt1DCCexpaDCejeb0Bf7mXrTnD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_05,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=631 clxscore=1015 phishscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130098
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-10-13 at 07:01 -0400, Mimi Zohar wrote:
> A major interpreter integrity gap exists which allows files read by
> the interpreter to be executed without measuring the file or verifying
> the file's signature.
> 
> The kernel has no knowledge about the file being read by the interpreter.
> Only the interpreter knows the context(eg. data, execute) and must be
> trusted to provide that information accurately.
> 
> To close this integrity gap, define an ima_trusted_for hook to allow
> IMA to measure the file and verify the file's signature based on policy.
> 
> Sample policy rules:
> 	measure func=TRUSTED_FOR_CHECK
> 	appraise func=TRUSTED_FOR_CHECK

To require file signatures, the policy rule should be:
	appraise func=TRUSTED_FOR_CHECK appraise_type=imasig
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

