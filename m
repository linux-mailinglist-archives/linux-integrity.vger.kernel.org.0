Return-Path: <linux-integrity+bounces-9656-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGOfJyWNE2pzDQcAu9opvQ
	(envelope-from <linux-integrity+bounces-9656-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 01:43:33 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FE25C4C9D
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 01:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA889300820A
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 23:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE800394789;
	Sun, 24 May 2026 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyXFgO6S"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E7F2FE060;
	Sun, 24 May 2026 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779666207; cv=none; b=fDltaYfi4a/m3JKeOw7uds2b6GaPeVkfRdEjWyp6DuNc3gOB1W7kB8A76EPXkAnrX+295X1UH12gp62fKouLNbNeY+VYi1Rwr3Dw7kV7a21le+Stdp9/YSSA3JSuIZlrRzdiBUbTcE6pyZ3L3KAnyKRW4QYaM7i9Hstzg6WvDA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779666207; c=relaxed/simple;
	bh=VOmEuoqj1QUiQHRcFyD2vyoILB4OVqxCbqJRFJ4a65k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRpvVBjXHy/cLsYTbBKumpXDNfoZaonzdUNNB6Pr08povaw8iq0MAAeiiZEGpHlBUqWFkwakyABqRFAGb/JWViaoICN4f3Z8CsG0o2Tc2X81y8fI6eJAE+SmmnofSG0tQ5MVx688M6bY7BX2R0QwLKrIVw9odQDmyKwVKooaRQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyXFgO6S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D0A3A1F000E9;
	Sun, 24 May 2026 23:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779666206;
	bh=4sOyiLRAJhl9sAFTpmyEnymyYch14BKVOAXeJ1tQ6aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lyXFgO6S5Gh7biB5sBEb3niyyTwrPanLaytjF3N7j9CHWLqNYgqnO7qCshElmu/HH
	 6Y5auQUrL9F6KptUoX2A+Nkrznnn7uUxVy3mfbDitJaYnYUW2TbqptuszhQ2dTObHm
	 LmQcEk4OkwRU54MkO/jPf+XWSqt5yXU0p0uMG1jjx5T4r6vYf8r8gMqm54EecypArW
	 6eUgNG7gnR4ZfKq8qXYdkkIsnZw5bYY4laxUdY/UtijvSD/cBS3hvr++5piQ7wP4PJ
	 TEYDftW26jsmIEyO9dWHIf65CzFlXl/o9aD2A+fCrSBmeZKG1XQLW4stGMivWLWX2x
	 hC0K56haUc9eQ==
Date: Mon, 25 May 2026 02:43:22 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, linux-crypto@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/3]
Message-ID: <ahONGtGQkrOYlunW@kernel.org>
References: <20260524051519.3708075-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524051519.3708075-1-jarkko@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9656-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ietf.org:url]
X-Rspamd-Queue-Id: 48FE25C4C9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 08:15:11AM +0300, Jarkko Sakkinen wrote:
> This series introduces key type for operating with asymmetric keys using
> a TPM2 chip.

This would deserve more explanation but the original trait was to
implement TPM2 parts of:

https://datatracker.ietf.org/doc/draft-woodhouse-cert-best-practice/00/

What motivated me to reiterate are actually these coding agents and how
all secrets are sprayed across the home directory. So, besides iwd one
could  use this feature to provide per-session cryptography for coding
agents.

There's a lot to do with security and coding agents as we have literally
moved to an era where we host indeterministically rogues software in our
development workstations.

There's other questions too that we need to eventually answer like for
instace, how to deal with persistent agent memory stored at the
computer's hard drive?

The irony here is that LLM is really neither rogue nor a lier. It is
just a text predictor optimizing for maximum reward and those
descriptions are just human interpretations of the output text. It
understand neither evil, lying nor quality for that matter ;-)

BR, Jarkko
 

