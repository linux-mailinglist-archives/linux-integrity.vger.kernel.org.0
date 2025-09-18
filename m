Return-Path: <linux-integrity+bounces-7176-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93E3B86985
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 20:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707261C864CF
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 18:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B362D3220;
	Thu, 18 Sep 2025 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="q4ZxZa03"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19603C465;
	Thu, 18 Sep 2025 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221839; cv=none; b=G9SbmFJEvI94Vu0JAU37l7yrBgt4TJwwcmoCZG80dcyPtL9gVlzIwwI+JdShnHgABQ6RKESTfh+LNjmzQYhBgBhL3eLFomA/g4hVypr5OILubaNzscrGamk6vGGydncKa4ByYdplLUdrzKmg6YMMSjbpEzZE5hYxFvPtLtIjpgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221839; c=relaxed/simple;
	bh=n3lbOBSHHN6qjgd0ZGik8Gxu1EjlZkYg8FEfJYQxmjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAQ3VI3Rz67TZNkXY0i1fzzKS7MFyhmGqZAgD675W/J8vdwrDj2/kjjDxSulwUqVTSrq+mkirXWTcQkp6zEUkvpb4iLH14O/KXeBX2EI30hQcDvuajQqobCeXBiwA0Rzp5oZjqShXoFabmK94xwPMgtQrYjJ1L6wi+Yt+fAiE+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=q4ZxZa03; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Dq+1iSG82r9yQIVHmumBoetFqjeDWLapJ2V4N8waYYE=; b=q4ZxZa03qHI68xQGdp1+HoucWC
	A6UKcRRoF7upoBx+/JQDcOnmpTpM+Gei1qTcmgUadALtWTjpfnhzEAzVt/x7MW/pYZLd14Aq1LvrW
	N0aDiWpJ0VKi8lOSIwAq4ngUjO1vknuFPaaCNjj6b86XUj1Pv7vaGObohPsiS1Xo+PlqNhCKtAemf
	RvZcobPmZv6pLKkD8DB0nZmNXQDeMj5+YmQB13tVTxPaU4nmzrjcjOfH8LKguncAqW6GoDEpdjNkP
	1/CCJsWoIb8Dvk7Nwdj1cpdAijA7x2xeZLqKwZRQW+ThWmXa1aAs46Y60v2xEpJ/E/a1aVVEExdWR
	GDrxP/0Q==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1uzJoL-00Fya0-13;
	Thu, 18 Sep 2025 19:56:53 +0100
Date: Thu, 18 Sep 2025 19:56:53 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, stable@vger.kernel.or,
	Chris Fenner <cfenn@google.com>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: Disable TPM2_TCG_HMAC by default
Message-ID: <aMxV9fB0E72QQY2G@earth.li>
References: <20250825203223.629515-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250825203223.629515-1-jarkko@kernel.org>

On Mon, Aug 25, 2025 at 11:32:23PM +0300, Jarkko Sakkinen wrote:
>After reading all the feedback, right now disabling the TPM2_TCG_HMAC
>is the right call.
>
>Other views discussed:
>
>A. Having a kernel command-line parameter or refining the feature
>   otherwise. This goes to the area of improvements.  E.g., one
>   example is my own idea where the null key specific code would be
>   replaced with a persistent handle parameter (which can be
>   *unambigously* defined as part of attestation process when
>   done correctly).
>
>B. Removing the code. I don't buy this because that is same as saying
>   that HMAC encryption cannot work at all (if really nitpicking) in
>   any form. Also I disagree on the view that the feature could not
>   be refined to something more reasoable.
>
>Also, both A and B are worst options in terms of backporting.
>
>Thus, this is the best possible choice.

I think this is reasonable; it's adding runtime overhead and not adding 
enough benefit to be the default upstream.

Reviewed-By: Jonathan McDowell <noodles@earth.li>

>Cc: stable@vger.kernel.or # v6.10+
>Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
>Suggested-by: Chris Fenner <cfenn@google.com>
>Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>---
>PS. I did not post this last week because that would have been most
>likely the most counter-productive action to taken. It's better
>sometimes to take a bit of time to think (which can be seen that
>I've given also more reasonable weight to my own eaerlier
>proposals).
>
>I also accept further changes, if there is e.g., inconsistency
>with TCG_TPM_HMAC setting or similar (obviously).
>---
> drivers/char/tpm/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
>index dddd702b2454..3e4684f6b4af 100644
>--- a/drivers/char/tpm/Kconfig
>+++ b/drivers/char/tpm/Kconfig
>@@ -29,7 +29,7 @@ if TCG_TPM
>
> config TCG_TPM2_HMAC
> 	bool "Use HMAC and encrypted transactions on the TPM bus"
>-	default X86_64
>+	default n
> 	select CRYPTO_ECDH
> 	select CRYPTO_LIB_AESCFB
> 	select CRYPTO_LIB_SHA256
>-- 
>2.39.5

J.

-- 
] https://www.earth.li/~noodles/ []  Is this real - that's the first   [
]  PGP/GPG Key @ the.earth.li    []    thing I think every morning.    [
] via keyserver, web or email.   []                                    [
] RSA: 4096/0x94FA372B2DA8B985   []                                    [

