Return-Path: <linux-integrity+bounces-2355-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4793B8C112D
	for <lists+linux-integrity@lfdr.de>; Thu,  9 May 2024 16:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A414BB210E2
	for <lists+linux-integrity@lfdr.de>; Thu,  9 May 2024 14:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DD415E5B1;
	Thu,  9 May 2024 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mq83i2Lv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F7C15E1F8;
	Thu,  9 May 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715264803; cv=none; b=fHTCcTIRhDXI2KUZflvUpOgA67aZhNh5uCogcRCrvCLvNVRj0xqH48I0ZYCH2CglxgdEvreEZ4v8jsbJ8PK7ViOIB/kA07ijSsy2GkW0vqvodtDOo/eC0y9j6zlglCeuiLjKJjGbRAnZTrYL1yoa+TnZ3sSWeLpasvakjvwfUq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715264803; c=relaxed/simple;
	bh=SCaHMmd1m0QK7gnRTSHDhuSaxihiJErG4UxfHXLr1Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gi5qTBx/x1E5F0Nw0S2IELomZgibclEK5nSPVBMqvzRwI2gynOl7/j95pcjoaCv758gmGA8B+curXPm8aOk98U1vj4xAW3HkGOQ0H3NFOXQw3pqgRMx3PVh6TNzaphUyBV5mklEzXyENnOThALJiQug+QEzY/yxxkcHj6fYRhsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mq83i2Lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AD6C116B1;
	Thu,  9 May 2024 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715264802;
	bh=SCaHMmd1m0QK7gnRTSHDhuSaxihiJErG4UxfHXLr1Go=;
	h=From:To:Cc:Subject:Date:From;
	b=mq83i2LvIcvAUmFlwWSbH9rp73iD39gAd6teIYv0nnXhd0pTxFeFkJ/E+RCWKq8jP
	 WysFRGljckNhwwp8NmtcaRN6+GM9igeC0LHv7s1IM0ft9j1j31EQ3v+FbgiWaEtzgR
	 9eMdZcQmjFf/L+gNkFNtMI7zhNroPa0lYNifqqRFabl3rycEV8n6uVCEze+xEVbv0P
	 0Pl8Bh3P6TNgkbtZEQvjhJxYyfE7UHwinJ9yuLzMObfGDt0zhs/IMfx8e9ECo+S+bG
	 d0valGYk5V7hBUpu3eLn2AUR7Mn+DMS5YCzE/ZI7jeWkd3VW6d++ktnXJbdk3a+6Gs
	 3PR8LeXZbXmag==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: [GIT PULL] keys changes for v6.10-rc1
Date: Thu,  9 May 2024 17:25:17 +0300
Message-ID: <20240509142517.2787-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  Merge tag '6.9-rc7-ksmbd-fixes' of git://git.samba.org/ksmbd (2024-05-08 10:39:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-6.10-rc1

for you to fetch changes up to 9da27fb65a14c18efd4473e2e82b76b53ba60252:

  keys: Fix overwrite of key expiration on instantiation (2024-05-09 16:28:58 +0300)

----------------------------------------------------------------
Hi

2nd trial of the earlier PR with more appropriate tag:

1. Do no overwrite the key expiration once it is set.
2. Early to quota updates for keys to key_put(), instead of
   updating them in key_gc_unused_keys().

[1] Earlier PR:
    https://lore.kernel.org/linux-integrity/20240326143838.15076-1-jarkko@kernel.org/

BR, Jarkko

----------------------------------------------------------------
Luis Henriques (1):
      keys: update key quotas in key_put()

Silvio Gissi (1):
      keys: Fix overwrite of key expiration on instantiation

 security/keys/gc.c     |  8 --------
 security/keys/key.c    | 35 ++++++++++++++++++++++++-----------
 security/keys/keyctl.c | 11 ++++++-----
 3 files changed, 30 insertions(+), 24 deletions(-)

