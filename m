Return-Path: <linux-integrity+bounces-9240-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NrgIJJS5WnmhAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9240-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 00:09:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A86425A0C
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 00:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B86BB302A2DE
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 22:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC723112B7;
	Sun, 19 Apr 2026 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BP8Abvn9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C85628469F;
	Sun, 19 Apr 2026 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776636529; cv=none; b=EsnhbhO4KwrSYryW4ZD2yH7z0rF7oHM3NCXICUhPa4wQubbP1SV3gDP/EbiCbe/CINAzGODTjKmOksVsXOtWfMWz40RvCFODzVxlqtIV/524OwbAFSssn41UTCYXpIBwtzD9l+YAm4epo3XsBslq+tSQvQOXF55rqJtq4nM0AC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776636529; c=relaxed/simple;
	bh=wStAdO7mfEx4FH3qgv15bmA6U5wIK3h8L2nlKjb+EM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Spya0fitNIpFJrKBSiAU2PvnVz4QRIiJy4anm8VZGKtUWtdtj8/aMXKKwNiXM4Bsy09kw1ubeH93e5M+w9f/eIuBzm7+aWEgFA6XSyt7xIELwX4zp4JYT3SBJK5EQdjP5Wcjz2/ouHV4fuQQr2FRfse7NZr6cZNFAG6hcDD6lYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BP8Abvn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CDBC2BCAF;
	Sun, 19 Apr 2026 22:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776636529;
	bh=wStAdO7mfEx4FH3qgv15bmA6U5wIK3h8L2nlKjb+EM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BP8Abvn9pgBsjSRLy4QOGLHYh5r5/tpadgJ05Gl9WjucdQ/zGUXFUl6VU8l5IxXzs
	 5FSXjPazwWAg3+mAFWaj33FPsIWwGuEJQDnYcM2NnPiHKxHuDMQje/vwAC7BLotqMU
	 HDgbMvyyiPE9AKb6E3YtZydrE9ReK0TZOVAzQz/HVf9U9A1nIW2/aGf0rw9CiGkK5V
	 gY40cHLW+BowmbxHVxygThCFfWev3vgIh57pGMl+atZ9f7IwQlmhcoOSbsdMG8I2I7
	 wrECDl+4c1Al4B5h1xt+Tlu4jczXlpjApraspiLsQpQkbx4bFYHSZRCD+UIXh7Ius7
	 ZHtlzaDU+xsuw==
Date: Mon, 20 Apr 2026 01:08:45 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [GIT PULL] KEYS: keys-next-7.1-rc1
Message-ID: <aeVSbVIFaCDRXf7C@kernel.org>
References: <aeTLzOgblMZRnDvF@kernel.org>
 <CAHk-=whjUfVy22QCcsCS2h8AkJVpQBjHyVW4_hKXpUxHn9S65w@mail.gmail.com>
 <aeVLPLa8JDLIEgDR@kernel.org>
 <CAHk-=wjaGOBCsRpEhmPLcsuK6ggiaaeyz0rT6x3Zv7DMK7JNHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjaGOBCsRpEhmPLcsuK6ggiaaeyz0rT6x3Zv7DMK7JNHA@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9240-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21A86425A0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 02:52:06PM -0700, Linus Torvalds wrote:
> On Sun, 19 Apr 2026 at 14:38, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > I tested both PRs for the same baseline with two separate buildroot builds of
> 
> You threw away any and all testing that had been done by anybody else
> in linux-next.
> 
> And you rebased things on top of a random commit-of-the-day during the
> merge window, when things are possibly unstable due to all the *other*
> churn going on.
> 
> In other words, you did *EVERYTHING* that you shouldn't be doing, and
> that the documentation tells you not to do.
> 
> The WHOLE POINT of being in linux-next and being ready when the merge
> window opens is gone. All for apparently nothing.
> 
> Those stable cc tags do not add *any* value, since you could just have
> cc'd stable later instead.
> 
> I'm not pulling this. You need to stop doing this pointless churn, and
> read the docs on rebasing. See
> 
>    Documentation/maintainer/rebasing-and-merging.rst
> 
> about how you are *not* supposed to randomly just rebase, and
> _particularly_ not rebase on top of some random state during the merge
> window.

"A frequent cause of merge-window trouble is when Linus is presented with a
patch series that has clearly been reparented, often to a random commit,
shortly before the pull request was sent.  The chances of such a series
having been adequately tested are relatively low - as are the chances of
the pull request being acted upon."

OK, point digested.

I can update 'next' to contain only fixes from these PRs, and hold on up
til doing PR for -rc2 (as corrective step).

> 
>           Linus

BR, Jarkko

