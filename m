Return-Path: <linux-integrity+bounces-7788-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A46CA1C7E
	for <lists+linux-integrity@lfdr.de>; Wed, 03 Dec 2025 23:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C5E53006F48
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Dec 2025 22:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2EC2D063C;
	Wed,  3 Dec 2025 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9tDiqTT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459B2BD5A2;
	Wed,  3 Dec 2025 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764799941; cv=none; b=IQhIZRhf28kpxOFrtIq05YfcRXYNC6W+dqUghnPwa5kcTu33P+K96RfwAIc6Ja09kiZmGLIY5BrVG95xhPuAGYa5mpoSfCDD8SJ8Vi8gB0lKwzxpI37cq7zk6bnI68s8MkT80tdNBnl+TYyW3KsZSShAqk13VDkftaF8DUmtvOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764799941; c=relaxed/simple;
	bh=YL1+/H/7FLlGlHQZ4N3mMgUeDVzFLilSv+V57vloJRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KJHU6/saiNWjCW8x37i+cX3Ow7MfGAe52ssdSZICOKrS+3O/vCrT7J+GJxYbajGjhV+6bRaQQnB/dwKDctcW/e187RKCtofTK5iWXDe7cO18V3sD4PA6D3nGlTgjSzUrZ75UKjJVNEz/zmHQjsD5ZzTc1TFgPGL8FcPetZijkxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9tDiqTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E66CC4CEF5;
	Wed,  3 Dec 2025 22:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764799941;
	bh=YL1+/H/7FLlGlHQZ4N3mMgUeDVzFLilSv+V57vloJRA=;
	h=From:To:Cc:Subject:Date:From;
	b=e9tDiqTTb6XZNUVZp0kmCkqpyk9QXCKsX0hjKhK/YOYCACeLEADu1pc5WEMQlo1k1
	 UxK1K75jo+aeol8cK/1rkP7cc4uY90P7juNhUpzYpubjEfUC3RO9DSwlPhVHsKHGn2
	 JqumbRrzY9l/WJQsBRhPY05sykn/P07aeO/cjyPHV9A7//2/CUu81ZSEgc08kF7FMW
	 FiH96UV3NXJryIkEFZ6KH0mtPoski79Rta8x6Tfdi1dfxEAv/vFUgBDaaCQMXPWrO2
	 XfLXYOBEoXkcixVJbKdI5Fwn/z1AGPSNQbPsGgX1H+rMwtDtaMZDW9MDDoqZ7obNxh
	 /a3R5xwsJL/CQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jonathan McDowell <noodles@earth.li>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 0/4] tpm2-sessions: Fixes for v6.19-rc2
Date: Thu,  4 Dec 2025 00:12:10 +0200
Message-ID: <20251203221215.536031-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I collected the accumulated fixed for tpm2-sessions, geared towards
v6.19-rc2.

v3:
- Fixed two issues in 1/4.
v2:
- Addressed issues reported by Jonathan McDowell:
  https://lore.kernel.org/linux-integrity/aS8TIeviaippVAha@earth.li/

Cc: Jonathan McDowell <noodles@earth.li>

Jarkko Sakkinen (4):
  tpm2-sessions: fix out of range indexing in name_size
  tpm2-sessions: Fix tpm2_read_public range checks
  tpm2-sessions: Remove 'attributes' parameter from tpm_buf_append_auth
  tpm2-sessions: Open code tpm_buf_append_hmac_session()

 drivers/char/tpm/tpm2-cmd.c               |  42 ++++-
 drivers/char/tpm/tpm2-sessions.c          | 199 ++++++++++++++--------
 include/linux/tpm.h                       |  38 +----
 security/keys/trusted-keys/trusted_tpm2.c |  41 ++++-
 4 files changed, 204 insertions(+), 116 deletions(-)

-- 
2.52.0


