Return-Path: <linux-integrity+bounces-9039-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPuyL8PTwGmVMgQAu9opvQ
	(envelope-from <linux-integrity+bounces-9039-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:46:43 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 667592ECB99
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6AEF3003D3C
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 05:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A51F1EA7CE;
	Mon, 23 Mar 2026 05:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qa/dqHCW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4658CAD4B;
	Mon, 23 Mar 2026 05:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774244799; cv=none; b=PNORfk2cBUjrmLcs37puopkRjf9Ss3HAhCM+Lrixo1rnV0NSTai7bXVT/BuRS3z/72A5raB9V8zxeoNIg1AuDv8x6sqohEwgw+fXxlEvc9Bs2dR9iYLDTLcTiHu7HFCcFHboH4qOCZtYXQXGnQWwjmMCLkeSLbw076LUTuyjFIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774244799; c=relaxed/simple;
	bh=pUVBnjuNST4PaFL8VOWTHd6SPN/M7WarIvVdMfI/U3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdJJK01vd4hpxAFSJxdcL+QAEQ2aLDQG+KmE3kVWld6kgbTzMstyQP+C7A5fKY9CrcClRBIcNfIKwtOwK70C74DGWOaxnJ5JJWu1shTG6fGzdEW4l5Szqpv9Bn/BRqoXPSGVDJyzW8nBfBuFqC5R+GHQRexk+IBsh2PJ/+QrU5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qa/dqHCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A66EC4CEF7;
	Mon, 23 Mar 2026 05:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774244799;
	bh=pUVBnjuNST4PaFL8VOWTHd6SPN/M7WarIvVdMfI/U3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qa/dqHCWHo4mvrqnSIuEWCY8Zne5DruYt3bJQE9Am2CY9j+iSj0TaFYdPly+SHV0d
	 eJxVECbSpqwxqKQjcRzLsIHoGqg2CgDvi0o/ESutCI9704BqDawRrRIJNjICz6CZT5
	 apuu/vsvwd88YhIKz8BS2ZKgS19GaTdYJNb6aiJwUFfgN/5//5Zk7iYmjzeQw+Qg7F
	 MKDxMUxPGycpo/Rj+MfXk+neF3UcCphdVKL1LP/4aRmGJYs8Y1kCyk2eQ2KHxra6R9
	 dc+Gwh0704cTZY86oLP/fbbSPSY2eHRgRyE5hkYccAIDaQUDce+ckhTOn4F9npkFcv
	 f3SntlofSBAdg==
Date: Mon, 23 Mar 2026 07:46:33 +0200
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
Message-ID: <acDTucJGLGCDZ7PU@kernel.org>
References: <20260125192526.782202-1-jarkko@kernel.org>
 <20260125192526.782202-2-jarkko@kernel.org>
 <06a08cbbe47111a1795e5dcd42fb8cc4be643a72.camel@linux.ibm.com>
 <CAMigqh1H1NKP9gddjhf4M1v-aM=+EpW9O4KJmu=UysOWhn4ryA@mail.gmail.com>
 <aadTgsbzDDkCg1Pr@kernel.org>
 <dca994cd0ed11a262d4022c4984984460ba06a78.camel@linux.ibm.com>
 <CAMigqh2kW_srDgnOs+1t=sk9Q9jJgaQVswO0ZRHhV-6zrOAZ6A@mail.gmail.com>
 <df0a54666d890d5223877e0a0f90ac9082b2d038.camel@linux.ibm.com>
 <acDPCRVx_xO_RhZK@kernel.org>
 <acDQ7_lXNhsvp8Nb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acDQ7_lXNhsvp8Nb@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9039-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 667592ECB99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 07:34:39AM +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 23, 2026 at 07:26:38AM +0200, Jarkko Sakkinen wrote:
> > On Thu, Mar 19, 2026 at 10:28:03AM -0400, Mimi Zohar wrote:
> > > On Wed, 2026-03-18 at 10:36 -0700, Chris Fenner wrote:
> > > > Apologies if my long message derailed this discussion. I meant to
> > > > support Mimi's concern here and project a future vision where
> > > > TCG_TPM2_HMAC doesn't conflict with other features.
> > > > 
> > > > More concisely, I think that:
> > > > 
> > > > > tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled
> > > > 
> > > > is not a compelling argument for removing TPM as an RNG source,
> > > > because TCG_TPM2_HMAC is known to have poor performance already
> > > > anyway.
> > > 
> > > Agreed.  Thanks, Chris!  FYI, we raised concerns about IMA performance with the
> > > TPM HMAC and encrypted feature while it was being developed. James had some
> > > ideas, at the time, as to how to resolve the performance issue for IMA.  Yet it
> > > was upstreamed without those changes and with CONFIG_TCG_TPM2_HMAC enabled by
> > > default on x86 systems.
> > > 
> > > Jarkko has queued this patch in the "queue" branch, without indicating whether
> > > it will eventually be upstreamed or not.
> > 
> > Yes and there's been multiple months of time to comment this and I
> > backed up the patch set there, which is not same as applying it.
> 
> There's quite many other patches in that patch set also in the queue
> branch. This was largeriy past life for me when these comments came.
> Really don't understand what is suddenly going on tnh and for one
> not that interesting patch.

Underlined: not a queue to anywhere. I can rename it something else,
did not really think about the name when I created the branch.

BR, Jarkkko

