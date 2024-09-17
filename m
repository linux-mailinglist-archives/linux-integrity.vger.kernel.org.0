Return-Path: <linux-integrity+bounces-3621-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6864397B246
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 17:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E2B285CBD
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 15:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B211940BE;
	Tue, 17 Sep 2024 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1x1R34x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67B519342B;
	Tue, 17 Sep 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726587895; cv=none; b=BUnNkqKmb0Y170rhWd5u/Ms2lReaG0n9p0rb2MLoVgO68IinvSIdm7RXb4JiOiXRWzxXR4JD6ghzOa5pHhiLU7q9J4vF4soZ6UtS40YkgYZSyoRGu+MVmX7yehacfsSPKWQ/12JSXCUtTnZKISUgJbzWXzP7hd6BZHGttOj68tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726587895; c=relaxed/simple;
	bh=rw9/FeMz51DKME1/reXnnc5Za/cdWbF/63E6IVevQMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlwxsXIkDUvwIHtfFHhUvSBC3XdJrNYc721cAMGvWP9ayQZiEJf61G0ngI1cTeWuk/6XtHdEVNcg0BVriyyK1CRdgd5CoGhKQVwvEdiw5r83Sn5+ZeWQVVed1IBR5iZIZHrB/s8Tz2Z7lReg240uGUq9lp7JqB5NSUZSnvi6jQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1x1R34x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AE3C4CEC5;
	Tue, 17 Sep 2024 15:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726587894;
	bh=rw9/FeMz51DKME1/reXnnc5Za/cdWbF/63E6IVevQMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J1x1R34xwXuYWredtfrrtopU3MK3gM3SAL6yGKt8rAiiOtCdLKsik9YmKDWwsjeB/
	 XRxRNYNp6SErbu4l6spAh7ynExAEX3SXC5zgOW/+HDgb8XO8PSPr29RDXNK//boCFf
	 Y7Aq45GDWvM0JB4dptCzfTUcmd0Y/m1Lil2d5ohebapFE367dqCDPSc0YyIzYr8/rk
	 trG4mdnVwXzMgXDuqu+z/IL/88uPk7YycRHhZEZeKTpla+uY+6zJyVz9q7zv8KcOsS
	 VV/aG6U3KoSg+sf5wwDqhpsQ8rv4kandlVQe4UlWD2eBTMUmzSR//z4DxgwYCBT/FM
	 wAB5S5ruY3amA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] tpm: Remove the top-level documentation tpm2-sessions.c
Date: Tue, 17 Sep 2024 18:44:30 +0300
Message-ID: <20240917154444.702370-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917154444.702370-1-jarkko@kernel.org>
References: <20240917154444.702370-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation in the file header is duplicate documentation to the
documentation Documentation/security/tpm/tpm-security.rst and kdoc comments
attached to the exported functions in 'tpm2-sessions.c'.

Remove it as maintaining it would be just a waster of time and resources.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
- Refine the commit message.
v2:
- Refine the commit message.
---
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


