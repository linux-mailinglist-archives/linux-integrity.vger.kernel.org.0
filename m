Return-Path: <linux-integrity+bounces-3005-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38C5927D4C
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 20:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7D4283341
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 18:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961E66EB7D;
	Thu,  4 Jul 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkyE1hMP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371F4E1CA;
	Thu,  4 Jul 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119201; cv=none; b=OYl8bf/uRTjrLtIBEzVNNXO10nzoEuxv2CLDManqE8qwC8CYcPQtq22E2bTAZRmVhmvvzhe2E1lklzKEt1/lwCu8GAPZqvbN9mDy4AFpmLPU9e3HR4jh24lmaUaKQ7UsTRUVTjbd6VJ9EuO8apewJFeuTEN03tr65/ePv3WwBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119201; c=relaxed/simple;
	bh=CYarSEwmlNaTYzL/Nt8gn0Rbqf1Axm3ojbF4GWmppx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fG9DcJlWqYcdiV6R6r43MZJF+LPx1NGcrjDbJPetwXrNgxF8mWdKnE8BL946JZuohECaNJYPR/yVfDeaqImAHoaE9eekSxem+xb3nI/6NTIrw4JyZzc/l1HV3Z4+9TW6/IJLd6tN1FGiRE5TIFXS7JrbRuUppLxjt8KjYaSCmUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkyE1hMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62180C3277B;
	Thu,  4 Jul 2024 18:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720119200;
	bh=CYarSEwmlNaTYzL/Nt8gn0Rbqf1Axm3ojbF4GWmppx4=;
	h=From:To:Cc:Subject:Date:From;
	b=pkyE1hMPc2e0AURPNzjW9xJHzsMAuoDmcWBJxevXKdYlcyNpbS4P81BCzssSQIkIN
	 jBJmMNy42KUL6cqXJ6Zu/TRKHc8/VEMJ61r+4WjlTm8u8uok2okbbHvPX3nRP5zwqN
	 1HCeFWmIofY1kkTNo1yb0mjBhMtwItMk03VWYw6qhHO8dSX1mJB/Cbnxn9HZSwo13/
	 ZBwqQWHlDtp9wiBXcJFYshpcCQNiVxrJJQSsvKW2XoDfLpZGDEPucdmQkRlcngkoMN
	 CEml0T9pEjPzqWJbYkxPtsYKClIP2c64D2hcTRBsg2TXhUpcNFbV7gaWXXe8PiEbwP
	 a9NT77lz/6nUA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: [PATCH v4 0/3] Address !chip->auth
Date: Thu,  4 Jul 2024 21:53:05 +0300
Message-ID: <20240704185313.224318-1-jarkko@kernel.org>
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

For drivers that do not initialize with tpm2_chip_bootstrap(), the lack of
auth sessions is reported once per power cycle by:

"tpm tpm0: auth session is not active"

This is expected output for the following drivers:

* tpm_ftpm_tee.c
* tpm_i2c_nuvoton.c
* tpm_ibmvtpm.c
* tpm_tis_i2c_cr50.c
* tpm_vtpm_proxy.c

They need to later on enable auth sessions, if they eager to. This
patch set only fixes any collateral damage of not doing so.

v4:
* Address:
  https://lore.kernel.org/linux-integrity/CAHk-=wiM=Cyw-07EkbAH66pE50VzJiT3bVHv9CS=kYR6zz5mTQ@mail.gmail.com/
* Git: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/?h=auth-null-4
v3:
* Address:
  https://lore.kernel.org/linux-integrity/922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com/
* Git: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/?h=auth-null-3
* Did a full QA run given the changes in config flag handling.
v2:
* Rebase to commit 8a9c6c40432e ("Merge tag 'io_uring-6.10-20240703' of git://git.kernel.dk/linux").
* Couple of cosmetic fixes.

Jarkko Sakkinen (3):
  tpm: Address !chip->auth in tpm2_*_auth_session()
  tpm: Address !chip->auth in tpm_buf_append_name()
  tpm: Address !chip->auth in tpm_buf_append_hmac_session*()

 drivers/char/tpm/Makefile        |   2 +-
 drivers/char/tpm/tpm2-sessions.c | 419 ++++++++++++++++++-------------
 include/linux/tpm.h              |  81 +++---
 3 files changed, 269 insertions(+), 233 deletions(-)

-- 
2.45.2


