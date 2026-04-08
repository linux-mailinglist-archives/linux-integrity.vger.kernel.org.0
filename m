Return-Path: <linux-integrity+bounces-9137-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPNBJJsR1mmxAwgAu9opvQ
	(envelope-from <linux-integrity+bounces-9137-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Apr 2026 10:28:11 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 369DD3B9035
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Apr 2026 10:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49E533006B53
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Apr 2026 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6C93A1698;
	Wed,  8 Apr 2026 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPVZIet2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52F51B983F;
	Wed,  8 Apr 2026 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636821; cv=none; b=JYRX1MrhoXnfEsZSuvYrBXcYlpAar4nG6vi36jyF31xHns6ZDT1eoxRaH6dNwQVX54iqZReTgUM9Z0yEd53CBkeCdYRnw5l+plM3UGPcGQEMrK+0LQqh+5X5ohqkioerMkBUgDWggk6sY5k9SIJkC0JDnjcNmfLAXJBMBRbeVGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636821; c=relaxed/simple;
	bh=CnPXUWZUmD4m56Ii+lL8em+qHWgknOpC8DreUJCxk0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0jdvHYtdTONeHeL3J1v4zVhDraVaV0PzaXwfzQ+5Lk2fo1fGCrZ5tlAvpaUi96wrguQpnHWZ4h8SjOBKIH0M/sXKQOTgjl9A99pRhefs2Aqy7hfBVv8hYlmUp/bxAUQ/M1PFvTL934z64HTH/26nWlC3DRVdqr3jsddEVqX61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPVZIet2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBC5C19424;
	Wed,  8 Apr 2026 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775636821;
	bh=CnPXUWZUmD4m56Ii+lL8em+qHWgknOpC8DreUJCxk0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OPVZIet2qpTcTLo6zAIEy/F+zxBMM6MOd4A9aO9Iy82qbG9aOH5xjv5DWRNGfsyyy
	 6Py29N9Z5tnvaFUPXEWFWtLM7ctTiWIuuw1Hd2M6IaK7uTDm7K36RuT2mRiHw1dOOo
	 WZetN1YEhFSIAIYGJkiXXsO5f8MzqJDcvASrBviUOT/lkxJ+fyz1FBXrIIMMIq6id/
	 KZD0WKmjo1FvsSQe0fe3vtWCIyaeEkTghwRlgULuBxxE74V1JSwQWfF5/rMIGa+YlE
	 TGNB0nVUef1lhvw0LCq3JhZa2z3jtc6Z3+b6n4Gjd70fGrkT5hIP4mPOUPfwfSGPTF
	 zee9+Up4HUd3w==
Date: Wed, 8 Apr 2026 11:26:57 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Nayna Jain <nayna@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	Srish Srinivasan <ssrish@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2] KEYS: trusted: Debugging as a feature
Message-ID: <adYRURAJfNCu0FYB@kernel.org>
References: <20260324110043.67248-1-jarkko@kernel.org>
 <afc489d2-a62f-4604-8e56-219311b46516@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc489d2-a62f-4604-8e56-219311b46516@linux.ibm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9137-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 369DD3B9035
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 10:42:00PM -0400, Nayna Jain wrote:
> 
> On 3/24/26 7:00 AM, Jarkko Sakkinen wrote:
> > TPM_DEBUG, and other similar flags, are a non-standard way to specify a
> > feature in Linux kernel.  Introduce CONFIG_TRUSTED_KEYS_DEBUG for
> > trusted keys, and use it to replace these ad-hoc feature flags.
> > 
> > Given that trusted keys debug dumps can contain sensitive data, harden
> > the feature as follows:
> > 
> > 1. In the Kconfig description postulate that pr_debug() statements must be
> >     used.
> > 2. Use pr_debug() statements in TPM 1.x driver to print the protocol dump.
> > 
> > Traces, when actually needed, can be easily enabled by providing
> > trusted.dyndbg='+p' in the kernel command-line.
> > 
> > Cc: Srish Srinivasan <ssrish@linux.ibm.com>
> > Reported-by: Nayna Jain <nayna@linux.ibm.com>
> > Closes: https://lore.kernel.org/all/7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com/
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v2:
> > - Implement for all trusted keys backends.
> > - Add HAVE_TRUSTED_KEYS_DEBUG as it is a good practice despite full
> >    coverage.
> > ---
> >   include/keys/trusted-type.h               | 18 +++++-------
> >   security/keys/trusted-keys/Kconfig        | 19 ++++++++++++
> >   security/keys/trusted-keys/trusted_caam.c |  4 +--
> >   security/keys/trusted-keys/trusted_tpm1.c | 36 +++++++++++------------
> >   4 files changed, 46 insertions(+), 31 deletions(-)
> > 
> > diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> > index 03527162613f..620a1f890b6b 100644
> > --- a/include/keys/trusted-type.h
> > +++ b/include/keys/trusted-type.h
> > @@ -83,18 +83,16 @@ struct trusted_key_source {
> >   extern struct key_type key_type_trusted;
> > -#define TRUSTED_DEBUG 0
> > -
> > -#if TRUSTED_DEBUG
> > +#ifdef CONFIG_TRUSTED_KEYS_DEBUG
> >   static inline void dump_payload(struct trusted_key_payload *p)
> >   {
> > -	pr_info("key_len %d\n", p->key_len);
> > -	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
> > -		       16, 1, p->key, p->key_len, 0);
> > -	pr_info("bloblen %d\n", p->blob_len);
> > -	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
> > -		       16, 1, p->blob, p->blob_len, 0);
> > -	pr_info("migratable %d\n", p->migratable);
> > +	pr_debug("key_len %d\n", p->key_len);
> > +	print_hex_dump_debug("key ", DUMP_PREFIX_NONE,
> > +			     16, 1, p->key, p->key_len, 0);
> > +	pr_debug("bloblen %d\n", p->blob_len);
> > +	print_hex_dump_debug("blob ", DUMP_PREFIX_NONE,
> > +			     16, 1, p->blob, p->blob_len, 0);
> > +	pr_debug("migratable %d\n", p->migratable);
> >   }
> >   #else
> >   static inline void dump_payload(struct trusted_key_payload *p)
> > diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
> > index 9e00482d886a..2ad9ba0e03f1 100644
> > --- a/security/keys/trusted-keys/Kconfig
> > +++ b/security/keys/trusted-keys/Kconfig
> > @@ -1,10 +1,25 @@
> >   config HAVE_TRUSTED_KEYS
> >   	bool
> > +config HAVE_TRUSTED_KEYS_DEBUG
> > +	bool
> > +
> > +config TRUSTED_KEYS_DEBUG
> > +	bool "Debug trusted keys"
> > +	depends on HAVE_TRUSTED_KEYS_DEBUG
> > +	default n
> > +	help
> > +	  Trusted keys backends and core code that support debug dumps
> > +	  can opt-in that feature here. Dumps must only use DEBUG
> > +	  level output, as sensitive data may pass by. In the
> > +	  kernel-command line traces can be enabled via
> > +	  trusted.dyndbg='+p'.
> 
> Would it be good idea to add an explicit note/warning:
> 
> 
> NOTE: This option is intended for debugging purposes only. Do not enable on
> production systems as debug output may expose sensitive cryptographic
> material.
> If you are unsure, say N.
> 
> Apart from this, looks good to me.
> 
> Reviewed-by: Nayna Jain <nayna@linux.ibm.com>

Thank, I'll add your tag but would you mind quickly screening v3 again
where I add "trusted.debug=0|1". And yes, your suggestion about extra
warning makes sense.

Let's make this safe as possible. Mistakes do happen... and then those
measures pay off :-)

BR, Jarkko

