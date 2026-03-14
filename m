Return-Path: <linux-integrity+bounces-8996-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKHqJguotWll3AAAu9opvQ
	(envelope-from <linux-integrity+bounces-8996-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Mar 2026 19:25:15 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DB628E6B8
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Mar 2026 19:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A604F302DB7E
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Mar 2026 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD49336EC0;
	Sat, 14 Mar 2026 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8k0Njvp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3DC3368B5;
	Sat, 14 Mar 2026 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512703; cv=none; b=RPJEIshwI3zK+3D+Df5GTwF1gp6dqKNW20KjHYsIux582BeQCFv3rvIAKwidhkf2Wmcc5tjRI/9Yg0XYdTQXp2A7rgW4gkhnKsohpFjFXk0I9khVIPx4+h4B3eurgpvqmyVygEp5/aPTDzlt36QtAxq/RgPWOHFtUhXVE5C3Rxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512703; c=relaxed/simple;
	bh=uWliVXCLJ8jcsB8SlO/Qp6auFR57J27mbGBvyxn1CCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7K48vANM3glg2tnHCF7aUkEsMYWhGuVFpu7dRhZtzzeKv5Df2P1BCMuLJ5iWxN99oOKMX7CEYBPGTMmY65HlJW0TscMSo1tGZaIN9U3DFrp0lL9ENvj1ryGB66ZFGzMYvGBeU9S5n8YqtoPyJcogPMlSBFfEHUEbvd7j3M9krQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8k0Njvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBE1C116C6;
	Sat, 14 Mar 2026 18:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773512702;
	bh=uWliVXCLJ8jcsB8SlO/Qp6auFR57J27mbGBvyxn1CCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n8k0NjvpDVx32uwjWqN2h+xhEwkv4puUxp8XZ3HHgJohHO3AylJBrnSq1LWpR8OuD
	 YQbocc7ZC/UFhgpn63HXlfuYlY91pqVK5zlPlRKj691dE+17Flg9f0ufT9C2vwElNi
	 T+j9XS5G/Zx2ypztqR1hJ4CGFSBhV0zDjdvFPfc1bg87P2ovilhTpugrAulItlgfVL
	 +IyNfLNHXcnoBLpLJ4VsBC5XgSLRLR6mTL7XLOzYt7Pc83LTq2Oz9p0KYSCSKK8eRD
	 cXeiQOTmn1HEFSYJeyY+VYqzAxFn1ncVbfwd32g8Lbi+VuWuIqM6AO4lQc6DmjEF6m
	 fE0DNTUmYyKfA==
Date: Sat, 14 Mar 2026 11:25:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ima: remove buggy support for asynchronous hashes
Message-ID: <20260314182501.GA40504@quark>
References: <20260312053933.53012-1-ebiggers@kernel.org>
 <1c5f16f0913bae48bf2f24feaaaf3525ecdf4c97.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c5f16f0913bae48bf2f24feaaaf3525ecdf4c97.camel@linux.ibm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8996-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,huawei.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10DB628E6B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 07:29:05PM -0400, Mimi Zohar wrote:
> On Wed, 2026-03-11 at 22:39 -0700, Eric Biggers wrote:
> > IMA computes hashes using the crypto_shash or crypto_ahash API.  The
> > latter is used only when ima.ahash_minsize is set on the command line,
> > and its purpose is ostensibly to make the hash computation faster.
> > 
> > However, going off the CPU to a crypto engine and back again is actually
> > quite slow, especially compared with the acceleration that is built into
> > modern CPUs and the kernel now enables by default for most algorithms.
> > Typical performance results for SHA-256 on a modern platform can be
> > found at https://lore.kernel.org/linux-crypto/20250615184638.GA1480@sol/
> > 
> > Partly for this reason, several other kernel subsystems have already
> > dropped support for the crypto_ahash API.
> 
> The performance benefit was the ability of reading and filling a buffer from 
> disk, which was slow, while the other buffer was sent to the crypto engine.

On normal filesystems, sequential reads from a file already kick off
async readahead.  So the hashing and disk reads can already happen
concurrently anyway.

- Eric

