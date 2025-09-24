Return-Path: <linux-integrity+bounces-7271-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555BDB9AFD1
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 19:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C85E1BC0322
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0A1313295;
	Wed, 24 Sep 2025 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QG8yqqQE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2DE306B25;
	Wed, 24 Sep 2025 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733961; cv=none; b=lODgwNodzGGJJ4R+ciYi4eecNBT5IE8HCH7MI03mh21dpdSDcvCgKVcVFu6LX3qSnrZqS2gvmumZZZFJH95JLJRRMGYomEvf8gKSDJdKOOsTRiL18cPJ1e7rY8thWzY4PmGo/Ale3KyJGnNl6nVGd7+9nDbgOql9vYWyNEeg7oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733961; c=relaxed/simple;
	bh=+G9sv2tDc4FbEJzsjLgSznj7S3OGi2+iDf8vqIAh6FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbeZ+lKNUlnilCyVeul8V+HWIuJiszox2zTdACKTmfQ5V1hXoxKo7rAUbFOKQkpqaZPeZuZigG0evwo3wrRmJI6uH60nLiY8F4WRgBLnh1PfRd6KQZ7fUXKiZQB3QMnCS/GW75c4MKydb5/WGfTmIqlkhbir+/y0pKUSIA2VM3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QG8yqqQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73202C4CEE7;
	Wed, 24 Sep 2025 17:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758733960;
	bh=+G9sv2tDc4FbEJzsjLgSznj7S3OGi2+iDf8vqIAh6FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QG8yqqQE1PQFH/8YSN+ESa4kh7cft+zMFfmZAUdzYqgw3mAChbk0/cgF9xN8SLakQ
	 gKxK9kAZTlln4DIXdjU/J+UveGHUNdmviiFIwibYDqOy6zz2yXJS4BS0ml0lzvIEsQ
	 xCjDMBLYUd0771+EcKWjAurVG/rkgGmackxtqeOEd1TObVOUx33L4rzUhmb30s53/T
	 jSW4xzHCCUetWfTOd8PFeL4YSMjNG4yTqZiNRuGj+RYgKQ3LLd5vTcmwc6xuxfpHMX
	 lpYjy6Y3iXX9a1tY/mRjWx0WkYa/wRxy7Cyhs5v0QCLN+h7uSPlYR6V6kn8vbOLoR8
	 dH7dlupG80PNw==
Date: Wed, 24 Sep 2025 20:12:36 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] keys, trusted: Remove redundant helper
Message-ID: <aNQmhIFpnoKQP1W1@kernel.org>
References: <20250922164318.3540792-1-jarkko@kernel.org>
 <20250922164318.3540792-5-jarkko@kernel.org>
 <aNOr4_xLQ30iTRSe@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNOr4_xLQ30iTRSe@earth.li>

On Wed, Sep 24, 2025 at 09:29:23AM +0100, Jonathan McDowell wrote:
> On Mon, Sep 22, 2025 at 07:43:17PM +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > tpm2_buf_append_auth has only single call site and most of its parameters
> > are redundant. Open code it to the call site. Remove illegit FIXME comment
> > as there is no categorized bug and replace it with more sane comment about
> > implementation (i.e. "non-opionated inline comment").
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Seems like a reasonable cleanup.
> 
> Reviewed-by: Jonathan McDowell <noodles@earth.li>

Thank you!

BTW, I applied your patches to master:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/

I did not yet bother to test them other than compilation and checkpatch
but I'm testing this and tpm_buf-series so they will get a lot of stress
testing. I'll rebase 'next' once they are actually tested (before PR).

BR, Jarkko

