Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955533EB5C1
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 14:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbhHMMt4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Aug 2021 08:49:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233416AbhHMMty (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Aug 2021 08:49:54 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17DCYCKF012761;
        Fri, 13 Aug 2021 08:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=X5EXgJBe9+qe/QnI6njLMHkTVJ+e7ODl3/1nShklDsE=;
 b=gtkU4cTpiOJaC6SpkyUzcLOf4s7UQn3QNR5oAYyyFGtguBk/DvW9Q/oixHP+5yQTtLVX
 wWMRT73Atukq+hhyVHJT1dM/GD549+KO8e9rtdAA5v9DuGXST5AUaFdt0Z4YJpik4c3v
 vH4i5d+MhhHNZTtvwG/8nXa/Ft7CJ7/n5iO7YZ3CLIEAjjnk1+bdizN+sprdlyWKeDn9
 waXrNnQH9o2Z2zq4e0cbpDBmV3xXnKAKkAkHcgqR+1btWLW114YETiNTAEIekraM9eKu
 l/i5q9x08D2GDvLWtY6TVBiA3IrfWgcgBQZIXL7JjERQdwBUQV7OX/2jP7wVSrhf6PgM 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ad1ky631y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 08:49:26 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17DCYDMt012849;
        Fri, 13 Aug 2021 08:49:26 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ad1ky631d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 08:49:26 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17DClmZG021478;
        Fri, 13 Aug 2021 12:49:23 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ad4kqhmd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 12:49:23 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17DCnL8g55706040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 12:49:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D065AE051;
        Fri, 13 Aug 2021 12:49:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFB2CAE04D;
        Fri, 13 Aug 2021 12:49:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.21.129])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 Aug 2021 12:49:19 +0000 (GMT)
Message-ID: <2ad7cb6361efafabc803555135fe299017eba07a.camel@linux.ibm.com>
Subject: Re: [PATCH v7 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date:   Fri, 13 Aug 2021 08:49:18 -0400
In-Reply-To: <b7cd3e6d-a23d-177b-5a6b-fb81d9bca4aa@viveris.fr>
References: <20210811114037.201887-1-simon.thoby@viveris.fr>
         <20210811114037.201887-5-simon.thoby@viveris.fr>
         <84b3a572eb5fc1ec81291656c9f9af00568bff9f.camel@linux.ibm.com>
         <023a0ec1-aed7-9862-e0c9-a825d46ade0f@viveris.fr>
         <c705ef557f40289d58ab7cbab8c2c0e7b888671e.camel@linux.ibm.com>
         <aef8a1e8cee322409ef3dc6723c7e77bc16f6b2f.camel@linux.ibm.com>
         <b7cd3e6d-a23d-177b-5a6b-fb81d9bca4aa@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1JCoph6Zl-o_eK1bDcVbq5x-iXolkHwg
X-Proofpoint-ORIG-GUID: lBN6iQrZX7fynXri3vuCdUYm0u6wPnm3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-13_04:2021-08-12,2021-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130076
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-08-13 at 07:17 +0000, THOBY Simon wrote:
> On 8/12/21 8:31 PM, Mimi Zohar wrote:
> > Before posting the patch, please fix your user name and email address
> > in the git configuration.  scripts/checkpatch.pl is complaining:
> > 
> > ERROR: Missing Signed-off-by: line by nominal patch author 'THOBY Simon
> > <Simon.THOBY@viveris.fr>'
> 
> > 
> > total: 1 errors, 0 warnings, 218 lines checked
> 
> I guess Microsoft Exchange strikes again :/
> On my end, the patches have the correct 'From: Simon Thoby <simon.thoby@viveris.fr>'
> header, but it seems Outlook likes to rewrite headers to match my Microsoft work account
> information. I will update my git config, as I can't edit the name and email of the corporate
> account.
> Sorry about that.

If commit 48ca2d8ac8a1 ("checkpatch: add new warnings to author signoff
checks") wasn't case sensitive, it would have flagged  "<
simon.thoby@viveris.fr>" as a warning, not an error.

Mimi

