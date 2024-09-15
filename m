Return-Path: <linux-integrity+bounces-3594-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CFB979698
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 14:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FAA41F21AE6
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 12:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B051422D4;
	Sun, 15 Sep 2024 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHKY2Lf/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540611CAF;
	Sun, 15 Sep 2024 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726403611; cv=none; b=Xl2rEmbx/2eaCrfZHan18B+EziVSquQcLVjp98RXSdYbtiOuxCGcBI/A42qy1ELSi4Fn7I7YuxzwecKl53yA2IpVYWNUw9MlbWGF3iX+P8W9YQXLrKhbMZIZQhY//SOcOBHDHiVuhBp8cMl/4pFaEjaTVIF7cilXjMP2jV1e5cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726403611; c=relaxed/simple;
	bh=PVNncDVUwdveT1NbQPhjqULt1DuFVYIxtUHsC2r/QWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0jHy9lUEa/0y/woGujSus/cZIbL8o4FiGOWs+Nv9mnz2cHZHaE1woQKtuFtF8vXjIC7LkeJS3WS/r7G/HVpS7X0+JV3oV0PM3/U8LiFvMYq5j5Pdspxtlfcrjc2BTo8HfGQauk+d+3bPdC0sA0QsQID8jR21F+pJSYbvXjgp98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHKY2Lf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBE2C4CEC3;
	Sun, 15 Sep 2024 12:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726403610;
	bh=PVNncDVUwdveT1NbQPhjqULt1DuFVYIxtUHsC2r/QWE=;
	h=From:To:Cc:Subject:Date:From;
	b=sHKY2Lf/mg9UIvwgGM/rdumD3Crd3CXaQX51z2X0TphCeP4JQlt4kycnejOmUEgRV
	 OSXB7I9qMWozBbvodMOf4tJ5cGBiVfYf6YeCnAFKVQAglzIAZyXG57UzUpnH2r/7hD
	 R67W1ZsiOpnY82G/k9JlzEeYqwheEtQnOhMvFFrjwGGXrTalXUWZeSS4Zan71/hdnW
	 e7aci3ndxIeiGABt4TUDdTgYETPYioRN3Os+o35cYjY5zS+pDnWM+qC0Uxs0zIQefz
	 SQ9gV0x0LJWrbP5NdEwbHA2WgRb3EcbkGsfoGRuBlK19BAKt96TEkKueki4m13Opni
	 A0uqaFZ5JKw6A==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: remove file header documentation from tpm2-sessions.c
Date: Sun, 15 Sep 2024 15:33:15 +0300
Message-ID: <20240915123315.10999-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation in the file header is duplicate documentation, which
is already addressed elsewhere (tpm-security.rs and function associated
documentations). In addition remove the invalid newline character after
the SPDX tag.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
It is good time to remove this finally before doing anything else.
Unless someone commits to maintain this part of the file, I will just
take it away because I have neither intention nor motivation to maintain
it. Came right on front when I started to look into kernel command-line
and optimizations for session life-time so thus the patch. I'll include
this later on to a larger patch set.
 drivers/char/tpm/tpm2-sessions.c | 65 --------------------------------
 1 file changed, 65 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 44f60730cff4..6cc1ea81c57c 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1,71 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-
 /*
  * Copyright (C) 2018 James.Bottomley@HansenPartnership.com
- *
- * Cryptographic helper routines for handling TPM2 sessions for
- * authorization HMAC and request response encryption.
- *
- * The idea is to ensure that every TPM command is HMAC protected by a
- * session, meaning in-flight tampering would be detected and in
- * addition all sensitive inputs and responses should be encrypted.
- *
- * The basic way this works is to use a TPM feature called salted
- * sessions where a random secret used in session construction is
- * encrypted to the public part of a known TPM key.  The problem is we
- * have no known keys, so initially a primary Elliptic Curve key is
- * derived from the NULL seed (we use EC because most TPMs generate
- * these keys much faster than RSA ones).  The curve used is NIST_P256
- * because that's now mandated to be present in 'TCG TPM v2.0
- * Provisioning Guidance'
- *
- * Threat problems: the initial TPM2_CreatePrimary is not (and cannot
- * be) session protected, so a clever Man in the Middle could return a
- * public key they control to this command and from there intercept
- * and decode all subsequent session based transactions.  The kernel
- * cannot mitigate this threat but, after boot, userspace can get
- * proof this has not happened by asking the TPM to certify the NULL
- * key.  This certification would chain back to the TPM Endorsement
- * Certificate and prove the NULL seed primary had not been tampered
- * with and thus all sessions must have been cryptographically secure.
- * To assist with this, the initial NULL seed public key name is made
- * available in a sysfs file.
- *
- * Use of these functions:
- *
- * The design is all the crypto, hash and hmac gunk is confined in this
- * file and never needs to be seen even by the kernel internal user.  To
- * the user there's an init function tpm2_sessions_init() that needs to
- * be called once per TPM which generates the NULL seed primary key.
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
2.46.0


