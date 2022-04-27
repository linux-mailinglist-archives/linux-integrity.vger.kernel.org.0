Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B836D512474
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Apr 2022 23:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiD0VYq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Apr 2022 17:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiD0VYg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Apr 2022 17:24:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADDD6E8D0;
        Wed, 27 Apr 2022 14:21:19 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RLDsI8020643;
        Wed, 27 Apr 2022 21:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Kb8QQD4rsJqSzMlQCv657F8recoXzj3ZXDDxMpxp/YM=;
 b=Q+Sj4OEBwpXuMkY2uEpbT75VqT+DgdHbNRkv6aH9I2Juqri5itqYoRgz6TOWB7WhhPwy
 w6QZneXyMoODgc+eC9YJuGO+zhuFK2ozxZ52STmYfIUkOeAK1tt3GwnU1TODigEhmgOm
 Lqf94u9V4EKf2RSnA9qvEh6XQXPUg/0h2Gk9C8pG6ou6RgIWDO2oEfiGKNtEsl51NFkA
 k6jqDz9Z3xHBI02zSHyDXN7hotI0NoITZ5YdCwxcc20acKvuWPKcmkX6qW6xdwRbVTrk
 PsE2UoiuGoRMm8QuSzIyH9zHtQWrZFU4KeN/YcoeG2RHn/Q9KcGudhs1eLv+7YARhfZQ Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqdjf039j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 21:21:07 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23RLDsCI020638;
        Wed, 27 Apr 2022 21:21:06 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqdjf0390-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 21:21:06 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23RL3bCk017390;
        Wed, 27 Apr 2022 21:21:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3fm8qhn56j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 21:21:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23RLL2cj49349036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 21:21:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1011FA405B;
        Wed, 27 Apr 2022 21:21:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16A88A4054;
        Wed, 27 Apr 2022 21:21:01 +0000 (GMT)
Received: from sig-9-65-70-226.ibm.com (unknown [9.65.70.226])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Apr 2022 21:21:00 +0000 (GMT)
Message-ID: <9a9a6cb0b3f2e643a17743250f4a137baaea7a7e.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: Allow ima_appraise bootparam to be set when
 SB is enabled
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Apr 2022 17:21:00 -0400
In-Reply-To: <48467663-5CD6-49C5-B43F-9FA0887D0575@oracle.com>
References: <20220425222120.1998888-1-eric.snowberg@oracle.com>
         <d7ba004bd2ce2a8ce2ff0601b4bca921a5301ece.camel@linux.ibm.com>
         <48467663-5CD6-49C5-B43F-9FA0887D0575@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wVpVvyL4cW6tz6CMaPfFc-lRyfkYKU_E
X-Proofpoint-ORIG-GUID: N87tiXpPTrCWlLzWfsOUB04elZ7Ur81-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-04-27 at 16:12 +0000, Eric Snowberg wrote:
> 
> > On Apr 26, 2022, at 12:18 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Mon, 2022-04-25 at 18:21 -0400, Eric Snowberg wrote:
> >> The IMA_APPRAISE_BOOTPARM config allows enabling different "ima_appraise="
> >> modes (log, fix, enforce) to be configured at boot time.  When booting
> >> with Secure Boot enabled, all modes are ignored except enforce.  To use
> >> log or fix, Secure Boot must be disabled.
> >> 
> >> With a policy such as:
> >> 
> >> appraise func=BPRM_CHECK appraise_type=imasig
> >> 
> >> A user may just want to audit signature validation. Not all users
> >> are interested in full enforcement and find the audit log appropriate
> >> for their use case.
> >> 
> >> Add a new IMA_APPRAISE_SB_BOOTPARAM config allowing "ima_appraise="
> >> to work when Secure Boot is enabled.
> >> 
> >> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > 
> > Since the IMA architecture specific policy rules were first
> > upstreamed, either enabling IMA_APPRAISE_BOOTPARAM or IMA_ARCH_POLICY
> > was permitted, but not both.  
> 
> I don’t see code preventing this and just created a config with both of them
> enabled.  Is this an assumption everyone is supposed to understand?

This was very clear in the original patch upstreamed.  Refer to the
IMA_APPRAISE_BOOTPRAM in commit d958083a8f64 ("x86/ima: define
arch_get_ima_policy() for x86").  This subsequently changed to be based
on  the secureboot runtime state.  Refer to commit 311aa6aafea4 ("ima:
move APPRAISE_BOOTPARAM dependency on ARCH_POLICY to runtime").

> 
> > This Kconfig negates the assumptions on
> > which the CONFIG_IMA_ARCH_POLICY and the ima_appraise_signature() are
> > based without any indication of the ramifications.   This impacts the
> > kexec file syscall lockdown LSM assumptions as well.
> 
> I will fix this in the next round.

Either secureboot is or isn't enabled.  When it is enabled, then IMA
must be in enforcing mode.

> > A fuller, more complete explanation for needing "log" mode when secure
> > boot is enabled is required.
> 
> and add a more thorough explanation.  Thanks.

Normally "log" mode is needed during development.

thanks,

Mimi

