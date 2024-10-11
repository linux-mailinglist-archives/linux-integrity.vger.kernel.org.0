Return-Path: <linux-integrity+bounces-3786-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5A299A8A5
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2024 18:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD01B22CA5
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2024 16:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8FF1974F4;
	Fri, 11 Oct 2024 16:11:08 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434F16F27E;
	Fri, 11 Oct 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663068; cv=none; b=pWIB7vn5MH5xiqzTP+c1uIvA26ovswc9hgCNgNdo5E2kaYV52W7Uzdk7nJp6GdbVf8Y7eHTMqH8LrSUosrS4xWXLPjfzHMqmzEWZF5TAjpjuYcxNWg4iq3xnxygSexEs4s1BGI/4UKB4UesLBABxL0emCrPYG5AJDTIojAhZC9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663068; c=relaxed/simple;
	bh=TZDn0sUuy2tinNJpUTDRdXhwz/uKpIMSWwu6/1c8yw4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XtbL7RjwqEhk55T0WmtpKJM8e3i4U2vUPoPFfHUXZ2vV46uIavavF3UE3tOgXId11kmtmKIk078y+RecKWrEcwKxDJuvJFIFufRUHlJxu0UkKMPjqK4PG7nSk/UZyvpCUEe/BVqwDZ4+Ocjd2kybn8E9A7J9nLZd8QyfAUyxWCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XQB1C4TTyz9v7Hl;
	Fri, 11 Oct 2024 23:50:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 200E11403D2;
	Sat, 12 Oct 2024 00:10:52 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwB3JMX_TQlngtqsAg--.53302S2;
	Fri, 11 Oct 2024 17:10:50 +0100 (CET)
Message-ID: <21b46f4882f0b9b12304d7786bd88f33a7ad2b97.camel@huaweicloud.com>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, roberto.sassu@huawei.com, 
 mapengyu@gmail.com, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Peter Huewe
 <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 keyrings@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 11 Oct 2024 18:10:35 +0200
In-Reply-To: <f69e08167d8354db31013018edf064a2876f8d1c.camel@kernel.org>
References: <20240921120811.1264985-1-jarkko@kernel.org>
	 <f69e08167d8354db31013018edf064a2876f8d1c.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwB3JMX_TQlngtqsAg--.53302S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4rCFyUZF4UJrWUKrykKrg_yoW5uF15pF
	WxKa98CFyDWw1xJ397Aw4UAFyFq34rJ34UGrykJ3s3ArWYgF1Yv3yv9rySgryUWrZ7Gr4j
	qFsFqr1v9Fyjy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBGcIif8LAQABsZ

On Fri, 2024-10-11 at 17:06 +0300, Jarkko Sakkinen wrote:
> On Sat, 2024-09-21 at 15:08 +0300, Jarkko Sakkinen wrote:
> > This patch set aims to fix:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229.
> >=20
> > The baseline for the series is the v6.11 tag.
> >=20
> > v4:
> > https://lore.kernel.org/linux-integrity/20240918203559.192605-1-jarkko@=
kernel.org/
> > v3:
> > https://lore.kernel.org/linux-integrity/20240917154444.702370-1-jarkko@=
kernel.org/
> > v2:
> > https://lore.kernel.org/linux-integrity/20240916110714.1396407-1-jarkko=
@kernel.org/
> > v1:
> > https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jarkko=
@kernel.org/
> >=20
> > Jarkko Sakkinen (5):
> > =C2=A0 tpm: Return on tpm2_create_null_primary() failure
> > =C2=A0 tpm: Implement tpm2_load_null() rollback
> > =C2=A0 tpm: flush the null key only when /dev/tpm0 is accessed
> > =C2=A0 tpm: Allocate chip->auth in tpm2_start_auth_session()
> > =C2=A0 tpm: flush the auth session only when /dev/tpm0 is open
> >=20
> > =C2=A0drivers/char/tpm/tpm-chip.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 14 ++++
> > =C2=A0drivers/char/tpm/tpm-dev-common.c |=C2=A0=C2=A0 8 +++
> > =C2=A0drivers/char/tpm/tpm-interface.c=C2=A0 |=C2=A0 10 ++-
> > =C2=A0drivers/char/tpm/tpm2-cmd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 3 +
> > =C2=A0drivers/char/tpm/tpm2-sessions.c=C2=A0 | 109 ++++++++++++++++++--=
--------
> > --
> > =C2=A0include/linux/tpm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > =C2=A06 files changed, 102 insertions(+), 44 deletions(-)
>=20
> The summarize some discussions:
>=20
> 1. I'll address Stefan's remarks.
> 2. We know that these patches address the desktop boot.
> 3. IMA is too slow =3D> add a boot option for IMA default off. I.e.
>    IMA will not use the feature unless you specifically ask.

Initially, I thought that maybe it would not be good to have an event
log with unmodified and altered measurement entries. Then, I tried to
think if we can really prevent an active interposer from injecting
arbitrary PCR extends and pretending that those events actually
happened.

If I understood James's cover letter correctly, the kernel can detect
whether a TPM reset occurred, but not that a PCR extend occurred (maybe
with a shadow PCR?).

Second point, do we really want to take the responsibility to disable
the protection on behalf of users? Maybe a better choice is to let them
consciously disable HMAC protection.

So, maybe we should keep the HMAC protection enabled, and if the number
of PCR extends is above a certain threshold, we can print a warning
message in the kernel log.

Roberto

> 4. Random generation can be optimized a lot with or without
>    encryption. Not sure if  I have time to do ths right now
>    but I have already patch planned for this.
>=20
> What is blocking me is the James' request to not include
> functional fixes. The problem with that is that if comply
> to that request I will have to postpone all the performacne
> fixes and send a patch set with only functional fixes and
> go all review rounds with that before moving forward.
>=20
> This is just how priorities go in kernel and doing by the
> book. Is that really necessary?
>=20
> Since I've just started in a new job any patches can be
> expected earliest next week. That's why I was rushing with
> the patch set in the first place because I knew that there
> will be otherwise a few week delay but we'll get there :-)
>=20
> BR, Jarkko
>=20


