Return-Path: <linux-integrity+bounces-3823-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4D899FA7F
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 23:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64426B21ACC
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 21:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3E01B0F10;
	Tue, 15 Oct 2024 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZWA+L+Z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255A51AB6D4;
	Tue, 15 Oct 2024 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028798; cv=none; b=X91RG6SmHRzv8U6AdTTRrQ6sqd7b5Ln3VTcxiNhLnssHsVtXY6lig5/L4EfB0EXqSUXeE4stkMZ8loZfIqY2lite04NvfG/yMXcVPfexuUW6u/EwVVeEQM2VR746GndbWH63DUaM+ytichU2XBwOLYzMftLRVKW6eZ/weX03xZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028798; c=relaxed/simple;
	bh=5hMFAGCQ/p0vLmyk7t5lsLX/S1FvE/P1hbZfk8QRsHo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=P1jj42bLsK/7cyN7cLRrcsRzD3vrcMUHPIFCO14IYQ4rYDRG/3JXhDsZyb2Y5iOAMs1nVaTCNZgFgl4fywuIYUdIOYWnt20Wj3hLBzAjDqUML/ZcWUuOGzsJ+8Yz5j0hEISNPPE73Bt/JP3l+qX3IYWjyFBmYfep12hn2Yhgthg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZWA+L+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01476C4CEC6;
	Tue, 15 Oct 2024 21:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729028797;
	bh=5hMFAGCQ/p0vLmyk7t5lsLX/S1FvE/P1hbZfk8QRsHo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=KZWA+L+ZXKrrt1USZrzDfXbcNR2r/kt/OJsAgYBjMkNvj2rCBPX5gJKYGF5fQRf+4
	 SZVRWJH8qF2Q3iwameaknB3XN8qejShq07uaxZxLzJIAwnHZE9aOLK7HbMjOrHA1T7
	 YmoztuUV9lHqGLJj0v23w87CyRCCbjF2ZW/yBLyenrCMBmcnv/pwP6Mah4+H0k5WD9
	 ZfsKXM/dIJ/S2CN4VKjtSJ3U5xvw/vynR/AmnYZss5NXbfH1TZT70iTjS0hMcPAIEQ
	 TnGTK0VsI+v49dyQJvn9znFziqA59nGEi4VDMhim06mxA1YeiN8cpKhNvyb9wt/IEd
	 Rjtb6Bhg8B73A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Oct 2024 00:46:33 +0300
Message-Id: <D4WPJY0LZR8T.2HMLVCKXL45TA@kernel.org>
Cc: <James.Bottomley@HansenPartnership.com>, <roberto.sassu@huawei.com>,
 <mapengyu@gmail.com>, "Paul Moore" <paul@paul-moore.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] tpm: Allow the TPM2 pcr_extend HMAC capability to
 be disabled on boot
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Mimi Zohar"
 <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241015193916.59964-1-zohar@linux.ibm.com>
 <D4WP74KE8VZF.3VJITHXKVZOHK@kernel.org>
In-Reply-To: <D4WP74KE8VZF.3VJITHXKVZOHK@kernel.org>

On Wed Oct 16, 2024 at 12:29 AM EEST, Jarkko Sakkinen wrote:
> On Tue Oct 15, 2024 at 10:39 PM EEST, Mimi Zohar wrote:
> > The initial TPM2 HMAC session capability added HMAC authentication to
> > each and every TPM communication making the pcr_extend performance
> > abysmal for HW TPMs. Further, the new CONFIG_TCG_TPM2_HMAC option was
> > configured by default on x86_64.
> >
> > The decision to use the TPM2 HMAC session capability feature doesn't
> > differentiate between the critical encrypted and the non-encrypted
> > communication, but when configured is required for all TPM communicatio=
n.
> >
> > In addition, the reason to HMAC the tpm2_pcr_extend() as provided in co=
mmit
> > 6519fea6fd37 ("tpm: add hmac checks to tpm2_pcr_extend()") was to prote=
ct
> > tpm2_pcr_extend() when used by "trusted keys" to lock the PCR.  However=
,
> > locking the PCR is currently limited to TPM 1.2.
> >
> > We can revert the commit which adds the HMAC sessions for
> > tpm2_pcr_extend, allow just the TPM2 pcr_extend HMAC capability to be
> > disabled on boot for better IMA performance, or define a generic boot
> > command line option to disable HMAC in general.  This patch allows
> > disabling the HMAC for just the TPM2_pcr_extend.
> >
> > Fixes: 6519fea6fd37 ("tpm: add hmac checks to tpm2_pcr_extend()")
> > Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> > Comment: applied and tested with/without patches in Jarkko's hmac-v5 br=
anch -
> > commit 92999f9cd11f ("tpm: flush the auth session only when /dev/tpm0 i=
s open")
> >
> >  .../admin-guide/kernel-parameters.txt         |  5 ++
> >  drivers/char/tpm/tpm2-cmd.c                   | 41 ++++++++++---
> >  drivers/char/tpm/tpm2-sessions.c              | 59 +++++++++++--------
> >  include/linux/tpm.h                           |  4 ++
> >  4 files changed, 77 insertions(+), 32 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index 1518343bbe22..c7811f32ba28 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6727,6 +6727,11 @@
> >  	torture.verbose_sleep_duration=3D [KNL]
> >  			Duration of each verbose-printk() sleep in jiffies.
> > =20
> > +	tpm_pcr_extend_hmac_disable [HW,TPM]
> > +			Disable TPM2 pcr_extend HMAC for better IMA
> > +			performance. By default is set to true (1).
> > +			Mainly needed when using a HW TPM2.
>
> Thanks for doing this! I think the code change itself is pretty good but
> maybe we should not emphasize HMAC per se (applies to config flag too but
> it is what it is now) but instead that they are encrypted and integrity
> protected.
>
> I guess all these features intend to protect data from unintended and
> physical access, like in common sense terms.
>
> So like for any possible sysadmin and similar I think this would be somet=
hing
> that anyone could grab:
>
> 	tpm_disable_protect_pcrs [HW,TPM]
> 			Do not protect PCR registers from unintended physical
> 			access, or interposers in the bus by the means of
> 			having an encrypted and integrity protected session=20
> 			wrapped around TPM2_PCR_Extend command. Consider this
> 			in a situation where TPM is heavily utilized by
> 			IMA, thus protection causing a major performance hit,
> 			and the space where machines are deployed is by other
> 			means guarded.
>
> Perhaps a bit long but at least it is clear and helps to make the right c=
hoice.

Back in 2018 at LA, I think it was LSS, there was BoF where this was
discussed I said that for me this feature does not necessarily make
sense since data centers tend to have armed guards, and not black hat
would ever take a even a minor risk of getting hole in the head :-)

After that the whole ecosystem has changed, especially thanks to what
Apple has done with their security chip and user friendly encrypted
boot process, and that has reflected to systemd and the use TPM2,
and thus as a feature bus protection has become relevant.

So also based on these old conclusions I had I fully agree that we
need such a flag to balance things between desktop/laptop and server
use cases, which are both quite relevant. E.g. just me personally
I really enjoy the experience of being able to boot my ThinkPad=20
with encryption and without having to type a passphrase per
boot.

I.e. the buy-in part is totally addressed as far as I'm concerned :-)

BR, Jarkko

