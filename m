Return-Path: <linux-integrity+bounces-3936-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE0D9B6849
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Oct 2024 16:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF82B20D0F
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Oct 2024 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36576213EDC;
	Wed, 30 Oct 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="gFLIe5oG";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="gFLIe5oG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1111F4292;
	Wed, 30 Oct 2024 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303273; cv=none; b=rZ53NEPJnvKkYiI6/Voz8h2vfjY3DWjAPV+IJJZqDF36PAQVFdUxVMLxCkltZ4gqyUqOlXXpOKWQ0BOcHPhyf+0A8ojgv/M8hWfTo/KmEk9xYuMShaZxEW+ZIubQItET+yfebnd6dht39/uWzGShk0O4jJv4xbSZJWroxojnPqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303273; c=relaxed/simple;
	bh=gLv7I3LQWoNpPdAjKDGzLZtcqN+O5sw62gfGdxNh4Rs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mjOVy8zO9enJHKRcjdtHhuq6g4Fx6KNW4gG0lBYlv+E4UFnhn6d0nNTZGaXlS/9qGHrpV/6z0WdGaMNDhQTmBwtX90CpqDr7QXf0GjebKnWdlZO5/4iJWw/Fc4J618Cid6nLG5qFU0EecZ542cPpeQ8iZH8sTn9s5xHQnbI0Ah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=gFLIe5oG; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=gFLIe5oG; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730303269;
	bh=gLv7I3LQWoNpPdAjKDGzLZtcqN+O5sw62gfGdxNh4Rs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=gFLIe5oGUl4XOWdBvWXxn4yBRHjPVm63LID7tWePrlIGMm2bt86q1ETvL6TvXxpUs
	 AOe6MbaYg2/kKvnXhXKwY04cCHonjtalPjXbgSkJxU2m6bPwXqF6h5zQ6R8UFNXX6m
	 ydEpspES2zdhipTuWdLQvOItZCg+ok4HjzTC9xrQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 870B71281DD4;
	Wed, 30 Oct 2024 11:47:49 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id yTGeH0NvpN3p; Wed, 30 Oct 2024 11:47:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730303269;
	bh=gLv7I3LQWoNpPdAjKDGzLZtcqN+O5sw62gfGdxNh4Rs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=gFLIe5oGUl4XOWdBvWXxn4yBRHjPVm63LID7tWePrlIGMm2bt86q1ETvL6TvXxpUs
	 AOe6MbaYg2/kKvnXhXKwY04cCHonjtalPjXbgSkJxU2m6bPwXqF6h5zQ6R8UFNXX6m
	 ydEpspES2zdhipTuWdLQvOItZCg+ok4HjzTC9xrQ=
Received: from [10.250.250.46] (122x212x32x58.ap122.ftth.ucom.ne.jp [122.212.32.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1865E1281A0B;
	Wed, 30 Oct 2024 11:47:46 -0400 (EDT)
Message-ID: <27e3ac1678bde5e107691e12c09fa470ab47a5b2.camel@HansenPartnership.com>
Subject: Re: [PATCH v8 2/3] tpm: Rollback tpm2_load_null()
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Mimi
 Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Stefan Berger <stefanb@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, "open list:KEYS-TRUSTED"
 <keyrings@vger.kernel.org>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>,  stable@vger.kernel.org
Date: Thu, 31 Oct 2024 00:47:44 +0900
In-Reply-To: <20241028055007.1708971-3-jarkko@kernel.org>
References: <20241028055007.1708971-1-jarkko@kernel.org>
	 <20241028055007.1708971-3-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-10-28 at 07:50 +0200, Jarkko Sakkinen wrote:
[...]
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -915,33 +915,37 @@ static int tpm2_parse_start_auth_session(struct
> tpm2_auth *auth,
>  
>  static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
>  {
> -       int rc;
>         unsigned int offset = 0; /* dummy offset for null seed
> context */
>         u8 name[SHA256_DIGEST_SIZE + 2];
> +       u32 tmp_null_key;
> +       int rc;
>  
>         rc = tpm2_load_context(chip, chip->null_key_context, &offset,
> -                              null_key);
> -       if (rc != -EINVAL)
> -               return rc;
> +                              &tmp_null_key);
> +       if (rc != -EINVAL) {
> +               if (!rc)
> +                       *null_key = tmp_null_key;
> +               goto err;
> +       }
>  
> -       /* an integrity failure may mean the TPM has been reset */
> -       dev_err(&chip->dev, "NULL key integrity failure!\n");
> -       /* check the null name against what we know */
> -       tpm2_create_primary(chip, TPM2_RH_NULL, NULL, name);
> -       if (memcmp(name, chip->null_key_name, sizeof(name)) == 0)
> -               /* name unchanged, assume transient integrity failure
> */
> -               return rc;
> -       /*
> -        * Fatal TPM failure: the NULL seed has actually changed, so
> -        * the TPM must have been illegally reset.  All in-kernel TPM
> -        * operations will fail because the NULL primary can't be
> -        * loaded to salt the sessions, but disable the TPM anyway so
> -        * userspace programmes can't be compromised by it.
> -        */
> -       dev_err(&chip->dev, "NULL name has changed, disabling TPM due
> to interference\n");
> +       /* Try to re-create null key, given the integrity failure: */
> +       rc = tpm2_create_primary(chip, TPM2_RH_NULL, &tmp_null_key,
> name);
> +       if (rc)
> +               goto err;

From a security point of view, this probably isn't such a good idea:
the reason the context load failed above is likely the security
condition we're checking for: the null seed changed because an
interposer did a reset.  That means that if the interposer knows about
this error leg, it would simply error out the create primary here and
the TPM wouldn't be disabled.

Regards,

James


