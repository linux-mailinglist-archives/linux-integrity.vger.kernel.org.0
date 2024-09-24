Return-Path: <linux-integrity+bounces-3679-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0D298495F
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 18:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3761F250DC
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 16:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE831ABEB5;
	Tue, 24 Sep 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjzKbdeM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C81AB6EC;
	Tue, 24 Sep 2024 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194427; cv=none; b=OtaZcMGpHxe03DdBOWu4ADBRDmKmtYrxhvDPJa8XhchTCRbwJMI2R4wwbl/REG7Tt/NC48tqa16O2OSQx9zrrtmsBYHLPVIor8sw+o3RB7Sv2RmJ1XioombwS58dSnqH3Po2iUUTG5+Uc+pwSnvn+0PooSEDjWalxlSgrxClAG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194427; c=relaxed/simple;
	bh=gzHzujlfF85P79/bvwy1TkeTrvl4uorlxlKjH/ZDers=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MU+4zJ1VDUF84q69/YtKGh0zzAsNA9QipO9/GgI+cdVNh0Ie3n92KVG3kO3txcQQwKTQV8qhqAJZYtktqsEKuXKu2wlTHbaDAwb0+bktlbYjWWZL1ZK8spXQ8049hw2iRdD0BuLF0rmVDwAOE1pn3uWYiQWwhQVLOh6ygsSe1LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjzKbdeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F91CC4CEC4;
	Tue, 24 Sep 2024 16:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727194426;
	bh=gzHzujlfF85P79/bvwy1TkeTrvl4uorlxlKjH/ZDers=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=VjzKbdeMgZQAihV/1hTpycX5f2S+fTFmsBCsu6NTlMw/G+AkvFz4Qhpkjg/0fctph
	 fURLck7MXofwAicQj4qUPCKi+myQV14kE2NwLD0f0vtlBRB/d1xABK3Ki3FFbY+I16
	 wsrn79UTeRjiFwixnL/1acXSg3fGwvvl4i05LQ+IB5tOj0k5avG60jw/0oJTX/E5iB
	 nEqZ5NVEPmmXH/0uvC9+pFSfkcUtI+u8HFI3v/EJfcJjgtyRiIJzGrn9RwwYLIBT51
	 7Rs05yYHs6NR8wGNt51I5JEJKLkeLOtyamq5An5GLDxY4BX2HrX1z7O+Sl59rqCKOh
	 P3U36qsEF8RGw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Sep 2024 19:13:42 +0300
Message-Id: <D4ENBNZ5715P.1A1NWQMN9MC44@kernel.org>
Cc: <roberto.sassu@huawei.com>, <mapengyu@gmail.com>,
 <stable@vger.kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/5] tpm: flush the auth session only when /dev/tpm0
 is open
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240921120811.1264985-1-jarkko@kernel.org>
 <20240921120811.1264985-6-jarkko@kernel.org>
 <00cf0bdb3ebfaec7c4607c8c09e55f2e538402f1.camel@HansenPartnership.com>
In-Reply-To: <00cf0bdb3ebfaec7c4607c8c09e55f2e538402f1.camel@HansenPartnership.com>

