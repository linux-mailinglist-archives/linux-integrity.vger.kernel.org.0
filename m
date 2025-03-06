Return-Path: <linux-integrity+bounces-5140-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB16A55657
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 20:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD031898013
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 19:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A647C26FDA6;
	Thu,  6 Mar 2025 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWxDp7q0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB2526FD8C;
	Thu,  6 Mar 2025 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288421; cv=none; b=j69Z0ZZCalcF+ryGdVDtkyFeh8+8ViIILXzUZx1E+21Njd2gsYr35hhTtop5L0kAh+J4zCD21EcVM/y77MwiLuDU+nRQSCVoM7eji0T7BYW+ZAsYtP9x6wFASTptW2385gMYp/goKRbqOScloeqyLZJfj6tNdbWl8q1bevhbKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288421; c=relaxed/simple;
	bh=aSoRZEC9ihe1E97uZreVdlraRGF9Lh8i+uzdQMNL4wY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Qk82crHXzqnVXgZ/2MH3vvOQcHTlb71seyc3i4EdeMyh/UUfcG1VGCOenYXa44heVOHWuY8QaJeQfv0pUrDESkbmYAroWBA9cBVA4qJcF7MPXnhGM2emuAaBNYB7XD71YCP9ROaE8+BT1RaRmgYCSZq9CHT96VlU7Aznu5UqY2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWxDp7q0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489C3C4CEE0;
	Thu,  6 Mar 2025 19:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288419;
	bh=aSoRZEC9ihe1E97uZreVdlraRGF9Lh8i+uzdQMNL4wY=;
	h=From:To:Subject:Date:From;
	b=VWxDp7q0U+sVT3TUavg+ywSCX+7f/tcBP3OqsYp6OMdmLMqvIDvzdItOCV53cDHUV
	 kjtORyheop+XOZ+ncioQmZZl2Sa65iC4iuxCmbqb/pkTZW0IudxCzps5g6/mgVc0Va
	 5yp/Pf6Q+KxA861W2bkZNbfIhwG84dCWlXcRiD0Vmg8/uZ5hARAnELbgCyAOZ66vkv
	 aRfFNhH9objH92eue2FXwpHVNTkgbhkNQAB3oEl80rKL7+5bdeAJvLMWcL0PHYvbjz
	 +T7YgTujmQmDyztcH0SmAGkGalZNIEtySjhIeHszKHJIijAwfXoK3wwhI7E8aaMoPn
	 cHI+oHXE1tqyw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: Remove duplicate documentation
Date: Thu,  6 Mar 2025 21:13:27 +0200
Message-ID: <20250306191328.28680-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions already have documentation as defined in

https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

Remove duplicate documentation in order to reduce maintainer overhead.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
This is posted mainly for transparency and will be picked to the next
PR an all conditions. Ack are still welcome of course.
 drivers/char/tpm/tpm2-sessions.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index b70165b588ec..e7d186637664 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
 /*
  * Copyright (C) 2018 James.Bottomley@HansenPartnership.com
  *
@@ -37,35 +36,6 @@
  * file and never needs to be seen even by the kernel internal user.  To
  * the user there's an init function tpm2_sessions_init() that needs to
  * be called once per TPM which generates the NULL seed primary key.
- *
- * These are the usage functions:
- *
- * tpm2_start_auth_session() which allocates the opaque auth structure
- *	and gets a session from the TPM.  This must be called before
- *	any of the following functions.  The session is protected by a
- *	session_key which is derived from a random salt value
- *	encrypted to the NULL seed.
- * tpm2_end_auth_session() kills the session and frees the resources.
- *	Under normal operation this function is done by
- *	tpm_buf_check_hmac_response(), so this is only to be used on
- *	error legs where the latter is not executed.
- * tpm_buf_append_name() to add a handle to the buffer.  This must be
- *	used in place of the usual tpm_buf_append_u32() for adding
- *	handles because handles have to be processed specially when
- *	calculating the HMAC.  In particular, for NV, volatile and
- *	permanent objects you now need to provide the name.
- * tpm_buf_append_hmac_session() which appends the hmac session to the
- *	buf in the same way tpm_buf_append_auth does().
- * tpm_buf_fill_hmac_session() This calculates the correct hash and
- *	places it in the buffer.  It must be called after the complete
- *	command buffer is finalized so it can fill in the correct HMAC
- *	based on the parameters.
- * tpm_buf_check_hmac_response() which checks the session response in
- *	the buffer and calculates what it should be.  If there's a
- *	mismatch it will log a warning and return an error.  If
- *	tpm_buf_append_hmac_session() did not specify
- *	TPM_SA_CONTINUE_SESSION then the session will be closed (if it
- *	hasn't been consumed) and the auth structure freed.
  */
 
 #include "tpm.h"
-- 
2.48.1


