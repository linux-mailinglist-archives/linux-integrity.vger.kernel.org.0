Return-Path: <linux-integrity+bounces-3129-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED669327FE
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 16:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA191F23597
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 14:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEBE19AD5E;
	Tue, 16 Jul 2024 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JivdGOzi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730D613CA99;
	Tue, 16 Jul 2024 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721138845; cv=none; b=YsNz2Z+bPLvKFV+/fW8VwHQz9r1j2RpK+BBp/2e+llpme6EJSOjqDa1tBljOFhH+uZAcMt/F38Szg5y2HiPzkmrGd83gi8jgAv+yqcdt7ghxO39sFzkt7Ou68LCsIkzq7gXsbYM0AuZQKS6DonyPF8Q2zo7tXQMEReTHiAAPhgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721138845; c=relaxed/simple;
	bh=NhF2AhS4Tzk1W86sNSabjgw4XMNT6kDzqOU2Yeki3vU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=NOVG6BKH8FvMJgqvrK03oBGlOGoNfJanG6YYQv+w5kPg+0fe3ZW6QLhTiaHPGD/p9mweRS5OmUOvlvbNsvqF/YuawR7CZG+aXRRlP8rewWC6TN8FFuf3B5zj79G0A9bFz/LW+Lg8FgYgXHOwO5UkKA298zpRoVO2swKkrAonvgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JivdGOzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2925DC116B1;
	Tue, 16 Jul 2024 14:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721138845;
	bh=NhF2AhS4Tzk1W86sNSabjgw4XMNT6kDzqOU2Yeki3vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JivdGOziDfIs9KFQmjFIfuVviMOKiFspmYHuwIIPQkncRO/2kR64mskK6UaX0h92J
	 9FAnRRsN5DQGzm6nEltZpeaz/bnL1UN7h5vsKa6qk/QRzKpXkIfhiOGNQW7Tp3uHbV
	 m2cM9rj8ZbHwEgNSjBSeAVCp2BsL0YoHdq1V+UBEBO6wP1Dm6gw81mljDtVrLYKBQG
	 gsf9oGkoEaqGop2TTxF8O7YGRSNmdcJpq7KESNEUlutFp8LSA95oBmobx/9nlO1lML
	 yQy8hCHHyWAI0Yhc3ZuW70D2zkdyaD7XG7A4BxqA4HXLSSpoizLefT4Dt1UXCQQKUa
	 SR8JhCvziVVMw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 17:07:22 +0300
Message-Id: <D2R0SSS449F2.1CSVCMJ39S3LB@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>
Subject: Re: [PATCH 2/6] tpm: add policy sessions
X-Mailer: aerc 0.17.0
References: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
 <20240524130459.21510-3-James.Bottomley@HansenPartnership.com>
 <D2QXYCVI47RK.GFOY8SNQHWW2@kernel.org>
In-Reply-To: <D2QXYCVI47RK.GFOY8SNQHWW2@kernel.org>

On Tue Jul 16, 2024 at 2:53 PM EEST, Jarkko Sakkinen wrote:
> > -	u8 name[AUTH_MAX_NAMES][2 + SHA512_DIGEST_SIZE];
> > +	u8 name[AUTH_MAX_NAMES][2 + HASH_MAX_DIGESTSIZE];

Ouch, we definitely do not want 2-dimensional arrays. I missed this in
the hmac review.

Why this is based on count (AUTH_MAX_NAMES) rather than space? Is that
value from the specs?

You could just as well replace name and name_h with a single tpm_buf
instance in "sized" mode and return -E2BIG from the functions that use
it. Right, those don't return anything but void, which should be also
fixed.

BR, Jarkko

