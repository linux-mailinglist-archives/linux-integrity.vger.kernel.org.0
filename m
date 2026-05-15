Return-Path: <linux-integrity+bounces-9584-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK++HYaxB2pBCgMAu9opvQ
	(envelope-from <linux-integrity+bounces-9584-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 01:51:34 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8138559713
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 01:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 631A1301D688
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 23:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D3F3CF664;
	Fri, 15 May 2026 23:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsLvklbz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0979405C21;
	Fri, 15 May 2026 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778889085; cv=none; b=XDmmRnGYT4xPY90i6F6Au0nxNxewHUbDNTsanZ6QsDcBx4H6ZeSWFevMxqDaS2FT9a6HtMJxao90hs0RiCMbM9Zo0VjRL8KqNRG/eSF+oKxLmUtj1XfS0q6HexcSCCxwq+2G4Lo7+kjsYTWKEXjSg/KREhU2aml9cfkh3w9JCZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778889085; c=relaxed/simple;
	bh=+YzNzv7+8ANMNSfpUKGBa4/M7FpU0LJIdO4rB6Fn/kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIavUuz6m6BzgcoMX/rk8jIsBU24XT3Vw5JniOu0ULSPiy6v900KXzsVIeop8BWHKBNq0w/eLXSEYxdsUhuTOjbhpBmnerk2GYG2n7lY2GRsYhztMMntlMbv3fmKSNgC7Txbj2MX77vclK68PcrQS4hacjeMjvNRvtgxSVuPjL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsLvklbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE60C2BCB0;
	Fri, 15 May 2026 23:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778889085;
	bh=+YzNzv7+8ANMNSfpUKGBa4/M7FpU0LJIdO4rB6Fn/kE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JsLvklbzrw4NVy9ivGINX2a36fbGi+ygffgepGdJ5hG6qyRf8Q3nqxgS3QcinfRrB
	 e5KpYLoJhrppPPjF2+sNnfN+Mq6Lk8g7B2uZMU5EfcRk35pIXiqn92mahYDw0h5UhY
	 7+Bvclxqd2QZrPlQx1tWgTdXJN/w31+PcP+8FPYlw+ovzGBICFhpBwJIfSwEz3Ru9n
	 8+wldIff/nA144OZx1CwHzDaXKjo5SDfzdWUlTbIK5qfrrHqz2WNoJ309w6VbcEwW8
	 VgRZDrMFI0wtKR/5dZf4227iefM6Xwz7ZZgw3Hy7aj15i34hehJuUfWtvCI/DZL22X
	 OhKMaqeIAFe7A==
Date: Sat, 16 May 2026 02:51:22 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Ross Philipson <ross.philipson@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	iommu@lists.linux.dev, dpsmith@apertussolutions.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com, andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v16 01/38] tpm: Initial step to reorganize TPM public
 headers
Message-ID: <agexemLOag0eAiJB@kernel.org>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
 <20260515211410.31440-2-ross.philipson@gmail.com>
 <agemXwxVb9jvAbYM@kernel.org>
 <20260515230553.GO7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515230553.GO7702@ziepe.ca>
X-Rspamd-Queue-Id: C8138559713
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9584-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,srcf.ucam.org,hansenpartnership.com,gmx.de,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 08:05:53PM -0300, Jason Gunthorpe wrote:
> On Sat, May 16, 2026 at 02:03:59AM +0300, Jarkko Sakkinen wrote:
> 
> > LGTM
> > 
> > I'll hold on from actual tags up until there is some consensus with the
> > patch set.
> 
> This patch set is huge, and I know there is alot of interest now in
> DRTM.
> 
> Can we please split out and progress the TPM reorg mini-series at the
> front?

I'm not usually for "non-functional" series but in the case of D-RTM
that could stil bel a good idea.

I.e. let's iterate it through faster than the main series and get it to
the mainline before next merge window,  and then switch gears back to
the "main series".

> 
> Jason

BR, Jarkko

