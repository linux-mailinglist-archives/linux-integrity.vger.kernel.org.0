Return-Path: <linux-integrity+bounces-7195-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A616AB89665
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 14:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700BC585D14
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 12:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0CF30EF95;
	Fri, 19 Sep 2025 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk1oRAv7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346630E836;
	Fri, 19 Sep 2025 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284179; cv=none; b=FhqpOXp56+VgxuFOXR0VBZh8apbmM+7n2tdM22cASXpbckHT6xXRm0+upPREtjW5yyqO4pnVLvBJuK2HkAq/azmQ5Y3vzoIv6Py3XhUINUsXyTstkKReHcdnUoEeI6QlywPUg+gvlNgT8dTY0jP1g2O9H0btTP5ma0hHWzjTLL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284179; c=relaxed/simple;
	bh=Jq+uV7DerM2WNwCWTFS0Xta6WG3HpiW8FkneVrMyWA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqEKl4lAEZIkUVZb7osXs2wOkSsA6NENOpAk3eF99aiBaIESyP2oNzwALsnyaVaXtJsCSWpwB+BqJkZXAmmpjDujw/7SV3tI3OpjsZY3IFt5IaNvw7xYWCUaLi31oQj/rc1W/tvJOTN5x0qkrdhLiSZsltVguZDIMrH1CA4/KoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yk1oRAv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B77C4CEF0;
	Fri, 19 Sep 2025 12:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758284178;
	bh=Jq+uV7DerM2WNwCWTFS0Xta6WG3HpiW8FkneVrMyWA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yk1oRAv70m1CzPsg5kYDfioJDLx8DU+85LpFs/kda5V8dZ4eZ4PnkHlPNz+4Gyljm
	 NYKDBmi4hp2fG/rYUV1/Kk5lBcQt6CUgL8/LRiIBUDlib2RUstK+VXcY+6/WV2THXn
	 ixy1VWKPbpGIjNb5C3XO4Mu08RCzGpbZxmUip6+yhIPmsSziN/Kvx5z/pGRGyK61uz
	 RLHczb8tzwgPvp7goAyq1nX3NHqJavzZwzrqDnZeAeg1wf0dhOSfYp3Y59nwqkjjWm
	 owHrRqIij5mJClEq1M3fafYIvEmKmxltigZama2JVG435RmQbhBJl6FDnAUWH4qDDH
	 2IkgcFvx6yBNA==
Date: Fri, 19 Sep 2025 15:16:14 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	ross.philipson@oracle.com, trenchboot-devel@googlegroups.com,
	daniel.kiper@oracle.com
Subject: Re: [PATCH v7] tpm: Make TPM buffer allocations more robust
Message-ID: <aM1Jjgo2fZmFI3kH@kernel.org>
References: <20250919112448.2543343-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919112448.2543343-1-jarkko@kernel.org>

On Fri, Sep 19, 2025 at 02:24:47PM +0300, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Drop 'tpm_buf_init', 'tpm_buf_init_sized' and 'tpm_buf_free'. Refine
> 'struct tpm_buf' to hold capacity in order to enable stack allocation and
> sizes other than page size.
> 
> The updated 'struct tpm_buf' can be allocated either from stack or heap.
> 
> The contract is the following:
> 
> 1. 'tpm_buf_reset' and 'tpm_buf_reset_size' expect that on the first run
>    the passed buffer is zeroed by the caller (e.g. via memset or kzalloc).
> 2. The same buffer can be reused. On the second and subsequent resets the
>    aforementioned functions verify that 'buf_size' has the same value, and
>    emits warning if not.
> 
> As a consequence 'struct tpm_buf' instance can be easily wrapped into
> managed allocation:
> 
> 	struct tpm_buf *buf __free(kfree) buf = kzalloc(PAGE_SIZE,
> 							GFP_KERNEL);
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

We need this type of robustness to address:

1. More complex use cases such as HMAC encryption. No giving up on this but
   it is easier to experiment when the tools are solid.
2. More decoupled types might be needed for TrenchBoot / D-RTM use cases
   that some people are working on. The most likely use case in this are would
   be to make 'tpm2-cmd.c' a set of builders, and decouple tpm_transmit() from
   it entirely.

While I can describe this motivation only broadly, especially bullet 2 will
be tedious, if tpm buffers are no uplifted a bit (obviously that would also
require header split for tpm_buf* buf that is the trivial step).

Thus, it is right time to do this type of overturn. I.e., it does not
any of these particular paint points but we get a better playing field.

BR, Jarkko

