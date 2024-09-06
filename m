Return-Path: <linux-integrity+bounces-3485-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB0896F304
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 13:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C787E1F23F95
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 11:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07DF1C8FC7;
	Fri,  6 Sep 2024 11:25:41 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074651A2C39;
	Fri,  6 Sep 2024 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621941; cv=none; b=rKdw3czDXxXcxNhpUt0epRWhTU94Uw0hdx5FvQmvSp/r4PSbF9PUEb+TvgUrNGgcMurnLir/u/+kBwIiACbiQKijdfeZrca2FgJSZMTI53IyykB7CEbRE8+3LJ8pozqe+XDM6hYQWY+6POACqEWhUbWX/6p3rBrZ9Zf17j0BwdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621941; c=relaxed/simple;
	bh=pR25/xPSkyxagW/WiXY5OMWnbDbkz3eZPAEA9zgzID8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MMHUbAxFtasv6CVfxVNVNyjzIioBrFA+Y/0l/55PiiJ2joitNZwSNCGdbwUyundAQM+tMTGnfzB9dI+Wq35oIOkdjyOyKCAEGc7gb4WTyUhKuDdb3iIdQKEMLT4abOs9NDgTlGfj6E61XsR1zv4/cEFtEAyb2NZ8u7qtvFKWX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4X0YLk4yRwz9v7Hq;
	Fri,  6 Sep 2024 19:06:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id C65B3140FDE;
	Fri,  6 Sep 2024 19:25:22 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA35saU5tpmvSRjAA--.22657S2;
	Fri, 06 Sep 2024 12:25:22 +0100 (CET)
Message-ID: <a96e41bd0d4cdc726a80ae24901bcda1e887a65a.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH v3 04/10] ima: Add digest_cache_measure/appraise
 boot-time built-in policies
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, corbet@lwn.net,
 zohar@linux.ibm.com,  dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
 paul@paul-moore.com,  jmorris@namei.org, serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 wufan@linux.microsoft.com, pbrobinson@gmail.com, zbyszek@in.waw.pl,
 hch@lst.de,  mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
 dhowells@redhat.com,  jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com,
 petr.vorel@gmail.com,  mzerqung@0pointer.de, kgold@linux.ibm.com, Roberto
 Sassu <roberto.sassu@huawei.com>
Date: Fri, 06 Sep 2024 13:25:06 +0200
In-Reply-To: <D3Z3S9Z6B4BC.2OSFJZYTZOPZD@kernel.org>
References: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
	 <20240905152512.3781098-5-roberto.sassu@huaweicloud.com>
	 <D3Z3S9Z6B4BC.2OSFJZYTZOPZD@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwA35saU5tpmvSRjAA--.22657S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4xCr1fJF4UKFyUWF1xZrb_yoW5Wr1Dpa
	yDGF1YkrZ8JrnxCw4aka1xWr4rt397Ka13WayDtryrAr98XF1vkw10qr13uFZ8Zr10y3W8
	XF4Ygr4UCw1DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU8RuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGbaZPMG-wAAsF

On Fri, 2024-09-06 at 12:45 +0300, Jarkko Sakkinen wrote:
> On Thu Sep 5, 2024 at 6:25 PM EEST, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Specify the 'digest_cache_measure' boot-time policy with 'ima_policy=3D=
' in
> > the kernel command line to add the following rule at the beginning of t=
he
> > IMA policy, before other rules:
> >=20
> > measure func=3DDIGEST_LIST_CHECK pcr=3D12
> >=20
> > which will measure digest lists into PCR 12 (or the value in
> > CONFIG_IMA_DIGEST_CACHE_MEASURE_PCR_IDX).
> >=20
> > Specify 'digest_cache_appraise' to add the following rule at the beginn=
ing,
> > before other rules:
> >=20
> > appraise func=3DDIGEST_LIST_CHECK appraise_type=3Dimasig|modsig
> >=20
> > which will appraise digest lists with IMA signatures or module-style
> > appended signatures.
> >=20
> > Adding those rule at the beginning rather than at the end is necessary =
to
> > ensure that digest lists are measured and appraised in the initial ram
> > disk, which would be otherwise prevented by the dont_ rules.
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 10 +++++-
> >  security/integrity/ima/Kconfig                | 10 ++++++
> >  security/integrity/ima/ima_policy.c           | 35 +++++++++++++++++++
> >  3 files changed, 54 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index 09126bb8cc9f..afaaf125a237 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2077,7 +2077,8 @@
> >  	ima_policy=3D	[IMA]
> >  			The builtin policies to load during IMA setup.
> >  			Format: "tcb | appraise_tcb | secure_boot |
> > -				 fail_securely | critical_data"
> > +				 fail_securely | critical_data |
> > +				 digest_cache_measure | digest_cache_appraise"
> > =20
> >  			The "tcb" policy measures all programs exec'd, files
> >  			mmap'd for exec, and all files opened with the read
> > @@ -2099,6 +2100,13 @@
> >  			The "critical_data" policy measures kernel integrity
> >  			critical data.
> > =20
> > +			The "digest_cache_measure" policy measures digest lists
> > +			into PCR 12 (can be changed with kernel config).
> > +
> > +			The "digest_cache_appraise" policy appraises digest
> > +			lists with IMA signatures or module-style appended
> > +			signatures.
> > +
> >  	ima_tcb		[IMA] Deprecated.  Use ima_policy=3D instead.
> >  			Load a policy which meets the needs of the Trusted
> >  			Computing Base.  This means IMA will measure all
>=20
> Must be updated as a separate commit as kernel-parameters.txt not
> part of IMA. Consider it as a different subsystem in this context.

Can be done, but this would be more like an atomic change in case the
patch is reverted.

Thanks

Roberto


