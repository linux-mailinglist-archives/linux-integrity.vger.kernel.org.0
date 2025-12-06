Return-Path: <linux-integrity+bounces-7829-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5861FCAA530
	for <lists+linux-integrity@lfdr.de>; Sat, 06 Dec 2025 12:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC0F230136DB
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Dec 2025 11:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87950126C02;
	Sat,  6 Dec 2025 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4Tb9kKc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2AF3B8D70;
	Sat,  6 Dec 2025 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765020682; cv=none; b=CbfFGbIiwv0FN7+1EMMbbx56gXok01E99WT8ptyY5FT6Nf1HAG9f3UNkl8zCcYP6Jd4Uv9NC9lJCfW/7z3Ey8ffNIQbeknYbt1SLyqhOllIOIJXvnEgmu6kmZwEQQxNR1G+viv/tjl+nv9khElwOt0wPrNL1e8oyj5ivWJrAPjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765020682; c=relaxed/simple;
	bh=Ck13VDLGBRsb+G5GVGwMTmwg65IiR9oyUt5RqpBAiCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gx2d8/ElpQ2HRV5vP/VsKhdiTgW+zk3MObVpJ6CrTtZXfz9sUBuI0gYbXy9kwIqe8fjp+BoLGpknud6NQvjePr23Dvz2H79HmFYtjCNjaVNiFFmvRsgPZeWAcyeVMlVEcF683uaGA31XmYVb73J+Y0/Ka/61eqKeY5HhxvrUt14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4Tb9kKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593C9C4CEF5;
	Sat,  6 Dec 2025 11:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765020680;
	bh=Ck13VDLGBRsb+G5GVGwMTmwg65IiR9oyUt5RqpBAiCg=;
	h=From:To:Cc:Subject:Date:From;
	b=O4Tb9kKcKIXrDaExo9+s2b/1mg+NxRppDZp4XvpErRsEoweJg+OkCWCULYBX7XTdI
	 /iD6LrUtXJQUbsw9/yC+3N8uVjSt3zxMifuokh6PTQfs5DqW0USK4pfz0RHg3Yb/CR
	 tRmeyoHDy0KzMNEN9a710irEz9KL/LX94+ab7HKn7S3ZuWG8pszdjO+FFxHZjaVVVP
	 MI4vndXyu+6Ojy0TlP5yrfkDWAHGI4dS0ePJlMte5NG3aNhw2QhfEmDQnVMzgg30lo
	 GasM/1Ixb6iZL8LhjPiiMnjetPJrLLS008txV59bbmGXqkuSTPwQd0AxGjrbtcitnL
	 LZomjS4RlbHGg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/3] Implement managed allocations
Date: Sat,  6 Dec 2025 13:31:07 +0200
Message-Id: <20251206113110.1793407-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jarkko Sakkinen (3):
  tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
  tpm-buf: Remove chip parameter from tpm_buf_append_handle
  tpm-buf: Implement managed allocations

 drivers/char/tpm/tpm-buf.c                | 143 ++++++----
 drivers/char/tpm/tpm-sysfs.c              |  21 +-
 drivers/char/tpm/tpm.h                    |   1 -
 drivers/char/tpm/tpm1-cmd.c               | 166 +++++------
 drivers/char/tpm/tpm2-cmd.c               | 320 ++++++++++------------
 drivers/char/tpm/tpm2-sessions.c          | 144 +++++-----
 drivers/char/tpm/tpm2-space.c             |  44 ++-
 drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +-
 include/linux/tpm.h                       |  30 +-
 security/keys/trusted-keys/trusted_tpm1.c |  36 +--
 security/keys/trusted-keys/trusted_tpm2.c | 170 ++++++------
 11 files changed, 523 insertions(+), 582 deletions(-)

-- 
2.39.5


