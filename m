Return-Path: <linux-integrity+bounces-9030-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FxhAajOwGm2LQQAu9opvQ
	(envelope-from <linux-integrity+bounces-9030-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:24:56 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 790FF2ECA3B
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7514A3006B1E
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 05:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C623E289340;
	Mon, 23 Mar 2026 05:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAjYcblD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF9F1A9B24;
	Mon, 23 Mar 2026 05:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774243490; cv=none; b=IATKVN72c2uoZLruhvtNwu3WkQI3qlwbPLDLaE2Jb1oOCxkk/BEI97wN8WEIjP8f7thIl5pK5MVEizN8uyFUhhuMjtgDnRb2oM+PnzIoQgaj0xrAesuQtV+cd7KyaaLlfgrpr93c64AxWceLC8+dyjmXP6m4+U9C+fqt05VEa48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774243490; c=relaxed/simple;
	bh=eusF8SOMQWdbEbP43z8o44IbOKrIx4jUr4mjRCu4esk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fp90Cbcxm9ZAKPEzelNihrq+y6CyevPhJtlVuR1dg3JVEcTx5tMca/edt8ROJrnkIsL2ZgZ8Vd/f51jgEaU3Dm7Q01ncj/vEpqvXOSv1AK3/BjQvO009/QTXkxtSL+ARg07OTiyE8LVWTqGnm+CpmITiFaXSSXgRbruA54t3Y4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAjYcblD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED056C4CEF7;
	Mon, 23 Mar 2026 05:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774243490;
	bh=eusF8SOMQWdbEbP43z8o44IbOKrIx4jUr4mjRCu4esk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FAjYcblDepO7Nr0g/KCmmWlfPUIzrpar+YncGrJtTKYBT86afGPc1gekRVhhQ9jAh
	 1peOX9EEO0aneq02PYMC/or0/FfwzGYsTGEZZCSdmjvnLnIrSIRzyLticQerMWnRNX
	 ZDjB9jzaqfCD8rNUDvVX6uk9nFHMRl23vAoVL9f8hWFbbxEKtq2abIddAN8naPsVCL
	 Ld0Hna4noMu4CohaRlSyprhV3UUJOzM++05Sgc8Z0GWpe2mJkvv0A4JO8CDfPxL81g
	 wTexPTWSbmuhWYhLNpKwFv9RY8GEJ+nO3ojBme/JbtShrn0UKw39SLZlCwf3qqwEQs
	 jYMc2zxLGPQJQ==
Date: Mon, 23 Mar 2026 07:24:46 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Chris Fenner <cfenn@google.com>, linux-integrity@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v9 01/11] KEYS: trusted: Use get_random-fallback for TPM
Message-ID: <acDOnu3wILRLh36K@kernel.org>
References: <20260125192526.782202-1-jarkko@kernel.org>
 <20260125192526.782202-2-jarkko@kernel.org>
 <06a08cbbe47111a1795e5dcd42fb8cc4be643a72.camel@linux.ibm.com>
 <CAMigqh1H1NKP9gddjhf4M1v-aM=+EpW9O4KJmu=UysOWhn4ryA@mail.gmail.com>
 <aadTgsbzDDkCg1Pr@kernel.org>
 <dca994cd0ed11a262d4022c4984984460ba06a78.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dca994cd0ed11a262d4022c4984984460ba06a78.camel@linux.ibm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9030-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 790FF2ECA3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 05, 2026 at 10:37:08AM -0500, Mimi Zohar wrote:
> On Tue, 2026-03-03 at 23:32 +0200, Jarkko Sakkinen wrote:
> > On Fri, Feb 20, 2026 at 10:30:26AM -0800, Chris Fenner wrote:
> > > My conclusion about TCG_TPM2_HMAC after [1] and [2] was that
> > > TPM2_TCG_HMAC doesn't (or didn't at the time) actually solve the
> > > threat model it claims to (active interposer adversaries), while
> > > dramatically increasing the cost of many kernel TPM activities beyond
> > > the amount that would have been required to just solve for
> > > passive/bus-sniffer interposer adversaries. The added symmetric crypto
> > > required to secure a TPM transaction is almost not noticeable; the big
> > > performance problem is the re-bootstrapping of the session with ECDH
> > > for every command.
> > > 
> > > My primary concern at that time was, essentially, that TCG_TPM2_HMAC
> > > punts on checking that the key that was used to secure the session was
> > > actually resident in a real TPM and not just an interposer adversary.
> > > I wrote up my understanding at
> > > https://www.dlp.rip/decorative-cryptography, for anyone who wants a
> > > long-form opinionated take :).
> > > 
> > > Unless I'm wrong, or TCG_TPM2_HMAC has changed dramatically since
> > > August, I don't think "TPM2_TCG_HMAC makes this too costly" is a
> > > compelling reason to make a security decision. (There could be other
> > > reasons to make choices about whether to use the TPM as a source of
> > > randomness in the kernel! This just isn't one IMHO.)
> > > 
> > > The version of TCG_TPM2_HMAC that I'd like to see someday would be one
> > > that fully admits that its threat model is only passive interposers,
> > > and sets up one session upon startup and ContextSaves/ContextLoads it
> > > back into the TPM as needed in order to secure parameter encryption
> > > for e.g., GetRandom() and Unseal() calls.
> > 
> > Neither agreeing nor disagreeing but this patch set clearly does not
> > move forward and I spent already enough energy for this. For better
> > ideas the patches are available in queue branch.
> 
> Jarkko, you totally ignored my comments below.  I object to your removing the
> TPM trusted-keys RNG support.

It has not been removed but I can keep the patches still backed
up in a branch, can't I?

BR, Jarkko

