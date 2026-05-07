Return-Path: <linux-integrity+bounces-9476-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOUUFYtP/GlOOAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9476-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 07 May 2026 10:38:35 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE37D4E4F37
	for <lists+linux-integrity@lfdr.de>; Thu, 07 May 2026 10:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 764FB30733C5
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2026 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C697436F43F;
	Thu,  7 May 2026 08:30:31 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B4377EC1;
	Thu,  7 May 2026 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142631; cv=none; b=Fxlw9dHa3MSa+tClEj70x1Op3v/uBr+kJmZja0Njhn05dW384TNYk9KVFkVpdLPLfQytJcYFbZnCtHazT0+vjptUnWWWYUND7zjPtls4bFnB8KvdzNCwUX4K1LhKyVeNkJifLPZFCUboU8YkcEfHdoRjflVehK//Ceny0jX4fXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142631; c=relaxed/simple;
	bh=9JH+JKtOUYC88OvLe5TjJNgR65xA2MidNnhXMXVbBdg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vrnlbvi5CpDOkInzmd4yQ3mNCtdum4Xe4Ie4ucUoYuyp4GiUxRKR5BrmmcV4aeddZe65b6wDim3a4DIb5++TrCzHGFom/OGMaVzFnihLP7WgVwZ5b8+xBvUF+FPdRqjEg1OoD4V6ILV+x+qqg5sWlyYYN1StBWWPYj9EjlZchnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gB4Zs6zYbz1HCMn;
	Thu,  7 May 2026 16:06:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id B69604056F;
	Thu,  7 May 2026 16:11:10 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXiKIPSfxptCa3AA--.10670S2;
	Thu, 07 May 2026 09:11:10 +0100 (CET)
Message-ID: <8c99263d8e63100e0b5e6c8cf739f7f6e7e79f6b.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan McDowell <noodles@earth.li>,
  linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, jmorris@namei.org, serge@hallyn.com, 
 roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  jarkko@kernel.org, jgg@ziepe.ca,
 sudeep.holla@kernel.org, maz@kernel.org,  oupton@kernel.org,
 joey.gouly@arm.com, suzuki.poulose@arm.com,  yuzenghui@huawei.com,
 catalin.marinas@arm.com, will@kernel.org, noodles@meta.com, 
 sebastianene@google.com
Date: Thu, 07 May 2026 10:10:52 +0200
In-Reply-To: <461ec995935e2b42a8414f6f87063ff2557bbfb4.camel@linux.ibm.com>
References: <cover.1777036497.git.noodles@meta.com>
	 <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
	 <afMlgstqahnZg68h@e129823.arm.com>
	 <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
	 <CAHC9VhRsnmPp2KmQAns5uq5qXX5EF2xQQzyfTgrPi4O9AXyPpg@mail.gmail.com>
	 <ba4bf28314b679474a6a8da6298e548e54b3754c.camel@linux.ibm.com>
	 <CAHC9VhRE2kRr1fdDf6xgQgpSrtvqtP8Vy9LVGJhDZFUbzLKGmQ@mail.gmail.com>
	 <ff28c6dcb60c357c752724927addaa8c4fd3bf2c.camel@linux.ibm.com>
	 <CAHC9VhQY2TMkTvQq9P8oZteQWQSr7qq2utOuH+pdVx+8jWLBCw@mail.gmail.com>
	 <a9412fe10e70ce95dd70556ace19368bec5c188c.camel@linux.ibm.com>
	 <CAHC9VhRUgNA=Sj=jhD=zOt8R80Q+FQj+H0nYSy-FAujTL3EKPA@mail.gmail.com>
	 <5debff82dc758d9c91223e4f1f5b9e39a3fcd4f5.camel@linux.ibm.com>
	 <19dfb0e2730.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
	 <461ec995935e2b42a8414f6f87063ff2557bbfb4.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDXiKIPSfxptCa3AA--.10670S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF18Kw4kArWDAr17tFy8AFb_yoW5tFWfpa
	y7W3WIkrWktFW8Aws2qw18WryIy3s3GayUXr15Kry5ArnYkr9Y9FsxtrWFka97C3ykt3WY
	qF1jqay2kw1DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIF
	4iUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBGn7JLIKAwAAsN
