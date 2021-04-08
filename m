Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22084358F3D
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Apr 2021 23:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhDHVfW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Apr 2021 17:35:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232158AbhDHVfW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Apr 2021 17:35:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138LWk2v127518;
        Thu, 8 Apr 2021 17:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=NlTWlP7JzJrLFbMqZA78IcCmymtDtKnIvdZilXk8Ryc=;
 b=XnqvZB35vbJ6qe2sJEpPmBKs+1vmRy43bphUFWgbsFo1gXfu1DSCPlMZat4/1PU9IIlz
 YDSYI2oJvnf22ywilcWK4rplP1NGwy09yTKXWBsjamjEr8ZHZ/j2JVYHQ8CEFQ2Gfizw
 PM5P5362bWB4MmHkRvPw9+l5RwRx7RCvu+SQIYYKSWvJFYugAHWHdCigEWK1p7H3t4WL
 HBSuBA6EP68hxAducyyrzbY6PtJ4pEUlBbHIYIFyQ5u2e8FtW+8mAhW9WBjEka5Hr8ku
 +n4lCTlZRdY/fIXmI16imXlV+0j7jMnYuBZlyY9Q4wI8TUEeev/Qq1rHBvcBboBnam42 Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37rvy8jawm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 17:35:04 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 138LWpEP128048;
        Thu, 8 Apr 2021 17:35:03 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37rvy8jav5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 17:35:03 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 138LXUus001983;
        Thu, 8 Apr 2021 21:34:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 37rvbw9wu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 21:34:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 138LYunM43319658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 21:34:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AED2352050;
        Thu,  8 Apr 2021 21:34:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.65.12])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7F10D52052;
        Thu,  8 Apr 2021 21:34:54 +0000 (GMT)
Message-ID: <ff1e9e427e1011976fcf122fa93c2b35d314f89b.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] certs: Trigger creation of RSA module signing
 key if it's not an RSA key
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org,
        dhowells@redhat.com, jarkko@kernel.org,
        Herbert Xu <herbert@gondor.hengli.com.au>
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 17:34:53 -0400
In-Reply-To: <b04939a3-c9e5-faf2-ec7b-27127b2ab41d@linux.ibm.com>
References: <20210408152403.1189121-1-stefanb@linux.ibm.com>
         <20210408152403.1189121-2-stefanb@linux.ibm.com>
         <a5f7f2b44e7d4de94b761324139024a31a1cf209.camel@linux.ibm.com>
         <b04939a3-c9e5-faf2-ec7b-27127b2ab41d@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tKkizb_yLtcjx-4zjhtc7aA3znySB9i7
X-Proofpoint-ORIG-GUID: s9QxXQQjKkxuJJdVB2nsSqIQsbBgVqJd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_07:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080143
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-04-08 at 15:19 -0400, Stefan Berger wrote:
> On 4/8/21 1:15 PM, Mimi Zohar wrote:
> > On Thu, 2021-04-08 at 11:24 -0400, Stefan Berger wrote:
> >> Address a kbuild issue where a developer created an ECDSA key for signing
> >> kernel modules and then builds an older version of the kernel, when bi-
> >> secting the kernel for example, that does not support ECDSA keys.
> >>
> >> Trigger the creation of an RSA module signing key if it is not an RSA key.
> >>
> >> Fixes: cfc411e7fff3 ("Move certificate handling to its own directory")
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Thanks, Stefan.
> >
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> >
> 
> Via which tree will this go upstream? keyrings?

This patch set originally had a dependency on Nayna's v1 & v2 "ima:
kernel build support for loading the kernel module signing key" patch
set and on Herbert's "ecc" branch.  With v3, the dependency on Nayna's
patch set is gone.

Jarkko, David, Herbert did you want to pick up this patch set or would
you prefer that I did?  Either way is fine.

thanks,

Mimi

