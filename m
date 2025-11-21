Return-Path: <linux-integrity+bounces-7661-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2573FC7B9EA
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 21:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0903362673
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 20:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F1427FD7D;
	Fri, 21 Nov 2025 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7tQnAgA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8858923ABA1;
	Fri, 21 Nov 2025 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763755837; cv=none; b=aFbauRluZ0BXin3vYKux4T1rN0f05rcFcW1I8uT27wd6aMS6eGXY//WGDEN7CfXorlRxdnsJQii3WnPnLkD7a9VRQi3slsI/96BpdU/clbmP69w0iU/It0gU1rHxtpkNAieiirxTI/xqrBOlA+AfgJ/EuMGLagGYFAnREVgNq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763755837; c=relaxed/simple;
	bh=bi5gOBnMp9lCWlfLvzLC3aQnkpo+i7fsjzxBk/+4wRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSw8ArigHcRzeaSws2wqwotw4RXdqCB4vsnaeYqoEi6k49WnVqUL/yXnW2lYHsqM2w99/E4TQcj83+1o6VJkRr/S1Njc20RJ84wwOaZGteb75AILZszp4HGVOV5wwUHYLFz/lYUA/qhUoPzBdHIDoJvyEmjMitQ4NqOSCP2zMWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7tQnAgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ED4C4CEF1;
	Fri, 21 Nov 2025 20:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763755837;
	bh=bi5gOBnMp9lCWlfLvzLC3aQnkpo+i7fsjzxBk/+4wRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G7tQnAgAGPLymxjLyM5VGr9XBqsvTb0t5X3Yox2HSLBUV8Qw4dtZPxeBTH41XA9sD
	 MhGeF0d2ME/hap5ENDRmeux4yFQGuOlN4pQsQNINpTM7Kn00aYqnI4+0wYTrwg8zYi
	 v3O6xJgqkGpk9OZVAOFbX4+dXFBw2hf0Ne/4AsqeCxUT4dRiBvQm5fdyeHLA2ax9L1
	 mJpuvxRhoMh7TW6mkbH1s4YZ6oB3OgRapYOzbPnhvkJkRoAb+OWC0mVkcIZe390s94
	 1DgX9rxY6Rl0bFgZYEuYMMnX1yAtGTelTnRaBewyVEv4hAVtGW+7meKXCsaP84K2y1
	 JuU4u/lWgX8vg==
Date: Fri, 21 Nov 2025 22:10:33 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: Use pr_fmt()
Message-ID: <aSDHOfdaoBJgNqFN@kernel.org>
References: <20251113123544.11287-2-thorsten.blum@linux.dev>
 <aR0v9mLOKJsr_0Zm@kernel.org>
 <83C83079-0354-4642-A980-DBC7AE572A53@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83C83079-0354-4642-A980-DBC7AE572A53@linux.dev>

On Wed, Nov 19, 2025 at 03:45:02PM +0100, Thorsten Blum wrote:
> On 19. Nov 2025, at 03:48, Jarkko Sakkinen wrote:
> > On Thu, Nov 13, 2025 at 01:35:44PM +0100, Thorsten Blum wrote:
> >> Use pr_fmt() to automatically prefix all pr_<level>() log messages with
> > 
> > This fails to describe what "use" means.
> 
> I don't understand what you mean. What's wrong with "use ... to ..."?

I think e.g., "Rewrite the definition of ..." describes better what
you're doing.

> 
> >> "encrypted_key: " and remove all manually added prefixes.
> >> 
> >> Reformat the code accordingly and avoid line breaks in log messages.
> >> 
> >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> >> ---
> >> security/keys/encrypted-keys/encrypted.c | 74 +++++++++++-------------
> >> security/keys/encrypted-keys/encrypted.h |  2 +-
> >> 2 files changed, 35 insertions(+), 41 deletions(-)
> >> 
> >> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> >> index 513c09e2b01c..a8e8bf949b4b 100644
> >> --- a/security/keys/encrypted-keys/encrypted.c
> >> +++ b/security/keys/encrypted-keys/encrypted.c
> >> @@ -11,6 +11,8 @@
> >>  * See Documentation/security/keys/trusted-encrypted.rst
> >>  */
> >> 
> > 
> > Should have undef prepending.
> 
> Why is this necessary when the #define is at the top of a source file?
> The kernel documentation [1] doesn't mention this anywhere. Isn't #undef
> only needed when redefining 'pr_fmt' in the middle of a file to avoid a
> compiler warning/error?
> 
> >> +#define pr_fmt(fmt) "encrypted_key: " fmt
> >> +
> >> [...]
> 
> Thanks,
> Thorsten
> 
> [1] https://docs.kernel.org/core-api/printk-basics.html
> 

BR, Jarkko

