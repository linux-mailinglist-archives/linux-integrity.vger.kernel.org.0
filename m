Return-Path: <linux-integrity+bounces-3822-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E4F99F91F
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 23:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259C81C22468
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9791FBF76;
	Tue, 15 Oct 2024 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVgQ1FAt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE671FBF52;
	Tue, 15 Oct 2024 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027793; cv=none; b=lkoWWc1ip1KIihjGV+JizXzX+yRZTJL8hEVWmmWby+9EPBTwBr8MdfrO8KifrC7cQViaQeg0/+pv69slGu9rJIP9V0GgWMlSOAowTMQz5FWLdxxsuTskLxth5U08G6FQYxbv8WFS2h0DxNYi1yz8iT70H7ALH9xppd1q9EMEDUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027793; c=relaxed/simple;
	bh=oSVdFK89IUI6uANDyGoSlNLCNsfA7F682g4XiC0m1y8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=dbICcCI35rvVsssKLTJB0RH5auzERN0fi9QOG2MnSK8tZynchuhgMhOWZpcL4ybRiKIC/9EzC4NoCjZyhQ6uUs1LEqiwV5mgdUKsZnuQGOdvGegLloG0DunpxIhdpbIfemzYQBRF77Xw656N2pdo1hg0TtPIp004L0zEwad6BRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVgQ1FAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F688C4CED5;
	Tue, 15 Oct 2024 21:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729027792;
	bh=oSVdFK89IUI6uANDyGoSlNLCNsfA7F682g4XiC0m1y8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=AVgQ1FAtUdhe6G7o30SjEgC+E9nDuZhwvc80/IAzGHaXRG4gyKGRl8PEiorjLhjPC
	 VOxW3QOg3gsHa/8An4ZemPEkJavIV3l9NNJtjGKOG4xzoKoOjjFrMU512w/FA1Rvcb
	 GfHaROxLcRc1rqTeV0q4Fuhs+Sd5OR774yFIS4S0y0wJKKLSZ5+BOS7QlT1YZMh1ZF
	 ZQbKx80rXcM3jA/7Uu5tGcmBylDSJ0Wda9mp89/Avn9++KGRIj7bJPJZmFQA3CF9kS
	 ryKkQBYL3v5JWgGkNgeUudo6aCYSo83DPv9qHMO+n2wbkedm897ICdcCbqWvVGO7CS
	 kmWU1QqW2YIoQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Oct 2024 00:29:48 +0300
Message-Id: <D4WP74KE8VZF.3VJITHXKVZOHK@kernel.org>
Subject: Re: [RFC PATCH] tpm: Allow the TPM2 pcr_extend HMAC capability to
 be disabled on boot
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mimi Zohar" <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>
Cc: <James.Bottomley@HansenPartnership.com>, <roberto.sassu@huawei.com>,
 <mapengyu@gmail.com>, "Paul Moore" <paul@paul-moore.com>,
 <linux-kernel@vger.kernel.org>
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
> ---
> Comment: applied and tested with/without patches in Jarkko's hmac-v5 bran=
ch -
> commit 92999f9cd11f ("tpm: flush the auth session only when /dev/tpm0 is =
open")
>
>  .../admin-guide/kernel-parameters.txt         |  5 ++
>  drivers/char/tpm/tpm2-cmd.c                   | 41 ++++++++++---
>  drivers/char/tpm/tpm2-sessions.c              | 59 +++++++++++--------
>  include/linux/tpm.h                           |  4 ++
>  4 files changed, 77 insertions(+), 32 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 1518343bbe22..c7811f32ba28 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6727,6 +6727,11 @@
>  	torture.verbose_sleep_duration=3D [KNL]
>  			Duration of each verbose-printk() sleep in jiffies.
> =20
> +	tpm_pcr_extend_hmac_disable [HW,TPM]
> +			Disable TPM2 pcr_extend HMAC for better IMA
> +			performance. By default is set to true (1).
> +			Mainly needed when using a HW TPM2.

Thanks for doing this! I think the code change itself is pretty good but
maybe we should not emphasize HMAC per se (applies to config flag too but
it is what it is now) but instead that they are encrypted and integrity
protected.

I guess all these features intend to protect data from unintended and
physical access, like in common sense terms.

So like for any possible sysadmin and similar I think this would be somethi=
ng
that anyone could grab:

	tpm_disable_protect_pcrs [HW,TPM]
			Do not protect PCR registers from unintended physical
			access, or interposers in the bus by the means of
			having an encrypted and integrity protected session=20
			wrapped around TPM2_PCR_Extend command. Consider this
			in a situation where TPM is heavily utilized by
			IMA, thus protection causing a major performance hit,
			and the space where machines are deployed is by other
			means guarded.

Perhaps a bit long but at least it is clear and helps to make the right cho=
ice.

BR, Jarkko

