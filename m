Return-Path: <linux-integrity+bounces-9771-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4qaGKkpJJmqaUQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9771-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 06:47:06 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB0C652A24
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 06:47:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IS6uXbf2;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9771-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9771-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C065A3003D0A
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jun 2026 04:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9421D3161BA;
	Mon,  8 Jun 2026 04:47:04 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878CD2771B;
	Mon,  8 Jun 2026 04:47:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780894024; cv=none; b=AtjzLU4onZWAn4la7f+zVbotcTVcEfdyL1XjsbVrschvB3EEgAeyYC//bFJLH6oKSM4wQmFWg4hO5Cf92RvAtPd5k1+v+Q3iVzfLOiI0GtoN/TekkOZ5+i/H7fLh4wilaf4iUCnD7NpezIBjlODUSqmp0p2S+rUMSaFNE8Y0J0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780894024; c=relaxed/simple;
	bh=HzhYmRX2nopKAccHM1GYw7/eum7CLQA7DD37+lke6xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OobJh1b5KS1Ivlj3o7faP6dQrJM2LzYJH5Oso8P0dnfwQZZ0YbFFn+L8Fk2desfqw5++yT/9rCVbWVmyx4C/6isX/vvDIIdx/J3xlmtFXd5Bf59ul1dxtQsFJm6gZhDJikZhIbgdwFDnxSrzFlclAyHhjxVqYToGlodDkkEzn8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS6uXbf2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D703E1F00893;
	Mon,  8 Jun 2026 04:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780894023;
	bh=AiC6IPztEYJ/u86CgpttLslDsUBS7Wl8BsHG5skCcSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IS6uXbf2oJsprQtKgtX7Mkv4xqoLTi9uAQBokpcM8YDBfmVAdwSPBn1qW6bYu6G1o
	 V4SEyxju5kl593oG5Fg8/kHWjrn129nU7rlcuzV1zo1FCDn1h2Rzu8lwGy+ljYOjB3
	 5DKfrcdJT+j5UUUtys7Jk0AbxN4gfTqrD/FQlzLZEEd3LpZytGt4neBwDmJNHeHJGv
	 saR6bQA13dda+ZJVTrmwLaAp+Dc4OGf6P7kQrXffx6Q+Ig8XYMgGqSG8lDCBvCKvgV
	 TnxGPkQtNu/MxVJN0BTAUMIbaG6IRZ1XJ25zg9E2nu54/HbU/X8nDQVoHnjmtBcvPl
	 SKy+299c4THmw==
Date: Mon, 8 Jun 2026 07:46:59 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH next] keys: Replace strcpy(derived_buf, "AUTH_KEY") with
 strscpy(..., HASH_SIZE)
Message-ID: <aiZJQ71se4x4d9Bh@kernel.org>
References: <20260606202633.5018-9-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606202633.5018-9-david.laight.linux@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:keyrings@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:dhowells@redhat.com,m:jmorris@namei.org,m:zohar@linux.ibm.com,m:paul@paul-moore.com,m:serge@hallyn.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9771-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CB0C652A24

On Sat, Jun 06, 2026 at 09:26:03PM +0100, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> derived_buf is guaranteed to be HASH_SIZE - and it is more than enough.
> The strscpy() degenerates into an memcpy() (as did the strcpy()).
> Do the same for the associated "ENC_KEY" copy.
> 
> Removes a possibly unbounded strcpy().
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
> 
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
> 
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
> 
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
> 
> Note that all the changes are only compile tested.
> 
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
> 
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
> 
>  security/keys/encrypted-keys/encrypted.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> index 56b531587a1e..59cb77b237b3 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -343,9 +343,9 @@ static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
>  		return -ENOMEM;
>  
>  	if (key_type)
> -		strcpy(derived_buf, "AUTH_KEY");
> +		strscpy(derived_buf, "AUTH_KEY", HASH_SIZE);
>  	else
> -		strcpy(derived_buf, "ENC_KEY");
> +		strscpy(derived_buf, "ENC_KEY", HASH_SIZE);
>  
>  	memcpy(derived_buf + strlen(derived_buf) + 1, master_key,
>  	       master_keylen);
> -- 
> 2.39.5
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

