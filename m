Return-Path: <linux-integrity+bounces-3595-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FD39796A6
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 14:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FE21F219AB
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D121C3F36;
	Sun, 15 Sep 2024 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koV0K5od"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C73184E;
	Sun, 15 Sep 2024 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726404441; cv=none; b=Q/bBabOU3Q9h6mpPnBrsJ0OEH8g21fLDz8SawZuChCOWS0EqiGC+9gOgnR+K4Y4BekfH8TNQoB/Q5XHD8xIeT73aHEM/e3yl2IMUL/BNeM2ckixWnaIQGOhODQnCZqmbAe2tN88fnlDc6r6UWA6KFvoeK+DEeoaHCE+A/9iD6TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726404441; c=relaxed/simple;
	bh=1ywnZf3g9854z7KIjcCmWdr5jWxssc890jorZeCzGO4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nDNbZOfAbLIVazlHKOFvoQM5S5Mx5E+VkPdL7xnZl7yDY4Z6az27F4ynZweLTAEyFZ2lDdS9GnEInA6bdbe3kXpQmnWi0iLAD0KIetphNCZlU7PXBFvFRWWSbocYyqOZ4Z/X9/mPgRE0pVHvmNLN/UyxyIB4Ob5lGb22uKxNo8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koV0K5od; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C73C4CEC3;
	Sun, 15 Sep 2024 12:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726404440;
	bh=1ywnZf3g9854z7KIjcCmWdr5jWxssc890jorZeCzGO4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=koV0K5odSTK2uIwaVE5THLKLkFCCDaUfMdCc+0gZN1vE6jrO98R+4v21tFh/LlA9T
	 vUWmPoD6RR3MA6cNNwRUNsS4VqPMRh/iqIZlymBCpn+Xitzzqpk162oCtUcYQri9wC
	 /U39yTiICNFr5DLzXYefGHgXkUXdJFx0+HcfTHjs3ilf4iH4hPVGvVufyHx5HcrCEm
	 lsUPi4oJbdWsxh/C3FgiUTS9oJNrZ6g+KI0siIP5yKzPcHqueJOflxlfDt65Dn+TI6
	 DTac0MXTlFuEY/80gKXxLtDomUQuTV0Xd+uH/HNS8nqznR5saMF3FAgL97Ms3o1sXy
	 wGJxu/zx4Kl5w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Sep 2024 15:47:17 +0300
Message-Id: <D46VAPJWL4XT.DDHV1DEB4ATO@kernel.org>
Cc: <James.Bottomley@HansenPartnership.com>, <roberto.sassu@huawei.com>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: remove file header documentation from
 tpm2-sessions.c
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240915123315.10999-1-jarkko@kernel.org>
In-Reply-To: <20240915123315.10999-1-jarkko@kernel.org>

On Sun Sep 15, 2024 at 3:33 PM EEST, Jarkko Sakkinen wrote:
> The documentation in the file header is duplicate documentation, which
> is already addressed elsewhere (tpm-security.rs and function associated
> documentations). In addition remove the invalid newline character after
> the SPDX tag.
>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> It is good time to remove this finally before doing anything else.
> Unless someone commits to maintain this part of the file, I will just
> take it away because I have neither intention nor motivation to maintain
> it. Came right on front when I started to look into kernel command-line
> and optimizations for session life-time so thus the patch. I'll include
> this later on to a larger patch set.

Moving forward to actual fixes is to fixup tpm_chip_boostrap() as
follows:

1. Saving the handle and not saving the context in the null key
   creation. I.e. rip of create_primary_null() or whatever the
   function was called.
2. Use that handle to go through selftest.
3. Save the context in the end of the bootstrap.

That cuts out unnecessary overhead of saving and loading context
between null key creation and selftest. I'll do this fix and see
how much it affects the boot time.

BR, Jarkko

