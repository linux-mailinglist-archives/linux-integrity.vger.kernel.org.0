Return-Path: <linux-integrity+bounces-8346-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOATEIXfeGkGtwEAu9opvQ
	(envelope-from <linux-integrity+bounces-8346-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 16:53:41 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C270397267
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 16:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FFD5306D8C3
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 15:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C536C3559D1;
	Tue, 27 Jan 2026 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2f/KysY4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oVZV4nGi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF6035B632;
	Tue, 27 Jan 2026 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528735; cv=none; b=BVKtCl8U8wBlO4hDoVxpMXqVqOrva0lgIBS3NN3FAGEbV7p7yto87l/SmVFRa+zZv/hdOrNEX9o3t77SsroBFQDJ0I8GWQzejGAizjK/jDwnq//4s24aFtY6MfIQKvAYgLH6jpb946tqta8iCohelcwwM7ntojdPpPvNvo7/0Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528735; c=relaxed/simple;
	bh=d4QCgirQGUGDrDP+ZhpmWrlquC87QZooZmKgKiRl3kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ucnm/gnbfCZadwYLSEB/Kk1NL3Ron8wU6YaC7/yHZGXtJcAmJlYiEORIIE1nSzMmtE2X2Fz6d+mrJgEsJ8/lH0rjJLGrGfad5yuO2886N5h+/ZiFeueAKp2oK8VZCTuTSOWHm7QOzuWbsOtGPdQfC8JMDFhW4q5jxNPFC1DgAKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2f/KysY4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oVZV4nGi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Jan 2026 16:45:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769528732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ljnqvQ7FcejLyLmSh5biG+cZ0bvPvaTDT2MvmDyOGIo=;
	b=2f/KysY4r90o/Xhw0WiWrPN0ZgzBaZyvhgkQxAwd/CyOwc75U8BPVteyAaEhreTRoYmb2H
	CClMP/sh27hbLb7NKautw6V0TsjAEKm2qpCmP15/+nZjfJmcTCyhD9ne95giVS+g3o+IhO
	X+J0gKja5vDYCt1NbTNJAqyEsA+UoIuz9MW68BZtSs2T9M/GtTdFF2nfercUr/qXwkOrCA
	hxXezOJwhXdb+b9cxi/Czrvp24C5tKtOUqK/PWFNtD55zak1v6Dq1iUGD/ltmFs4ADkaUS
	O2LQidhsMk0kkbfc0BhiKotOMTNCbPhSIBW4/21273WfxQu+uG/G5UYsdsCGug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769528732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ljnqvQ7FcejLyLmSh5biG+cZ0bvPvaTDT2MvmDyOGIo=;
	b=oVZV4nGi0gtGaooXDtVkwNwaPzOcCNF/iqnK3AA6mvH6pVXoKoDvuzsO0/dW0lMnQYKDHG
	UJLmjzn/NsgIPODQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 09/21] char: tpm: cr50: Remove IRQF_ONESHOT
Message-ID: <20260127154530.SPUEa63d@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-10-bigeasy@linutronix.de>
 <aXZJuFXFvvfsW-Qb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXZJuFXFvvfsW-Qb@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,gmx.de,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-8346-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: C270397267
X-Rspamd-Action: no action

On 2026-01-25 18:50:00 [+0200], Jarkko Sakkinen wrote:
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Shoud I pick this? I did apply it to my master branch (not next).

I am about to prepare a v2 and if you take it I am going to drop it.
Shouldn't you apply it, then I hope to route leftovers via the genirq
tree.

> BR, Jarkko

Sebastian

