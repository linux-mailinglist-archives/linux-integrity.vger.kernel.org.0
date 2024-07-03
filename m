Return-Path: <linux-integrity+bounces-2987-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F24C92680C
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 20:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7B21F209A6
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7F9186E32;
	Wed,  3 Jul 2024 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvKDuqd8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8011849EB;
	Wed,  3 Jul 2024 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031103; cv=none; b=F46Ew8qnUaKjpqdd9C6pRfd4rMxe1H7u/jamldguu186OUVPFBaz6+1S9mj+fs3cRN/ddPAW857HWGO5Byfrc9413l4kF93ogT047VCs4ugJlJOfMMGPKsGlgfKSXRLpnhJ3Vl7XuLWCn7zUmKZ78qPDH5sYZyo4Yfv3AX1n9DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031103; c=relaxed/simple;
	bh=P2JpZ39cO/wbzKDmrY/CH7fJrTG/jmJHZd2265VeCfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VS6vVqPREc2dx8OCJ1cqSHpI9qQF7RCFwAnp2MyY3NG3zj6s6MU3evub/GidQCV4nD0N2NrbgbLwgJkUSznceMmNeosOR8sYYSKJI7SsgLJihXI1+VL05KPYIhVZ/ROeiJ08P224t7rLkykrD38fELVXOxBawwZGkXuFuH1Uzjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvKDuqd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5138BC2BD10;
	Wed,  3 Jul 2024 18:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720031102;
	bh=P2JpZ39cO/wbzKDmrY/CH7fJrTG/jmJHZd2265VeCfo=;
	h=From:To:Cc:Subject:Date:From;
	b=VvKDuqd8aLd5fjX4UMNMkoHkqTzjFglHX24jmhqH6eavPxWNLvtZCtoGRc8D5TWJ+
	 yPUNKtcj0juyMeARoM7VwF28hFqqcbnvFSzaOlwILfMyfHs4Pvmr4V6lqxjE3cwFBQ
	 gbrIIv76Q3SyG1Pq1ePmhu2wcBaVBmpywzAuYqRHYzCkFRl/Ho8kRaybxyMA6YkfBL
	 2cvLLN5eSem9sAuQQwsVcJb67PhS/Eq0KBDMFz0Fvhr2umI/cLXfZBakKKBBnAGzV6
	 X2aYrEybi4kz+3GPBnd9TE/Kkbyv+/WRuxQiv7G8oer1Lfa+DGs5XWQOqcSK0zF2Kn
	 vneMiWQOSJpaQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Address !chip->auth
Date: Wed,  3 Jul 2024 21:24:47 +0300
Message-ID: <20240703182453.1580888-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unless tpm2_sessions_init() is called, then chip->auth ends up being a null
pointer, which is ignored by authenticated sessions code. These patches aim
to fully address the bug, and hopefully still make into 6.10-rc7.

Tested on x86-64 with:

- TCG_TPM2_HMAC disabled.
- TCG_TPM2_HMAC enabled.
- TCG_TPM2_HMAC enabled, and "/* rc = tpm2_sessions_init(chip); */".

v2:
- Rebase to commit 8a9c6c40432e ("Merge tag 'io_uring-6.10-20240703' of git://git.kernel.dk/linux").
- Couple of cosmetic fixes.

Jarkko Sakkinen (3):
  tpm: Address !chip->auth in tpm2_*_auth_session()
  tpm: Address !chip->auth in tpm_buf_append_name()
  tpm: Address !chip->auth in tpm_buf_append_hmac_session*()

 drivers/char/tpm/Makefile        |   2 +-
 drivers/char/tpm/tpm2-sessions.c | 400 +++++++++++++++++--------------
 include/linux/tpm.h              |  75 ++----
 3 files changed, 245 insertions(+), 232 deletions(-)

-- 
2.45.2


