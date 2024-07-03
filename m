Return-Path: <linux-integrity+bounces-2985-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EADE9266F0
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 19:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFBB1C21A35
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0720D1836C2;
	Wed,  3 Jul 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSW8ZgOK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7518C05;
	Wed,  3 Jul 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027168; cv=none; b=UyLvG7fnFAQQJEst2DNRK0BNqLuJ583b/I5/4cD7ApAvIR5YN3sZlWdlOuBIh6XMaG8FvgtpJBoD5c3dp8XVM9DanzWnpeWOLaO55kwVnvRrpvu+Kb057gs6Iep6WTU7lIl54rNimoJhcIFQf1KuYJDYHfdNkhd+sjOUo10xSVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027168; c=relaxed/simple;
	bh=o8bRY5T5C6boQ2KouICg/cTizZ7ZWeyIRo5f1hrciYI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eYg3oVlAtgtWs0Wg+CGn8megVPgE9lyzneVkL7BPRVIoThqmxTgtjbeommGnUcAVhnSuDnL+3+ZwndXdDJ3pEfohVUZqMDqYE+rbQlV12zuSk56bb6/e1jbcbe20xvSSthSre77FyltOFCJfQcT+F/NLh1IcutBg4U+2oW/Ql+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSW8ZgOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D836C2BD10;
	Wed,  3 Jul 2024 17:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720027168;
	bh=o8bRY5T5C6boQ2KouICg/cTizZ7ZWeyIRo5f1hrciYI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=RSW8ZgOKuNP3kUjxdp16wHyDbj3SyvB8+j0FBKpGHDNqZMU7zWW5bvsaYO/j8jl9s
	 0wZz/MyAn2hUekHv8BjlRrjTxucPiSI9KLfwMkqcHldYCLVO/lAddTDItuJV3Ink3T
	 tLlfAbfxZNpQoH/1a8WffAps1xTv8jutc7GQMIJk36BSVpwWWrOmhy9rJjg6XKCbQG
	 UbgBQ+nI+2Kp4WKSP5/EuU5396Hi89dg4c+MKf+bOGTg0NvtqFr4xr6yDONARsVQge
	 vDvtxQO3cizPHV0eZo9m5PeDrwTGUgpUaVTOIXqYc052E1k/ErVL3SMavk1UC0qjZ2
	 TBgN6pOQIODCg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jul 2024 20:19:24 +0300
Message-Id: <D2G2QR0DMG8B.R0B95Z5T5YAF@kernel.org>
Cc: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] Address !chip->auth
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240703170815.1494625-1-jarkko@kernel.org>
In-Reply-To: <20240703170815.1494625-1-jarkko@kernel.org>

On Wed Jul 3, 2024 at 8:08 PM EEST, Jarkko Sakkinen wrote:
> Tested on x86-64 with:
>
> - TCG_TPM2_HMAC disabled.
> - TCG_TPM2_HMAC enabled.
> - TCG_TPM2_HMAC enabled, and "/* rc =3D tpm2_sessions_init(chip); */".
>
> Jarkko Sakkinen (3):
>   tpm: Address !chip->auth in tpm2_*_auth_session()
>   tpm: Address !chip->auth in tpm_buf_append_name()
>   tpm: Address !chip->auth in tpm_buf_append_hmac_session*()
>
>  drivers/char/tpm/Makefile        |   2 +-
>  drivers/char/tpm/tpm2-sessions.c | 400 +++++++++++++++++--------------
>  include/linux/tpm.h              |  75 ++----
>  3 files changed, 245 insertions(+), 232 deletions(-)

Aiming these still to 6.10 so that there would not be known regressions
in hmac authenticated sessions. Note that issue is wider than "just"
tpm_ibmvtpm.

BR, Jarkko

