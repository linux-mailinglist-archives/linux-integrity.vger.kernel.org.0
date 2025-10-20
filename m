Return-Path: <linux-integrity+bounces-7504-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EA7BF0E4D
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 13:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0901893417
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 11:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929EA302CD9;
	Mon, 20 Oct 2025 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="ZeskzsYD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC72FFDFF;
	Mon, 20 Oct 2025 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960588; cv=none; b=PokqaxgM77W8sTrlQ9Be+afzU0lxazDGndhXI2Bw9+SwUAXFUjJR8mIb4CIuE75it7njMTtd9BbnMLCmzxtH718+wxbegfmpX8vjThZGaK37ju6KOcU3fKw9iNipQ//fjAfi1dpUoBEvPlgUAz6FLdxgLg8h/dTFjAvc4V76mqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960588; c=relaxed/simple;
	bh=BVHGhjsqK9b4xu71d6bYhuw8ohlUq0hfSWRFMjoS2us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3W1fRqSYCDwHHY3GUQoNy9QPqQien2Nc+zKo4MjULnhtMwYZgYrKqeohImUbOsG5084FbISbRGMwI6FdUmSV5pAE0Pket5ni/sVhLDrqWy9JYKmfVp0I6f7tg/7kOR/4ckbdl8AGKrb4b6va5pst0O8PUIz+/53AMU2t87tKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=ZeskzsYD; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sGh+lXCxJLP2PCtNQCSqJwH2PFvRYf3kwyoAPzwi6ko=; b=ZeskzsYDXqPOHB5dSBDe6pqdU/
	cvZUjn4eTyzf22cno3nnnFvTDxUhg0jmRWnT2OFEKXS6DH9Tkzg3kgn6u0nGlJuR49ZQKT9TRoSLo
	Kui0O0lWBkKZG1epYUheSakicRJGGuY9hIbHvCPlQGmBgO/B2j911ORhMwd47rBUAvX/bn34tpP4d
	R3xIGVqYTyKj8aIxNu80t0upX8+BOzwrFGyqTGTMcbvB2Y9mCkI0EHcxIrakJZBV4EhUVAS71ZYwX
	kIUu+SLq/aADyTeuyd6RODDLP67z6pLm3d1hZErS6FFqiJXV7GiSpHjur1Z/hDiHFqjyYpPHMBgBa
	y0ngSvRQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1vAo5w-0017ul-1Y;
	Mon, 20 Oct 2025 12:30:32 +0100
Date: Mon, 20 Oct 2025 12:30:32 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] pm: Ensure exclusive userspace access when using
 /dev/tpm<n>
Message-ID: <cover.1760958898.git.noodles@meta.com>
References: <cover.1758646791.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758646791.git.noodles@meta.com>

I hit a problem where ~ 1% of TPM firmware upgrades were failing.
Investigating revealed the issue was that although the upgrade tool uses
/dev/tpm0 this does not actually prevent access via /dev/tpmrm0, nor
internal kernel users. It *does* prevent access to others via /dev/tpm0

So the upgrade process started, the HW RNG came in to get some
randomness in the middle, did the HMAC context dance, and confused
everything to the point the TPM was no longer visible to the OS even
after a reboot.

Thankfully I've been able to recover those devices, but really what I'd
like is the ability for a userspace tool to exclusively access the TPM
without something coming in behind it. Given the lightweight attempt at
locking that already exists I think this was the original intention.

I've reworked this series based on feedback received.

Firstly, it's been reordered TPM sharing functionality doesn't break
during bisection.

Secondly, the O_EXCL check has been tightend up to ensure the caller is
also opening the device O_RDWR. Callers shouldn't really be opening the
TPM except for reading + writing, but this should help guard against
unexpected flags usage a bit more.

Finally, this revision keeps the prohibition on more than one user of
/dev/tpm#, to avoid unexpected breakages for clients that expect this to
guard against multiple invocations. A client only then needs to use
O_EXCL if it wants to prevent *all* other access, even with
ContextSaves, such as the firmware upgrade case.

(I've sent a separate standalone patch that allows the TPM HW RNG to be
disabled at run time, and it's now in -next, but even with that I think
something like this is a good idea as well.)

Jonathan McDowell (4):
  tpm: Remove tpm_find_get_ops
  tpm: Add O_EXCL for exclusive /dev/tpm access
  tpm: Include /dev/tpmrm<n> when checking exclusive userspace TPM
    access
  tpm: Allow for exclusive TPM access when using /dev/tpm<n>

 drivers/char/tpm/tpm-chip.c       | 90 +++++++++++++++----------------
 drivers/char/tpm/tpm-dev-common.c |  8 +--
 drivers/char/tpm/tpm-dev.c        | 35 ++++++++++--
 drivers/char/tpm/tpm-dev.h        |  1 +
 drivers/char/tpm/tpm-interface.c  | 20 +++++--
 drivers/char/tpm/tpm.h            |  3 +-
 drivers/char/tpm/tpm2-space.c     |  5 +-
 drivers/char/tpm/tpm_tis_core.c   |  3 +-
 drivers/char/tpm/tpmrm-dev.c      | 20 ++++++-
 include/linux/tpm.h               |  4 +-
 10 files changed, 124 insertions(+), 65 deletions(-)

-- 
2.51.0


