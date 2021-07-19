Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123C73CEFFD
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 01:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343613AbhGSWyE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jul 2021 18:54:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1388327AbhGSUuo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jul 2021 16:50:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JL6rd4117934;
        Mon, 19 Jul 2021 17:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Hm3HtHAIClYPJMaHNz5oPOdctUrqaMn0N7JNV1T/h1Q=;
 b=i0zgQV88xet/bnk3XV9SzS69m6R06eGH6osyyO5jJ6DjyQpHGWI7nU/Rt6BJBS/um2I1
 5a8QMNQ4H3uiaA4b17lOs2no8dE858gQg9vLW2pxobSaJWAj13+KzVWLp/3fTgbaRPqK
 VlwpXO8vYcD+/W3qPfUS9vtPTVeO8BAkyHgox/ImqyXQAsyqYJKVnoEAxhkmBaUR/e0e
 9gLUeV8gPIY1i5QbftbveTCkGX942TJNniKuNX0n2LA6bsAwhf6WlNOEeYjskC4VW9pU
 5J17O6QOgt0Y54PIuEB/Twr6Z6EigyCayF2+LPHV12XtE0J8l51Dy86q+oUb+VjmcRQX dA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39wdmfy6e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 17:30:42 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16JLQ5ES020509;
        Mon, 19 Jul 2021 21:30:40 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 39upu88wjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 21:30:40 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16JLUbL634668862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 21:30:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E702A406A;
        Mon, 19 Jul 2021 21:30:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB873A405F;
        Mon, 19 Jul 2021 21:30:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.28.163])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jul 2021 21:30:35 +0000 (GMT)
Message-ID: <2f26bc3df4851b3af93d51742de99b1c4f197e68.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Support euid keyword for buffer measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     "tusharsu@linux.microsoft.com" <tusharsu@linux.microsoft.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 19 Jul 2021 17:30:34 -0400
In-Reply-To: <35a1ef50bf534933a10fd350aee9baa2@huawei.com>
References: <20210705115650.3373599-1-roberto.sassu@huawei.com>
         <2996f5ae-d76f-5fc9-bf90-857d4fc6644a@linux.microsoft.com>
         <35a1ef50bf534933a10fd350aee9baa2@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: amYMOTA2NWrharWdEvohgCd7O69A3qqy
X-Proofpoint-ORIG-GUID: amYMOTA2NWrharWdEvohgCd7O69A3qqy
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_11:2021-07-19,2021-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190119
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Wed, 2021-07-07 at 07:15 +0000, Roberto Sassu wrote:
> > From: Lakshmi Ramasubramanian [mailto:nramas@linux.microsoft.com]
> > Sent: Tuesday, July 6, 2021 9:30 PM
> > On 7/5/2021 4:56 AM, Roberto Sassu wrote:
> > 
> > Hi Roberto,
> > 
> > > This patch makes the 'euid' keyword available for buffer measurement rules,
> > > in the same way as for other rules. Currently, there is only support for
> > > the 'uid' keyword.
> > >
> > > With this change, buffer measurement (or non-measurement) can depend
> > also
> > > on the process effective UID.
> > 
> > Who (kernel component) will be using this?
> 
> Hi Lakshmi
> 
> I'm using it in a (not yet submitted) test for digest lists.
> 
> It is in a dont_measure rule to try to unload a digest list
> without measurement and to check that this is not allowed
> if the digest list was measured at addition time (to ensure
> completeness of information).
> 
> > Maybe you could make this change as part of the patch set in which the
> > above "euid" support will be used.
> 
> I wanted to send the digest lists patch set without anything
> else. I could resend the patch as part of that patch set if it is
> preferred.

Unless there is another usecase, please keep it with the digest list
tests patch set.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

thanks,

Mimi

