Return-Path: <linux-integrity+bounces-4042-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B289BFA8B
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 01:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEB61C21033
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 00:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED5D391;
	Thu,  7 Nov 2024 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K61K9P6y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43EB366;
	Thu,  7 Nov 2024 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730937840; cv=none; b=WsbHrpa8YEY1jJg6lvpjXN2DsyLTKE1TPM8z9dQM0jNm7CcIaMVcakEoPUDt9F05qbyMU8cS7AcD9T7IHbCrQjEitAfM3orloEK8R4+osnoUe/eNeXVu5TqIQ9q5Kio9YFLKvPRPBfbznZeuLrDg8wvyHmFr0DjM8nuSewBHa3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730937840; c=relaxed/simple;
	bh=eVEmG1rSKK40HDhb0BAxP+hhaDqvTIM19ehnylrrkp8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QKUqgI+fAwkEeqqLbcu35pmeIFL1SDYP6qYjbumpw3KcnoJlsnPZfphhy/38xRvFfQW1+4EId2nXlWsY8FkDmAyv32VpUorKq9IeQFSSThnzoLq29gXAPMLG5duwUVX++A1iscnatWrWjAxDL7TWF2QcsE0p0ufYoeKvy4YOy8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K61K9P6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038F1C4CEC6;
	Thu,  7 Nov 2024 00:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730937840;
	bh=eVEmG1rSKK40HDhb0BAxP+hhaDqvTIM19ehnylrrkp8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=K61K9P6ydcGQi5cqBLWNFs3jtlfhJR650f1adgcqvScwkUNizYypzhYM9//ew/UTn
	 qIuj2sNTdofzn4jGFrzt7hmUxZsK9HlYY8LqXd4afnaWNZdF6d52RXPj7kXmxI9suy
	 pX4zuB3ZB/5KzMu1csPNa3z78AlL1CNvAJ3wDLzz9HmOSMYAcskkj9Vaxom15kuUrc
	 rYaLPjmAZfaY/R6cUtR4tOHdtLzzBTfwOvFdRF+AJDMzUB9FZWu/rRTxEFpL0LA/Dq
	 rKtJ8jAp1CjxCiN5r0dwq+eIez35ji1ghbpxJt+PCbbAgFUkd0qVMNNzXW756xiUTx
	 VEP4tgdc7ZyiA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 02:03:56 +0200
Message-Id: <D5FI94F98BS0.2JMJGMV9W5GBC@kernel.org>
Cc: <roberto.sassu@huawei.com>, <mapengyu@gmail.com>, "Paul Moore"
 <paul@paul-moore.com>, <linux-kernel@vger.kernel.org>,
 <christian@heusel.eu>
Subject: Re: [RFC PATCH] tpm: Allow the TPM2 pcr_extend HMAC capability to
 be disabled on boot
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mimi Zohar" <zohar@linux.ibm.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241015193916.59964-1-zohar@linux.ibm.com>
 <D5FG6TOVUY5W.3SUG1J3CDB3J5@kernel.org>
 <321b247dcfaba5d9691919eec8476b3c6fc7875d.camel@HansenPartnership.com>
 <D5FHDIMJBWQM.2GWFOR0198360@kernel.org>
 <84fcb3e29f3aa1ea7a5b638307e500608bc8b11a.camel@linux.ibm.com>
In-Reply-To: <84fcb3e29f3aa1ea7a5b638307e500608bc8b11a.camel@linux.ibm.com>

On Thu Nov 7, 2024 at 1:52 AM EET, Mimi Zohar wrote:
> On Thu, 2024-11-07 at 01:22 +0200, Jarkko Sakkinen wrote:
> > On Thu Nov 7, 2024 at 12:52 AM EET, James Bottomley wrote:
> > >=20
> > > I'm a bit confused here.  It's TPM2_PCR_Extend we have the trouble wi=
th
> > > (as Mimi says in her email that you quoted) not TPM2_GetRandom.
> > >=20
> > > The random number generator reseed occurs in a kernel thread that fir=
es
> > > about once a minute, so it doesn't show up in really any of the boot
> > > timings.  Plus even with sessions added, what there now isn't a
> > > significant overhead even to the running kernel given it's asynchrono=
us
> > > and called infrequently.
> >=20
> > Ah, right then we need the boot flag, and my earlier comments to the
> > parameter apply. I've never used IMA so I don't actually even know in
> > detail how it is using TPM.
>
> Huh?  A simple explanation is that IMA-measurement maintains a measuremen=
t list,
> similar to the pre-boot event log.  Each IMA-measurement record extends t=
he TPM
> PCR (default PCR 10).
>
> Assuming IMA is enabled in the kernel, then just add "ima_policy=3Dtcb" o=
r
> "ima_policy=3Dcritical_data" on the boot command line.  To view the measu=
rement
> records, cat <securityfs>/integrity/ima/ascii_runtime_measurements.  Norm=
ally
> the IMA policy specified on the boot command line is replaced with a fine=
r
> grained custom policy.

I'll try to figure out how to test it regularly. And yeah we need the
flag obviously.

I have my (CI compatible) framework that I run regularly with upstream
that I've mentioned a few times earlier.

https://codeberg.org/jarkko/linux-tpmdd-test

How would I would make all files in /etc get to get the checksums, and
how can I generate legit and illegit change to some file in that tree?

No need to address how to implement that to my framework, I can figure
that out. I just would love throw something so that any performance
regressions will be catched right at the get go, i.e. before they
end up to the mainline.

> Mimi

BR, Jarkko

