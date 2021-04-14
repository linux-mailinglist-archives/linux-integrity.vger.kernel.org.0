Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57AE35FC82
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Apr 2021 22:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243291AbhDNUVl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Apr 2021 16:21:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349619AbhDNUVi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Apr 2021 16:21:38 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13EK4POx147939;
        Wed, 14 Apr 2021 16:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Kt121RAgkvKSrkqRbxcIYV4R/gzne73LdbzLOFVppWo=;
 b=XCtDseyjX7B5mql3zYBu/ybHYuz43Fa3UnOqD5iRWSK26bybUv1Xy4O9dKoSgDQczVNi
 IEJZ3Rl8KavIQuzd9+YSPYsabtDMXWQOavlRQjG97YpeBmMlUYnxbeuScDSHdfKRo7CE
 l4qPYUFQiLyNtXATSupy9U60IlozoYiDWBFlSBJIfYPiEEhPpkwRkrG1+yUrDdsKmZsF
 B02GRyrpeYVULte8J7EUH3uT1Z1W/q6UC9qnJkLtQCet1Cm9PUb7OrnAlZTJqMosb8Bn
 wvhFYqe22K6DkDDROKYe/xDJ4WQpjrEF4nNKbclyk3K1JSpDHjavUYp/QsiFgEp4vQVA DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37x4dk4fxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 16:21:13 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13EK4QXP147993;
        Wed, 14 Apr 2021 16:21:12 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37x4dk4fx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 16:21:12 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13EKCoWX014007;
        Wed, 14 Apr 2021 20:21:10 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 37u3n89vp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 20:21:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13EKL8jo13435232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 20:21:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5F864204C;
        Wed, 14 Apr 2021 20:21:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A1104203F;
        Wed, 14 Apr 2021 20:21:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.89.102])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Apr 2021 20:21:06 +0000 (GMT)
Message-ID: <c4fa972d0aa32febee712cd70723a5da12a06ee2.camel@linux.ibm.com>
Subject: Re: null-ptr-deref in integrity_inode_free()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 14 Apr 2021 16:21:05 -0400
In-Reply-To: <20210414181940.fp66fiwkcfoogu44@wittgenstein>
References: <20210414115055.mayc4aeonsklgwks@wittgenstein>
         <630cc0a27a0db8fd790a767300ae0a7f2540bdc2.camel@linux.ibm.com>
         <20210414181940.fp66fiwkcfoogu44@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ggp6MeX_vw14lgalYcwpU4hiZvw8JiZp
X-Proofpoint-ORIG-GUID: j4n3ToG7fV_yR4Ixd6fwaDzfO4RgPoab
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_12:2021-04-14,2021-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140128
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-04-14 at 20:19 +0200, Christian Brauner wrote:
> On Wed, Apr 14, 2021 at 01:46:46PM -0400, Mimi Zohar wrote:
> > Hi Christian,
> > 
> > On Wed, 2021-04-14 at 13:50 +0200, Christian Brauner wrote:
> > > Hey,
> > > 
> > > [Resending since the previous mail somehow hasn't made it onto the list.]
> > > 
> > > While working on a patch to port ecryptfs to use clone_private_mount() I
> > > hit the splat in [1] with v5.12-rc6 (Without any of my changes.). To
> > > reproduce this you can use the config in [5]. Then run the scripts [2]
> > > and [3] in two terminals. The kernel command line was [4]:
> > > 
> > > while true; do ./test.sh; done
> > > while true; do ./test2.sh; done
> > > 
> > > and wait for [1] to appear.
> > > 
> > > The two test scripts aren't specifically designed to trigger this issue.
> > > They were stress tests for my ecryptfs clone_private_mount() port. They
> > > just allow to trigger this issue.
> > > 
> > > From a very uninformed position it seemed that:
> > > 
> > > void integrity_inode_free(struct inode *inode)
> > > {
> > >         struct integrity_iint_cache *iint;
> > > 
> > >         if (!IS_IMA(inode))
> > >                 return;
> > 
> > Thank you for all the details.
> > 
> > A builtin IMA policy wasn't specified on the boot command line.  Unless
> > a custom IMA policy is loaded, it shouldn't get beyond this
> > point.   Before looking any farther, I would appreciate your confirming
> > that you've loaded a custom IMA policy.  To see if a policy has been
> > loaded, cat /sys/kernel/security/ima/policy.
> 
> Ah, interesting thank you. Here's the output:
> 
> sudo cat /sys/kernel/security/ima/policy
>   dont_measure fsmagic=0x9fa0
>   dont_measure fsmagic=0x62656572
>   dont_measure fsmagic=0x64626720
>   dont_measure fsmagic=0x1021994
>   dont_measure fsmagic=0x1cd1
>   dont_measure fsmagic=0x42494e4d
>   dont_measure fsmagic=0x73636673
>   dont_measure fsmagic=0xf97cff8c
>   dont_measure fsmagic=0x43415d53
>   dont_measure fsmagic=0x27e0eb
>   dont_measure fsmagic=0x63677270
>   dont_measure fsmagic=0x6e736673
>   dont_measure fsmagic=0xde5e81e4
>   measure func=MMAP_CHECK mask=MAY_EXEC
>   measure func=BPRM_CHECK mask=MAY_EXEC
>   measure func=FILE_CHECK mask=^MAY_READ euid=0
>   measure func=FILE_CHECK mask=^MAY_READ uid=0
>   measure func=MODULE_CHECK
>   measure func=FIRMWARE_CHECK
>   measure func=POLICY_CHECK
> 
> Hm, note that ecryptfs is not in this list so I guess ecryptfs would be
> measured?

That's the "tcb" policy, which can be specified as "policy=tcb" on the
boot command line.  The builtin policy rules are generic and would
normally be replaced with more specific policy rules based on LSM
labels.

Right, ecryptfs files are being measured.

There's somehow a race freeing the inode.  The fix is straight forward.
Did you want to fix it or should I?

thanks,

Mimi

