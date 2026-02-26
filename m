Return-Path: <linux-integrity+bounces-8561-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Fl1K8iPn2kicwQAu9opvQ
	(envelope-from <linux-integrity+bounces-8561-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 01:11:52 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CFE19F4F9
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 01:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 589613027B63
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 00:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83880824A3;
	Thu, 26 Feb 2026 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCynDOyU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8B4A21;
	Thu, 26 Feb 2026 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772064657; cv=none; b=pGHUkmz28HxTC9nxTZxPnKkBF2ZnqyfhKMqa+AC8/x0hy58ms6qjzg/Abh4JMWS360/VJ9CwqFtIzqshYZbvaAFm/t9knm7gxEGTAa53okMHg3t2ZCSIUJfrmT8qsrFZB0p5axzvW2xBJtiUNudl+LE2NcK1UrhZbPPSIhZ67iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772064657; c=relaxed/simple;
	bh=Hp8XdMbt8T9/DD+xxTRZWrJVGxrduonc71/LyubvrO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0zfE2LmxBV5imrvXdVA6p/ka9uLXL3nPGwLMBucKqyPNMFW0tAekriYXUFUnxNxVVXkDx6s4aR0JgOjlV2neSQdF/HjLvDeWysAn+P6itfZ5SQVd32atVhfAjS5O06pYQYjLp3VlLXTkMq6Nu37RQptqYLOvtmG2RR9VTqfqZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCynDOyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C3CC116D0;
	Thu, 26 Feb 2026 00:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772064657;
	bh=Hp8XdMbt8T9/DD+xxTRZWrJVGxrduonc71/LyubvrO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCynDOyUSyIUc8xszf6VlE+bVWzCsTD2J7PC4kD9e3AKvgz7NPklqOKnY/XfWO5kK
	 dV7oS8lkcSmWuHqyrW9e89NvTRFuLDG5IOnYJU3rXZBh7ysVFvTFfD85fdxSgN3Ixq
	 fL1DuMTF07JQnF/uVR7ym/mWiOPxhyi25jx05O9ubXIZyH7BmpKWG+eLDNm/1gFgEf
	 zT6hPr8/6ZRDJsXA6532ifUsXmQMXVbygqC1pHGHGlphKUpgJGX+BuelkZ2twyOWzo
	 TgMvdslJ9YH9++4JjN3tkrN4cIzcBrsbZJPkYT6Z841FOr3Tm6pfvQi2b8kVAbNiao
	 /b4NKlbQB7QuQ==
Date: Wed, 25 Feb 2026 16:10:49 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Coiby Xu <coxu@redhat.com>,
	Johannes =?iso-8859-1?Q?Wiesb=F6ck?= <johannes.wiesboeck@aisec.fraunhofer.de>,
	dhowells@redhat.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	roberto.sassu@huawei.com, simo@redhat.com, zohar@linux.ibm.com,
	michael.weiss@aisec.fraunhofer.de
Subject: Re: IMA and PQC
Message-ID: <20260226001049.GA3135@quark>
References: <aXrKaTem9nnWNuGV@Rk>
 <20260130203126.662082-1-johannes.wiesboeck@aisec.fraunhofer.de>
 <aYHznG6vbptVOjHQ@Rk>
 <ee36981d-d658-4296-9acb-874c72606b3e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee36981d-d658-4296-9acb-874c72606b3e@linux.ibm.com>
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-8561-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,aisec.fraunhofer.de,gmail.com,oracle.com,vger.kernel.org,huawei.com,linux.ibm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[keymaterial.net:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06CFE19F4F9
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 09:25:43AM -0500, Stefan Berger wrote:
> To avoid duplicate work: Is either one of you planning on writing patches
> for IMA to use ML-DSA and convert the current ML-DSA to also support HashML?
> I had done the work on this before and could dig out the patches again...

IMA already had to add its own digest prefixing support, since it was
needed to disambiguate between full-file digests and fsverity digests.
See 'struct ima_file_id'.  Thus the message signed is at most 66 bytes.

With that being the case, HashML-DSA isn't necessary.  It's not even
possible to use here, since there are no OIDs assigned for the fsverity
digests, so it cannot replace the ima_file_id.

I'll also note that HashML-DSA is controversial (e.g. see
https://keymaterial.net/2024/11/05/hashml-dsa-considered-harmful/),
since it was added to the ML-DSA specification at a late stage without
sufficient review, and what it does can be achieved in better ways.
Which is exactly what we are seeing here, since again, IMA needs to do
the digest calculation and prefixing itself anyway.

- Eric

