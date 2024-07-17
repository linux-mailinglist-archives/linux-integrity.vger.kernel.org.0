Return-Path: <linux-integrity+bounces-3154-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE16933B28
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 12:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3F71F21BAD
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 10:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6999114036F;
	Wed, 17 Jul 2024 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnvoZFM4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A2D51A;
	Wed, 17 Jul 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212367; cv=none; b=DklQpt5m6qCLc6fb2H4P/8WBQ83c1pMM5ZAuc69XVWjnMqnzOsiKid8AsOQiKnGREjRcA/3oztkLO4K3UHKuoJjsrETFcBw1FVyAF/qXjYZgDtyg9+CUUn6NC8g1PRkjYJRvxZrgVADecJ5BpCiQ88K9938cmBl3XExOa6FPido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212367; c=relaxed/simple;
	bh=ksbpgJlPcu4WkNOsPOZmmLrwJX2KGiijIO4g8CrEULI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=qezSirbyZANmm5l8f9Ufu/pW1FVka3FpVWp274x9ym1m/YSdM5EtC7GGTrmswn3lLROP4UTieReV2OKeXGq1VF9XzU5sYiGJA0ykCOx+5qV68tQ6PmLxNJGVfhxPrNM2AIB122WnfkSo5bhocZeO770TIXp8bOr67gisX+LXwUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnvoZFM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF486C32782;
	Wed, 17 Jul 2024 10:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721212366;
	bh=ksbpgJlPcu4WkNOsPOZmmLrwJX2KGiijIO4g8CrEULI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=HnvoZFM48vLviVoTBsf487LngTeLEHKAuAqfUg1FdFlKjvhKSaa0a4zlDvLGi+7FG
	 7tBF5lV8lAeXBpo9a92KgApJtVibz2fo1lAaWg8yfIsIBGT8fDDzbok//UGPNC1p7f
	 tNfTN6wcUrT7qhJoGOJTOXTPo4Gr0MjG3GF7UrObnqM3yyCoEypj+XNL9cUj8BOLmz
	 WZ4/eEgxghNNAxrpiVQY56qT59fyK/ulXp6VTPlqGQ73cjYMGIggQtvgzKEXoxKqwW
	 JFykTERYcTUBQb6xQCUxJ7weIzC7XS+0yDTuFGjHoLIfI53KSPeN7znCDzf6xwedVR
	 AOBQN4uhZYDcA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jul 2024 13:32:42 +0300
Message-Id: <D2RQUZCAHOJY.1KTAFTZ818GJ6@kernel.org>
Subject: Re: [PATCH 2/2] KEYS: trusted: dcp: fix leak of blob encryption key
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Gstir" <david@sigma-star.at>, "sigma star Kernel Team"
 <upstream+dcp@sigma-star.at>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "David Oberhollenzer"
 <david.oberhollenzer@sigma-star.at>, "Richard Weinberger" <richard@nod.at>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240703125353.46115-1-david@sigma-star.at>
 <20240703125353.46115-2-david@sigma-star.at>
In-Reply-To: <20240703125353.46115-2-david@sigma-star.at>

On Wed Jul 3, 2024 at 3:53 PM EEST, David Gstir wrote:
> Trusted keys unseal the key blob on load, but keep the sealed payload in
> the blob field so that every subsequent read (export) will simply
> convert this field to hex and send it to userspace.
>
> With DCP-based trusted keys, we decrypt the blob encryption key (BEK)
> in the Kernel due hardware limitations and then decrypt the blob payload.
> BEK decryption is done in-place which means that the trusted key blob
> field is modified and it consequently holds the BEK in plain text.
> Every subsequent read of that key thus send the plain text BEK instead
> of the encrypted BEK to userspace.
>
> This issue only occurs when importing a trusted DCP-based key and
> then exporting it again. This should rarely happen as the common use case=
s
> are to either create a new trusted key and export it, or import a key
> blob and then just use it without exporting it again.
>
> Fix this by performing BEK decryption and encryption in a dedicated
> buffer. Further always wipe the plain text BEK buffer to prevent leaking
> the key via uninitialized memory.
>
> Signed-off-by: David Gstir <david@sigma-star.at>
> Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted key=
s")

Similar comments, fixes before sob etc and CC to stable with "# v6.10+"

BR, Jarkko

