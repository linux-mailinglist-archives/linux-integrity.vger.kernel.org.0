Return-Path: <linux-integrity+bounces-9033-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFrlBRPRwGkVMAQAu9opvQ
	(envelope-from <linux-integrity+bounces-9033-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:35:15 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC89D2ECAD8
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5D48300D956
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 05:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1821E296BBC;
	Mon, 23 Mar 2026 05:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpXMbq1l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70231A9FA0;
	Mon, 23 Mar 2026 05:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774244084; cv=none; b=NK5eTCQV8936tzVr4xzZ9STEZ0ZaN2ztt6tFEmTfzBw34Vo54CSK5RhIbKra9bp9yRCpHXjMA9L994K/E/AYfxlOvidc4YTVzvANt0sIS5JHF4jKVFeeKEuvc9eXMqu5VAy3+6zT5OyeTXt+5VulxOqyjSvVObM420exXiddDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774244084; c=relaxed/simple;
	bh=msbKeajFmRLgfE/3ZMTR27ufPLLQ2VLFURPvutt6V0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqG/gY/3PR96/ifGI/Zc+3P+KEE9xJ1OsWOuV73Dz1VXt/1P8AS7v/whfVYG882kFBaD1LwseJf3R4mqhN46Qe2k5V/w9yq7uyGhKoH/RweSOLgkFfuJI1Lz4+XeAze6KtOLHgC5WNDmB44OkhXLcKSXDx+DeIoOmn+p+CRs03I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpXMbq1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2C9C4CEF7;
	Mon, 23 Mar 2026 05:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774244083;
	bh=msbKeajFmRLgfE/3ZMTR27ufPLLQ2VLFURPvutt6V0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PpXMbq1lG4H5pcxy6BZhTSgQrn+2ofg5BImYsfFdcov7owYtwYnBa20uNVoj5Lzen
	 1fm7c/L0Zp0K2GFwPe8UOeL/w1QxzBsvyWHi/8eM7V6N9ZjKsCBQGugIxWVm3clYUE
	 KU9LLbNLIlnzEdS0cq6q6OrNTG561NY45ogVAPSd/Uteb5tOihC2MeiKNcoU+ICL6V
	 UIrmVSRWBxQ0JTiIj2kgX1W7njTsaFWhnbzne/O8Z6KS/XblnMF2myoFb5wI66D40S
	 J48n/1aW16Pkytk3acfVrIQbpDh99wPVBUng7yul6gWzB90boSnL3ckjweMenSDGmr
	 Lzy4XwahsUzqA==
Date: Mon, 23 Mar 2026 07:34:39 +0200
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
Message-ID: <acDQ7_lXNhsvp8Nb@kernel.org>
References: <20260125192526.782202-1-jarkko@kernel.org>
 <20260125192526.782202-2-jarkko@kernel.org>
 <06a08cbbe47111a1795e5dcd42fb8cc4be643a72.camel@linux.ibm.com>
 <CAMigqh1H1NKP9gddjhf4M1v-aM=+EpW9O4KJmu=UysOWhn4ryA@mail.gmail.com>
 <aadTgsbzDDkCg1Pr@kernel.org>
 <dca994cd0ed11a262d4022c4984984460ba06a78.camel@linux.ibm.com>
 <CAMigqh2kW_srDgnOs+1t=sk9Q9jJgaQVswO0ZRHhV-6zrOAZ6A@mail.gmail.com>
 <df0a54666d890d5223877e0a0f90ac9082b2d038.camel@linux.ibm.com>
 <acDPCRVx_xO_RhZK@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acDPCRVx_xO_RhZK@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9033-lists,linux-integrity=lfdr.de];
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
X-Rspamd-Queue-Id: AC89D2ECAD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 07:26:38AM +0200, Jarkko Sakkinen wrote:
> On Thu, Mar 19, 2026 at 10:28:03AM -0400, Mimi Zohar wrote:
> > On Wed, 2026-03-18 at 10:36 -0700, Chris Fenner wrote:
> > > Apologies if my long message derailed this discussion. I meant to
> > > support Mimi's concern here and project a future vision where
> > > TCG_TPM2_HMAC doesn't conflict with other features.
> > > 
> > > More concisely, I think that:
> > > 
> > > > tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled
> > > 
> > > is not a compelling argument for removing TPM as an RNG source,
> > > because TCG_TPM2_HMAC is known to have poor performance already
> > > anyway.
> > 
> > Agreed.  Thanks, Chris!  FYI, we raised concerns about IMA performance with the
> > TPM HMAC and encrypted feature while it was being developed. James had some
> > ideas, at the time, as to how to resolve the performance issue for IMA.  Yet it
> > was upstreamed without those changes and with CONFIG_TCG_TPM2_HMAC enabled by
> > default on x86 systems.
> > 
> > Jarkko has queued this patch in the "queue" branch, without indicating whether
> > it will eventually be upstreamed or not.
> 
> Yes and there's been multiple months of time to comment this and I
> backed up the patch set there, which is not same as applying it.

There's quite many other patches in that patch set also in the queue
branch. This was largeriy past life for me when these comments came.
Really don't understand what is suddenly going on tnh and for one
not that interesting patch.

BR, Jarkko

