Return-Path: <linux-integrity+bounces-9601-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJh0Fl0dDGpJWQUAu9opvQ
	(envelope-from <linux-integrity+bounces-9601-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 10:20:45 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A868E579DF2
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 10:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97838305EF2C
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 08:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB793DDDD0;
	Tue, 19 May 2026 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqAYdC/7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BD93DCDAB;
	Tue, 19 May 2026 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178561; cv=none; b=MRDeIYhgkepf0fE/keiwp4ya7hbxgeVCH6zZN7cJT3AtEClkqbOxk5PfnjzaBlw4juLGSLEi+U0BySQEQmw46oa2Ej9dszpcucmFhu0/ZzAWWEqrYfI9qBpkNX83RskDmxo7CVmy3xlPWU/ZMNJ3GsoMoKPwLEv6h7nC23b2h3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178561; c=relaxed/simple;
	bh=nUjCbSp2lxBqQ2F562PYeRY8hxSuCskbyznexMVZPmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMw8wL99xVJxu7jV83CY2Nwd1xsD5FcZCb+DvQn3u587mfocO14z33CrI8K8MXJjwbfsjIHskWBXxoYVc+t4q16FmJ8uzxcev/LpSQUL62Si38dC9zij/vYzEJCr3NNmuzS0vzc9O9WhI6udWDS7UXkc3aD1gyx98kss5PLE96M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqAYdC/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9395AC2BCB3;
	Tue, 19 May 2026 08:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779178561;
	bh=nUjCbSp2lxBqQ2F562PYeRY8hxSuCskbyznexMVZPmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZqAYdC/7TpojR5+AlcCxULStz6GMXY4AuJzK4RL1UEf+Ck106GcvN2Np95/mOSiS+
	 8p3EHzplNnftOjXuUYlCXK1MM4I5RlQHgCq4OD15sp/NLYPMykKgbDCOEJPnsCTXdg
	 /TaQBzh4uBYh031MVs9TsojM3f1KvbMRjT4xgNoyT1u4IFU9k4jh2w8tJv8FDVt43s
	 9HCQwzxI5HFKBJ8SSmh54FKYHpMFfCZzO9LYGRptMFH3n/88GOh4CcbjOfxIkj38g1
	 piACBPdt45Aee9cvO3ltUr6/38KnGxkQ+V+XoEho9Ds+iZqbMeBkttJcl+XycfB2SS
	 sIr6C4/IDip5w==
Date: Tue, 19 May 2026 11:15:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Len Bao <len.bao@gmx.us>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys/trusted_keys: mark 'migratable' as __ro_after_init
Message-ID: <agwcPK0OJIQmm0a1@kernel.org>
References: <20260516152249.41851-1-len.bao@gmx.us>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516152249.41851-1-len.bao@gmx.us>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9601-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.us];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.us:email]
X-Rspamd-Queue-Id: A868E579DF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 16, 2026 at 03:22:47PM +0000, Len Bao wrote:
> The 'migratable' variable is initialized only during the init phase
> in the 'init_trusted' function and never changed. So, mark it as
> __ro_after_init.
> 
> Signed-off-by: Len Bao <len.bao@gmx.us>
> ---
>  security/keys/trusted-keys/trusted_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index 0b142d941..433579365 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -59,7 +59,7 @@ DEFINE_STATIC_CALL_NULL(trusted_key_unseal,
>  DEFINE_STATIC_CALL_NULL(trusted_key_get_random,
>  			*trusted_key_sources[0].ops->get_random);
>  static void (*trusted_key_exit)(void);
> -static unsigned char migratable;
> +static unsigned char migratable __ro_after_init;
>  
>  enum {
>  	Opt_err,
> -- 
> 2.43.0
> 

Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

