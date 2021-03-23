Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66EB3461CE
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Mar 2021 15:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhCWOsY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Mar 2021 10:48:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3316 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232330AbhCWOsB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Mar 2021 10:48:01 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NEX47B171508;
        Tue, 23 Mar 2021 10:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=NnXAMaZivCEU2YhepXfaUriWVaKzCU08wVSdcBmDLsw=;
 b=M1SGJd1u/vafmKhjjTilyDlb8NX4sKYWN8Lq0+z3xMsXYOMnkvL5Qq12vtODsRDcadBY
 P9CbToDSFikZv5trIjR7EEcRNjGM4lG90PCmJL+BCZtNB5kr+zmzjG0Vyon8vsjn1Tgf
 jSP1o9WRjo2yspTerEo8VfhrAze+kWbU7M/oD6Hg+zUiwOj2GnU2SP+eXmvqnM12ISCf
 9ZLwmI+VMZqXuALcKlZsdaP6e5A02tgiRS7suCSGTHiCcVNUrvf+zSYPUdFeiWuI8+EQ
 ZVEyvev0bl2D9J0Nz/kScG3VRlKcOoVXUGJTem2xT9/1q9pvD5Gkd5ECxIVczUeoQEZz yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37ef54xjc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 10:47:53 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12NEYObs178755;
        Tue, 23 Mar 2021 10:47:53 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37ef54xjb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 10:47:52 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NEiAZF011254;
        Tue, 23 Mar 2021 14:47:51 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 37d9by9t2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 14:47:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NElmkV55771526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 14:47:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9E19AE04D;
        Tue, 23 Mar 2021 14:47:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF310AE045;
        Tue, 23 Mar 2021 14:47:46 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.41.170])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Mar 2021 14:47:46 +0000 (GMT)
Message-ID: <3ed2004413e0ac07c7bd6f10294d6b6fac6fdbf3.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 2/2] integrity: double check iint_cache was
 initialized
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Date:   Tue, 23 Mar 2021 10:47:45 -0400
In-Reply-To: <8a8763a7-eeeb-3578-d50c-c15919fbe1f9@i-love.sakura.ne.jp>
References: <20210319200358.22816-1-zohar@linux.ibm.com>
         <20210319200358.22816-2-zohar@linux.ibm.com>
         <8450c80a-104a-3f36-0963-0ae8fa69e0f2@i-love.sakura.ne.jp>
         <CACT4Y+bvakfNhVs29QvbY6Z8Pw0zmAUKGWM-DD5DcPZW5ny90A@mail.gmail.com>
         <1a2245c6-3cab-7085-83d3-55b083619303@i-love.sakura.ne.jp>
         <8039976be3df9bd07374fe4f1931b8ce28b89dab.camel@linux.ibm.com>
         <cde00350-2a18-1759-d53b-2e7489b6cc0e@i-love.sakura.ne.jp>
         <8a8763a7-eeeb-3578-d50c-c15919fbe1f9@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_06:2021-03-22,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230107
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-03-23 at 23:01 +0900, Tetsuo Handa wrote:
> On 2021/03/23 22:37, Tetsuo Handa wrote:
> > On 2021/03/23 21:09, Mimi Zohar wrote:
> >> Please take a look at the newer version of this patch.   Do you want to
> >> add any tags?
> > 
> > Oh, I didn't know that you already posted the newer version.
> > 
> >> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> >> index 1d20003243c3..0ba01847e836 100644
> >> --- a/security/integrity/iint.c
> >> +++ b/security/integrity/iint.c
> >> @@ -98,6 +98,14 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
> >>  	struct rb_node *node, *parent = NULL;
> >>  	struct integrity_iint_cache *iint, *test_iint;
> >>  
> >> +	/*
> >> +	 * The integrity's "iint_cache" is initialized at security_init(),
> >> +	 * unless it is not included in the ordered list of LSMs enabled
> >> +	 * on the boot command line.
> >> +	 */
> >> +	if (!iint_cache)
> >> +		panic("%s: lsm=integrity required.\n", __func__);
> >> +
> > 
> > This looks strange. If "lsm=" parameter must include "integrity",
> > it implies that nobody is allowed to disable "integrity" at boot.

Integrity isn't always required.  Only when something tries to use it,
does it need to be enabled.  Since both integrity and the integrity
caller are runtime dependent, it is up to the user/admin to specify
"integrity" as an "lsm=" option.

> > Then, why not unconditionally call integrity_iintcache_init() by
> > not counting on DEFINE_LSM(integrity) declaration?

Initially I also questioned making "integrity" an LSM.  Perhaps it's
time to reconsider.   For now, it makes sense to just fix the NULL
pointer dereferencing.

Mimi

