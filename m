Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C06345DCB
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Mar 2021 13:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhCWMKJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Mar 2021 08:10:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231172AbhCWMJh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Mar 2021 08:09:37 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NC4F7m184741;
        Tue, 23 Mar 2021 08:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MC00Ea8uhsssTjkMY1e0u/7kEnChLL8j68aeQS3nlmY=;
 b=HuR0DI5z2i+vSf6drTTKFfhq1ANdZAooaMn63eq0AICld4pnvX+mVVDbrc84/y3w0Q3e
 yaj6wYLspDbM/FWh5BDo0KfnHXOkT+AULeO91oLP6lqm/CyeD/4P1X4PW01x5t9bYcD+
 VJkL7mw3J758gQMw7RfxdZbl+lfl5s8FUslBkN4C05yb2rds/OwrrPDRkf8SswFnFLXw
 LJFRZoVJVZKqgYW/XWIAOgHIOO09gxBff04AyHYHjN7TM2awOwVzL6YdbxbBZj60dK48
 IGIIvdhSBz8P0ln7GpgfvoeJzjM8zp6rSNMQ5Gm+QlJ1Omuh7DRRLmE48SYKi/Y2e1pU 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dwy6hc1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 08:09:30 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12NC5MBM192542;
        Tue, 23 Mar 2021 08:09:30 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dwy6hc12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 08:09:30 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NC7M24001153;
        Tue, 23 Mar 2021 12:09:27 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 37d9by9qp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 12:09:27 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NC9PsZ49021284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 12:09:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0132DA405B;
        Tue, 23 Mar 2021 12:09:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8238FA4053;
        Tue, 23 Mar 2021 12:09:22 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.41.170])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Mar 2021 12:09:22 +0000 (GMT)
Message-ID: <8039976be3df9bd07374fe4f1931b8ce28b89dab.camel@linux.ibm.com>
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
Date:   Tue, 23 Mar 2021 08:09:21 -0400
In-Reply-To: <1a2245c6-3cab-7085-83d3-55b083619303@i-love.sakura.ne.jp>
References: <20210319200358.22816-1-zohar@linux.ibm.com>
         <20210319200358.22816-2-zohar@linux.ibm.com>
         <8450c80a-104a-3f36-0963-0ae8fa69e0f2@i-love.sakura.ne.jp>
         <CACT4Y+bvakfNhVs29QvbY6Z8Pw0zmAUKGWM-DD5DcPZW5ny90A@mail.gmail.com>
         <1a2245c6-3cab-7085-83d3-55b083619303@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_06:2021-03-22,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 clxscore=1011 phishscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103230087
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-03-23 at 10:46 +0900, Tetsuo Handa wrote:
> On 2021/03/20 5:03, Mimi Zohar wrote:
> > The integrity's "iint_cache" is initialized at security_init().  Only
> > after an IMA policy is loaded, which is initialized at late_initcall,
> > is a file's integrity status stored in the "iint_cache".
> > 
> > All integrity_inode_get() callers first verify that the IMA policy has
> > been loaded, before calling it.  Yet for some reason, it is still being
> > called, causing a NULL pointer dereference.
> > 
> > qemu-system-x86_64 (...snipped...) lsm=smack (...snipped...)
> 
> Hmm, why are you using lsm=smack instead of security=smack ?
> Since use of lsm= overrides CONFIG_LSM="lockdown,yama,safesetid,integrity,tomoyo,smack,bpf" settings,
> only smack is activated, which means that integrity_iintcache_init() will not be called by
> 
>   DEFINE_LSM(integrity) = {
>   	.name = "integrity",
>   	.init = integrity_iintcache_init,
>   };
> 
> declaration. That's the reason iint_cache == NULL when integrity_inode_get() is called.

That's exactly the problem, but since we don't control how the system
is configured or which parameters are supplied on the boot command
line, the kernel needs to at least provide some explanation instead of
dereferencing a NULL pointer.

FYI, "security=" is being deprecated.   From Documentation/admin-
guide/kernel-parameters.txt:

       security=  [SECURITY] Choose a legacy "major" security module to
                        enable at boot. This has been deprecated by the
                        "lsm=" parameter.

Please take a look at the newer version of this patch.   Do you want to
add any tags?

thanks,

Mimi

