Return-Path: <linux-integrity+bounces-7247-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B0BB96F51
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 19:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6B519C636C
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 17:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C8B2571BC;
	Tue, 23 Sep 2025 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="ElhrnBy5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1295A27A45C;
	Tue, 23 Sep 2025 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647397; cv=none; b=c8eu1XKCQHy/y64i7cp4EkXQnoO/ikRoBYRkY+O2fR8vEp50PE60FlJXaiXYpwI+5pm8HonYaGEoBM1xy6O7YZKMsP0GvSLgk5REt2jLsPduwMR2MC7A6+LdG1R8rlvLTbzpl8bK5ODhNGiIOmVzGlZenTipCa41YlJ3O1jnLi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647397; c=relaxed/simple;
	bh=TkQqqz1Mp+1mQ0Cua+B0k8S3VCvOEQduFfEg9pdmdf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6msi15Ebvns78ZlOj2RGUIs6qXm0th/HnZ0BlYqoR+bXHz5Te2VMkC2SogsfiyJpFht0R9hG+g3jZFEddYJKBfgIRlJ+ZrPT/MZVE6BSatrOiA0mPLeJc+o69JJZpqxISRNoz+7uKVmrZc8uvZWfpDMno0xnHITx5NKfh5j1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=ElhrnBy5; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=e2b9B9cX3YLpjPIJ2b344k7fqyDfpXDvhWnchqYiv3I=; b=ElhrnBy5J4qLRs6R+01RRq9Dmc
	8sqcKveyGo3cnMnlSTsqPxmrSIpMiXiwMkysjUFNv28RKUmZRUzyUZMkVUlbZSozQu5zkzWLXOyEq
	wLxq6Ff7qOUrdCe5ca4vyYUZJ0hLhr03Szz9LqTMscAx7Y/Vpg65BlLA1Jtf86TXB2Rbt040owmZt
	6L66MwodysxQtH544y8w4W1OCU3b2NWE+cKZpHwJgVqg1ojNPI7gDJKgC7CRgGCOqyRqWnNOwShNL
	lBJhs+PKjTKGdzHUAtwu3eL+ezEdqwHAlFxHoGFreUha/jKN2LTMfliffeUmFgXeZQLjcwLYH3IgY
	+9lkMFlg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1v16WV-00CZi8-1o;
	Tue, 23 Sep 2025 18:09:51 +0100
Date: Tue, 23 Sep 2025 18:09:51 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Re-establish ability for exclusive TPM access to
 userspace
Message-ID: <cover.1758646791.git.noodles@meta.com>
References: <cover.1756833527.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756833527.git.noodles@meta.com>

I hit a problem last week were ~ 1% of TPM firmware upgrades were
failing. Investigating revealed the issue was that although the upgrade
tool uses /dev/tpm0 this does not actually prevent access via
/dev/tpmrm0, nor internal kernel users. It *does* prevent access to
others via /dev/tpm0

So the upgrade process started, the HW RNG came in to get some
randomness in the middle, did the HMAC context dance, and confused
everything to the point the TPM was no longer visible to the OS even
after a reboot.

Thankfully I've been able to recover those devices, but really what I'd
like is the ability for a userspace tool to exclusively access the TPM
without something coming in behind it. Given the lightweight attempt at
locking that already exists I think this was the original intention.

As an initial approach I propose this patch set; I don't think the first
2 patches are controversial, but the blocking of kernel access + switch
to O_EXCEL in patches 3 + 4 might be. I'm open to alternative
suggestions about how to achieve this.

(I've sent a separate standalone patch that allows the TPM HW RNG to be
disabled at run time, but even with that I think something like this is
a good idea as well.)

Jonathan McDowell (5):
  tpm: Ensure exclusive userspace access when using /dev/tpm<n>
  tpm: Remove tpm_find_get_ops
  tpm: Allow for exclusive TPM access when using /dev/tpm<n>
  tpm: Require O_EXCL for exclusive /dev/tpm access
  hwrng: core - Allow runtime disabling of the HW RNG

 drivers/char/hw_random/core.c     |  9 ++--
 drivers/char/tpm/tpm-chip.c       | 90 +++++++++++++++----------------
 drivers/char/tpm/tpm-dev-common.c |  8 +--
 drivers/char/tpm/tpm-dev.c        | 27 +++++++---
 drivers/char/tpm/tpm-dev.h        |  1 +
 drivers/char/tpm/tpm-interface.c  | 20 +++++--
 drivers/char/tpm/tpm.h            |  3 +-
 drivers/char/tpm/tpm2-space.c     |  5 +-
 drivers/char/tpm/tpm_tis_core.c   |  3 +-
 drivers/char/tpm/tpmrm-dev.c      | 20 ++++++-
 include/linux/tpm.h               |  3 +-
 11 files changed, 118 insertions(+), 71 deletions(-)

-- 
2.51.0


