Return-Path: <linux-integrity+bounces-6226-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF91AB7B5C
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 04:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD551B673CC
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 02:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9705627933E;
	Thu, 15 May 2025 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpZcvMPR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D692367C4;
	Thu, 15 May 2025 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747274409; cv=none; b=mCG2WPv0rPlnk+foFoeNcjRIbL8fzhAZPSWJ8lmtx5c0RkA6aNXSAFz6gmA4qobzbanb0skTfKTjfAxPY1zl+Hoy7Znw30O5trRePNTmeAf2Nr6+S1nOq0ZN4qBDPThYlZJ943CMNmVYAFt52H3CMN8H7qy2VCXSgs8VSwwObrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747274409; c=relaxed/simple;
	bh=+5hCB7PmCmZ0EaLxPYUbEWrfqZk+o3hUvq+oXXZpfJ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=FG51fWw6eN1MhHpYBu05zZhDLbMb/tzTy+ypKzzpYIAArzPRGjAnX9AMph6qsIPsBj1stpKXVpI1ltQKVh1tKQQmqW1J4aEqtJQXK0WZzKQe09JLTQx+QD32jhZ2dxObYAKReHlz48s/IpJzU7a2WtDASv7nsqZ03Ua2Rr57dAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpZcvMPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469F4C4CEEB;
	Thu, 15 May 2025 02:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747274408;
	bh=+5hCB7PmCmZ0EaLxPYUbEWrfqZk+o3hUvq+oXXZpfJ8=;
	h=Date:Cc:Subject:From:To:From;
	b=YpZcvMPRF6ikrYqEDwfQLxa5GWYOIFcaRFStUvCJNS1YGwy9SNBw2UYydX7H9FJ7E
	 8Ltr/eZOsjLW1oBQfOS7M3Sq3FvpumfS18qa1JfP4+P27hUlNG1r6XakCwyXcBrT6+
	 nD2YU3B1JCqSp1jR0zrGWJa/rS9XCGPNg6y5PT9PGHkhOzKWuW0+4wW9WaMx8bmCsd
	 VckrZeOSqAsKU4HGlyrBQApM7N9lvLxUJbOAchxvWgyCqipsK+FlZUSlf+vuxMVR65
	 MivZZJYNoAFzEKuXjgWlCQEqpjy7R1lXg3DHmHVFg/4R1SiNmd3zaNEE+kPxIemVRq
	 v5UlFfteacxaA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 May 2025 05:00:04 +0300
Message-Id: <D9WD3016M557.1ZXO3GLKGUIIF@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Sasha
 Levin" <sashal@kernel.org>, =?utf-8?q?Michal_Such=C3=A1nek?=
 <msuchanek@suse.de>
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.15-rc7
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.20.0

The following changes since commit 74a6325597464e940a33e56e98f6899ef77728d8=
:

  Merge tag 'for-6.15-rc6-tag' of git://git.kernel.org/pub/scm/linux/kernel=
/git/kdave/linux (2025-05-14 18:39:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpmdd-next-6.15-rc7

for you to fetch changes up to 2f661f71fda1fc0c42b7746ca5b7da529eb6b5be:

  tpm: tis: Double the timeout B to 4s (2025-05-15 04:49:15 +0300)

----------------------------------------------------------------
Hi,

Contains a few last minute fixes for v6.15.

BR, Jarkko

----------------------------------------------------------------
Jarkko Sakkinen (1):
      tpm: Mask TPM RC in tpm2_start_auth_session()

Michal Suchanek (1):
      tpm: tis: Double the timeout B to 4s

Purva Yeshi (1):
      char: tpm: tpm-buf: Add sanity check fallback in read helpers

 drivers/char/tpm/tpm-buf.c       |  6 +++---
 drivers/char/tpm/tpm2-sessions.c | 20 ++++++--------------
 drivers/char/tpm/tpm_tis_core.h  |  2 +-
 include/linux/tpm.h              | 21 ++++++++++++++++++++-
 4 files changed, 30 insertions(+), 19 deletions(-)