On Tue Sep 24, 2024 at 4:43 PM EEST, James Bottomley wrote:
> On Sat, 2024-09-21 at 15:08 +0300, Jarkko Sakkinen wrote:
> > Instead of flushing and reloading the auth session for every single
> > transaction, keep the session open unless /dev/tpm0 is used. In
> > practice this means applying TPM2_SA_CONTINUE_SESSION to the session
> > attributes. Flush the session always when /dev/tpm0 is written.
>
> Patch looks fine but this description is way too terse to explain how
> it works.
>
> I would suggest:
>
> Boot time elongation as a result of adding sessions has been reported
> as an issue in https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
>
> The root cause is the addition of session overhead to
> tpm2_pcr_extend().  This overhead can be reduced by not creating and
> destroying a session for each invocation of the function.  Do this by
> keeping a session resident in the TPM for reuse by any session based
> TPM command.  The current flow of TPM commands in the kernel supports
> this because tpm2_end_session() is only called for tpm errors because
> most commands don't continue the session and expect the session to be
> flushed on success.  Thus we can add the continue session flag to
> session creation to ensure the session won't be flushed except on
> error, which is a rare case.
>
> Since the session consumes a slot in the TPM it must not be seen by
> userspace but we can flush it whenever a command write occurs and re-
> create it again on the next kernel session use.  Since TPM use in boot
> is somewhat rare this allows considerable reuse of the in-kernel
> session and shortens boot time:
>
> <give figures>
>
>
>
> >=20
> > Reported-by: Pengyu Ma <mapengyu@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
> > Cc: stable@vger.kernel.org=C2=A0# v6.10+
> > Fixes: 7ca110f2679b ("tpm: Address !chip->auth in
> > tpm_buf_append_hmac_session*()")
> > Tested-by: Pengyu Ma <mapengyu@gmail.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v5:
> > - No changes.
> > v4:
> > - Changed as bug.
> > v3:
> > - Refined the commit message.
> > - Removed the conditional for applying TPM2_SA_CONTINUE_SESSION only
> > when
> > =C2=A0 /dev/tpm0 is open. It is not required as the auth session is
> > flushed,
> > =C2=A0 not saved.
> > v2:
> > - A new patch.
> > ---
> > =C2=A0drivers/char/tpm/tpm-chip.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 1 +
> > =C2=A0drivers/char/tpm/tpm-dev-common.c | 1 +
> > =C2=A0drivers/char/tpm/tpm-interface.c=C2=A0 | 1 +
> > =C2=A0drivers/char/tpm/tpm2-sessions.c=C2=A0 | 3 +++
> > =C2=A04 files changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-
> > chip.c
> > index 0ea00e32f575..7a6bb30d1f32 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -680,6 +680,7 @@ void tpm_chip_unregister(struct tpm_chip *chip)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D tpm_try_get_ops(=
chip);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!rc) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm2_e=
nd_auth_session(chip);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
tpm2_flush_context(chip, chip->null_key);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
chip->null_key =3D 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > diff --git a/drivers/char/tpm/tpm-dev-common.c
> > b/drivers/char/tpm/tpm-dev-common.c
> > index 4eaa8e05c291..a3ed7a99a394 100644
> > --- a/drivers/char/tpm/tpm-dev-common.c
> > +++ b/drivers/char/tpm/tpm-dev-common.c
> > @@ -29,6 +29,7 @@ static ssize_t tpm_dev_transmit(struct tpm_chip
> > *chip, struct tpm_space *space,
> > =C2=A0
> > =C2=A0#ifdef CONFIG_TCG_TPM2_HMAC
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (chip->flags & TPM_C=
HIP_FLAG_TPM2) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0tpm2_end_auth_session(chip);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm2_flush_context(chip, chip->null_key);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0chip->null_key =3D 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> > interface.c
> > index bfa47d48b0f2..2363018fa8fb 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -381,6 +381,7 @@ int tpm_pm_suspend(struct device *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!rc) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > =C2=A0#ifdef CONFIG_TCG_TPM2_HMAC
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm2_e=
nd_auth_session(chip);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
tpm2_flush_context(chip, chip->null_key);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
chip->null_key =3D 0;
> > =C2=A0#endif
> > diff --git a/drivers/char/tpm/tpm2-sessions.c
> > b/drivers/char/tpm/tpm2-sessions.c
> > index a8d3d5d52178..38b92ad9e75f 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -333,6 +333,9 @@ void tpm_buf_append_hmac_session(struct tpm_chip
> > *chip, struct tpm_buf *buf,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > =C2=A0#ifdef CONFIG_TCG_TPM2_HMAC
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* The first write to /dev/t=
pm{rm0} will flush the session.
> > */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0attributes |=3D TPM2_SA_CONT=
INUE_SESSION;
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The Architecture Gui=
de requires us to strip trailing zeros
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * before computing the=
 HMAC
>
> Code is fine, with the change log update, you can add
>
> Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>

OK, thank you.

BR, Jarkko

