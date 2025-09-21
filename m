Return-Path: <linux-integrity+bounces-7207-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 941FDB8D349
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Sep 2025 04:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CCF1899705
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Sep 2025 02:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5481519AC;
	Sun, 21 Sep 2025 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA0LjxgU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15A82F2D;
	Sun, 21 Sep 2025 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758420492; cv=none; b=kr6AMoL2fpZQ6MUQ4fXz0/nAkrLdBkB9ue/afR7DADuMo2WOtQxfodGatfhX+BE1Ru51XGhl4YQOxfy55HDz7Vr623jEt6WhaXp/uqPJyoL4O5VnTVwk4DPF1hQUF2xbTYLIgGw5MlOy2d/ybVq9ybTdph9oVkfXmDdBdT0DvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758420492; c=relaxed/simple;
	bh=+CZ+wOxHyF9xzd1+hfdpLtpuvd5nO3Vu9O60ehQU2RY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aK8f38Q0XVFbo5ilPV7+mfmgr9iYl0VA6pOoYiUO9FPyiouq80EI9ynTi4i13CGvt+ux03bWpafXCvmQLpkzZV3ldzbz92U2LdnvkvSqVxf0fPEgzQhfRqxXgYhc2KRWSHtL0iIvSnJ9zxC/WEUGH0e1Mr7kyphBbl65HkEYXOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA0LjxgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B79C4CEEB;
	Sun, 21 Sep 2025 02:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758420491;
	bh=+CZ+wOxHyF9xzd1+hfdpLtpuvd5nO3Vu9O60ehQU2RY=;
	h=From:To:Cc:Subject:Date:From;
	b=KA0LjxgU+aXlqC1m6PV6BCLWts+zhRLnVeLKcfJUAEWybkgrqCFxcazwk/mkYEpat
	 QL4aG1uWi17iYMdamSh47JAcwFDJtKog1m8mAT0zEVGfb4n7ZiaEm2NmlbgpSNLRUd
	 xt+r6Fe5ClKJ2JA/4oiyrYqlJ11GH5xMa02FwEkk4bcOJeGKkc0UMd87KTs1O1DMLH
	 +YU3ahPDdLTpXmTFkd5yPudDDQMNj6+eE648ub5oLNvldij0JMbEE2GVPLb6lLDCUH
	 BO3vmPjaaMhC3aobIUv6DEK/hTX8AmrT6IQoQSJFUkZlRLGslRmS1QQ5bvHlA4aBI3
	 zTGv/tj/qpTmQ==
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
Subject: [PATCH v10 0/4] tpm: robust stack allocations
Date: Sun, 21 Sep 2025 05:08:00 +0300
Message-Id: <20250921020804.1088824-1-jarkko@kernel.org>
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

Jarkko Sakkinen (4):
  tpm: Make TPM buffer allocations more robust
  tpm, tpm1-cmd: Use stack for trivial cases
  tpm, tpm2-cmd: Use stack for trivial cases
  tpm_vpm_proxy: Use stack for TPM_CC_SET_LOCALITY

 drivers/char/tpm/tpm-buf.c                | 137 ++++++----
 drivers/char/tpm/tpm-dev-common.c         |   4 +-
 drivers/char/tpm/tpm-dev.h                |   2 +-
 drivers/char/tpm/tpm-interface.c          |   4 +-
 drivers/char/tpm/tpm-sysfs.c              |  20 +-
 drivers/char/tpm/tpm.h                    |   3 +-
 drivers/char/tpm/tpm1-cmd.c               | 151 +++++------
 drivers/char/tpm/tpm2-cmd.c               | 297 ++++++++++------------
 drivers/char/tpm/tpm2-sessions.c          | 121 +++++----
 drivers/char/tpm/tpm2-space.c             |  44 ++--
 drivers/char/tpm/tpm_tis_i2c.c            |   4 +-
 drivers/char/tpm/tpm_vtpm_proxy.c         |  34 +--
 include/linux/tpm.h                       |  28 +-
 security/keys/trusted-keys/trusted_tpm1.c |  34 ++-
 security/keys/trusted-keys/trusted_tpm2.c | 156 ++++++------
 15 files changed, 493 insertions(+), 546 deletions(-)

-- 
2.39.5


