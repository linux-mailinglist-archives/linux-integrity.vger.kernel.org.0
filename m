Return-Path: <linux-integrity+bounces-4052-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7038E9BFE79
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 07:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3B4283019
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 06:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC4502B1;
	Thu,  7 Nov 2024 06:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMegyjkI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D011426C;
	Thu,  7 Nov 2024 06:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961150; cv=none; b=W6BA8w6RcV6G7APGc0XK/QH3Q6UPedijjlTUcCSBTqvWCvrZ9pMgEkbR27Qbm4WJXYyff7jVcuSd0tg0RgTYivjEfJQUvdJ+QFLfZHfELmrADM377Nb/q926DoQhzEGyTkovdMX7oeiYtjnFo4sPlIUz1gH4NbzgEfZnmvRdN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961150; c=relaxed/simple;
	bh=q4hxbIwCeDxFIPsAJb3aaovNyTFUQW+tdPid0rWZCDY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=hF9+qYoVWzzOoUAQhy2QdJAltxnNzmTdNnJpKRd7VF/PNNcns441vO6+NVxp7ZRXAZVg5z3V2CwUUzkKb1KPRiUwh+7+HRw4aklZpnMp6jlgo4U1b+2uqBt0M24eUSBtMe5+jAeEKIR5WZM6k0/kl2LarBvk26T6/wy/dG2FsWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMegyjkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A133FC4CECD;
	Thu,  7 Nov 2024 06:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730961150;
	bh=q4hxbIwCeDxFIPsAJb3aaovNyTFUQW+tdPid0rWZCDY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=DMegyjkIjThhhDPcj8+r9QRK4YbY8CNZXFT9dJG+u990Fncur2+3ap29yIhyZGTsy
	 Dw6cKgecoD0kgYTykU//GG0/h/L0cHhm/kU63GhKA9g87G2NF1ioOvUIxp+jaJPFE0
	 UJKb+oU/eL4quXF9NynyHgvosFEOL006yTbcOB7Geo9fgFSdiXe//r7AWGNunOSP73
	 5tZVlcXFhHgos+ZGXiUsyCOHM204EdODcYpA/tOWhFe2LCB1ldYTJbdGSx9HSMwYYm
	 lBfxfkJ2aH/LIqv+7aS6e9Z78yKLOh2nybQe4uXF4bTcrpqacQyLjg5CMJ27uKYnaU
	 lf3Q/qOsvfHDA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 08:32:26 +0200
Message-Id: <D5FQIKSL031K.I61QCX45TOIX@kernel.org>
Subject: Re: [RFC PATCH] tpm: Allow the TPM2 pcr_extend HMAC capability to
 be disabled on boot
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mimi Zohar" <zohar@linux.ibm.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
Cc: <roberto.sassu@huawei.com>, <mapengyu@gmail.com>, "Paul Moore"
 <paul@paul-moore.com>, <linux-kernel@vger.kernel.org>,
 <christian@heusel.eu>, "Ken Goldman" <kgold@linux.ibm.com>
X-Mailer: aerc 0.18.2
References: <20241015193916.59964-1-zohar@linux.ibm.com>
 <D5FG6TOVUY5W.3SUG1J3CDB3J5@kernel.org>
 <321b247dcfaba5d9691919eec8476b3c6fc7875d.camel@HansenPartnership.com>
 <D5FHDIMJBWQM.2GWFOR0198360@kernel.org>
 <84fcb3e29f3aa1ea7a5b638307e500608bc8b11a.camel@linux.ibm.com>
 <D5FI94F98BS0.2JMJGMV9W5GBC@kernel.org>
 <0bca8c26693d28093a1cf4dd2df1dcc985cbf252.camel@linux.ibm.com>
 <D5FKM963NJ6O.3BGXETHW2FC5K@kernel.org>
 <253ca7f4dcfdff7f42fd52800e9bd0c126429f0d.camel@linux.ibm.com>
In-Reply-To: <253ca7f4dcfdff7f42fd52800e9bd0c126429f0d.camel@linux.ibm.com>

On Thu Nov 7, 2024 at 5:14 AM EET, Mimi Zohar wrote:
> On Thu, 2024-11-07 at 03:55 +0200, Jarkko Sakkinen wrote:
> > On Thu Nov 7, 2024 at 3:07 AM EET, Mimi Zohar wrote:
> > > On Thu, 2024-11-07 at 02:03 +0200, Jarkko Sakkinen wrote:
> > > > On Thu Nov 7, 2024 at 1:52 AM EET, Mimi Zohar wrote:
> > > > > On Thu, 2024-11-07 at 01:22 +0200, Jarkko Sakkinen wrote:
> > > > > > On Thu Nov 7, 2024 at 12:52 AM EET, James Bottomley wrote:
> > > > > > >=20
> > > > > > > I'm a bit confused here.  It's TPM2_PCR_Extend we have the tr=
ouble with
> > > > > > > (as Mimi says in her email that you quoted) not TPM2_GetRando=
m.
> > > > > > >=20
> > > > > > > The random number generator reseed occurs in a kernel thread =
that fires
> > > > > > > about once a minute, so it doesn't show up in really any of t=
he boot
> > > > > > > timings.  Plus even with sessions added, what there now isn't=
 a
