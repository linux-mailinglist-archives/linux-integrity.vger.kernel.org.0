Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6DD5FE680
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Oct 2022 03:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJNBQw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Oct 2022 21:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJNBQv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Oct 2022 21:16:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE3D164BD5;
        Thu, 13 Oct 2022 18:16:49 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E0KFF0028757;
        Fri, 14 Oct 2022 01:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Djt0j2YY8eLspCwplixscJuyUe4sdhNs1Xue9zl8EPE=;
 b=UbMl+5169njfxT+8aLwm//M4yo8ifGBrfRNq9tYCGXkUdLRn74v44PIsQeHG1um5S2gW
 cNG422qhiV4K0qNDtxvxYvB6MqDmSaTkcE5b6oYudHpqnvUHA6aVNVcCzFAsvpnDxpT5
 98qKbpqxZluC+Du9f/vzmCY168ZEnfwecFDaCLBV8ylowWTgGuc4lkoAGsL5/8451MGJ
 SMjR2I6uVtJ8eU8jQp7u4L7PCuJGmbdDQCpgwri3K4bxbZxo+HFwv2NVBagUJvBeAfFZ
 iFcGMMs11s0D7U6kAQgB3wqwu+rm+I9LFF3z1oN9sV/XKlOtjd3YRCU69I/45EHIJX7c oA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k6gw1fqdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 01:16:35 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29E15udY001139;
        Fri, 14 Oct 2022 01:16:34 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 3k30ub366q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 01:16:34 +0000
Received: from smtpav03.wdc07v.mail.ibm.com ([9.208.128.112])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29E1GXlC18088482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 01:16:34 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 461FF5805A;
        Fri, 14 Oct 2022 01:16:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38A895805D;
        Fri, 14 Oct 2022 01:16:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.3.142])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Oct 2022 01:16:32 +0000 (GMT)
Message-ID: <d5081ccecf3ffd5562d9a66a5663b236870605ce.camel@linux.ibm.com>
Subject: Re: [PATCH 0/9] integrity: Move hooks into LSM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>
Cc:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Thu, 13 Oct 2022 21:16:31 -0400
In-Reply-To: <CAHC9VhR1kGT0+zM3smAQMEzGQLmVNhHu40f=YK3qavuYvcQYQQ@mail.gmail.com>
References: <20221013222702.never.990-kees@kernel.org>
         <CAHC9VhR1kGT0+zM3smAQMEzGQLmVNhHu40f=YK3qavuYvcQYQQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P7chmgREeO9Uz69kIbAfjMH3LwnZ-m54
X-Proofpoint-GUID: P7chmgREeO9Uz69kIbAfjMH3LwnZ-m54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_10,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=971 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210140004
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-10-13 at 18:47 -0400, Paul Moore wrote:
> On Thu, Oct 13, 2022 at 6:36 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Hi,
> >
> > It's been over 4 years since LSM stack was introduced. The integrity
> > subsystem is long overdue for moving to this infrastructure. Here's my
> > first pass at converting integrity and ima (and some of evm) into LSM
> > hooks. This should be enough of an example to finish evm, and introduce
> > the missing hooks for both. For example, after this, it looks like ima
> > only has a couple places it's still doing things outside of the LSM. At
> > least these stood out:
> >
> > fs/namei.c:     ima_post_create_tmpfile(mnt_userns, inode);
> > fs/namei.c:                             ima_post_path_mknod(mnt_userns, dentry);
> >
> > Mimi, can you please take this series and finish the conversion for
> > what's missing in ima and evm?
> >
> > I would also call attention to "175 insertions(+), 240 deletions(-)" --
> > as expected, this is a net reduction in code.
> >
> > Thanks!
> 
> Without looking at any of the code, I just want to say this 100% gets
> my vote; this is something we need to make happen at some point.
> 
> Thanks Kees!

Sorry I'm on vacation this week and the beginning of next week, but
will look at it when I get back.

Mimi