X-Rspamd-Queue-Id: CE37D4E4F37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arm.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9476-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, 2026-05-06 at 22:25 -0400, Mimi Zohar wrote:
> On Tue, 2026-05-05 at 22:11 -0400, Paul Moore wrote:
> > On May 5, 2026 9:57:23 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > On Tue, 2026-05-05 at 18:55 -0400, Paul Moore wrote:
> > > > On Tue, May 5, 2026 at 5:05=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.=
com> wrote:
> > > > > On Mon, 2026-05-04 at 16:51 -0400, Paul Moore wrote:
> > > > > > On Mon, May 4, 2026 at 8:03=E2=80=AFAM Mimi Zohar <zohar@linux.=
ibm.com> wrote:
> > > > > > > On Sun, 2026-05-03 at 12:46 -0400, Paul Moore wrote:
> > > > > > > > Regardless, assuming you always want IMA to leverage a TPMs=
 when they
> > > > > > > > exist, your reply suggests that using an initcall based IMA=
 init
> > > > > > > > scheme, even a late-sync initcall, may not be sufficient be=
cause
> > > > > > > > deferred TPM initialization could happen later, yes?
> > > > > > >=20
> > > > > > > Well yeah.  The TPM could be configured as a module, but that=
 scenario is=20
> > > > > > > not of
> > > > > > > interest.  That's way too late.  The case being addressed in =
this patch set is
> > > > > > > when the TPM driver tries to initialize at device_initcall, r=
eturns
> > > > > > > EPROBE_DEFER, and is retried at deferred_probe_initcall (late=
_initcall).  Since
> > > > > > > ordering within an initcall is not supported, this patch atte=
mpts to initialize
> > > > > > > IMA at late_initcall and similarly retries, in this case, at=
=20
> > > > > > > late_initcall_sync.
> > > > > >=20
> > > > > > Okay, so from a TPM initialization perspective you are satisfie=
d with
> > > > > > a late-sync IMA initialization, yes?
> > > > >=20
> > > > > No. On some architectures moving IMA initialization from the late=
_initcall to
> > > > > late_initcall_sync does not miss any measurement records. However=
, as=20
> > > > > previously
> > > > > mentioned, Linux running in a PowerVM LPAR the move would drop ~3=
0 measurement
> > > > > records[1].  So no, only if the TPM is not initialized by late_in=
itcall, should
> > > > > IMA retry at late_initcall_sync.
> > > >=20
> > > > What do you do in the PowerVM LPAR when the TPM is not avaiable at
> > > > late initcall and you have to defer IMA initialization until
> > > > late-sync?
> > >=20
> > > Your question is hypothetical ...
> >=20
> > <heavy eye roll>
> >=20
> > > ... as the TPM isn't deferred, so IMA doesn't go into
> > > TPM-bypass mode.  Testing on a PowerVM LPAR demonstrated that it skip=
s ~30
> > > measurement list records.  So moving the initcall to late_initcall_sy=
nc would
> > > cause a regression.
> >=20
> > Let me rephrase to make the question clear - how do you plan to handle =
a=20
> > system where you lose measurements by waiting until late-sync, but the =
TPM=20
> > is not available at the late initcall.
>=20
> There have been suggestions to queue the IMA measurements, but that goes =
against
> the "measure before use" principle. The solution is not to defer IMA
> initialization for all systems, but to differentiate the boot_aggregate r=
ecord
> (boot_aggregate vs. boot_aggregate_late) based on when the TPM becomes av=
ailable
> relative to IMA's initcall.  IMA's job is simply to collect and provide t=
he
> measurement list.  Based on the attestation service policy, the attestati=
on
> service will decide whether a measurement list containing boot_aggregate_=
late is
> acceptable.

Agreed on no violation of the measure and load principle.

But also the two boot_aggregate solution does not work. If there are
measurements before boot_aggregate_late, they can corrupt the system
without noticing, and the corrupted system would emit the
boot_aggregate measurement (non-late) to pass verification.

Roberto


