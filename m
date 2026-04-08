Return-Path: <linux-integrity+bounces-9140-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H5nK3YU1mnwAwgAu9opvQ
	(envelope-from <linux-integrity+bounces-9140-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Apr 2026 10:40:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AE23B9369
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Apr 2026 10:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3923730134B0
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Apr 2026 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63D73A63F9;
	Wed,  8 Apr 2026 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9toCchI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE33A0B28;
	Wed,  8 Apr 2026 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637370; cv=none; b=Q/cuRbqvl83mmOvYBxeUeOdBIWD3R50qIL9gGl6VH3eEv/KUQFi+oTQveq3qYBDT/i6AB7FkMTTcKmrCDMY7+vd7bY9W67VTmHXVy/kz9/bw4Y3jpjpiuy84BIfFA96k05/Z6z9vWbCu9tR1LYh3SjM/pL9qWxS0+zeuZmKimmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637370; c=relaxed/simple;
	bh=wb7nl+wP2wE2hpjtyD6XObeZm2OlovZ95NsBlJNPD3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAIE4u+WyZwTRzwF0ZkaYkbW8kSc7Jl3mAFpDYW6CfZm/WwYGlmqpBQnBnyEzpE6mW9A4OtDBhla2U7b3PLAMq+i0yhAC9TOxQLmDmywr7mlLV9sV+dLQjHjVdCV6AEk1t/rwQqc50L6xiYw+l/gANnaXw1Nj3pxs3nyibx2lVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9toCchI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DE1C19424;
	Wed,  8 Apr 2026 08:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775637370;
	bh=wb7nl+wP2wE2hpjtyD6XObeZm2OlovZ95NsBlJNPD3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X9toCchIcFBK83BYKxP7I5OIU78gYJJZJPj61rjfFv7sc6HxCGV96laI+sVtMWtcQ
	 Msl5Z4Xv4awAAZKdbyqNYdI0Ll3HGlfM0QQQgAeNeobJY/Aqh3OSAZZx3odDzH9ppf
	 lYSo3fMroA9prnk9+Ndi7d2WjTSVJnxnEVFFADhgc4bwXBPnmMm41xkO0e4cooVxPR
	 +rFzWVtH4IWOsn33C42YcCoyIewBklNFe+WjUI4amAP6zqclrFF+0FNUXFBjyRTAib
	 iralTET5z4fcOmaCAoNevP6UKGPAGpWRPbRO0U03OOR34uNXEpnqE5Q3HdZWni4WdH
	 M+gDtgGzMO5JQ==
Date: Wed, 8 Apr 2026 11:36:06 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [RFC 2/4] tpm_crb: Add new wrapper function to invoke start
 method
Message-ID: <adYTdmCKferDsu4_@kernel.org>
References: <20260324071803.324774-1-armenon@redhat.com>
 <20260324071803.324774-3-armenon@redhat.com>
 <acJqi8S81I2hwvsR@kernel.org>
 <acKG6EQ_tXO8eqfj@fedora>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acKG6EQ_tXO8eqfj@fedora>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,gmx.de];
	TAGGED_FROM(0.00)[bounces-9140-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37AE23B9369
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 06:13:20PM +0530, Arun Menon wrote:
> 
> On Tue, Mar 24, 2026 at 12:42:19PM +0200, Jarkko Sakkinen wrote:
> > On Tue, Mar 24, 2026 at 12:48:01PM +0530, Arun Menon wrote:
> > > - Extract start invocation code into a separate function called
> > >   crb_trigger_tpm. This will be helpful in repeatedly calling the
> > >   start method with different bits set to toggle between start,
> > >   nextChunk or crbRspRetry behaviours.
> > > - Based on the bit set, we signal the TPM to consume
> > >   contents of the command/response buffer.
> > > - No functional change intended.
> > 
> > Please write a proper commit message, which is not a task list.
> 
> Yes, I shall do that. Thank you for taking a look.

Yeah, and now is good time to improve cosmetic details like this.

I rather take closer look at code when I can run it as I'm not LLM
coding agent, I need to run to understand cannot hallucinate it :-)

BR, Jarkko

