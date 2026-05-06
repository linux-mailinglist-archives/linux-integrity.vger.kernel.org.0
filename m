Return-Path: <linux-integrity+bounces-9461-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAtbD1Dt+mkRUgMAu9opvQ
	(envelope-from <linux-integrity+bounces-9461-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 09:27:12 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F64D4D7357
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 09:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ADFF300F9FB
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2026 07:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6170F371053;
	Wed,  6 May 2026 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d3PnhMug"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F9335E95E;
	Wed,  6 May 2026 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052247; cv=none; b=u17QMGZ9IWYXlRQYJL6Z5GXCo/1LY3ep8WBRRVX+c+DkfQbcByCRihi+PSPYr7ZbP8CyxBuDawGQNkAXEgDKl1I+eh+VQ2RD4+Fyb8vMv13grvJF4FUlYN4X4eYH3qzR5j2hkCVDv/iAchgq6aVwikh5d8ykwQqBttPjVD7XD+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052247; c=relaxed/simple;
	bh=josdpP8sJBysSQkrR9OfpU04GPGaVe3zhd6zCs8tfXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gs78ogtuXmBjerAzL2SVcvyDZ/x6baiHf8l6jAfVdT5HUPvqJ5azjDZMxEWnzMpalla2osX5X9xrNd0GUfc9asFkiosa0xDhsuvZqOUT4Xcv6xCItS4TZfjYEiOuhA+3JAEt30ydPsmuXPtq36zfkeIK+qbpKl6TsP1VbEy3AEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d3PnhMug; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B53291A9A;
	Wed,  6 May 2026 00:23:59 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 225EC3F7B4;
	Wed,  6 May 2026 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778052245; bh=josdpP8sJBysSQkrR9OfpU04GPGaVe3zhd6zCs8tfXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3PnhMugaDC4c4i+pjuX1jwFImk+ltiIhwM/DubcrBScXBfKVAaSLftveyiVp0fDL
	 OsntxqPiAxHGh3bVKUbb2ea4osStjjJXWIO6dAVsOXmYwkirhLkYeMgE6vwI4sl7/o
	 JAkVJiRZKkC5x/KN1ySRKGqpN4KLpZze02Q3J6Bg=
Date: Wed, 6 May 2026 08:23:59 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Safford <david.safford@gmail.com>,
	Jonathan McDowell <noodles@earth.li>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
Message-ID: <afrsj6ucNMLuQDA4@e129823.arm.com>
References: <cover.1777036497.git.noodles@meta.com>
 <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
 <afMlgstqahnZg68h@e129823.arm.com>
 <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
 <CAGWfHUW+AX0Hpuw5Vr5iTSaJKQJ+O_4nWWmU1UR8Z_3XFctHZg@mail.gmail.com>
 <202f90682fe47bb5fb9b08f8678ae00981b5290b.camel@linux.ibm.com>
 <201b9172ac47c6766443c1f2343cab3548f33c29.camel@linux.ibm.com>
 <afrXmRiq7XvSe6yN@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afrXmRiq7XvSe6yN@e129823.arm.com>
X-Rspamd-Queue-Id: 8F64D4D7357
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	TAGGED_FROM(0.00)[bounces-9461-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,e129823.arm.com:mid]

> > On Sun, 2026-05-03 at 07:36 -0400, Mimi Zohar wrote:
> > > On Fri, 2026-05-01 at 12:52 -0400, David Safford wrote:
> > > > On Thu, Apr 30, 2026 at 5:43 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > > 
> > > > > On Thu, 2026-04-30 at 10:48 +0100, Yeoreum Yun wrote:
> > > > > > With above change I confirmed there is no meaurement log
> > > > > > between boot_aggregate and boot_aggregate_late except "kernel_version"
> > > > > > But this is ignorable since this UTS measurement is done in
> > > > > > "ima_init_core() (old: ima_init())" and it is part of ima initialisation.
> > > > > > 
> > > > > > 1. ima_policy=tcb
> > > > > > 
> > > > > >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> > > > > >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 boot_aggregate
> > > > > >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 boot_aggregate_late
> > > > > >   10 7c23cc970eceec906f7a41bc2fbde770d7092209 ima-ng sha256:72ade6ae3d35cfe5ede7a77b1c0ed1d1782a899445fdcb219c0e994a084a70d5 /bin/busybox
> > > > snip
> > > > > > 
> > > > > > 2. ima_policy=critical_data
> > > > > > 
> > > > > >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> > > > > >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 boot_aggregate
> > > > > >   10 49ab61dd97ea2f759edcb6c6a3387ac67f0aa576 ima-buf sha256:0c907aab3261194f16b0c2a422a82f145bc9b9ecb8fdb633fa43e3e5379f0af2 kernel_version 372e312e302d7263312b // Ignorable since it's generated by ima_init(_core)().
> > > > > >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 boot_aggregate_late
> > > > > > 
> > > > > > Therefore, init_ima() could move into late_initcall_sync like v1 did:
> > > > > >   - https://lore.kernel.org/all/20260417175759.3191279-2-yeoreum.yun@arm.com/
> > > > > 
> > > > > Thanks, Yeoreum.  It's a bit premature to claim it's "safe" to move the
> > > > > initcall.  Hopefully others will respond.
> > > > > 
> > > > > Mimi
> > > > 
> > > > I have also run with this patch on a number of bare metal and virtual machines,
> > > > running everything from default Fedora 44 to a version with everything turned on
> > > > (uefi secure boot, UKI with sdboot stub measurements, IMA measurement
> > > > and appraisal enabled,
> > > > all systemd measurements on, and systemd using the TPM for root
> > > > partition decryption.)
> > > > I too see only the kernel_version event between the normal and late
> > > > calls, if ima_policy=critical_data.
> > > 
> > > Thanks, Dave!  Were all the systems you tested x86_64?  The next step would be
> > > to test on different arch's (e.g. Z, Power).
> > 
> > On both Z and PowerVM, there are ~30 measurements between boot_aggregate and
> > boot_aggregate_late.  For example, on PowerVM:
> > 
> > # grep -n boot_aggregate
> > /sys/kernel/security/integrity/ima/ascii_runtime_measurements
> > 
> > 1:10 f60a05d7354fb34aabc02965216abd3428ea52bb ima-sig
> > sha256:9887dd089ee19a6517bca10580b02c1bb9aa6cd86c157b6ead8a1c0403f348d5
> > boot_aggregate 
> > 31:10 e2592b0d61da6300d3db447b143897a9792231ea ima-sig
> > sha256:9887dd089ee19a6517bca10580b02c1bb9aa6cd86c157b6ead8a1c0403f348d5
> > boot_aggregate_late
> > 
> > It would be interesting to the results from a Raspberry Pi 5 as well,
> > with/without a TPM.
> 
> Honestly, I find this result hard to accept.
> 
> This effectively means that there is code invoking IMA measurement during late_initcall().
> It also implies that if, in the future, a late_initcall is added that performs
> an IMA measurement before IMA initialization has occurred accoding to order by linker,
> that measurement could be missed.
> 
> Could you please check how the index (1, 31) was added to either
> ima_template_entry or ima_queue_entry to produce this result?

And since most IMA measurements occur during module, file, or bprm operations,
I’m really curious about where such operations take place
before the init process is loaded, since init is started only after all
initcalls have completed.

Personally, I find it hard to believe that this kind of critical data
measurement comes from dm or SELinux, as those typically operate via
ioctl or load policies after userspace becomes available.

If you don’t mind, could you share your test code for the index,
as well as some stack traces? That would help me understand
where these measurements are coming from.

Thanks!

> 
> -- 
> Sincerely,
> Yeoreum Yun
> 

-- 
Sincerely,
Yeoreum Yun

