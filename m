Return-Path: <linux-integrity+bounces-2993-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E12926FC6
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 08:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6EF2819B2
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 06:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC7D1A08CB;
	Thu,  4 Jul 2024 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWzOgCP/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27C1A08C5;
	Thu,  4 Jul 2024 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075275; cv=none; b=K6i/ORGagmiLmrnRarx/w2MRsITTWkUyb1WdSHhJjLPrVggoTcCYgfSQGtH7mYIcL08xAYtP6tLqiRCgc1S8+62x1ambRPgBRScAo0957Kg3rf8iOHbREe2rPxSm7ku//SdF0op0edjW8CONoi0eNEF3Xpvs7wLiH9Ztv46mhQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075275; c=relaxed/simple;
	bh=+bWi1+if3WErd1/KnsdGciJEtBFRJDW87a6ElQhCzz8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=K3YHKaU5P2t37EW4OF7Jn3Tq8hgTokvrQVThEi5Mt5sjGC5ihe9uCOkKQkOnvPluXvXh1uowW8qtWcv4GcHdC9E6cUM3e1ajtiwJHFV2sg5xTbBNjTJR5f0mUogYU/G/BsrtS5w2At0LcMDZ7I8DLYPuENyB6DoUWnDoYgo+edQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWzOgCP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E51C32781;
	Thu,  4 Jul 2024 06:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720075275;
	bh=+bWi1+if3WErd1/KnsdGciJEtBFRJDW87a6ElQhCzz8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=tWzOgCP/EY25airxSQYJHCskq3zPKTdAWsRYJtzuTtc9khjy++FWX4h8GHPI3mflO
	 LYgUCUgPvjeQcUF4+qkBTLIBmG7e6IWgD0Am2KngPakPJWA51tYv3gLPm/qgSN22Q1
	 46MjU+0SCzJgJWGOlcq1e+fi5opQGcEVCZsknvtYlZUKjRyP9Jyh0cR4hNxmSZJlHM
	 pykWqKay0aReMRchPSwqgk0uQqXSGc3enLT0QnjPJXBVV6YvOXVIOIxS5YIia9WHDP
	 w/apUz0Nd7mCkdvUdKlZReK4V6Z5Idu10Uy2RHYoIZvO6VfDjAHKrMIWMI4Q0T0G4X
	 62KRI7TjeGgHw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 09:41:08 +0300
Message-Id: <D2GJSLLC0LSF.2RP57L3ALBW38@kernel.org>
Cc: "Thorsten Leemhuis" <regressions@leemhuis.info>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, <stable@vger.kernel.org>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, <linux-kernel@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] tpm: Address !chip->auth in
 tpm_buf_append_hmac_session*()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240703182453.1580888-1-jarkko@kernel.org>
 <20240703182453.1580888-4-jarkko@kernel.org>
 <c90ce151-c6e5-40c6-8d3d-ccec5a97d10f@linux.ibm.com>
In-Reply-To: <c90ce151-c6e5-40c6-8d3d-ccec5a97d10f@linux.ibm.com>

On Thu Jul 4, 2024 at 4:56 AM EEST, Stefan Berger wrote:
>
>
> On 7/3/24 14:24, Jarkko Sakkinen wrote:
> > Unless tpm_chip_bootstrap() was called by the driver, !chip->auth can
>
> Doesn't tpm_chip_register() need to be called by all drivers? This=20
> function then calls tpm_chip_bootstrap().
>
> > cause a null derefence in tpm_buf_hmac_session*().  Thus, address
> > !chip->auth in tpm_buf_hmac_session*() and remove the fallback
> > implementation for !TCG_TPM2_HMAC.
> >=20
> > Cc: stable@vger.kernel.org # v6.9+
> > Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> > Closes: https://lore.kernel.org/linux-integrity/20240617193408.1234365-=
1-stefanb@linux.ibm.com/
> > Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> I applied this series now but it doesn't solve the reported problem. The=
=20

It fixes the issues of which symptoms was shown by your transcript:

[    2.987131] tpm tpm0: tpm2_load_context: failed with a TPM error 0x01C4
[    2.987140] ima: Error Communicating to TPM chip, result: -14

Your original thread identified zero problems, so thus your claim here
is plain untrue.

Before the null derefence is fixed all other patches related are
blocked, including ibm_tpmvtpm patches, because it would be insane
to accept them when there is known memory corruption bug, which
this patch set fixes.

What is so difficult to understand in this?

> error message is gone but the feature can still be enabled=20
> (CONFIG_TCG_TPM2_HMAC=3Dy) but is unlikely actually doing what it is=20
> promising to do with this config option. So you either still have to=20
> apply my patch, James's patch, or your intended "depends on=20
> !TCG_IBMVTPM" patch.

Well this somewhat misleading imho...

None of the previous patches, including your, do nothing to fix the null
derefence bug and that is the *only* bug we care about ATM. With these
fixes drivers that do not call tpm_chip_bootstrap() will be fully
working still but without encryption.

There's five drivers which would require update for that:

drivers/char/tpm/tpm_ftpm_tee.c:        pvt_data->chip->flags |=3D TPM_CHIP=
_FLAG_TPM2;
drivers/char/tpm/tpm_i2c_nuvoton.c:             chip->flags |=3D TPM_CHIP_F=
LAG_TPM2;
drivers/char/tpm/tpm_ibmvtpm.c:         chip->flags |=3D TPM_CHIP_FLAG_TPM2=
;
drivers/char/tpm/tpm_tis_i2c_cr50.c:    chip->flags |=3D TPM_CHIP_FLAG_TPM2=
;
drivers/char/tpm/tpm_vtpm_proxy.c:              proxy_dev->chip->flags |=3D=
 TPM_CHIP_FLAG_TPM2;


BR, Jarkko

