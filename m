Return-Path: <linux-integrity+bounces-9184-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMjdD3TW3mnwIwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9184-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 02:06:12 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C428B3FF36C
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 02:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7EE03093993
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 00:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4AA3FCC;
	Wed, 15 Apr 2026 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXbK/YgN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE38D10785;
	Wed, 15 Apr 2026 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776211527; cv=none; b=oNcqFGEJdYxRVuxJbpz5UxUw8oWxCCtzo4EmtVY9+5IW6OTEB7FwKk56IiD0UhpUbeGzDdXXA5MqPqiFE5jpwEtTjqhba2LEAdsSNlhCy1d9E92o/XZlML3UbIQfQ8TLBay6Kr5HF518KARLX175q/yi2rk9yBZkTRHM/91sO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776211527; c=relaxed/simple;
	bh=PSrSRwRn4MKa54/IrG32UGFRrDBkQctp2senTqauhH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6z/nT6bOJ8IeuczM30/R0EtJEZQgLMyb8mBjr0oVsNn7dGVL9XUGmHC/aWKR6L+poa4IL1jGjuJXTailW4Pl5ucqWmLnvk3FrgG8RoQqnHzwbflnD8hpp9svIZmIFg2ae+xFOP5e5n0Za4AE38bYAFwYuRTymF6IAGHOXaeAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXbK/YgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEC4C19425;
	Wed, 15 Apr 2026 00:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776211526;
	bh=PSrSRwRn4MKa54/IrG32UGFRrDBkQctp2senTqauhH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXbK/YgNnRdZ9ajObaY+LEjqh4VhI9V0SNCCSgmGgqJB3KWhp063X5ZZ4E2VCxSuQ
	 sFGBq5PJas07AbSLpc82nWDxJKPo1J1nQ1A8dnwAStaV/EVCQkjW6/ughsTzULZhd+
	 YNa6edu2EF8Z4fTYryfWW6wilBr+nw2t27q2CC7WczFchaxnjEEHN3paXzvVCt2CRN
	 sc43ydUFENZX1GuomdlMMtMzllJGNvD1v9r5qd+JZah09fFIjvFKgAgEhrYZZ96CrU
	 /j3zKEktQORaKIaWuNEhpTwfbOMBWhQvjdAW0ZG3QYYgN3OgwGSYiJGyk7qnVdYHmQ
	 Kzueh9SsBUpag==
Date: Wed, 15 Apr 2026 03:05:23 +0300
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
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3] KEYS: trusted: Debugging as a feature
Message-ID: <ad7WQ_Gr5H9GRdSX@kernel.org>
References: <20260409160752.988713-1-jarkko@kernel.org>
 <129b137c-be9b-4b01-824f-beec7111377c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <129b137c-be9b-4b01-824f-beec7111377c@linux.ibm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9184-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C428B3FF36C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 02:47:20PM -0400, Nayna Jain wrote:
> 
> On 4/9/26 12:07 PM, Jarkko Sakinen wrote:
> > From: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > TPM_DEBUG, and other similar flags, are a non-standard way to specify a
> > feature in Linux kernel. Introduce CONFIG_TRUSTED_KEYS_DEBUG for trusted
> > keys, and use it to replace these ad-hoc feature flags.
> > 
> > Given that trusted keys debug dumps can contain sensitive data, harden the
> > feature as follows:
> > 
> > 1. In the Kconfig description postulate that pr_debug() statements must be
> >     used.
> > 2. Use pr_debug() statements in TPM 1.x driver to print the protocol dump.
> > 3. Require trusted.debug=1 on the kernel command line (default: 0) to
> >     activate dumps at runtime, even when CONFIG_TRUSTED_KEYS_DEBUG=y.
> > 
> > Traces, when actually needed, can be easily enabled by providing
> > trusted.dyndbg='+p' and trusted.debug=1 in the kernel command-line.
> 
> Thanks Jarkko. Additional changes looks good to me. I just realized that the
> kernel command-line parameters document may need to be updated to include
> these parameters.

Good point. I will bake that to my PR version of patch. It's low risk as
per corrateral damage. Thanks for pointing this out.

> 
> Apart from that, feel free to add my
> 
> Reviewed-by: Nayna Jain <nayna@linux.ibm.com>

Thank you! These defines have been a huge itch for me for a while :-)


> 
> Thanks & Regards,
> 
>     - Nayna
> 
> 

BR, Jarkko

