Return-Path: <linux-integrity+bounces-7282-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA36BBA7E4E
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 05:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727C3175078
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 03:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C56212549;
	Mon, 29 Sep 2025 03:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/j1Xg4T"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32261F099C;
	Mon, 29 Sep 2025 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759118390; cv=none; b=jyIsI6T0fThh1NmsS0yBUr1Q4/GJ0WaVNHVvwiHC5hHyrb5BFOH2nrYa/+0SanD82FHLHKMVENoW0/xxDz3x4FDQvHZkhTP9XZ/595R8gOlPp5fUZIzQBdbRBLRBiPm6Pp7YNuxChtH8YmbfKQmw246LyKgqvTdUTpehlYaytbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759118390; c=relaxed/simple;
	bh=fs/cafiRVjlhVdgDg+QUuaTpLaFBVtomBFLuzSedfr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TbyIJlndFD0AFkekR04q4CrbMMiG9RB9mvLs26MTXYeQaCSaGULYFypj97RNuMGo40B/yXomlOfwGcHapI2bM7JRcxbYXyeWyvvuwtf/uaWZDejPT0O36OirOmbBhqau21B3V48HSq7lryfwvKZ30Nid37BXg/NESfO7EZS64nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/j1Xg4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17481C4CEF4;
	Mon, 29 Sep 2025 03:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759118388;
	bh=fs/cafiRVjlhVdgDg+QUuaTpLaFBVtomBFLuzSedfr0=;
	h=From:To:Cc:Subject:Date:From;
	b=P/j1Xg4TxjzwllW9tgQy2mffRRVp8IvtR0zVhXqz/PvgUai5WEClLcEeAQwRIpih0
	 VpvQCKdCfDWkpaGB//wh0h1hjwFjsIUFVzND2ivqiN2EFi29SIqjPmfzQptkNhd+rW
	 kwbtJvjylYnK1VX0YQXp0Z7JfBCemqRKNJ3NTO+tEqgAg0BiTElNx5AIBPSTMl+qev
	 I/AjkOp29VE/KbAnfa/Y6v+RH6pv5BJsp5bsnG7F8gvMzi50D5f6qzUCqNQWbtRpIR
	 HxFnL0YO9nCXTy9fRFXobDXHelX75Y0cdiiufy7UqYx+0eZiU9NuvmxZ2xGDXNoCvc
	 zGE0J1OYz64xw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/9] tpm: Decouple PCR extend from driver
Date: Mon, 29 Sep 2025 06:59:29 +0300
Message-Id: <20250929035938.1773341-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Decouple tpm2-sessions enough from implementation so that building for PCR
extend commands can be decoupled from rest of the implementation. This is
a mandatory for Trenchboot series, and including all these changes for
that series would over-complicate it.

This is first part of refactorizations for make grounds for Trenchboot,
and still aimed for 6.18. The second part includes robustness updates
for tpm-buf.

v2:
- While including fixes from v1, this patch set has a refocus in order to
  do minimal changes to make code base more compatible  Trenchboot.

Jarkko Sakkinen (9):
  tpm: cap PCR bank in tpm2_get_pcr_allocations()
  tpm: Use -EPERM as fallback error code in tpm_ret_to_err
  KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2
  tpm2-sessions: Remove 'attributes' from tpm_buf_append_auth
  tpm2-sessions: Umask tpm_buf_append_hmac_session()
  KEYS: trusted: Open code tpm2_buf_append()
  tpm-buf: check for corruption in  tpm_buf_append_handle()
  tpm-buf: Remove chip parameeter from tpm_buf_append_handle
  tpm-buf: Build PCR extend commands

 drivers/char/tpm/tpm-buf.c                | 85 +++++++++++++++++---
 drivers/char/tpm/tpm-chip.c               | 13 +++-
 drivers/char/tpm/tpm.h                    |  1 -
 drivers/char/tpm/tpm1-cmd.c               | 40 ++--------
 drivers/char/tpm/tpm2-cmd.c               | 39 ++++++----
 drivers/char/tpm/tpm2-sessions.c          |  7 +-
 include/linux/tpm.h                       | 61 +++++----------
 include/linux/tpm_command.h               |  5 +-
 security/keys/trusted-keys/trusted_tpm2.c | 95 +++++++----------------
 9 files changed, 170 insertions(+), 176 deletions(-)

-- 
2.39.5


