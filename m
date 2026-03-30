Return-Path: <linux-integrity+bounces-9112-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDJkHuPZymniAgYAu9opvQ
	(envelope-from <linux-integrity+bounces-9112-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2026 22:15:31 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B0B360E12
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2026 22:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E404730439ED
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2026 20:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC11397E96;
	Mon, 30 Mar 2026 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoXe/XtP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E83976BB
	for <linux-integrity@vger.kernel.org>; Mon, 30 Mar 2026 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901685; cv=none; b=CMfXkH/r+qcDanqAcShmR8Z6kRbJk6qj1IvdE8e4Cd5iTzjp6HXbXDhbN2EZ6QnYtLIB9qwOFjMfKYnxBTIOgHkLbl85+S1QK7sefTF8QXg7dymh0b35qCPQmPW9e0q7NSUBuGUcPK+PrbeXm2i8rVmQvRsZOf3OUI1OXg2vBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901685; c=relaxed/simple;
	bh=R1pwynaUgdRNgwi51uAR6jOtIkYi7AVrXxJDFaXkJh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMbVNPJCFsZqhxOgazOj9wDEYB3lbH/7UQ+FvVVbZD5sH9wb9iuQaSyobat+mskjStn/s5eLCEU+Iev035ARtll+lk7lXxswHtJbqKUmkbjeIZn9MhB0r1W/a99YZOUihfJOwsVeWemXahvM63ZgZMDZHig1/CDCu+fATqei0pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoXe/XtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6C0C4CEF7;
	Mon, 30 Mar 2026 20:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774901684;
	bh=R1pwynaUgdRNgwi51uAR6jOtIkYi7AVrXxJDFaXkJh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RoXe/XtPnlKlcGuJVUli+flPMw9Uxht+mTZxi25g1tonWQrIZVC6LgcnmWzWFWDW2
	 tirkNFjtenNxxOPjFuIykvi+kABfgYNI6B8bOpOI0RKxAaA1a1G3UFK0zPIz82m8AD
	 XOhDZDwP+sVYWXusA1RXCrTTF58Da6TwcH8rS3TDIYXF+hdQtFiXQq7Uag/sPAebjl
	 LYKSmKz2hbQ55iKX9NWVTEWhM7txw+G+sZ78npwiOOigATTXmg8Qw1Pnbi8U5NoYhv
	 L/dih5KUb/cfbJ3evSuAdyRwpC8F7as9uQz0ot+Pk6tgmA7oGIv1mcPPEbxu9olad9
	 8Fp8iCE4NLJug==
Date: Mon, 30 Mar 2026 13:13:36 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH 1/3] ima: Define asymmetric_verify_v3() to verify IMA
 sigv3 signatures
Message-ID: <20260330201336.GE4303@sol>
References: <20260324203929.2475782-1-zohar@linux.ibm.com>
 <20260324203929.2475782-2-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324203929.2475782-2-zohar@linux.ibm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9112-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34B0B360E12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 04:39:27PM -0400, Mimi Zohar wrote:
> + * IMA signature version 3 disambiguates the data that is signed by
> + * indirectly signing the hash of the ima_file_id structure data.

The right way to think about it is that it's the ima_file_id itself that
is being signed and verified, and taking the hash of it is only a
workaround for legacy algorithms that can only sign and verify hashes.
With modern algorithms like Ed25519 and ML-DSA that accept
arbitrary-length messages, that workaround won't be needed.

- Eric

