Return-Path: <linux-integrity+bounces-5002-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5437A477EC
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2025 09:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3180163479
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2025 08:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9099223711;
	Thu, 27 Feb 2025 08:36:50 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8013A3F2
	for <linux-integrity@vger.kernel.org>; Thu, 27 Feb 2025 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645410; cv=none; b=UxzFXhIVKeBT74uRYd7SWKWfDdPqbcG8/YZSYjXSIBHeC1jiWXuRHSHtApxDP3EIYKW9uqF14ku2k6AYROUJNoVpoDAxq9uTfTcIi2P+BKazq/K3Ie6GAz4VZL6Sd64mTBsLVAB9K12KFHgD0YSyPwVj/5NnI9VHPTWOBPTlMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645410; c=relaxed/simple;
	bh=ibhCDrtDzFax9dn3fd49jh730NEe0albLlL6wMRTckk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=agxtuymjqLnwm8P1Z9uPGPzMv4EC+Ypk7ov9Fjgrq33T1N13raqgOu+E5zq+3QCpSyI3INZvvrqWzIcwKIvWP+nwII7HcxofQs88YThz+WOUhMVQXAnfFMHkHe/JwzF2y2j2uBdaojb3fYi9AUePpBbRCorIfA4Llh1IxMEU2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z3PHS3BVlz9v7Gc
	for <linux-integrity@vger.kernel.org>; Thu, 27 Feb 2025 16:13:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id BDC16141022
	for <linux-integrity@vger.kernel.org>; Thu, 27 Feb 2025 16:35:33 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCXAOOTI8BnWus9Aw--.58600S2;
	Thu, 27 Feb 2025 09:34:33 +0100 (CET)
Message-ID: <bb3b912900d9ba28b446754a01b841af265e485e.camel@huaweicloud.com>
Subject: Re: [PATCH 2/2] ima: limit the number of ToMToU integrity violations
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, Stefan Berger <stefanb@linux.ibm.com>, Petr
 Vorel <pvorel@suse.cz>
Date: Thu, 27 Feb 2025 09:34:23 +0100
In-Reply-To: <27cbda733ae6285866b0b38d771981431b9162e5.camel@linux.ibm.com>
References: <20250219162131.416719-1-zohar@linux.ibm.com>
	 <20250219162131.416719-3-zohar@linux.ibm.com>
	 <62e715f5ea0e901f7fd4185e996871eb9f2e14e2.camel@huaweicloud.com>
	 <27cbda733ae6285866b0b38d771981431b9162e5.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCXAOOTI8BnWus9Aw--.58600S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1kAFyDuFy7KF4fCF4fuFg_yoW5Gr1Dp3
	y8KFWfGFsYqFyUCr1kK3WYvay0q3yrKF1UWrW5Zw1UZF90grnYqrWSkF1j9r93GF1Fyw1I
	qr4av3sxZFs8CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVbkUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBGfADtcA4wAAsX

On Wed, 2025-02-26 at 14:19 -0500, Mimi Zohar wrote:
> Hi Roberto,
>=20
> On Fri, 2025-02-21 at 18:36 +0100, Roberto Sassu wrote:
> > On Wed, 2025-02-19 at 11:21 -0500, Mimi Zohar wrote:
> > > Each time a file in policy, that is already opened for read, is opene=
d
> > > for write a Time-of-Measure-Time-of-Use (ToMToU) integrity violation
> > > audit message is emitted and a violation record is added to the IMA
> > > measurement list, even if a ToMToU violation has already been recorde=
d.
> > >=20
> > > Limit the number of ToMToU integrity violations for an existing file
> > > open for read.
> > >=20
> > > Note: The IMA_MUST_MEASURE atomic flag must be set from the reader si=
de
> > > based on policy.  This may result in a per open reader additional ToM=
ToU
> > > violation.
> >=20
> > Probably the goal can be summarized as to limit emitting consecutive
> > ToMToU violations.
>=20
> Other audit messages and measurements could have been emitted, so they ma=
y not
> be consecutive.

Ah, sorry, not well expressed. I meant if there is a second ToMToU
violation after the first (read -> write -> write). Not consecutive
means when there is a new measurement (more correct would be when there
is a new policy match) on the same file to be invalidated.

> >=20
> > In the previous patch, we are not emitting a new open_writers violation
> > until all writers close the file. Here, it is a bit different, we are
> > not emitting an additional ToMToU violation until there is another
> > reader matching the policy. Maybe we should highlight this difference.
> >=20
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  security/integrity/ima/ima_main.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/i=
ma/ima_main.c
> > > index cde3ae55d654..f1671799a11b 100644
> > > --- a/security/integrity/ima/ima_main.c
> > > +++ b/security/integrity/ima/ima_main.c
> > > @@ -129,9 +129,10 @@ static void ima_rdwr_violation_check(struct file=
 *file,
> > >  		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
> > >  			if (!iint)
> > >  				iint =3D ima_iint_find(inode);
> > > +
> > >  			/* IMA_MEASURE is set from reader side */
> > > -			if (iint && test_bit(IMA_MUST_MEASURE,
> > > -						&iint->atomic_flags))
> > > +			if (iint && test_and_clear_bit(IMA_MUST_MEASURE,
> >=20
> > Since IMA_MUST_MEASURE is only used for violations, what if we rename
> > it to:
> >=20
> > IMA_TOMTOU_MAY_EMIT
>=20
> How about naming the atomic flags as IMA_MAY_EMIT_TOMTOU and
> IMA_EMIT_OPENWRITERS?

Yes, I like them.

Thanks

Roberto


