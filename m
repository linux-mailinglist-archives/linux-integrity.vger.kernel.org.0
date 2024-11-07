Return-Path: <linux-integrity+bounces-4063-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A369C080C
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 14:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06AD1F22924
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227BB2076A5;
	Thu,  7 Nov 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrocHux1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84952114;
	Thu,  7 Nov 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987433; cv=none; b=mXeICyvdBPu/ccWsN6l0HVlMlQ31bGdVqb9DP7Vgl4qRA7X0bU+PHp2o2GP2eftU0Lxh+EDgUF9LZWyMwkFiLS984mog/hmC03O73Z7tJ7f3QJG6b3jsq231db5X21F4ui5Oo5eCQg2iOh7eFrZi8iac32+f3aAdSAUQRPAZ1Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987433; c=relaxed/simple;
	bh=2oNyuRYFX7LMeihmTBqPHzHGKYUDIV+hO1bH84GomYw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=n8c7/Ho6t/PD3e54Y/54+DLUIDTskLlM+MQen0RvdEZzuhSrXwIbH479YWDkIMy13UuEwTdaty1teFHbORsiF14cwShj7HndQcMaDZkEywU8Gtzq2AYUz/t4wNGS+R0hG+ZcBtT+J8pYQSpHy2ZqKUj6iKijy7LsTO7aiunV30U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrocHux1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC81C4CECC;
	Thu,  7 Nov 2024 13:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730987432;
	bh=2oNyuRYFX7LMeihmTBqPHzHGKYUDIV+hO1bH84GomYw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=GrocHux10lvM2z8Ibettax4mHigWpqCKo8UiQ8k0QcXGxP7RRmvvBjfkQgAjBt0A5
	 NNon2SkyRrNbMZSEGc0mWLkrduppmCHMnn5FZ118t3MDGiFWue1Cal4sxAx+R/U6Pc
	 KbO0cyMRmJukuTwFbvAoc2QDr5/m3dXGDpnQI7Hs9NbzzFfvvfXcb1ZNhZ3rnW/O2s
	 VeJiZElICy94k6yKMZDQO7E5U1P0osUIW4SfxJ1COIZptIrkB8cfhePaNY/463Szd9
	 RLS2U7Udcuo3ZsS9c6ckWBQ7BENPtNH9+81PLx8wZxPvlaXD52t/ds/EMfGKJWHk4T
	 lbqpvsKzAIbUQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 15:50:28 +0200
Message-Id: <D5FZTYOGY3IO.4SKIAS11102D@kernel.org>
Cc: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "open list" <linux-kernel@vger.kernel.org>,
 "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>, "open list:SECURITY
 SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: Remove the documentation from tpm2-sessions.c
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>,
 <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.18.2
References: <20241107112023.5731-1-jarkko@kernel.org>
In-Reply-To: <20241107112023.5731-1-jarkko@kernel.org>

On Thu Nov 7, 2024 at 1:20 PM EET, Jarkko Sakkinen wrote:
> Nobody will maintain this, i.e. it is destined to rotten. It is better to
> just rip it off, and not have duplicate stuff that is already in the kern=
el
> documentation and function headers.
>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm2-sessions.c | 68 ++------------------------------
>  1 file changed, 3 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-ses=
sions.c
> index a7c1b162251b..ff00e9483564 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -1,71 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
>  /*
> - * Copyright (C) 2018 James.Bottomley@HansenPartnership.com
> - *
> - * Cryptographic helper routines for handling TPM2 sessions for
> - * authorization HMAC and request response encryption.
> - *
> - * The idea is to ensure that every TPM command is HMAC protected by a
> - * session, meaning in-flight tampering would be detected and in
> - * addition all sensitive inputs and responses should be encrypted.
> - *
> - * The basic way this works is to use a TPM feature called salted
> - * sessions where a random secret used in session construction is
> - * encrypted to the public part of a known TPM key.  The problem is we
> - * have no known keys, so initially a primary Elliptic Curve key is
> - * derived from the NULL seed (we use EC because most TPMs generate
> - * these keys much faster than RSA ones).  The curve used is NIST_P256
> - * because that's now mandated to be present in 'TCG TPM v2.0
> - * Provisioning Guidance'
> - *
> - * Threat problems: the initial TPM2_CreatePrimary is not (and cannot
> - * be) session protected, so a clever Man in the Middle could return a
> - * public key they control to this command and from there intercept
> - * and decode all subsequent session based transactions.  The kernel
> - * cannot mitigate this threat but, after boot, userspace can get
> - * proof this has not happened by asking the TPM to certify the NULL
> - * key.  This certification would chain back to the TPM Endorsement
> - * Certificate and prove the NULL seed primary had not been tampered
> - * with and thus all sessions must have been cryptographically secure.
> - * To assist with this, the initial NULL seed public key name is made
> - * available in a sysfs file.
> - *
> - * Use of these functions:
> - *
> - * The design is all the crypto, hash and hmac gunk is confined in this
> - * file and never needs to be seen even by the kernel internal user.  To
> - * the user there's an init function tpm2_sessions_init() that needs to
> - * be called once per TPM which generates the NULL seed primary key.
> - *
> - * These are the usage functions:
> + * Copyright (c) 2018 James Bottomley <James.Bottomley@HansenPartnership=
.com>
>   *
> - * tpm2_start_auth_session() which allocates the opaque auth structure
> - *	and gets a session from the TPM.  This must be called before
> - *	any of the following functions.  The session is protected by a
> - *	session_key which is derived from a random salt value
> - *	encrypted to the NULL seed.
> - * tpm2_end_auth_session() kills the session and frees the resources.
> - *	Under normal operation this function is done by
> - *	tpm_buf_check_hmac_response(), so this is only to be used on
> - *	error legs where the latter is not executed.
> - * tpm_buf_append_name() to add a handle to the buffer.  This must be
> - *	used in place of the usual tpm_buf_append_u32() for adding
> - *	handles because handles have to be processed specially when
> - *	calculating the HMAC.  In particular, for NV, volatile and
> - *	permanent objects you now need to provide the name.
> - * tpm_buf_append_hmac_session() which appends the hmac session to the
> - *	buf in the same way tpm_buf_append_auth does().
> - * tpm_buf_fill_hmac_session() This calculates the correct hash and
> - *	places it in the buffer.  It must be called after the complete
> - *	command buffer is finalized so it can fill in the correct HMAC
> - *	based on the parameters.
> - * tpm_buf_check_hmac_response() which checks the session response in
> - *	the buffer and calculates what it should be.  If there's a
> - *	mismatch it will log a warning and return an error.  If
> - *	tpm_buf_append_hmac_session() did not specify
> - *	TPM_SA_CONTINUE_SESSION then the session will be closed (if it
> - *	hasn't been consumed) and the auth structure freed.
> + * Cryptographic helper routines for handling TPM2 sessions for authoriz=
ation
> + * HMAC and request response encryption.
>   */
> =20
>  #include "tpm.h"

So no means to slander this. I just checked the kdoc's and also
documentation and they have all the content needed. So it is better
to focus to maintaining those and not have duplicate copies.

If there is a detail here missing from those I'd advice to contribute
that but I could not spot anything...

BR, Jarkko

