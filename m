Return-Path: <linux-integrity+bounces-4047-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4628A9BFC04
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 02:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EAA283CF9
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 01:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF6AD268;
	Thu,  7 Nov 2024 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSpuR07G"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4688D6AA7;
	Thu,  7 Nov 2024 01:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944512; cv=none; b=MdEPaiT6S+GvjPq0VdPH0VYYvD5XoCjGuZGzTKmA/W7RjFnqpkeME211wsOi9Gpq7tLt/AuAKIGY/s1dq4JEAvcl6gWgPOvtymVLHciQvA9Fq9zvDLAVjLB9MxosQRuyQDVHBeDGgiY6yO4hTqfiLLIAR9VxGPBiBK/3+CFS/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944512; c=relaxed/simple;
	bh=1xEJP8hUSWgJKDUDvotNdbEBTPP3pEWjaolJ2nxwfD0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=jg36ges1I1A208RqG+O2F4/7LNk0zK4bu2NElKP20G/EgUSwIhdeS2Um5h3bAX9Nhyx3ltmlVStqZwYKxK+aGma4kLUZ6IUyaj5osKunySm934M52Q9W+s2yxJ/yidUyrRuPWxHRprsYLPtVMG+wWUgzCvPRkfNbOZsnkmQzHyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSpuR07G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC25C4CED2;
	Thu,  7 Nov 2024 01:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730944511;
	bh=1xEJP8hUSWgJKDUDvotNdbEBTPP3pEWjaolJ2nxwfD0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=aSpuR07GNPIyxT7T98J2JGW4Mu5EKkRQ2Y0ON+S48GPbJO8d0QZ71rN89zaqLPtCs
	 6dR+ylt0rhYiRiQEJalfQ+QQ3KkiD+f9PUC9xI1mcMnNrtwP6kl9tY6A8fbHwWTPwz
	 /ocTQUOex3hUElCJzG/B1IBwZVmgIfadScRyBKMsnDR0nhnpA3LWVhlNmwKjodhF6H
	 6TD+i1SMzJvJWX2weYVPrkF/kLAmqoS9fTRWGCKudo0YAaeUgr4I8beWKS/5A043XP
	 +ZUbWY0oUEmp/IAOu0D18nDqQI65KO69x2MWNIV6F+OeoZbYyV3xrDMDvFZJ9VYnOf
	 Jc0t3Il0eu36Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 03:55:07 +0200
Message-Id: <D5FKM963NJ6O.3BGXETHW2FC5K@kernel.org>
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
In-Reply-To: <0bca8c26693d28093a1cf4dd2df1dcc985cbf252.camel@linux.ibm.com>

On Thu Nov 7, 2024 at 3:07 AM EET, Mimi Zohar wrote:
> On Thu, 2024-11-07 at 02:03 +0200, Jarkko Sakkinen wrote:
> > On Thu Nov 7, 2024 at 1:52 AM EET, Mimi Zohar wrote:
> > > On Thu, 2024-11-07 at 01:22 +0200, Jarkko Sakkinen wrote:
> > > > On Thu Nov 7, 2024 at 12:52 AM EET, James Bottomley wrote:
> > > > >=20
> > > > > I'm a bit confused here.  It's TPM2_PCR_Extend we have the troubl=
e with
> > > > > (as Mimi says in her email that you quoted) not TPM2_GetRandom.
> > > > >=20
> > > > > The random number generator reseed occurs in a kernel thread that=
 fires
> > > > > about once a minute, so it doesn't show up in really any of the b=
oot
> > > > > timings.  Plus even with sessions added, what there now isn't a
> > > > > significant overhead even to the running kernel given it's asynch=
ronous
> > > > > and called infrequently.
> > > >=20
> > > > Ah, right then we need the boot flag, and my earlier comments to th=
e
> > > > parameter apply. I've never used IMA so I don't actually even know =
in
> > > > detail how it is using TPM.
> > >=20
> > > Huh?  A simple explanation is that IMA-measurement maintains a measur=
ement list,
> > > similar to the pre-boot event log.  Each IMA-measurement record exten=
ds the TPM
> > > PCR (default PCR 10).
> > >=20
> > > Assuming IMA is enabled in the kernel, then just add "ima_policy=3Dtc=
b" or
> > > "ima_policy=3Dcritical_data" on the boot command line.  To view the m=
easurement
> > > records, cat <securityfs>/integrity/ima/ascii_runtime_measurements.  =
Normally
> > > the IMA policy specified on the boot command line is replaced with a =
finer
> > > grained custom policy.
> >=20
> > I'll try to figure out how to test it regularly. And yeah we need the
> > flag obviously.
> >=20
> > I have my (CI compatible) framework that I run regularly with upstream
> > that I've mentioned a few times earlier.
> >=20
> > https://codeberg.org/jarkko/linux-tpmdd-test
> >=20
> > How would I would make all files in /etc get to get the checksums, and
> > how can I generate legit and illegit change to some file in that tree?
> >=20
> > No need to address how to implement that to my framework, I can figure
> > that out. I just would love throw something so that any performance
> > regressions will be catched right at the get go, i.e. before they
> > end up to the mainline.
>
> Yes, I still need to look at it.  FYI, the IMA policy cannot be defined i=
n terms
> of pathnames.  For testing, we've been loopback mounting a filesystem and
> defining policy rules based on the UUID of the filesystem.  If you're usi=
ng
> SELinux, then rules can be defined in terms of SELinux labels. There are =
other
> methods of identifying files.  Ken's been working on new IMA documentatio=
n[1],
> which can be viewed here
> https://ima-doc.readthedocs.io/en/latest/ima-concepts.html .
>
> Here are some examples as to how to locally verify the IMA measurement li=
st and
> the boot aggregate.
>
> 1. To locally verify the IMA measurement list matches TPM PCR-10, use evm=
ctl
> (ima-evm-utils).  For example,
>
> a. An IMA measurement list without integrity violations
> (/sys/kernel/security/ima/violations)
>
> evmctl ima_measurement /sys/kernel/security/ima/binary_runtime_measuremen=
ts
>
> b. An IMA measurement list with integrity violations
>
> evmctl ima_measurement --ignore-violations
> /sys/kernel/security/ima/binary_runtime_measurements
>
> 2. To locally verify the 'boot_aggregate' record, the first record in the=
 IMA
> measurement list, use "evmctl ima_boot_aggregate -v" and compare the resu=
lting
> hash with the one in the boot_aggregate record.

Thanks! I write an issue based on this to my Codeberg repository, and
purge it once the time. I'll start by that and later on formalize
some commits or perhaps IMA specific buildroot config...

As far as the patch goes, I thought that I refine the patch myself, and
save everyone's time and nervers from unnecessary reviews rounds. It
does not make any radical changes to the approach.

See https://lore.kernel.org/linux-integrity/20241107004708.108667-1-jarkko@=
kernel.org/

I cannot take reviewed/tested-by's from any of the authors but if you
can check that it works for you I can surely send it Linus without
further tags than three SOB's :-) That said happy to get at least
tested-by from someone.

I'll send a PR to Linus as soon as possible.

>  =20
> [1] https://github.com/linux-integrity/ima-doc
> [2] https://github.com/linux-integrity/ima-evm-utils/tree/next-testing/
>
> Mimi

BR, Jarkko

