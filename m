Return-Path: <linux-integrity+bounces-2349-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A7B8BFBC8
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2024 13:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68ED1C21755
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2024 11:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BE081AD0;
	Wed,  8 May 2024 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="khOCi8hA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A7082891;
	Wed,  8 May 2024 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167175; cv=none; b=bFH/e/TEeHTtMiwc2PwiUArciFlYJ8SD4JHCQOne2EafNQFkEyvwBpCwfdeTr9/3p0NSQSLpCQsKVnusPQGdC6K88P1qeb1m+leE1SZOp6TH6l70vPAiDAcwFl8q+m2Q3+G4l1oUZfOI38nSjiWtAyEHtuzsnqnDYUeozwEwpN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167175; c=relaxed/simple;
	bh=fahxRvLaYNPsaNRrTAhZm9sxP9VtoSx15quxJHl9oQg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n9Oo1lIofGqhDv8ejZpHKyGSeGpDi/vVvztuGl0gzwua04FEcue77wuyegU0meBTdVP9qf4IbTv6GvHuyWej3Z6p39sRAVZS1gi/3F4DDiby4mjfHJ1IZ4+f/6uzW90fvX+VBGDDBUeRO5biNeXcNVBxvpSoake5QFIKnmU3NLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=khOCi8hA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448BHvEl024552;
	Wed, 8 May 2024 11:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=rtGG2I47uK9THgkbL+VoeGY4amzx1NjAUU4DxWQ9IKU=;
 b=khOCi8hAvxpl0DrGtueHKqdYuS5Ro6XjhUHr/rqzPWvikvgmfQN2f315oEk3etmrwVYT
 reSM/2Ai1NJtXvkqXDBGUB3r8atn5VgTUSHi8pnSSLH9b24F6kZ3axacsWwr9+N+SFVR
 zRKYohVrVy+lmk/EALcL9ZuL9V7GdFDQwRKkzvB/nDg4uV5/Tb1rvsg+e3hMl7r/cg+/
 DXiiFgPoCculaC7CW0+5OWE2IAXcZGRTbpW0UoywfyvkXIfv78yuh1WgL8kwCSe3uzdW
 Vfn9vfcdxt19YVl28+kY5hHstFT3s5ThckELPLS7+8LuHllWpGdtu9LNX1yTs5euxK/w LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y08cvg0at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 11:19:11 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 448BJBVx028141;
	Wed, 8 May 2024 11:19:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y08cvg0ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 11:19:11 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44887wFa003963;
	Wed, 8 May 2024 11:19:09 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xysgscatj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 11:19:09 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 448BJ68w21299496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 May 2024 11:19:09 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D35EC5804E;
	Wed,  8 May 2024 11:19:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5296E58054;
	Wed,  8 May 2024 11:19:05 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.105.162])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 May 2024 11:19:05 +0000 (GMT)
Message-ID: <ca58aaba02bd34a9369d74b322811ab75eb94afa.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Avoid blocking in RCU read-side critical section
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Stephen Smalley
	 <stephen.smalley.work@gmail.com>,
        GUO Zihua <guozihua@huawei.com>
Cc: roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        omosnace@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
Date: Wed, 08 May 2024 07:19:04 -0400
In-Reply-To: <806c5b96130810b9c078b1b0d99a3e90bad6b106.camel@huaweicloud.com>
References: <20240417074444.2834769-1-guozihua@huawei.com>
	 <CAEjxPJ52FzbBsVfbawiE=fx7UuMNp3pq2xuJnSebcPUhg6gc-A@mail.gmail.com>
	 <806c5b96130810b9c078b1b0d99a3e90bad6b106.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MYgN3B6-y0okCh2FaNRzmNa4akIzNmRH
X-Proofpoint-GUID: Lzw3RQhjfX9IK_1NNcup9OkUeEVUitL0
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_07,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405080081

