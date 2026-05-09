Return-Path: <linux-integrity+bounces-9509-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LFbXKgCG/2nd7QAAu9opvQ
	(envelope-from <linux-integrity+bounces-9509-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 21:07:44 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DAF501253
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 21:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4C5F300FC72
	for <lists+linux-integrity@lfdr.de>; Sat,  9 May 2026 19:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226AA34753B;
	Sat,  9 May 2026 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYJB155e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006444A3E;
	Sat,  9 May 2026 19:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778353659; cv=none; b=EgLLp82ZWGbCkLWqAbWMJ6+UWkRZuwrYbo5fpJ8ht22nZYsX3SzINSjd0E9Bu8bGgE2aRkEAt8XYcCjgEBc8OJOt4NlcbIeTcHrvvtJ1FdHdP0JNzwFF0O/qxvFXyI5SNBhv9w2iXstQ7tvmkYUyOp8EW0czwfXsRoBeeRfkN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778353659; c=relaxed/simple;
	bh=/vpUKzZw77aK827T6tjPdgS5L/OylKJ+5BvsBZ9aQXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFt6KYq4FxNPFRk1ODrsU33ivCt1DLY8C2APGbK8yP0HSvh9uWDDPloFezVTdNDQ9SxHp7TE64pUUjEMQ5xBE2gcXzOo90S+mEn0VAYSRfedK6BcK+cgVmdv6LgkNaZQnVHMZTZiYAPcf4JPho1SE9gYvk+Ww3YGjcrRiPLzswY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYJB155e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35505C2BCB2;
	Sat,  9 May 2026 19:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778353658;
	bh=/vpUKzZw77aK827T6tjPdgS5L/OylKJ+5BvsBZ9aQXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYJB155ejwgOTyvSsmKPLJa/V7Ix6BrKzJPEg3q6LxqqbxDCUNBa4omdhvZm29OXg
	 ZTpWPnte/4njSghCD0OhUyOZUJMzKYHx1hrvHubYZk2KFE8zqZgAc2tPCAQbQvKsz8
	 r4AI4kMy7AxM6bEZnSuKTsgcr24mjO/CWujMrmZC6Dt+kSQfcjYVNrgcQomlM9j31t
	 MFa5TeElNchUVIFV+f1dNTIo1B/HTbJDKh9hYpQ67+BtYYQfbBUNIQP0/zpvYkSQ8t
	 m4dAgeKnI1CXThLu9kwBdw6lI1LmoX2QSeB0twjPSkDmgRArzJ+sogzjDVsOxBIZbs
	 bZ+pdhM1Rna9w==
Date: Sat, 9 May 2026 22:07:34 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Zhang, Baoli" <baoli.zhang@linux.intel.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Serge Hallyn <serge@hallyn.com>, Lili Li <lili.li@intel.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: restore timeout for key creation commands
Message-ID: <af-F9iMpvQFpVBwH@kernel.org>
References: <20260421005021.13765-1-baoli.zhang@linux.intel.com>
 <afi3hrjLm36qPc_T@kernel.org>
 <46109c55-c85d-4c32-9f09-f3205495afe0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46109c55-c85d-4c32-9f09-f3205495afe0@linux.intel.com>
X-Rspamd-Queue-Id: 03DAF501253
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,hallyn.com,intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9509-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 01:36:36PM +0800, Zhang, Baoli wrote:
> 
> On 5/4/2026 11:13 PM, Jarkko Sakkinen wrote:
> > On Tue, Apr 21, 2026 at 08:50:20AM +0800, Baoli Zhang wrote:
> > > From: "Baoli Zhang" <baoli.zhang@linux.intel.com>
> > > 
> > > Commit 207696b17f38 ("tpm: use a map for tpm2_calc_ordinal_duration()")
> > > inadvertently reduced the timeout for TPM2 key creation commands
> > > (`CREATE_PRIMARY`, `CREATE`, `CREATE_LOADED`) from 300 seconds to 30
> > > seconds.
> > > 
> > > This causes intermittent timeout failures, with several failures observed
> > > across hundreds of test runs on some Intel platforms using Infineon
> > > SLB9670 and SLB9672 TPM modules. Restore the timeout to 300 seconds to
> > > avoid spurious failures.
> > Is this a production case?
> > 
> > I'm not sure if there is anything to fix tbh. I mean it is
> > pretty much the same as "maintaining compatibility to OTT driver"
> > to addresses issues on undisclosed hardware.
> > 
> > Please correct me if I'm wrong. Otherwise, I'd carry out internal patch
> > to tweak this for pre-production hardware (presumably).
> Hi Jarkko, this is indeed a production case. We discovered this issue during
> validation testing for the sustaining release.

OK, it can be considered as a backwards compatibility issue then I
guess.

I applied the patch, thank you.

BR, Jarkko

