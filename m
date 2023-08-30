Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC2B78E1A0
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Aug 2023 23:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbjH3VwW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Aug 2023 17:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242792AbjH3VwW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Aug 2023 17:52:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C3DE54;
        Wed, 30 Aug 2023 14:51:51 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ULbkpf005435;
        Wed, 30 Aug 2023 21:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=3frPMVoA975G69l1GA3cah2M5FfV7vEttHALXEQSKE0=;
 b=NT4fOp9qQdZyLGwZ97s7jM7qGuwk1rur9lQU3L2yfjHbJJH0hsxWHdt41WqiFawMwnpv
 2FRXU47T0XU0llg7dOr6ZenoMyZ/JUFQA1hYmeF5jlq6rwkN1sLz3AHI1p9UOV28qUj3
 zjvFxS070ZxELyosqPaJv7bZVPtPex8NvbnGmjLtjV5bIclVFXqRyiFpQfS1FzDm5fO1
 tMDVmZqBir0jeIUb+ruhqLDaYdDPWGs4Oum0WY/pP2Zhd+SMLBIGDaMXUn/l7f5lzf1S
 mGO8VfVqKncRApt+Ut5vBW98DTYiOeH2q4z4IXGjCpN6L0CY75a605VaUKIPcCXrBJ9j +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3stdph09qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 21:50:17 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37ULdEqr009163;
        Wed, 30 Aug 2023 21:50:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3stdph09ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 21:50:16 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37UL1PHf009966;
        Wed, 30 Aug 2023 21:50:15 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7kq2tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 21:50:15 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37ULoEQW4784812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 21:50:14 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8E7F5805D;
        Wed, 30 Aug 2023 21:50:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2352E58054;
        Wed, 30 Aug 2023 21:50:13 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.185.26])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 30 Aug 2023 21:50:13 +0000 (GMT)
Message-ID: <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com,
        code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.mic>,
        linux-security-module@vger.kernel.org,
        AmirGoldstein <amir73il@gmail.com>
Date:   Wed, 30 Aug 2023 17:50:12 -0400
In-Reply-To: <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
         <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
         <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
         <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
         <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
         <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
         <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
         <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
         <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com>
         <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
         <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com>
         <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
         <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sKUQ6JKOOFKqA3Azkuxn9TtEcHZ1lTxs
X-Proofpoint-ORIG-GUID: oTdMYYJ15PzjcUmfx6Tichvl09FKsgMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_18,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-08-30 at 16:47 -0400, Paul Moore wrote:
> On Wed, Aug 30, 2023 at 4:25 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > Your initial question was "what happens if the file/filesystem becomes
> > inaccessible at some point and an attestation client attempts to read
> > the entire log?".  For what reason would it be inaccessible?  For the
> > original single tmpfs file, what would make it inaccessible?
> 
> In your reply that I had responded to you had mentioned that the
> kernel was simply being passed a fd and taking ownership of it, the fd
> could either be a tmpfs backed file or some form of persistent storage
> as both were discussed in this thread.  I imagine a tmpfs filesystem
> could still be forcibly unmounted, resulting in problems, but I can't
> say that for certain.  However, there are definitely cases where a fd
> backed against an arbitrary filesystem could run into problems:
> storage device issues for local filesystems, networking issues for
> network filesystems, and good old fashioned user/admin intervention in
> both cases.

"I imagine tmpfs filesystem could still be forcibly unmounted" sounds
like an attack. Not being able to verify the measurement list against a
quote is probably a good thing.

> 
> > In the
> > "snapshotting" design this problem becomes a userspace issue.
> 
> Yes, exactly.  Userspace is almost always going to have an easier time
> recovering from these types of errors ... or at least I believe so,
> perhaps you have a clever solution for how the kernel can handle the
> file/filesystem disappearing from under the fd?

Nothing changes.  New measurements are initially stored in kernel
memory, until they are successfully copied.

> > The first sentence of the cover letter is "Depending on the IMA policy,
> > the IMA log can consume a lot of Kernel memory on the device." ...
> 
> As I'm still looking for an answer to my question, let's stay focused
> on that before we start worrying too much about the phrasing of the
> design proposal that was submitted.

It's more than just phrasing, but the purpose/motivation of the
proposed changes.

--  
thanks,

Mimi

