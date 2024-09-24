Return-Path: <linux-integrity+bounces-3674-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D899846F3
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 15:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE8E1C22921
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 13:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568AC1A76DE;
	Tue, 24 Sep 2024 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="hvlaqnVh";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="K5i7Zs8j"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802D114F124;
	Tue, 24 Sep 2024 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185414; cv=none; b=ckMjhaHMGBHjhq09WHG5XR4XHaI3KZLW6BQWLMVgFoEfg0Ydb9n6l+r7I0nAuqrXECQRBN3UIlxyvFbi8KPLcPbusRiFnaqiV1zur1qBZSBBW/LK+/ustQeJz5NsQF8gqspOp16DYWOhonbXd9zojVCFg/sDk+snMQi4A096acQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185414; c=relaxed/simple;
	bh=A4rveCzomZ1idWkEzSTfURP3q9bY55z7OgRVltQ+MoQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YnxZnK8agRevr12Bc6QcZs8td159VRaGcmXOMDy0tsX411UswcyvL22no0hYT11GFcxkuAFa14uqtuHGItY0X7GuSMYbrZ628wu15Mf+GFaK2fe8uTg9r59Z0HSBxCkRe1uEoJ5A2NlbajPHuF4tUs/Fwi/7MNAOxTrnJ9aWMZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=hvlaqnVh; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=K5i7Zs8j; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727185408;
	bh=A4rveCzomZ1idWkEzSTfURP3q9bY55z7OgRVltQ+MoQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=hvlaqnVhhIntzgRHJwR+6MLZ1NABIIQtevSX8tOh9YqBO/k9LMcO96Yl0F/reXsBs
	 UYXFZqHqXmqURTVgNJ5sojB8ybbyY0qLz5cGyntdFO33Yy+QQDX+Vb9GrnqZWrTVSQ
	 tL2QL2NdRBxuZu3OdM1k6RDJPC+Pnrbt/Hkf8slg=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 58354128118D;
	Tue, 24 Sep 2024 09:43:28 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id u2T_K8uaGlx7; Tue, 24 Sep 2024 09:43:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727185407;
	bh=A4rveCzomZ1idWkEzSTfURP3q9bY55z7OgRVltQ+MoQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=K5i7Zs8jXnQjEwI8wXDZnvljzC7feuPBSuezGUNoZYUVvIMxLsN03N1Nj+QamgTqP
	 4pp3GbeoixMO3Sm0/PMdCzxF/qu5q6u/s9vjWITBudZRDXHLVJfSjVxVUj2b7tBtao
	 cSXznDF5/yI6sKPBV6w0dJhhCOxCUUVG1Ll6IPEE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C3B9C1280EA1;
	Tue, 24 Sep 2024 09:43:26 -0400 (EDT)
Message-ID: <00cf0bdb3ebfaec7c4607c8c09e55f2e538402f1.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 5/5] tpm: flush the auth session only when /dev/tpm0
 is open
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, mapengyu@gmail.com, stable@vger.kernel.org,
 Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 24 Sep 2024 09:43:25 -0400
In-Reply-To: <20240921120811.1264985-6-jarkko@kernel.org>
References: <20240921120811.1264985-1-jarkko@kernel.org>
	 <20240921120811.1264985-6-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-09-21 at 15:08 +0300, Jarkko Sakkinen wrote:
> Instead of flushing and reloading the auth session for every single
> transaction, keep the session open unless /dev/tpm0 is used. In
> practice this means applying TPM2_SA_CONTINUE_SESSION to the session
> attributes. Flush the session always when /dev/tpm0 is written.

Patch looks fine but this description is way too terse to explain how
it works.

I would suggest:

Boot time elongation as a result of adding sessions has been reported
as an issue in https://bugzilla.kernel.org/show_bug.cgi?id=219229

The root cause is the addition of session overhead to
tpm2_pcr_extend().  This overhead can be reduced by not creating and
destroying a session for each invocation of the function.  Do this by
keeping a session resident in the TPM for reuse by any session based
TPM command.  The current flow of TPM commands in the kernel supports
this because tpm2_end_session() is only called for tpm errors because
most commands don't continue the session and expect the session to be
flushed on success.  Thus we can add the continue session flag to
session creation to ensure the session won't be flushed except on
error, which is a rare case.

Since the session consumes a slot in the TPM it must not be seen by
userspace but we can flush it whenever a command write occurs and re-
create it again on the next kernel session use.  Since TPM use in boot
is somewhat rare this allows considerable reuse of the in-kernel
session and shortens boot time:

<give figures>



> 
> Reported-by: Pengyu Ma <mapengyu@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219229
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: 7ca110f2679b ("tpm: Address !chip->auth in
> tpm_buf_append_hmac_session*()")
> Tested-by: Pengyu Ma <mapengyu@gmail.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v5:
> - No changes.
> v4:
> - Changed as bug.
> v3:
> - Refined the commit message.
> - Removed the conditional for applying TPM2_SA_CONTINUE_SESSION only
> when
>   /dev/tpm0 is open. It is not required as the auth session is
> flushed,
>   not saved.
> v2:
> - A new patch.
> ---
>  drivers/char/tpm/tpm-chip.c       | 1 +
>  drivers/char/tpm/tpm-dev-common.c | 1 +
>  drivers/char/tpm/tpm-interface.c  | 1 +
>  drivers/char/tpm/tpm2-sessions.c  | 3 +++
>  4 files changed, 6 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-
> chip.c
> index 0ea00e32f575..7a6bb30d1f32 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -680,6 +680,7 @@ void tpm_chip_unregister(struct tpm_chip *chip)
>         rc = tpm_try_get_ops(chip);
>         if (!rc) {
>                 if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +                       tpm2_end_auth_session(chip);
>                         tpm2_flush_context(chip, chip->null_key);
>                         chip->null_key = 0;
>                 }
> diff --git a/drivers/char/tpm/tpm-dev-common.c
> b/drivers/char/tpm/tpm-dev-common.c
> index 4eaa8e05c291..a3ed7a99a394 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -29,6 +29,7 @@ static ssize_t tpm_dev_transmit(struct tpm_chip
> *chip, struct tpm_space *space,
>  
>  #ifdef CONFIG_TCG_TPM2_HMAC
>         if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +               tpm2_end_auth_session(chip);
>                 tpm2_flush_context(chip, chip->null_key);
>                 chip->null_key = 0;
>         }
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> interface.c
> index bfa47d48b0f2..2363018fa8fb 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -381,6 +381,7 @@ int tpm_pm_suspend(struct device *dev)
>         if (!rc) {
>                 if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>  #ifdef CONFIG_TCG_TPM2_HMAC
> +                       tpm2_end_auth_session(chip);
>                         tpm2_flush_context(chip, chip->null_key);
>                         chip->null_key = 0;
>  #endif
> diff --git a/drivers/char/tpm/tpm2-sessions.c
> b/drivers/char/tpm/tpm2-sessions.c
> index a8d3d5d52178..38b92ad9e75f 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -333,6 +333,9 @@ void tpm_buf_append_hmac_session(struct tpm_chip
> *chip, struct tpm_buf *buf,
>         }
>  
>  #ifdef CONFIG_TCG_TPM2_HMAC
> +       /* The first write to /dev/tpm{rm0} will flush the session.
> */
> +       attributes |= TPM2_SA_CONTINUE_SESSION;
> +
>         /*
>          * The Architecture Guide requires us to strip trailing zeros
>          * before computing the HMAC

Code is fine, with the change log update, you can add

Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>



