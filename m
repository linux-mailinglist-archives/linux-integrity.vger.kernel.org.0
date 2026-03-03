Return-Path: <linux-integrity+bounces-8880-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNTULgRUp2lsgwAAu9opvQ
	(envelope-from <linux-integrity+bounces-8880-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Mar 2026 22:35:00 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B831F79A6
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Mar 2026 22:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0C333149269
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2026 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03B9382F0F;
	Tue,  3 Mar 2026 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peTwc7vm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6EC37B032;
	Tue,  3 Mar 2026 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573575; cv=none; b=ubQvvOaIKjeTCbZUl38NakCYGL6KP5LolcOXODC7N/MxbxOg2Xs0oei5uH0cx635FsnSJzp9yUy2TD8+DXGVLpWoniQTUiV/VQzNxGvEwJQpIKUaMrd4ZTsTdhSKXvL3FIh0bccmG5x9YbEisYoCGcn3QfpVUSb0xJJxsNYkypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573575; c=relaxed/simple;
	bh=HGXEN6CIIV2zc0hLkcO8+d7RGXuo+Dynxj/zp8BYXh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWq3ffGzxrZWzqy6Zpl0WygltpyUU64uXwGAwD1zpjcK7bc6BcjA6xrlgIdeCRrPuSxuLBcfJtRU+eHNBS3EzMQHp3nC55GS7z2NQANut5FZWpVDm1208MNcm9Kiuu4PYbF6E7yPP4fLUdljnp8h6Zz0KAGJ8/St8qbELvt3CRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peTwc7vm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F32C116C6;
	Tue,  3 Mar 2026 21:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772573575;
	bh=HGXEN6CIIV2zc0hLkcO8+d7RGXuo+Dynxj/zp8BYXh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peTwc7vmeZPXp0vNg8pyoNIdG4ZXDFlyUCDc1DLsKbd+QnIxy/UtxsgdMDikHttE4
	 btgAe3irhy4F305VS4IjjJYkkZE/foIW7neEg3Xleqlv+Pn+SDudoix61alrop/QH/
	 HVfmSkTI/9yMdo2B06eqNzQZJUm/wg/heJilMD9xlGlOgbNhLbZqk5gLyClCR/QAeu
	 KUm4ffAVyiM9tlVxH+E0iBB1gCnQHx0juKJw6hKAjYUdkwZsiPwWvdbypWhIZ/DN7j
	 laA0zZdv5Ik/cCUkZLXmDwaP7QfyHGBdZQ0vidBGQblnl26Nf6uMS5tT4aa4kx03bG
	 2ZLAOOmFE5A6A==
Date: Tue, 3 Mar 2026 23:32:50 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chris Fenner <cfenn@google.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
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
Message-ID: <aadTgsbzDDkCg1Pr@kernel.org>
References: <20260125192526.782202-1-jarkko@kernel.org>
 <20260125192526.782202-2-jarkko@kernel.org>
 <06a08cbbe47111a1795e5dcd42fb8cc4be643a72.camel@linux.ibm.com>
 <CAMigqh1H1NKP9gddjhf4M1v-aM=+EpW9O4KJmu=UysOWhn4ryA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMigqh1H1NKP9gddjhf4M1v-aM=+EpW9O4KJmu=UysOWhn4ryA@mail.gmail.com>
X-Rspamd-Queue-Id: 68B831F79A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8880-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:30:26AM -0800, Chris Fenner wrote:
> My conclusion about TCG_TPM2_HMAC after [1] and [2] was that
> TPM2_TCG_HMAC doesn't (or didn't at the time) actually solve the
> threat model it claims to (active interposer adversaries), while
> dramatically increasing the cost of many kernel TPM activities beyond
> the amount that would have been required to just solve for
> passive/bus-sniffer interposer adversaries. The added symmetric crypto
> required to secure a TPM transaction is almost not noticeable; the big
> performance problem is the re-bootstrapping of the session with ECDH
> for every command.
> 
> My primary concern at that time was, essentially, that TCG_TPM2_HMAC
> punts on checking that the key that was used to secure the session was
> actually resident in a real TPM and not just an interposer adversary.
> I wrote up my understanding at
> https://www.dlp.rip/decorative-cryptography, for anyone who wants a
> long-form opinionated take :).
> 
> Unless I'm wrong, or TCG_TPM2_HMAC has changed dramatically since
> August, I don't think "TPM2_TCG_HMAC makes this too costly" is a
> compelling reason to make a security decision. (There could be other
> reasons to make choices about whether to use the TPM as a source of
> randomness in the kernel! This just isn't one IMHO.)
> 
> The version of TCG_TPM2_HMAC that I'd like to see someday would be one
> that fully admits that its threat model is only passive interposers,
> and sets up one session upon startup and ContextSaves/ContextLoads it
> back into the TPM as needed in order to secure parameter encryption
> for e.g., GetRandom() and Unseal() calls.

Neither agreeing nor disagreeing but this patch set clearly does not
move forward and I spent already enough energy for this. For better
ideas the patches are available in queue branch.

High-level takes don't move anything forward (or backward), sorry.

> 
> [1]: https://lore.kernel.org/linux-integrity/CAMigqh2nwuRRxaLyOJ+QaTJ+XGmkQj=rMj5K9GP1bCcXp2OsBQ@mail.gmail.com/
> [2]: https://lore.kernel.org/linux-integrity/20250825203223.629515-1-jarkko@kernel.org/
> 
> Thanks
> Chris
> 
> On Fri, Feb 20, 2026 at 10:04 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > [Cc: Chris Fenner, Jonathan McDowell, Roberto]
> >
> > On Sun, 2026-01-25 at 21:25 +0200, Jarkko Sakkinen wrote:
> > > 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and thus its
> > >    use should be pooled rather than directly used. This both reduces
> > >    latency and improves its predictability.
> >
> > If the concern is the latency of encrypting the bus session, please remember
> > that:
> >
> > - Not all environments expose the TPM bus to sniffing.
> > - The current TPM trusted keys design is based on TPM RNG, but already allows it
> > to be replaced with the kernel RNG via the "trusted_rng=kernel" boot command
> > line option.
> > - The proposed patch removes that possibility for no reason.
> >
> > Mimi & Elaine
> >
> >

BR, Jarkko

