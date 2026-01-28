Return-Path: <linux-integrity+bounces-8355-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D0FHgmZemm58QEAu9opvQ
	(envelope-from <linux-integrity+bounces-8355-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 00:17:29 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2604A9E43
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 00:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6EE83014867
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jan 2026 23:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EFB33065D;
	Wed, 28 Jan 2026 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIDoSa7c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034122DECBD;
	Wed, 28 Jan 2026 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769642247; cv=none; b=AeeJ8t1Wb3k5cYQ4e25whegnxPdBetmz6xnS8uJqv+WQUoLGKSOTbxYA4HAOPxYpq9vJCyVyVip7b3oZFggF9W66TUeM/Hok9GBoyp1iHgAbn7kaufzZTA5wYX8BdF/sow0DWd1+hsNjWo52miDl3GvOABJui7I0M3MLpUaIdUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769642247; c=relaxed/simple;
	bh=qO7dfiw2GJNjPx3tSEUVxc4d77Lz9sPQeBV6GQPIP9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VB7I12Cqld8SeM8ZBPuhhPEUKJ0FFFOmxRczwRefc0REnd4cQv1CIgm6wRJGT5sHGJYyg5zvFWRMXmymn3WeDa/ORU3wJNWQBqr9+kpVEfUF28TGRBMHs7IX+as6qzyfZ5Z1O+y4CQKgN8eJIxl9cu83/ee+oYCLZUqxAAY0Jmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIDoSa7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04726C4CEF1;
	Wed, 28 Jan 2026 23:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769642246;
	bh=qO7dfiw2GJNjPx3tSEUVxc4d77Lz9sPQeBV6GQPIP9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIDoSa7cASX6RPExCNtkcPXgoxTt0cf6zPYA+pDe530YwjsuTbvw3GniO1mDbhVRX
	 VKbJiTjhYqwYFdjmUL3B2QBmeOlQOULoDa0poMsGwL07JLZr4fa7P+5rm0yLpo1mnE
	 xg0j/PECtvD+GzIiVGQQrr3+KJLSKVQcXkVfIRSW77Inc37aT0TB94IARhgs01OBgx
	 WGzXhqIAlMpkg4SvI8peSIFH/Gb+dvE3QCJ+dADlZleANV+OqbFlzWIrHuru9J0mTo
	 2mk7JVW+5RV2MH8DCCYaQV7HGcOjPSXyTTQzpoIuU/iVb7/Sqg0VK4mBOu24bgm8By
	 6oxUhWFVx8uHQ==
Date: Thu, 29 Jan 2026 01:17:21 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 09/21] char: tpm: cr50: Remove IRQF_ONESHOT
Message-ID: <aXqZAb1dfdoQkfls@kernel.org>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-10-bigeasy@linutronix.de>
 <aXZJuFXFvvfsW-Qb@kernel.org>
 <20260127154530.SPUEa63d@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127154530.SPUEa63d@linutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,gmx.de,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-8355-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2604A9E43
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 04:45:30PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-25 18:50:00 [+0200], Jarkko Sakkinen wrote:
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > Shoud I pick this? I did apply it to my master branch (not next).
> 
> I am about to prepare a v2 and if you take it I am going to drop it.
> Shouldn't you apply it, then I hope to route leftovers via the genirq
> tree.

Please route through genirq tree.

> 
> > BR, Jarkko
> 
> Sebastian

BR, Jarkko

