Return-Path: <linux-integrity+bounces-9192-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HZqCOL73mnqNAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9192-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 04:45:54 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F433FFD23
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 04:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5D21302677D
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 02:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C998427E049;
	Wed, 15 Apr 2026 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHvwlvgs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A651823D7DF;
	Wed, 15 Apr 2026 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776221058; cv=none; b=pBMdOSzdxT7gQFV9+HWsRy52CQX3Nxgo2pckl8AJW4iQ5xMyABbvGPO3LxpBf9PG9fYMpLUZAhOm//V1tHEVbSulF/WTvohcAkL0/fO/u+7uqbHxcdCNbky7vnfGAacGHvJgiN1voMRH7GIAZh+QWhN566PFbZ2cBvieCcmE3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776221058; c=relaxed/simple;
	bh=LCxdmvv/5bYHf0cCYe/ogZ3si/GlHCL+nksBOIxuhuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFTRlCQPl7/4Rn7aN5KP9hiOOG2ZFsFm66veBOTyBeNyxEGTys3EBrRhFmVhFpa8Z4WxpOEFstZzOkPg+pF4TQ3YOd8+U3sK1exKh3EwVSnBDgTwmNQH3s0DENEyhz5/q8fd/zhrv1tLD6ZifJVs9ES9LigMUD+qbsatb+47TVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHvwlvgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D31C2BCB3;
	Wed, 15 Apr 2026 02:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776221058;
	bh=LCxdmvv/5bYHf0cCYe/ogZ3si/GlHCL+nksBOIxuhuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHvwlvgsKnLICoQjTAPxuoIR52CuPmPpaeMcnvT9IVLrP5nMuF9lJPMhuLrQy5Y89
	 ejuPFb/iEHWSrte9EwP/6sU6uO+knwWFHqy8E+r8dI1x2AcJeCfqMt/keFSIAMgpu9
	 eXGdoKT+t1LBxtxqrhi9Q9GfgZJgJsVaSVc4QFX1OD+Uj8nesqFm93PJLSNmE2y6r3
	 Ob3L4G2a10jLzWOjqAS+8jdb95hVNX9KetOlOn9CTJMs5mbaG9Usz5NsoQA6YtmiPI
	 FieKNxez+NefGA7uvN/FtqBGp0Zw+5+m+jWfQgrGxljsaXjjxB/XaG0q0UMX33FflR
	 ZGRR2HfCoy1WQ==
Date: Wed, 15 Apr 2026 05:44:14 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Marco Felsch <m.felsch@pengutronix.de>, Josh Snyder <josh@code406.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	David Gstir <david@sigma-star.at>,
	sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	Srish Srinivasan <ssrish@linux.ibm.com>,
	Nayna Jain <nayna@linux.ibm.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trusted-keys: move pr_fmt out of trusted-type.h
Message-ID: <ad77fmcpBpz4sc91@kernel.org>
References: <20260411-trusted-key-header-v1-1-407c2cd954db@code406.com>
 <cie3zqy5phlopdrxsxpniujwr6i3cpdkfrwjvth3a7ypwjx3ee@hqjl67jnfdch>
 <20e9f021-f6b3-4e19-9e1b-93b1e00eb803@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20e9f021-f6b3-4e19-9e1b-93b1e00eb803@pengutronix.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9192-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity,dcp];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77F433FFD23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 01:03:30PM +0200, Ahmad Fatoum wrote:
> Hi,
> 
> On 4/13/26 1:01 PM, Marco Felsch wrote:
> > Hi Josh,
> > 
> > On 26-04-11, Josh Snyder wrote:
> >> Defining pr_fmt in a widely-included header leaks the "trusted_key: "
> >> prefix into every translation unit that transitively includes
> >> <keys/trusted-type.h>. dm-crypt, for example, ends up printing
> >>
> >>     trusted_key: device-mapper: crypt: dm-10: INTEGRITY AEAD ERROR ...
> >>
> >> dm-crypt began including <keys/trusted-type.h> in commit 363880c4eb36
> >> ("dm crypt: support using trusted keys"), which predates the pr_fmt
> >> addition, so the regression has been live from the moment the header
> >> gained its own pr_fmt definition.
> >>
> >> Move the pr_fmt definition into the trusted-keys source files that
> >> actually want the prefix.
> >>
> >> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> >> Assisted-by: Claude:claude-opus-4-6
> >> Signed-off-by: Josh Snyder <josh@code406.com>
> >> ---
> >>  include/keys/trusted-type.h               | 6 ------
> >>  security/keys/trusted-keys/trusted_caam.c | 2 ++
> >>  security/keys/trusted-keys/trusted_core.c | 2 ++
> >>  security/keys/trusted-keys/trusted_dcp.c  | 2 ++
> >>  security/keys/trusted-keys/trusted_pkwm.c | 2 ++
> >>  security/keys/trusted-keys/trusted_tpm1.c | 2 ++
> >>  security/keys/trusted-keys/trusted_tpm2.c | 2 ++
> >>  7 files changed, 12 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> >> index 03527162613f7..54da1f174aeab 100644
> >> --- a/include/keys/trusted-type.h
> >> +++ b/include/keys/trusted-type.h
> >> @@ -11,12 +11,6 @@
> >>  #include <linux/rcupdate.h>
> >>  #include <linux/tpm.h>
> >>  
> >> -#ifdef pr_fmt
> >> -#undef pr_fmt
> >> -#endif
> >> -
> >> -#define pr_fmt(fmt) "trusted_key: " fmt
> >> -
> >>  #define MIN_KEY_SIZE			32
> >>  #define MAX_KEY_SIZE			128
> >>  #if IS_ENABLED(CONFIG_TRUSTED_KEYS_PKWM)
> >> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
> >> index 601943ce0d60f..a31fd89c0e5c5 100644
> >> --- a/security/keys/trusted-keys/trusted_caam.c
> >> +++ b/security/keys/trusted-keys/trusted_caam.c
> >> @@ -4,6 +4,8 @@
> >>   * Copyright 2025 NXP
> >>   */
> >>  
> >> +#define pr_fmt(fmt) "trusted_key: " fmt
> > 
> > Can we adapt this patch further to include the trusted-key type as well?
> > E.g. 'trusted_key-caam'.
> 
> Agreed, if we move it into the individual files, we can use the occasion
> to make it a bit more descriptive.
> 
> I would suggest "trusted_key: caam: ", so the prefix stays the same.
> 
> Cheers,
> Ahmad

+1

BR, Jarkko

