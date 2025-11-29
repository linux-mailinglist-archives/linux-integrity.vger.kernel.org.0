Return-Path: <linux-integrity+bounces-7741-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 609C5C9484F
	for <lists+linux-integrity@lfdr.de>; Sat, 29 Nov 2025 22:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4DC33452DC
	for <lists+linux-integrity@lfdr.de>; Sat, 29 Nov 2025 21:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5477E246333;
	Sat, 29 Nov 2025 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihSv94jt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21005190473;
	Sat, 29 Nov 2025 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764450594; cv=none; b=ddWSwkkDnGDs1iKPRLzcX5KIEDMhhcZ8tmVxQYXupsOkluYGLZz63KmJ/orvM/K3eN68upe3iN7US+oZEOWFob9KHwIyCnf5tdPkKnmKr9TDoTCZfeBNyEcXGOtvM6gdwm0tQX8o1x4ZBpQUvrjBHTbtagAriCaNOpHWG9/K0VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764450594; c=relaxed/simple;
	bh=KfJe3IriiswbX5eyTTFTkyFyP3ZCsV/eRNW1Zl5dKAM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D+mWZJWZ8YY0otJ4hc58D9EjJrdVFFIWfxOZ+lVHUKOAzFEm71Y8T2LBB59swvxzL02czMdcOr3kFnHDp+vyRsP0OSyITZ+rs+j99H3ZREc4kVvy0JUmEvNgv5/dM40LAAl7TUrMepD+5aEkGsXOwRfYy21QaNwoM01q9mjh+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihSv94jt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F117C4CEF7;
	Sat, 29 Nov 2025 21:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764450593;
	bh=KfJe3IriiswbX5eyTTFTkyFyP3ZCsV/eRNW1Zl5dKAM=;
	h=Date:From:To:Cc:Subject:From;
	b=ihSv94jtlpgmvVsLrwOuPV+1zE2vC1mXQUZBlTCiu3psxYjzRK8JqFz3LAD59PnH8
	 jpWPEVr0FSclBomWqxhOfIt/2OgRB+SLAYwe5WdwREIp1dbFoUAe6zqIcnJ2o1D6EL
	 W74YHRNsabkUG1M4liBb3rkv1kwTKHwCnAYG3zU322xmlHO7E8TV45V5BVtwPVnXG+
	 rSTLeKw5y++bK+PUNjzbhnEJe3xkycS0Wv9owj2Z5HpQ5YPrk6+KQnTQ30ko7dQpyY
	 q6/LVh6rB+sPXLXeORc+feSrfB+D2YOW3o7O21ApOni0Yhp4vRVXjLjAZqULcIR3nO
	 Xc7lQ9xyUCZqQ==
Date: Sat, 29 Nov 2025 23:09:48 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] KEYS: trusted: keys-trusted-next-rc1
Message-ID: <aSthHCovbsDZANsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: aerc {{version}}

The following changes since commit e1afacb68573c3cd0a3785c6b0508876cd3423bc:

  Merge tag 'ceph-for-6.18-rc8' of https://github.com/ceph/ceph-client (2025-11-27 11:11:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-trusted-next-rc1

for you to fetch changes up to 62cd5d480b9762ce70d720a81fa5b373052ae05f:

  KEYS: trusted: Fix a memory leak in tpm2_load_cmd (2025-11-29 22:57:30 +0200)

----------------------------------------------------------------
Hi,

This pull request includes couple of updates for trusted keys:

1. Remove duplicate 'tpm2_hash_map' and use the one in the drive via new
   function 'tpm2_find_hash_alg'.
2. Fix a memory leak on failure paths of 'tpm2_load_cmd'.

BR, Jarkko

----------------------------------------------------------------
Jarkko Sakkinen (2):
      KEYS: trusted: Replace a redundant instance of tpm2_hash_map
      KEYS: trusted: Fix a memory leak in tpm2_load_cmd

 drivers/char/tpm/tpm2-cmd.c               | 14 +++++++++++++-
 include/linux/tpm.h                       |  1 +
 security/keys/trusted-keys/trusted_tpm2.c | 29 ++++++++---------------------
 3 files changed, 22 insertions(+), 22 deletions(-)

