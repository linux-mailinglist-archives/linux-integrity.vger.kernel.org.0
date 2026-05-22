Return-Path: <linux-integrity+bounces-9637-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEFnExtTEGodWQYAu9opvQ
	(envelope-from <linux-integrity+bounces-9637-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 14:59:07 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D675B4A6C
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 14:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 140CC31C94CE
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 12:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B5C40960C;
	Fri, 22 May 2026 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTsY5EDE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B5409122;
	Fri, 22 May 2026 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453438; cv=none; b=rc8SMNexAx3IIaYLjAECCP7CVG0GbU0mD/EWeU/NrQ5fMare+e52D30rja5odC3hcK3gukEUIKpSnOz/9+TrVLaU3+iFhiGiiK6Hmn2jnE4izbabOs78Qf9cUdPeFFi3Ep+f8fRvuGQvtPHu15o2hB6GvoT8FR4qvl1OwdeVVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453438; c=relaxed/simple;
	bh=z/wBZ6rbyuMTWugSS9poVsDj1SFNDY2m6jZ0V23nYb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2ieA3fcI8JwRR8rgnAK4Tyw4qAEPHiHZTnxtSCZ7rvS7U/it57NpLNeQcBfCuFo1OQklG5UWNNmpNbwn2TQpuCQdi+4i6nlbMeH1Me5UlV1IVyZP2wtpZfX6itK+/pZxY3z2G2YQLHdG9ve78+V6YBEHOp+pGpJkxR3hvb7AUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTsY5EDE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A2ECD1F000E9;
	Fri, 22 May 2026 12:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779453434;
	bh=1Ohm8Cnet1iHKIpq9I4c5hHxdXomr/kAibOP9DNQw9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KTsY5EDE2O290Azc1pmR7FcktXOVjPiA7t7ATYu8KCcB1CiAB9VfuBEPZ/0JJF8pQ
	 mlZn8Pmn2XeJng8xI7useBwGCHVbmcl4id9mfGSkJ/CtpaU6vUrz6h3dTGy5igR3rd
	 bpxwTiLn0utLCzW2Of7qW967UOOUKXpKXTPrKfku/wUVCPAky1GeMpApklLJ0NY25J
	 x0AcoHTeI9Gqyfz5G0tj6noyVF9xHOctBNDebe8WsPmLkIZwnWUFlgJQ5b4aqVRRby
	 23suY2q9y3rn7s3X7AFBo6D2nygHr+OYJAx6jjBvRccd5NhInLRvCQvxIvdgqMi4Vo
	 z0Lbb3H3DhDVA==
Date: Fri, 22 May 2026 15:37:10 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jim Broadus <jbroadus@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH] tpm: tpm_tis: Add optional delay after relinquish
Message-ID: <ahBN9vCLmHLBqnch@kernel.org>
References: <20260519060926.103727-1-jbroadus@gmail.com>
 <ag-ZuEt4uXnrO8AK@kernel.org>
 <CAKgEEwswj4in29_hoy_dQQ18+GF=Uwf0LnwS=w7bwZCSW=mwjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgEEwswj4in29_hoy_dQQ18+GF=Uwf0LnwS=w7bwZCSW=mwjw@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9637-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,ziepe.ca];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 00D675B4A6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 11:03:29PM -0700, Jim Broadus wrote:
> Thank you Jarkko. I'll do that.
> 
> Jim

Yeah, in this form it is quite unsable e.g., for any Linux distribution,
and somewhat involved for the user :-)

Conditionally on is much better with appropriate detection. Also, this
way the change improves the code base a bit given that chip->did_vid is
much more applicable than chip->manufaturer_id.

BR, Jarkko

