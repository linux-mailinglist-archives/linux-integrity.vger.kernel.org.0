Return-Path: <linux-integrity+bounces-9031-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK8aCxLPwGmxLgQAu9opvQ
	(envelope-from <linux-integrity+bounces-9031-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:26:42 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D522ECA62
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A089300BDA3
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 05:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6FA289340;
	Mon, 23 Mar 2026 05:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXQhfE6l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856D21A9B24;
	Mon, 23 Mar 2026 05:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774243598; cv=none; b=J057AJlvvRy05obOXqFRjOgwHrADdmDyKgWrVXjkeLX9cegkl7O5DmgrmJzqGlpHIcJjvkb4TLWBUmz9m+Sav/ELRLFcxBuXD4IHGyAf0RBOOS9F4s8u94Ka3AQu7ZZCAhNXNfCsK/4BbqvK4tc0LG3007CmX7UvtuLRtMkVbjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774243598; c=relaxed/simple;
	bh=Zux8o07G2J4eusOzTUquskkr9AqL7vPLoD/1LMsSxMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT5ztm63/wXrXy8Q/l/nJ2q5aLQF0GIhC31cpqZVKgNwdA3zzo9/wjQ30XXr+3odQVYbpHMEjNttPRrx5GbDtrlDq2tRGJZhOexcCEzbNG3VNfVl3El8p8Tt93ZnOds32InD9lsQ9zD3vuNmsy/Hk1ULPRn1gKm5UckJp50dfs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXQhfE6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE46C4CEF7;
	Mon, 23 Mar 2026 05:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774243598;
	bh=Zux8o07G2J4eusOzTUquskkr9AqL7vPLoD/1LMsSxMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eXQhfE6l3BN343u1Z9aqxFvBWRH15kjpfLZNm4Hv241nP6SXlGnnzv6XMrszbAHJ8
	 39NFfLv/uy86fMgUSHhDUU5FTJNV8d4JVyV7gIBCc3pbGR/kL6OPbSgQsD8gLLlSP4
	 uSFD1ie0pOA8mK5HVcpnaFeagbv/WiBcfqx1QRzxys7brKbesekh4PbvjZ7xGsyezi
	 V0U2Eri6Yv/Zs5QKyF9lRIk+AsAXNq83NAjRsUhMbPvym3Vb2BgJ1SjBfx0Lag4oYD
	 BNkZBnxlz1LouK5tt1ScAhFRmBABcQ/3FeJaFBQlfkxMcGL7mffnP6SZHBjuIXfrNZ
	 Q0z3qSunXmJMQ==
Date: Mon, 23 Mar 2026 07:26:33 +0200
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
Message-ID: <acDPCRVx_xO_RhZK@kernel.org>
References: <20260125192526.782202-1-jarkko@kernel.org>
 <20260125192526.782202-2-jarkko@kernel.org>
 <06a08cbbe47111a1795e5dcd42fb8cc4be643a72.camel@linux.ibm.com>
 <CAMigqh1H1NKP9gddjhf4M1v-aM=+EpW9O4KJmu=UysOWhn4ryA@mail.gmail.com>
 <aadTgsbzDDkCg1Pr@kernel.org>
 <dca994cd0ed11a262d4022c4984984460ba06a78.camel@linux.ibm.com>
 <CAMigqh2kW_srDgnOs+1t=sk9Q9jJgaQVswO0ZRHhV-6zrOAZ6A@mail.gmail.com>
 <df0a54666d890d5223877e0a0f90ac9082b2d038.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df0a54666d890d5223877e0a0f90ac9082b2d038.camel@linux.ibm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9031-lists,linux-integrity=lfdr.de];
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
X-Rspamd-Queue-Id: C0D522ECA62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:28:03AM -0400, Mimi Zohar wrote:
> On Wed, 2026-03-18 at 10:36 -0700, Chris Fenner wrote:
> > Apologies if my long message derailed this discussion. I meant to
> > support Mimi's concern here and project a future vision where
> > TCG_TPM2_HMAC doesn't conflict with other features.
> > 
> > More concisely, I think that:
> > 
> > > tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled
> > 
> > is not a compelling argument for removing TPM as an RNG source,
> > because TCG_TPM2_HMAC is known to have poor performance already
> > anyway.
> 
> Agreed.  Thanks, Chris!  FYI, we raised concerns about IMA performance with the
> TPM HMAC and encrypted feature while it was being developed. James had some
> ideas, at the time, as to how to resolve the performance issue for IMA.  Yet it
> was upstreamed without those changes and with CONFIG_TCG_TPM2_HMAC enabled by
> default on x86 systems.
> 
> Jarkko has queued this patch in the "queue" branch, without indicating whether
> it will eventually be upstreamed or not.

Yes and there's been multiple months of time to comment this and I
backed up the patch set there, which is not same as applying it.

> 
> Mimi

BR, Jarkko

