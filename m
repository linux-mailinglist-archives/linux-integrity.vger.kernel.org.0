Return-Path: <linux-integrity+bounces-7722-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AB2C904D4
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 23:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C87704E3F07
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 22:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2547231771B;
	Thu, 27 Nov 2025 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5WKq6IW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F145030DECA;
	Thu, 27 Nov 2025 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764282987; cv=none; b=KTOeWeLbDBiWZxG1nKx1zUJOEmYaYR4g7MuuOju5aM+qC4YZFu1DIe/4/jIsD0zyHPDcua9/Eby0V9SfpqJ9TIArMulqmeoENXw4tZSw9cRBvgFugSf3x9WwinWN4XsJLBfApHsQq05FpThT6fQILfyYbu685pNSViY8plDrwII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764282987; c=relaxed/simple;
	bh=Ak37bImlPoiqUPvToZ1ajFQ0luYRtVu47yezi1mhZ5M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PHwP7CWKjQSfkEnZekKogG5MEhpFoO70wf4tUJrVhfnZQ/9EBRfFjEgX2V0ONNvj639BsbiMolI3GzbA6INABErknCvzc4M5d9HjyYMeiqPiXGl4zKIp9vzuQM2/n2/g7MH5PbbME9CuHihW2uh0trzh9BwbCXmzYb7NvuIXV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5WKq6IW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E645DC4CEF8;
	Thu, 27 Nov 2025 22:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764282986;
	bh=Ak37bImlPoiqUPvToZ1ajFQ0luYRtVu47yezi1mhZ5M=;
	h=Date:From:To:Cc:Subject:From;
	b=c5WKq6IW/P5t2aNyp/KpDssa34oxy+ylYq3Pt3CPbDvglLbGzW0TKPE7bE5CpMBBA
	 JuPsHHBgz8G9742GGwi1spf3MX0AEoWmCzK9xyGM8/P0mKa5M5yIRQFwf5yeSm+YmM
	 HCRxdiCCN9jc6J6ZyEBnZctl1YxdcOq0Zbu6Y18XZcaXqeSahH5ueA232cZAgQU79e
	 CLOu5c4ZwmOKZ+n/rZr3GTDgAxfwFt/J5ETUB5pv8wP3r6s3ivawFz9ZBexlE+cqVS
	 oFACDYl8qyr0l850pwvRaxclkKiQ96AlBZ6k/tdLnbKfzNIwdoteCUw3yptYjhMeDX
	 05ghOiAfWJBSw==
Date: Fri, 28 Nov 2025 00:36:22 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: [GIT PULL] KEYS: keys-next-6.19-rc1
Message-ID: <aSjSZj47-p_3i_Xn@kernel.org>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.19-rc1

for you to fetch changes up to 8c8e3df3d2f51e9a3f6f1a1112adf250f7652d42:

  keys: Fix grammar and formatting in 'struct key_type' comments (2025-11-27 23:56:58 +0200)

----------------------------------------------------------------
Hi,

This first pull request for keys contains only three fixes.

BR, Jarkko

----------------------------------------------------------------
Thorsten Blum (3):
      keys: Remove redundant less-than-zero checks
      keys: Replace deprecated strncpy in ecryptfs_fill_auth_tok
      keys: Fix grammar and formatting in 'struct key_type' comments

 include/linux/key-type.h                       | 9 ++++++---
 security/keys/big_key.c                        | 2 +-
 security/keys/encrypted-keys/ecryptfs_format.c | 3 +--
 security/keys/encrypted-keys/encrypted.c       | 4 ++--
 security/keys/trusted-keys/trusted_core.c      | 4 ++--
 security/keys/user_defined.c                   | 2 +-
 6 files changed, 13 insertions(+), 11 deletions(-)

