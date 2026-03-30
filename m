Return-Path: <linux-integrity+bounces-9113-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLREOWvaymniAgYAu9opvQ
	(envelope-from <linux-integrity+bounces-9113-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2026 22:17:47 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44333360E5C
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2026 22:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB5DC300D176
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2026 20:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA69F1632E7;
	Mon, 30 Mar 2026 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkmtniJf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E73BB48
	for <linux-integrity@vger.kernel.org>; Mon, 30 Mar 2026 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901864; cv=none; b=B9sHNQPoyaMEAxxEVwJI5JGSTMDgAsTGN7Cxr13GO1dPTaovD/kJqlsc29B24u++LGtPXMlf7QYj0bJ8GIjv5QCgLrEVAnsMH28aW1kg9CWkivqRuiRJW8xJ6Dpqwi29oVgXU9UXAF1Bc8uepCOhyOVZceuh6RiSOnqwtomJ3zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901864; c=relaxed/simple;
	bh=KMKVq0GGBN8BsOCvMA1MrSH86cSO5JtwlNZBDQ+a6pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDaHgcNiHgZv5i3DbuKjTmvmT8SHHkUtb7QIDw/i6/t2QDGjwYIK1q+OBbYc5957/y0h2egjQTmNzt2H2BRXvjBE6I/AtcpPBszoB+6lzLalbLuxZMeRSJXzlr3N4CADtPugO6g5UtZIdtljfVZzKj8qMaj2xKCDXHSPIwTzzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkmtniJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209E8C2BCB0;
	Mon, 30 Mar 2026 20:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774901864;
	bh=KMKVq0GGBN8BsOCvMA1MrSH86cSO5JtwlNZBDQ+a6pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkmtniJf1OPngIfaPwSrQa5u5vQNiCDxiG9csIxuRuUlq1f0nHEpHRbd4pNNL/oZT
	 VOVj0yGpdjdBeI3uk4y2+DuwPrYYg9o6MtwWJH731uzNGEh/dDQbV4cVMhVe7uN+H5
	 c8PJ4xXQUZJXNvzUeLlOcOYyxqLDBXvNciA4uK1Krg4y/1mWoY9GIJgF7EgCJyKlN4
	 QCspdESyP1Ba4IRATYVWjuTsemdfQ8grBbYMDFOuDO8/C0xw0yHGTzl4byP+LRZcLn
	 blpeQujR3go1QmWNjPO775vYMpPELaknWjeqPXz2RaKQnihUYp1FfVkIaS9fJdddvd
	 e8FjwvW+/UrGw==
Date: Mon, 30 Mar 2026 13:16:35 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH 0/3] ima: add regular file data hash support for sigv3
Message-ID: <20260330201635.GF4303@sol>
References: <20260324203929.2475782-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324203929.2475782-1-zohar@linux.ibm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9113-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44333360E5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 04:39:26PM -0400, Mimi Zohar wrote:
> IMA signature version 3 (sigv3) support was introduced to avoid file
> signature ambiguity. Instead of directly signing a raw fs-verity hash,
> IMA signs the hash of ima_file_id structure, containing the type of
> signature, the hash algorithm, and the hash.
> 
> Pure ML-DSA calculates and signs the hash directly rather than a
> pre-hashed digest. To avoid ML-DSA having to re-calculate the file data
> hash, Eric Biggers suggested signing the smaller ima_file_id structure.
> 
> This patch set adds the sigv3 support for regular file data hashes. A
> subsequent patch set will add the ML-DSA support.

This explanation is a bit confusing, since this is actually needed
regardless of ML-DSA support.

Anyway, it's still the right thing to do.

Acked-by: Eric Biggers <ebiggers@kernel.org>

- Eric

