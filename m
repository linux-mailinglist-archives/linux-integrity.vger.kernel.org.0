Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEE335FCC1
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Apr 2021 22:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbhDNUhP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Apr 2021 16:37:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230227AbhDNUhO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Apr 2021 16:37:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13EKYK9g131730;
        Wed, 14 Apr 2021 16:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ARbKLx+gw+zYLy3uv4qTKRbj1aWZF9iPP+WPYGL1nN0=;
 b=odT5b1irdXtgjO7fJiLtgTfqTT77UVjY6S8hAtyNL42jAw8bXvHvKCB2/Uei43vZcdUb
 vB39PPcxJklDsDtKAPuvchfBCJkYrx/0zyK47bTFQOXudOjBuccajGQIuCQ23QNHi13F
 P/+glchAglEjfDnWP+meLZpGKPU2ORItmCzH+qSjRPxlmgeL0c2DrBPqho/xGRPmnolN
 mElLOB9l5/WBNxUjl+OzY+qRmmb0D7lIGxHOfDu+pLg/cUITjYpIDtbxW9a9nyTDq2+C
 L4INBsmjeofXTYo2nmXRt87sbQMmkvLDLl3C/6nHpfgKtYda7Ft/7+rjXUnM0KDAArNw JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37x0fevwaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 16:36:50 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13EKYrkc133164;
        Wed, 14 Apr 2021 16:36:50 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37x0fevwag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 16:36:50 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13EKYnaR023745;
        Wed, 14 Apr 2021 20:36:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 37u3n89vh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 20:36:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13EKaNrQ35914158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 20:36:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85C0D11C04C;
        Wed, 14 Apr 2021 20:36:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4035E11C058;
        Wed, 14 Apr 2021 20:36:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.89.102])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Apr 2021 20:36:44 +0000 (GMT)
Message-ID: <edf192973e1edb2a662991bfa7a1cf4bad397b94.camel@linux.ibm.com>
Subject: Re: null-ptr-deref in integrity_inode_free()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Date:   Wed, 14 Apr 2021 16:36:43 -0400
In-Reply-To: <CAHrFyr67SkruTdYnRYy+OkrEh6wqz1A=DGHZLKE2b0s-_=Cb8g@mail.gmail.com>
References: <20210414115055.mayc4aeonsklgwks@wittgenstein>
         <630cc0a27a0db8fd790a767300ae0a7f2540bdc2.camel@linux.ibm.com>
         <20210414181940.fp66fiwkcfoogu44@wittgenstein>
         <c4fa972d0aa32febee712cd70723a5da12a06ee2.camel@linux.ibm.com>
         <CAHrFyr67SkruTdYnRYy+OkrEh6wqz1A=DGHZLKE2b0s-_=Cb8g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _4-af8hbYBM2lPHCGiaz-MMQnjemtede
X-Proofpoint-ORIG-GUID: GCnpcl0naFKZJ_xjRWHL-LkAGcZFDyO1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_12:2021-04-14,2021-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140132
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-04-14 at 22:32 +0200, Christian Brauner wrote:

> On Wed, Apr 14, 2021, 22:21 Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Wed, 2021-04-14 at 20:19 +0200, Christian Brauner wrote:
> > > On Wed, Apr 14, 2021 at 01:46:46PM -0400, Mimi Zohar wrote:
> > > > Hi Christian,
> > > > 
> > > > On Wed, 2021-04-14 at 13:50 +0200, Christian Brauner wrote:
> > > > > Hey,
> > > > > 
> > > > > [Resending since the previous mail somehow hasn't made it onto the list.]
> > > > > 
> > > > > While working on a patch to port ecryptfs to use clone_private_mount() I
> > > > > hit the splat in [1] with v5.12-rc6 (Without any of my changes.). To
> > > > > reproduce this you can use the config in [5]. Then run the scripts [2]
> > > > > and [3] in two terminals. The kernel command line was [4]:
> > > > > 
> > > > > while true; do ./test.sh; done
> > > > > while true; do ./test2.sh; done
> > > > > 
> > > > > and wait for [1] to appear.
> > > > > 
> > > > > The two test scripts aren't specifically designed to trigger this issue.
> > > > > They were stress tests for my ecryptfs clone_private_mount() port. They
> > > > > just allow to trigger this issue.
> > > > > 
> > > > > From a very uninformed position it seemed that:
> > > > > 
> > > > > void integrity_inode_free(struct inode *inode)
> > > > > {
> > > > >         struct integrity_iint_cache *iint;
> > > > > 
> > > > >         if (!IS_IMA(inode))
> > > > >                 return;
> > > > 
> > > > Thank you for all the details.
> > > > 
> > > > A builtin IMA policy wasn't specified on the boot command line.  Unless
> > > > a custom IMA policy is loaded, it shouldn't get beyond this
> > > > point.   Before looking any farther, I would appreciate your confirming
> > > > that you've loaded a custom IMA policy.  To see if a policy has been
> > > > loaded, cat /sys/kernel/security/ima/policy.
> > > 
> > > Ah, interesting thank you. Here's the output:
> > > 
> > > sudo cat /sys/kernel/security/ima/policy
> > >   dont_measure fsmagic=0x9fa0
> > >   dont_measure fsmagic=0x62656572
> > >   dont_measure fsmagic=0x64626720
> > >   dont_measure fsmagic=0x1021994
> > >   dont_measure fsmagic=0x1cd1
> > >   dont_measure fsmagic=0x42494e4d
> > >   dont_measure fsmagic=0x73636673
> > >   dont_measure fsmagic=0xf97cff8c
> > >   dont_measure fsmagic=0x43415d53
> > >   dont_measure fsmagic=0x27e0eb
> > >   dont_measure fsmagic=0x63677270
> > >   dont_measure fsmagic=0x6e736673
> > >   dont_measure fsmagic=0xde5e81e4
> > >   measure func=MMAP_CHECK mask=MAY_EXEC
> > >   measure func=BPRM_CHECK mask=MAY_EXEC
> > >   measure func=FILE_CHECK mask=^MAY_READ euid=0
> > >   measure func=FILE_CHECK mask=^MAY_READ uid=0
> > >   measure func=MODULE_CHECK
> > >   measure func=FIRMWARE_CHECK
> > >   measure func=POLICY_CHECK
> > > 
> > > Hm, note that ecryptfs is not in this list so I guess ecryptfs would be
> > > measured?
> > 
> > That's the "tcb" policy, which can be specified as "policy=tcb" on the
> > boot command line.  The builtin policy rules are generic and would
> > normally be replaced with more specific policy rules based on LSM
> > labels.
> 
> Ah, thank you.
> 
> > Right, ecryptfs files are being measured.
> > 
> > There's somehow a race freeing the inode.  The fix is straight forward.
> > Did you want to fix it or should I?
> 
> Please do fix it. I've reach eod over here. :)
> You're simply going to handle the NULL case when freeing the iint?

Yes, but it would be nice to understand the race and whether this is
something or has been there from the beginning.

Mimi