On Wed, 2024-05-08 at 10:32 +0200, Roberto Sassu wrote:
> On Fri, 2024-04-19 at 14:41 -0700, Stephen Smalley wrote:
> > On Wed, Apr 17, 2024 at 12:49 AM GUO Zihua <guozihua@huawei.com> wrote:
> > > A panic happens in ima_match_policy:
> > > 
> > > BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
> > > PGD 42f873067 P4D 0
> > > Oops: 0000 [#1] SMP NOPTI
> > > CPU: 5 PID: 1286325 Comm: kubeletmonit.sh Kdump: loaded Tainted: P
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> > > RIP: 0010:ima_match_policy+0x84/0x450
> > > Code: 49 89 fc 41 89 cf 31 ed 89 44 24 14 eb 1c 44 39 7b 18 74 26 41 83 ff 05 74 20 48 8b 1b 48 3b 1d f2 b9 f4 00 0f 84 9c 01 00 00 <44> 85 73 10 74 ea 44 8b 6b 14 41 f6 c5 01 75 d4 41 f6 c5 02 74 0f
> > > RSP: 0018:ff71570009e07a80 EFLAGS: 00010207
> > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000200
> > > RDX: ffffffffad8dc7c0 RSI: 0000000024924925 RDI: ff3e27850dea2000
> > > RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffabfce739
> > > R10: ff3e27810cc42400 R11: 0000000000000000 R12: ff3e2781825ef970
> > > R13: 00000000ff3e2785 R14: 000000000000000c R15: 0000000000000001
> > > FS:  00007f5195b51740(0000) GS:ff3e278b12d40000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000000000010 CR3: 0000000626d24002 CR4: 0000000000361ee0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  ima_get_action+0x22/0x30
> > >  process_measurement+0xb0/0x830
> > >  ima_file_check+0x64/0x90
> > >  path_openat+0x571/0x1720
> > >  do_filp_open+0x9b/0x110
> > >  do_sys_open+0x1bd/0x250
> > >  do_syscall_64+0x5d/0x1d0
> > >  entry_SYSCALL_64_after_hwframe+0x65/0xca
> > > 
> > > (stack trace marked with ? is deleted)
> > > 
> > > Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
> > > ima_filter_rule_match()") introduced call to ima_lsm_copy_rule within a
> > > RCU read-side critical section which contains kmalloc with GFP_KERNEL.
> > > This implies a possible sleep and violates limitations of RCU read-side
> > > critical sections on non-PREEMPT systems.
> > > 
> > > Sleeping within RCU read-side critical section might cause
> > > synchronize_rcu() returning early and break RCU protection, allowing a
> > > UAF to happen.
> > > 
> > > The root cause of this issue could be described as follows:
> > > >       Thread A        |       Thread B        |
> > > >                       |ima_match_policy       |
> > > >                       |  rcu_read_lock        |
> > > > ima_lsm_update_rule    |                       |
> > > >  synchronize_rcu      |                       |
> > > >                       |    kmalloc(GFP_KERNEL)|
> > > >                       |      sleep            |
> > > ==> synchronize_rcu returns early
> > > >  kfree(entry)         |                       |
> > > >                       |    entry = entry->next|
> > > ==> UAF happens and entry now becomes NULL (or could be anything).
> > > >                       |    entry->action      |
> > > ==> Accessing entry might cause panic.
> > > 
> > > To fix this issue, we are converting all kmalloc that is called within
> > > RCU read-side critical section to use GFP_ATOMIC.
> > > 
> > > Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: GUO Zihua <guozihua@huawei.com>
> > > ---
> > >  security/integrity/ima/ima_policy.c | 2 +-
> > >  security/selinux/ss/services.c      | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > > index c0556907c2e6..c0cf9b6a01f0 100644
> > > --- a/security/integrity/ima/ima_policy.c
> > > +++ b/security/integrity/ima/ima_policy.c
> > > @@ -410,7 +410,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
> > >          * Immutable elements are copied over as pointers and data; only
> > >          * lsm rules can change
> > >          */
> > > -       nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
> > > +       nentry = kmemdup(entry, sizeof(*nentry), GFP_ATOMIC);
> > >         if (!nentry)
> > >                 return NULL;
> > > 
> > > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > > index e88b1b6c4adb..b7cfad1a2964 100644
> > > --- a/security/selinux/ss/services.c
> > > +++ b/security/selinux/ss/services.c
> > > @@ -3549,7 +3549,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
> > >                 return -EINVAL;
> > >         }
> > > 
> > > -       tmprule = kzalloc(sizeof(struct selinux_audit_rule), GFP_KERNEL);
> > > +       tmprule = kzalloc(sizeof(struct selinux_audit_rule), GFP_ATOMIC);
> > 
> > I would suggest passing in gfp flags from the callers and only using
> > GFP_ATOMIC for the particular call chain that requires atomic
> > allocations, or re-factoring the caller to perform the allocating
> > operations outside of the critical section.
> > Sidebar: the refactoring of the SELinux policy loading logic may have
> > made it possible to revisit the approaches here to permit holding a
> > reference to the policy from which the rule was derived so that we
> > don't have to return -ESTALE in this scenario.
> 
> That would be really nice, would simplify the code for us.
> 
> I was wondering if the label comparison would be still reliable after a
> policy update. I was thinking for example the case where a type is
> removed from the newer policy, and that type was used in an IMA rule.

Yes, I was concerned too.  We followed Stephen's suggestion to ignore the IMA
policy rules containing an unknown SELinux label.  The original discussion can
be found here: 
https://lore.kernel.org/linux-integrity/1432f617-424e-044c-4f78-47f1100262ae@tycho.nsa.gov/

thanks,

Mimi


