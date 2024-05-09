Return-Path: <linux-integrity+bounces-2356-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD258C122F
	for <lists+linux-integrity@lfdr.de>; Thu,  9 May 2024 17:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14232833D4
	for <lists+linux-integrity@lfdr.de>; Thu,  9 May 2024 15:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2F313C68C;
	Thu,  9 May 2024 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0KiHvcM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1633BBE3;
	Thu,  9 May 2024 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269709; cv=none; b=uhhIWVzXrE7rgLKofgAH5Z4paTtzk2OnEs/H4M+yJv7S/nODekqyz6MTNBY1Ofhc6l0axTAygyTWHJn4frNElvBlJVdOSdTB1l5CyjDPNPk4HmO/trcgQKxu1pfwRcQimmchs86eG1IDpRcAZDxXFcAqNbt6rP+ST2YB/WE9Y6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269709; c=relaxed/simple;
	bh=wcUJCc5Jd0sSuP3wsE984VDNHrBT9xCEyzalVdcN9ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fEdcKZM40L5JmKVbESjv9pnTiltgEJQRisUDD75v90zMnVOLk10QglzMWbcPmfp1df6Oe17ABA/repLf9DLcA8UcpQ+OqsHJ3nrUebod1Z3IyVBXOIaRNPVLtQyoU19fklwD9fKuOTj12t4X78WI9BSwv1DqMVHzAbbw2XNTSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0KiHvcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A463EC116B1;
	Thu,  9 May 2024 15:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715269709;
	bh=wcUJCc5Jd0sSuP3wsE984VDNHrBT9xCEyzalVdcN9ug=;
	h=From:To:Cc:Subject:Date:From;
	b=J0KiHvcMQ7bm6Z4VmXo/SfZXiaVOTRkl3gZY75q6NEFadKd5FxYTwb0t4Goz5ALXS
	 jTqybRq90giV/HQTpXwydp9l/MzSLXsVjww828l9YcZK5BToNakDeJH3Dpa5z4+GhF
	 8o/4vYhVAviaqv5pdBMQp5Oh++kT8nrV98FFAUxHJ0zH5mbPnoY24C53mKHuZXA8B/
	 M/xqfCaeuEpn7lqqV8wNyzRbsowaANpp5DmIAlxuCTsvy+ZhfDLahdB1pAhJpN41Ah
	 6ciuulS5PAfpr6XT8n7iPovQhblivyL+tC8UxOfSBoREhM45gsuWu48NgfxNolv1cM
	 dqd4rH1a/GqFA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: [GIT PULL] trusted keys changes for v6.10-rc1
Date: Thu,  9 May 2024 18:47:51 +0300
Message-ID: <20240509154751.25983-1-jarkko@kernel.org>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-trusted-next-6.10-rc1

for you to fetch changes up to 28c5f596ae3d1790cdc96fa5fc7370f934abfb2e:

  docs: trusted-encrypted: add DCP as new trust source (2024-05-09 18:29:03 +0300)

----------------------------------------------------------------
Hi,

This is pull request for trusted keys subsystem containing a new key
type for the Data Co-Processor (DCP), which is an IP core built into
many NXP SoCs such as i.mx6ull.

BR, Jarkko

----------------------------------------------------------------
David Gstir (6):
      crypto: mxs-dcp: Add support for hardware-bound keys
      KEYS: trusted: improve scalability of trust source config
      KEYS: trusted: Introduce NXP DCP-backed trusted keys
      MAINTAINERS: add entry for DCP-based trusted keys
      docs: document DCP-backed trusted keys kernel params
      docs: trusted-encrypted: add DCP as new trust source

 Documentation/admin-guide/kernel-parameters.txt   |  13 +
 Documentation/security/keys/trusted-encrypted.rst |  53 ++++
 MAINTAINERS                                       |   9 +
 drivers/crypto/mxs-dcp.c                          | 104 ++++++-
 include/keys/trusted_dcp.h                        |  11 +
 include/soc/fsl/dcp.h                             |  20 ++
 security/keys/trusted-keys/Kconfig                |  18 +-
 security/keys/trusted-keys/Makefile               |   2 +
 security/keys/trusted-keys/trusted_core.c         |   6 +-
 security/keys/trusted-keys/trusted_dcp.c          | 332 ++++++++++++++++++++++
 10 files changed, 554 insertions(+), 14 deletions(-)
 create mode 100644 include/keys/trusted_dcp.h
 create mode 100644 include/soc/fsl/dcp.h
 create mode 100644 security/keys/trusted-keys/trusted_dcp.c

