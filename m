Return-Path: <linux-integrity+bounces-7243-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5F4B96F03
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 19:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1589219C6B15
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 17:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719892773F8;
	Tue, 23 Sep 2025 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5OXlZvS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A7E2773EF;
	Tue, 23 Sep 2025 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647324; cv=none; b=Ci5KiR42xD4kvNgSzk1RSHHsoubkc/uVwdnrAHTnMfBJ3fFlH1RWHbJ1i04mGBwnlDdEIu6S+UAk39axcMUCv2bzU2v3rmCfsmqxpCJptLk/16j2ulC/pAWQ06mSHGreQ+CiilyBwS9uxnsq4HJj7raGoYSFQa6xcW7j8hp7E4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647324; c=relaxed/simple;
	bh=xLARWBaT8G+i09gvi71ZwdreL3BTX6otN5oFqE7wWNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QDACZViPLPE8AedorqHg0ykFVrXpk5oK1yky0eOV/Few2dBLl3OIGtIltehbll5KXCCcQApC5AX3xVEshbkARq298Ifn88llBhpXf1vhlvr/KovZ6Zigs0j7CRRhqpAzprOm3FzSYLQHpQH7KAtU9/Ot6yta+zwZY2DG5VGcdis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5OXlZvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7618C4CEF5;
	Tue, 23 Sep 2025 17:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758647324;
	bh=xLARWBaT8G+i09gvi71ZwdreL3BTX6otN5oFqE7wWNQ=;
	h=From:To:Cc:Subject:Date:From;
	b=T5OXlZvSVY/xEPCSoQ+QJE1hPnNuJxN1fduYKnarT7fjdXDzr60D/rjxx35Ytt2Z9
	 vUQ0VIcdjVMm+5M1ja+qBZYEGHnR1oPYeBTIFqYHCav0BDB2QJDmGPeg3++O3Ij9tv
	 HPyW06Xg+3d6IdATIt9DohJa8XDACIxcBTjMXnWzmOXpTsoL7SOEoeOkkjH5xdvY9A
	 llA0g09sLnXmltmdCV3vfvpcfHN7cRZwAz6QgQwbNayFdDGLAadyuaEnEsWaNEtFVa
	 OFY3ILNW4ZEN0MmArtUj7ZwuxdHyQMFucPSoq/H2tra7rJmw7WzF58P4OBnrgdxIOp
	 5O98cdRRxLfcA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 0/3] tpm: robust stack allocations
Date: Tue, 23 Sep 2025 20:07:41 +0300
Message-Id: <20250923170744.1749132-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. These are previous changes to tpm_buf, which make stack allocations
   much more feasible than previously.
2. Migrate low-hanging fruit to use stack allocations.
3. Re-orchestrate tpm_get_random().

Jarkko Sakkinen (3):
  tpm: Make TPM buffer allocations more robust
  tpm: Use TPM_MIN_BUF_SIZE in driver commands
  tpm orchestrate tpm_get_random() in the function

 drivers/char/tpm/tpm-buf.c                | 139 +++++----
 drivers/char/tpm/tpm-dev-common.c         |   4 +-
 drivers/char/tpm/tpm-dev.h                |   2 +-
 drivers/char/tpm/tpm-interface.c          |  36 ++-
 drivers/char/tpm/tpm-sysfs.c              |  20 +-
 drivers/char/tpm/tpm.h                    |  16 +-
 drivers/char/tpm/tpm1-cmd.c               | 177 +++++------
 drivers/char/tpm/tpm2-cmd.c               | 349 +++++++++-------------
 drivers/char/tpm/tpm2-sessions.c          | 127 ++++----
 drivers/char/tpm/tpm2-space.c             |  44 ++-
 drivers/char/tpm/tpm_tis_i2c.c            |   4 +-
 drivers/char/tpm/tpm_vtpm_proxy.c         |  34 +--
 include/linux/tpm.h                       |  28 +-
 security/keys/trusted-keys/trusted_tpm1.c |  34 +--
 security/keys/trusted-keys/trusted_tpm2.c | 156 +++++-----
 15 files changed, 556 insertions(+), 614 deletions(-)

-- 
2.39.5


