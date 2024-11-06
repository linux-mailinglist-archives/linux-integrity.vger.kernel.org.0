Return-Path: <linux-integrity+bounces-4038-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB819BF9E5
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 00:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522901F228C4
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 23:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D22E20D4E0;
	Wed,  6 Nov 2024 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sO/KOSsP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24424201110;
	Wed,  6 Nov 2024 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935364; cv=none; b=TTxsBcdwRfr/WIew6v5YXI62HvBFLFXSxuvDlgB8YO/6mqgKqdLBvA/qmiVoiHuxFebpISiuQ3Mzw9FA3i0dMuhYhR2+HMtJIHEK+NZDjT+BPV3ITZ9UIBtlUV9Ri4j74dI6h/YOso2VGJ+UxillOT1d358Ftp5RQaO2I0v1Fzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935364; c=relaxed/simple;
	bh=lcf+7l73JzBKQ+KigkV+9T6nUxYNGhwt8EiZ+E7xL2Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JQS4LlvCLPE1y5VsOvFQsSTRTiJ4Tcul3AUzOM222kxCCbk8k37pJmvF5qpgQxZx5XJl+nbdWVqseRaDf7mKlzYHjRH8qPxgrm2h5tl7M1vU8ALc0UUwoDsUnMh4wCK/ljXohNLEsgptsWS7gvtF7i/ktUZ5zYt6aAkxXndEg5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sO/KOSsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CF5C4CEC6;
	Wed,  6 Nov 2024 23:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730935363;
	bh=lcf+7l73JzBKQ+KigkV+9T6nUxYNGhwt8EiZ+E7xL2Q=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=sO/KOSsPQxLuzz7quwmccHeyPOY/4IdEErbd8s8OvPnhe4b0IYedR9dKRyu1VtGH5
	 IAjNDOvlDDaILT29cWrEZPpkOT6dgcIe9oOV9EuwLK+ABEpBa2q4c5XbxAV8IeSd98
	 L6T14hT4qKF3cCwDCz1A5/eh1p/n5YZ5TnwaqXUPZbUHKJv078joohZc4e6zwy/9tA
	 8bkSjd7VYc6LXZ4Gc86nCLis9f8Fb5+4uMLUhcAYGzz6jPSQhjoa4jnTUfbRNr+QET
	 y/bXNA4msMWMA3O4nq6/20C4824xbYu4KOtpBI2g5waY2P/YXQ5OEX4cPkQa7kw7nS
	 v0PksYLe+H9Kg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 01:22:39 +0200
Message-Id: <D5FHDIMJBWQM.2GWFOR0198360@kernel.org>
Cc: <roberto.sassu@huawei.com>, <mapengyu@gmail.com>, "Paul Moore"
 <paul@paul-moore.com>, <linux-kernel@vger.kernel.org>,
 <christian@heusel.eu>
Subject: Re: [RFC PATCH] tpm: Allow the TPM2 pcr_extend HMAC capability to
 be disabled on boot
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241015193916.59964-1-zohar@linux.ibm.com>
 <D5FG6TOVUY5W.3SUG1J3CDB3J5@kernel.org>
 <321b247dcfaba5d9691919eec8476b3c6fc7875d.camel@HansenPartnership.com>
In-Reply-To: <321b247dcfaba5d9691919eec8476b3c6fc7875d.camel@HansenPartnership.com>

On Thu Nov 7, 2024 at 12:52 AM EET, James Bottomley wrote:
> On Thu, 2024-11-07 at 00:26 +0200, Jarkko Sakkinen wrote:
> > On Tue Oct 15, 2024 at 10:39 PM EEST, Mimi Zohar wrote:
> > > The initial TPM2 HMAC session capability added HMAC authentication
> > > to each and every TPM communication making the pcr_extend
> > > performance abysmal for HW TPMs. Further, the new
> > > CONFIG_TCG_TPM2_HMAC option was configured by default on x86_64.
> > >=20
> > > The decision to use the TPM2 HMAC session capability feature
> > > doesn't differentiate between the critical encrypted and the non-
> > > encrypted communication, but when configured is required for all
> > > TPM communication.
> > >=20
> > > In addition, the reason to HMAC the tpm2_pcr_extend() as provided
> > > in commit 6519fea6fd37 ("tpm: add hmac checks to
> > > tpm2_pcr_extend()") was to protect tpm2_pcr_extend() when used by
> > > "trusted keys" to lock the PCR.=C2=A0 However, locking the PCR is
> > > currently limited to TPM 1.2.
> > >=20
> > > We can revert the commit which adds the HMAC sessions for
> > > tpm2_pcr_extend, allow just the TPM2 pcr_extend HMAC capability to
> > > be disabled on boot for better IMA performance, or define a generic
> > > boot command line option to disable HMAC in general.=C2=A0 This patch
> > > allows disabling the HMAC for just the TPM2_pcr_extend.
> > >=20
> > > Fixes: 6519fea6fd37 ("tpm: add hmac checks to tpm2_pcr_extend()")
> > > Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> >=20
> > I have alternative proposal that hit me today.
> >=20
> > First an observation: I think this issue shows that we also stress
> > beyond limits desktop configurations with encrypted bus, even tho it
> > is
> > not in the same way visible. This affects bunch of things, including
> > e.g. power consumption. Not a lot but best possible situation would
> > be
> > if callers could be served without any additional stress.
> >=20
> > A second observation is in [1]:=20
> >=20
> > "It is recommended that a TPM implement the RNG in a manner that
> > would
> > allow it to return RNG octets such that, as long as the value of
> > bytesRequested is not greater than the maximum digest size, the
> > frequency of bytesRequested being more than the number of octets
> > available is an infrequent occurrence."
> >=20
> > I think from this we can derive a fair assumption that with any
> > possible
> > TPM2 chip we can pull a 32 byte value within a single transcation
> > (i.e.
> > matching SHA256 digest size).
> >=20
> > So based on these facts I think this might be a sweet spot in making
> > a
> > compromise between performance and security:
> >=20
> > 1. Generate a 32 byte seed every N iterations (calls of
> > =C2=A0=C2=A0 tpm2_get_random(). Store it to chip->random_seed.
> > 2. In-between iterations use PRNG to generate the values
> > =C2=A0=C2=A0 starting form chip->random_seed.
> >=20
> > I think N could be fairly large without causing any major difference
> > (even when analyzed through numerical error analysis) between calling
> > TPM2_GetRandom for each and every iteration. And this way bus
> > encryption
> > never has to be disabled.
> >=20
> > I'd see this as win-win approach.
> >=20
> > PS. I have no idea what kind of PRNG's kernel provides (never used
> > such).
> >=20
> > [1] 16.1.TPM2_GetRandom
> > =C2=A0=C2=A0=C2=A0
> > https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-=
3-Commands.pdf
>
> I'm a bit confused here.  It's TPM2_PCR_Extend we have the trouble with
> (as Mimi says in her email that you quoted) not TPM2_GetRandom.
>
> The random number generator reseed occurs in a kernel thread that fires
> about once a minute, so it doesn't show up in really any of the boot
> timings.  Plus even with sessions added, what there now isn't a
> significant overhead even to the running kernel given it's asynchronous
> and called infrequently.

Ah, right then we need the boot flag, and my earlier comments to the
parameter apply. I've never used IMA so I don't actually even know in
detail how it is using TPM.

Now that I did some seek I mixed this up with the report:

https://chaos.social/@gromit/113345582873908273

Anyway concerning this issue and patch, my earlier comments still apply.

BR, Jarkko

