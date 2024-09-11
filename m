Return-Path: <linux-integrity+bounces-3517-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1202974F62
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 12:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E7BB25509
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 10:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BCC184555;
	Wed, 11 Sep 2024 10:09:21 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C12617C7CA;
	Wed, 11 Sep 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049361; cv=none; b=t1kiHV4NI0UcZu9oiwCOnPwnvaqKaXBkV7ngQdpl6QEbbLu6Ika/gcw2WM1ctCD9dq0xW4Z5GxX3okxk55MgK3hp7Jq38B/Tq35e4azUQ3Inep00rH0sBYmirQEMvMx4r0vw0uM+q5CUY4PNa9ZULYJtjDzUvwIwCFANXXRWSA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049361; c=relaxed/simple;
	bh=8+Ndaj3jZnhL5EDiXubNluJcb8oV14bVPogxa1ntrb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jw5x0qAKnQ3MNt9xIiz/MjagZSWp68akg4HrTkptxirCZ7Hmf+4UuwX+TY11/nwA5xY5WJQ7jX87Gb/r6RQJrlsgkXg/y5IZYzBNxIIv2rMUGFSvjIK3jQgN9ADgqGVtL0eKthh7JwDJelvG2Bociku8brm2LAjuyFqT9SSj4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 73F443000F00D;
	Wed, 11 Sep 2024 12:00:18 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 646BC37AFFA; Wed, 11 Sep 2024 12:00:18 +0200 (CEST)
Date: Wed, 11 Sep 2024 12:00:18 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mikhail Kurinnoi <viewizard@viewizard.com>
Cc: linux-integrity@vger.kernel.org, Matthias Gerstner <mgerstner@suse.de>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] integrity: prevent deadlock during digsig verification.
Message-ID: <ZuFqMgSfhIMkoIOH@wunner.de>
References: <20180627163342.3e1d6333@totoro>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627163342.3e1d6333@totoro>

On Wed, Jun 27, 2018 at 04:33:42PM +0300, Mikhail Kurinnoi wrote:
> +int integrity_kernel_module_request(char *kmod_name)
> +{
> +	if (strncmp(kmod_name, "crypto-pkcs1pad(rsa,", 20) == 0)
> +		return -EINVAL;
> +
> +	return 0;
> +}

Just a heads-up:  The above was applied as commit 6eb864c1d9dd
("integrity: prevent deadlock during digsig verification.") in 2018.

In 2021 the kernel gained support for ECDSA signatures,
in 2019 for ECRDSA (GOST) signatures.

If kernel modules are signed with ECDSA or ECRDSA, you may once again
see the deadlock addressed by the above-quoted patch and you may need
additional string comparisons to avoid it.

There's a (stalled) effort to support RSA PSS, this may likewise
require yet another string comparison:
https://lore.kernel.org/all/20210420114124.9684-1-varad.gautam@suse.com/

You may have to come up with a solution that doesn't require adding
new string comparisons as this isn't scalable and it's easy to forget
amending the string comparisons when new algorithms or encodings are
added to the crypto subsystem.

Thanks,

Lukas

