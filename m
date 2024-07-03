Return-Path: <linux-integrity+bounces-2986-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61327926708
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 19:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD4E9B22BFB
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 17:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C3A1849CF;
	Wed,  3 Jul 2024 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmdtdkn8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2062C17A920;
	Wed,  3 Jul 2024 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027470; cv=none; b=k1TjQoFAL9hIpdrrcP9O8uvDfPZtp3LcstsHx14fDGBKJRylZZ2dvTGGw70aIpA7FlEYCKGOKcGur5wPL3iGvaLnens+011MnIqww8qQcMi3bSiKso0Cz+gwKF36+Gt9h16oi2etswiSUJhA4rWFMFEZh7AgrB4pNMa2pQggoIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027470; c=relaxed/simple;
	bh=iuBZisjNdWYlQ9wx+QgfvIlstiZiWQefpRZWHhmW+I0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=G/KLIQocIMNlJvBVIzu70fDYztFkGwU+xsDdWE35yfuMZzdatqM4BLNV4nKaJU3z6waO7HFZsf+abFFJc8FYGXz7s+sbUCTCaVY/AepoTd/4uQKkykKZwt4R4+40w/fhRskYIu1eDOfKZiC9X16snUmpB5QYva/LxxqjaTFjt/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmdtdkn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1850FC2BD10;
	Wed,  3 Jul 2024 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720027470;
	bh=iuBZisjNdWYlQ9wx+QgfvIlstiZiWQefpRZWHhmW+I0=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=nmdtdkn8mOlr1tXHqHfwLxD4nyX69ommK2D2v59ifgA7Pm/dJRbeLpruVEYUDoJY+
	 SwLkqmjNcSkRvY+b/Mytpp22d3V+glQwtk2joScw5ErXgG5PmWqBWOKvJ9Yu1tUg8G
	 z2WkY0UG2hvgJXlC4Aw0vZh1N0TzTDsXygoTV382+/kkLMNV533GnbyC4gw2UMfME/
	 wKWT/QSslqX+qEdFIGtWzdQRYD6N3MjuBvVjWxGlxP7ikh0fXFjypD3I8nPt5pCy92
	 iqaHOrVMjYI+rxOij/QFRS6yfCTGbYc8CbW+ijD/YoRqlq+02aq2C303wP6NZD5Icx
	 nqmkI0JjvSeRg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jul 2024 20:24:25 +0300
Message-Id: <D2G2UL8ED69K.2CY96NBKMJPWD@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>
Cc: <stable@vger.kernel.org>, "Stefan Berger" <stefanb@linux.ibm.com>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, <linux-kernel@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: Limit TCG_TPM2_HMAC to known good drivers
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240703003033.19057-1-jarkko@kernel.org>
 <D2FHYVV7GNCV.3G1XOEUI3LZFB@kernel.org>
In-Reply-To: <D2FHYVV7GNCV.3G1XOEUI3LZFB@kernel.org>

On Wed Jul 3, 2024 at 4:02 AM EEST, Jarkko Sakkinen wrote:
> On Wed Jul 3, 2024 at 3:30 AM EEST, Jarkko Sakkinen wrote:
> > +	depends on TCG_CRB || TCG_TIS_CORE
>
> Needs to be "depends on !TCG_IBMVTPM":
>
> https://lore.kernel.org/linux-integrity/D2FHWYEXITS4.1GNXEB8V6KJM7@kernel=
.org/

This ended up such a mess to fix with any fast path so I made a
proper fix for the core issue in the hmac authentication patch
set:

https://lore.kernel.org/linux-integrity/20240703170815.1494625-1-jarkko@ker=
nel.org/

The problem is that tpm_crb and tpm_tis_core are the *only*
drivers, which call tpm_chip_bootstrap() so it is better not to
take any possible risks with this. I'm still aiming to get these
fixes into 6.10.

BR, Jarkko

