Return-Path: <linux-integrity+bounces-4036-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871269BF941
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 23:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB67B1C20A84
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07A720CCE7;
	Wed,  6 Nov 2024 22:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYOW6ssN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51BD20C313;
	Wed,  6 Nov 2024 22:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730932018; cv=none; b=UFDQ5WW31y6gEaijGklbQHCbz/CrwJaMDhGYriwZn7fi3kn+2rIsoHf9ciMSsKLxwwo0aPc0XGVmI+Cqmq4DxKCYqi6XXt2MhR32K5JrHdwlr/QtlojI1wh6weNUKjso5sZL3EKPL1JIYKOWKTXDcpBbCJuo1ZIiVSBGcwHrdgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730932018; c=relaxed/simple;
	bh=OC5e4KnBysEavl1YeXx88vJZKGAoloUIPo2wglacvfg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Hn/3hTMapP32xM6VxuWlSVf4uGIC3IlXK6W+wZx+qMn4CRv1ICOG0l4JpCoph/X8UIHZP1daHPBZJQE0N802Kbahw31aEOotPJAwnUWdKfViwwIcVRr+vxBZxUTYIhTX/dDeyCCL3kJ7LUT1K6wYTpPQzSG2Cegtnt9ufudcOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYOW6ssN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87DCC4CEC6;
	Wed,  6 Nov 2024 22:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730932018;
	bh=OC5e4KnBysEavl1YeXx88vJZKGAoloUIPo2wglacvfg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=CYOW6ssNu/aWE2b05S3LBoWLO+mIYt5+46hev9722vB11Z1yGBiGfmM/T1mxgO7xj
	 y/FSOQq976hvxWKY69f0ZzSwzXdDScWkCGzOris7Z7Pqi+fbhRaJxS77J2iECB5rmE
	 49rcyEFStCbfDECKeH116nqAEV6v3G79HHbAXfvrrkKoOYMUyUquY0g+y+4HvAT/L2
	 XY7pjBdBDE8D95bstgVyOqGrD2qjMAKwIWblo+Awm7HpQ75b2Fq91RvPBI44v2ZSem
	 7SsJtt+B/1nUt9QTgPh1WI6c3/YDrRjiCQJCOmRPEJX2ZI2np5ckPB2u07zhJ/HIXQ
	 MYWwT7wN1+U4w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 00:26:54 +0200
Message-Id: <D5FG6TOVUY5W.3SUG1J3CDB3J5@kernel.org>
Cc: <James.Bottomley@HansenPartnership.com>, <roberto.sassu@huawei.com>,
 <mapengyu@gmail.com>, "Paul Moore" <paul@paul-moore.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] tpm: Allow the TPM2 pcr_extend HMAC capability to
 be disabled on boot
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mimi Zohar" <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241015193916.59964-1-zohar@linux.ibm.com>
In-Reply-To: <20241015193916.59964-1-zohar@linux.ibm.com>

On Tue Oct 15, 2024 at 10:39 PM EEST, Mimi Zohar wrote:
> The initial TPM2 HMAC session capability added HMAC authentication to
> each and every TPM communication making the pcr_extend performance
> abysmal for HW TPMs. Further, the new CONFIG_TCG_TPM2_HMAC option was
> configured by default on x86_64.
>
> The decision to use the TPM2 HMAC session capability feature doesn't
> differentiate between the critical encrypted and the non-encrypted
> communication, but when configured is required for all TPM communication.
>
> In addition, the reason to HMAC the tpm2_pcr_extend() as provided in comm=
it
> 6519fea6fd37 ("tpm: add hmac checks to tpm2_pcr_extend()") was to protect
> tpm2_pcr_extend() when used by "trusted keys" to lock the PCR.  However,
> locking the PCR is currently limited to TPM 1.2.
>
> We can revert the commit which adds the HMAC sessions for
> tpm2_pcr_extend, allow just the TPM2 pcr_extend HMAC capability to be
> disabled on boot for better IMA performance, or define a generic boot
> command line option to disable HMAC in general.  This patch allows
> disabling the HMAC for just the TPM2_pcr_extend.
>
> Fixes: 6519fea6fd37 ("tpm: add hmac checks to tpm2_pcr_extend()")
> Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

I have alternative proposal that hit me today.

First an observation: I think this issue shows that we also stress
beyond limits desktop configurations with encrypted bus, even tho it is
not in the same way visible. This affects bunch of things, including
e.g. power consumption. Not a lot but best possible situation would be
if callers could be served without any additional stress.

A second observation is in [1]:=20

"It is recommended that a TPM implement the RNG in a manner that would
allow it to return RNG octets such that, as long as the value of
bytesRequested is not greater than the maximum digest size, the
frequency of bytesRequested being more than the number of octets
available is an infrequent occurrence."

I think from this we can derive a fair assumption that with any possible
TPM2 chip we can pull a 32 byte value within a single transcation (i.e.
matching SHA256 digest size).

So based on these facts I think this might be a sweet spot in making a
compromise between performance and security:

1. Generate a 32 byte seed every N iterations (calls of
   tpm2_get_random(). Store it to chip->random_seed.
2. In-between iterations use PRNG to generate the values
   starting form chip->random_seed.

I think N could be fairly large without causing any major difference
(even when analyzed through numerical error analysis) between calling
TPM2_GetRandom for each and every iteration. And this way bus encryption
never has to be disabled.

I'd see this as win-win approach.

PS. I have no idea what kind of PRNG's kernel provides (never used
such).

[1] 16.1.TPM2_GetRandom
    https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-=
3-Commands.pdf

BR, Jarkko