> > > > > > > significant overhead even to the running kernel given it's as=
ynchronous
> > > > > > > and called infrequently.
> > > > > >=20
> > > > > > Ah, right then we need the boot flag, and my earlier comments t=
o the
> > > > > > parameter apply. I've never used IMA so I don't actually even k=
now in
> > > > > > detail how it is using TPM.
> > > > >=20
> > > > > Huh?  A simple explanation is that IMA-measurement maintains a me=
asurement list,
> > > > > similar to the pre-boot event log.  Each IMA-measurement record e=
xtends the TPM
> > > > > PCR (default PCR 10).
> > > > >=20
> > > > > Assuming IMA is enabled in the kernel, then just add "ima_policy=
=3Dtcb" or
> > > > > "ima_policy=3Dcritical_data" on the boot command line.  To view t=
he measurement
> > > > > records, cat <securityfs>/integrity/ima/ascii_runtime_measurement=
s.  Normally
> > > > > the IMA policy specified on the boot command line is replaced wit=
h a finer
> > > > > grained custom policy.
> > > >=20
> > > > I'll try to figure out how to test it regularly. And yeah we need t=
he
> > > > flag obviously.
> > > >=20
> > > > I have my (CI compatible) framework that I run regularly with upstr=
eam
> > > > that I've mentioned a few times earlier.
> > > >=20
> > > > https://codeberg.org/jarkko/linux-tpmdd-test
> > > >=20
> > > > How would I would make all files in /etc get to get the checksums, =
and
> > > > how can I generate legit and illegit change to some file in that tr=
ee?
> > > >=20
> > > > No need to address how to implement that to my framework, I can fig=
ure
> > > > that out. I just would love throw something so that any performance
> > > > regressions will be catched right at the get go, i.e. before they
> > > > end up to the mainline.
> > >=20
> > > Yes, I still need to look at it.  FYI, the IMA policy cannot be defin=
ed in terms
> > > of pathnames.  For testing, we've been loopback mounting a filesystem=
 and
> > > defining policy rules based on the UUID of the filesystem.  If you're=
 using
> > > SELinux, then rules can be defined in terms of SELinux labels. There =
are other
> > > methods of identifying files.  Ken's been working on new IMA document=
ation[1],
> > > which can be viewed here
> > > https://ima-doc.readthedocs.io/en/latest/ima-concepts.html .
> > >=20
> > > Here are some examples as to how to locally verify the IMA measuremen=
t list and
> > > the boot aggregate.
> > >=20
> > > 1. To locally verify the IMA measurement list matches TPM PCR-10, use=
 evmctl
> > > (ima-evm-utils).  For example,
> > >=20
> > > a. An IMA measurement list without integrity violations
> > > (/sys/kernel/security/ima/violations)
> > >=20
> > > evmctl ima_measurement /sys/kernel/security/ima/binary_runtime_measur=
ements
> > >=20
> > > b. An IMA measurement list with integrity violations
> > >=20
> > > evmctl ima_measurement --ignore-violations
> > > /sys/kernel/security/ima/binary_runtime_measurements
> > >=20
> > > 2. To locally verify the 'boot_aggregate' record, the first record in=
 the IMA
> > > measurement list, use "evmctl ima_boot_aggregate -v" and compare the =
resulting
> > > hash with the one in the boot_aggregate record.
> >=20
> > Thanks! I write an issue based on this to my Codeberg repository, and
> > purge it once the time. I'll start by that and later on formalize
> > some commits or perhaps IMA specific buildroot config...
>
> Another important test would to be to make sure that IMA doesn't go into =
"TPM-
> bypass" mode, which happens when the TPM initialization is for some reaso=
n
> delayed.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/s=
ecurity/integrity/ima/ima_init.c#n124
> > As far as the patch goes, I thought that I refine the patch myself, and
> > save everyone's time and nervers from unnecessary reviews rounds. It
> > does not make any radical changes to the approach.
>
> Thanks
> >=20
> > See https://lore.kernel.org/linux-integrity/20241107004708.108667-1-jar=
kko@kernel.org/
> >=20
> > I cannot take reviewed/tested-by's from any of the authors but if you
> > can check that it works for you I can surely send it Linus without
> > further tags than three SOB's :-) That said happy to get at least
> > tested-by from someone.
>
> Our emails crossed.  I suggested removing the word "encrypted" throughout=
 the
> patch, as pcr_extend isn't encrypted, just HMAC'ed.

Well me getting this wrong, i.e. not noticing that in that case SA_ENCRYPT
is not passed, is a sign that hmac is wrong choice... I.e. my mistake
proves an argument here ;-)


>
> I'll re-test first thing tomorrow morning. Does the module_param require =
a value
> or is specifying the name on the boot command line enough?

Module params is what you should use in LKM's unless you have special
reason to use __setup(). It's a kernel-wide global where as this flag
is TPM driver only.

You need to just namespace it with "tpm." when passing throug kernel
command-line i.e. "tpm.pcr_integrity=3D1" (or whatever, open for naming
suggestions).

BR, Jarkko

