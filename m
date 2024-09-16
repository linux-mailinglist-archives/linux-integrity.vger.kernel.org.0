Return-Path: <linux-integrity+bounces-3613-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF499979FED
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2024 13:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FA22832E0
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2024 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707301553AB;
	Mon, 16 Sep 2024 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lon6fQqe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D7F149C57;
	Mon, 16 Sep 2024 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484847; cv=none; b=J8v5xE8h1AaOyEP1i71YsuEkOv1NkLQrHe3Xs4AnWaEfsGaNUBSJCdxIzC+p8aG8iTPPMBdUnXwEbM5qYlDiWvCCvttTdVpKODIEwy7cjJOdf1IbhR4wJ+kKLfDP7ogTNO+Hec4IjH2/lBqYi6l71lSjJQzwClv7nQYU6J3rtfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484847; c=relaxed/simple;
	bh=khBmSXOuLlVYvAwvZ+9x5G0EGtluhzmI2sB1ubUkQgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=af3pzNJhA1C6Cb4ngYtgEUhH7K2Ol3vbPV7NI3xQ6BZRAM7TrolGgh2dkl0x8T7SaBUZedev5oOu8LlwJ7SI9J2Nl162SIpvI7MUR2+ihYPiIJeYn5sr20/exlmSiorIqY63apLHW75GbAKmdrSBF63KMqUJRWCkjtCGtpR/Klw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lon6fQqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FEAC4CEC4;
	Mon, 16 Sep 2024 11:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726484846;
	bh=khBmSXOuLlVYvAwvZ+9x5G0EGtluhzmI2sB1ubUkQgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lon6fQqe/GjDLNyi1VC44dqYI+3OlBrmsU8s91QsRqach08cYlVvw9ax3HpK16ZZJ
	 p963NkwcgIK9mYh9AAdbS6CoyRG4KLmb3ZQljDGH9E79w6rtiFtluuDsV62H38QP9D
	 mLS4KEZrDdktiT86mo5zOkkPEAwEWfmNVGwjSw4cihb39xBe4cRPAjE+IdWr2k6KlX
	 SM+UQV114Y5QZ+StH/aFgSmPH9y+kehSgpoGEzhxv6lyo8GqRIUoGAPKht8TZv3qYu
	 QBc9zJG8Sb3HAl6VP52WRv9kZwzxqInUOJUzmuMivvSzoMinH2rxk2Ja/OIDFDvrKo
	 Tv0ybYaGCxixw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2 1/6] tpm: Remove documentation from the header of tpm2-sessions.c
Date: Mon, 16 Sep 2024 14:07:06 +0300
Message-ID: <20240916110714.1396407-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916110714.1396407-1-jarkko@kernel.org>
References: <20240916110714.1396407-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation in the file header is duplicate documentation to kernel
doc comments in the function declarations and tpm-security.rst. Wipe it
off as nobody will ever take care of keeping it up to date.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
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


