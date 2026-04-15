Return-Path: <linux-integrity+bounces-9183-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE49Dx7W3mnwIwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9183-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 02:04:46 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D13233FF338
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 02:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1893C3054C3F
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 00:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B722BA45;
	Wed, 15 Apr 2026 00:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIucEafJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5818317736;
	Wed, 15 Apr 2026 00:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776211408; cv=none; b=lUzlyTyJqIe4jzZpFoFkOZIN1a78K4waMMyGkxSI/J7IleLnuYCTVkvtwakHWwtnBAcQ+qgYOMcTijTOWLYpMXxye6hqjvPi2DxmEcUWegABpjW5JY/gyk4fIW0e5nJHlW0ExkPls0xGlbT0Fi92qHey1PlZU75e19WFtwHtWo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776211408; c=relaxed/simple;
	bh=D1azdV9/e5A4H1cqzIaEcHq6lpPz87AyLZiF/KLW1n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0cWCxwjY3X/fLX3u7ufpa01qPjR1jBUDG7gUm9+gQ36cSaNmpqMM64cGl+he9RGPPaL8Sy12qcq4tI7alqoIWyI0aNJdjIrQyNxvwdqxkpbvJjiSPnTKA0QrRnYh0TUCIYqam+s6m1JSvFWTq+UIgHtI8kMfd5HM1rH3I2J3/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIucEafJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BEDC2BCB5;
	Wed, 15 Apr 2026 00:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776211408;
	bh=D1azdV9/e5A4H1cqzIaEcHq6lpPz87AyLZiF/KLW1n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIucEafJlGYzh1Nb4EDxVbJBMSptey98Qq5TlJjyhcpGXINXX62Si+b6coQa1MirR
	 cTdvnEOo5M3DNE3LZSnHirNm2/71a/+elcKotkC/Ix0j5PX6c5/hWX2mNx+Lh/BTgY
	 /tNER6F2jZjG+ThFDYG0KOivNRc/PhpRDJYBXmOfbdaPhOcNK0tu5AD+fDkd5Z4oh/
	 J/pFsi9d7VDPA7uPXuOd++qIpfASCMzalakkm/2XZJGddmwYaZUpUi0WfUCmRmLjm8
	 pmoNm6YM9V17Mw/vGkLsuY93CwjGcGem2UrrpOTwt3XpnaFIlJmV+98zZaQXbhX0re
	 5S3wqmpUjghhA==
Date: Wed, 15 Apr 2026 03:03:24 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	Nayna Jain <nayna@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3] KEYS: trusted: Debugging as a feature
Message-ID: <ad7VzPUfyHULhmEC@kernel.org>
References: <20260409160752.988713-1-jarkko@kernel.org>
 <05c9a2c3-8077-4a1c-87f8-4e240ee1e5c4@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05c9a2c3-8077-4a1c-87f8-4e240ee1e5c4@linux.ibm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9183-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: D13233FF338
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 11:03:58PM +0530, Srish Srinivasan wrote:
> 
> On 4/9/26 9:37 PM, Jarkko Sakinen wrote:
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
> > 
> > Cc: Srish Srinivasan <ssrish@linux.ibm.com>
> > Reported-by: Nayna Jain <nayna@linux.ibm.com>
> > Closes: https://lore.kernel.org/all/7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com/
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> 
> Tested on PKWM and emulated TPM backends.
> 
> Tested-by: Srish Srinivasan <ssrish@linux.ibm.com>

Thank you!

BR, Jarkko

