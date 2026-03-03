Return-Path: <linux-integrity+bounces-8879-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIkuGG5Tp2lsgwAAu9opvQ
	(envelope-from <linux-integrity+bounces-8879-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Mar 2026 22:32:30 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F2A1F791D
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Mar 2026 22:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69A143143973
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2026 21:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC105425CFE;
	Tue,  3 Mar 2026 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdPm33CT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96410314A64;
	Tue,  3 Mar 2026 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573448; cv=none; b=pSCRFlvoobNUxNGctx/xDJEV7io1kM3ZW7dqf2OHBKeeyD5uARfPHI2C42ZxT7BTeQ0T0MRZHIcJ3gOnGPMdvq05j0HDOZHF18O8nQlN76hC6FFuMXBNfTtGd5nOY6JRex5jKVgYmkJ8Sj3tVWCiv9v0it0fEzSdaAMIRv4OR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573448; c=relaxed/simple;
	bh=4c0TFwH2b+pC4Fu9mQ0jIAlqb8vgIoFBsfbu1qKF5Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ma4pvVIarc46eOr+6amrPcOGZ0Nnk1WmTJVhThj6HKyO1X/A57NT7SiSaaEaUZ2vNAFweuntXQRa906t8FyIsEJR7bVNDHEwaAmCoIZQ8AgxzKQ9CpBkol/EEi3T/gr9CotaNx1jAzdizLw41ZLpVyguZ/WvR1T2SReBqTCDTo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdPm33CT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A827C116C6;
	Tue,  3 Mar 2026 21:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772573448;
	bh=4c0TFwH2b+pC4Fu9mQ0jIAlqb8vgIoFBsfbu1qKF5Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdPm33CT9vKuaJdE08c73fl9+Ivp84fXqk9CB4KIxnEWBRibooUEe5ecWwnDvIbpf
	 cph3GW5+3KlfuIeVn7KOel/x9D9EBKlWkPi5Z2mmWX1xwOPvesx1I9anh9sY8fRIC1
	 3gIMU5bR3ENXKHjeoFsY9q7FSGc5xgAEX35C+m3t1m+UORHn7zrySlnIx/HaIZAwqx
	 XhQxj3pke+Hpam0NBTJBelZfWdCWpnFr+sj/Ik4hciMX/b0DltBElCEKC2S3mNbLZ0
	 Hcl2DARBS6X6SdtT764dgWurtfm/HXVKZdjFHYYhdnz7UXw+pfoHqxqrRfFu7JDLli
	 vaxlpmCtXDsXA==
Date: Tue, 3 Mar 2026 23:30:43 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Chris Fenner <cfenn@google.com>,
	Jonathan McDowell <noodles@earth.li>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v9 01/11] KEYS: trusted: Use get_random-fallback for TPM
Message-ID: <aadTA3paHqNBlvSY@kernel.org>
References: <20260125192526.782202-1-jarkko@kernel.org>
 <20260125192526.782202-2-jarkko@kernel.org>
 <06a08cbbe47111a1795e5dcd42fb8cc4be643a72.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06a08cbbe47111a1795e5dcd42fb8cc4be643a72.camel@linux.ibm.com>
X-Rspamd-Queue-Id: 02F2A1F791D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8879-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 01:04:30PM -0500, Mimi Zohar wrote:
> [Cc: Chris Fenner, Jonathan McDowell, Roberto]
> 
> On Sun, 2026-01-25 at 21:25 +0200, Jarkko Sakkinen wrote:
> > 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and thus its
> >    use should be pooled rather than directly used. This both reduces
> >    latency and improves its predictability.
> 
> If the concern is the latency of encrypting the bus session, please remember
> that:
> 
> - Not all environments expose the TPM bus to sniffing.
> - The current TPM trusted keys design is based on TPM RNG, but already allows it
> to be replaced with the kernel RNG via the "trusted_rng=kernel" boot command
> line option.
> - The proposed patch removes that possibility for no reason.
> 
> Mimi & Elaine

I'm keeping this patch set in queue branch, possibly picking patches to
some other patch set or they are available for picking to other patch
sets.

BR, Jarkko

