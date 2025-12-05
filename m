Return-Path: <linux-integrity+bounces-7821-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 893B5CA8526
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Dec 2025 17:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DDE933B7903
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Dec 2025 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820393590DD;
	Fri,  5 Dec 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR3OL8fr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547E63590C8;
	Fri,  5 Dec 2025 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764948003; cv=none; b=J6AxvU5LrDDMfXALaV+nkQ5iEY8AsTsHiH0kijJEY7s/KAzkkpaNFrmmYmznqXaAbNRV0h2JD5HNV2jzcUt4RsqTbMzR2BqlFWZnb7J1ieS9tAhV+mewps1TONO6+g48aAAA0RC+t4nx9vfyc1rEMvQz0dkiiUNNRkScTtIBPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764948003; c=relaxed/simple;
	bh=LdI4Wl6PKH7yn8jbQ2r1c6ngqX+X6EB1d44byGV0EM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0Uy0xjqzYNIun9OkMqeoYFoktSjqlc/MakJwRK4Ty5WFf37uKw6Vx1+11CF+TyHR4lgk9XCE8K2aKfFmirAoogooe/GY7/2Z7uVDBaNj1ZhPIZN5v/vexfWCnAbrtdNWMonuixoisBfy+5lIBXpKJFDEtT1QW0M2mujNkGLQgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR3OL8fr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46CAC116B1;
	Fri,  5 Dec 2025 15:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764948002;
	bh=LdI4Wl6PKH7yn8jbQ2r1c6ngqX+X6EB1d44byGV0EM4=;
	h=From:To:Cc:Subject:Date:From;
	b=SR3OL8frUz8iiP696Wme83PX3qsnsnwm94M4A+WUxtWFMIz3l4YpeTGlmtDRbU33p
	 3YGcyIRAQDmJBSGXdCrEpv6eNAeihj6hfxB7t+q9AAXFxewWgCoty3iGPfA/azKexf
	 9tCN3kWRTLQ2bYf7QZlVbhury37PzmjMq7fgcaHQMhZ/q/uog3x767GXkFkVN/Xu6b
	 LyY8MmG3RlkeucvI15LTFVwzEZUCan4b3yuWNtkz5ptUGz6HcCQaTqQfr3GO39uVdw
	 FaisJd6/07blWOxHZ1Hi92jk3rxG5KJ4CImXOn9nJBFNq4ehm54c8Seb3Y6Z0MGh+C
	 8J7FBjANlwwxg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 0/4] Optimize tpm2_read_public() calls
Date: Fri,  5 Dec 2025 17:19:49 +0200
Message-ID: <20251205151955.298182-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main goal is fairly straight-forwrd here.

The aim of these patches is optimize the number of tpm2_read_public()
calls to the bare minimum. The last patch is a bit out of scope but
I included because it builds on top of this work.

Jarkko Sakkinen (4):
  KEYS: trusted: Re-orchestrate tpm2_read_public() calls
  KEYS: trusted: Store parent's name to the encoded keys
  KEYS: trusted: Open code tpm2_buf_append()
  tpm2-sessions: Enforce single authorized handle

 drivers/char/tpm/tpm2-cmd.c               |  93 +++++++-
 drivers/char/tpm/tpm2-sessions.c          | 169 ++-------------
 include/linux/tpm.h                       |   3 +-
 security/keys/trusted-keys/tpm2key.asn1   |  17 +-
 security/keys/trusted-keys/trusted_tpm2.c | 250 +++++++++++++---------
 5 files changed, 272 insertions(+), 260 deletions(-)

-- 
2.52.0


