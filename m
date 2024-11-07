Return-Path: <linux-integrity+bounces-4054-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836729C03BF
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 12:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47EA4282CA2
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 11:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180E91F4FA8;
	Thu,  7 Nov 2024 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMIYWxih"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6DA1F4272;
	Thu,  7 Nov 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978437; cv=none; b=KWyIUPQy2wSxdcM29IRRdJY44NBG/3D2OYbaT21rst507hPklfpBdKodgoqx4GG6bmPdtb6M+oEcfdaz1j1Gr3v9YXnKQWp55H6YcfSgxvf1wFCDk4qch48EGK98rZPfocwKINN52mc2MwRanks7Se8aLD18DuEe753myZBKHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978437; c=relaxed/simple;
	bh=xF8ZbGW400Arsn35oIvMaUkwIQp/crqb3h+5bmD2B1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jpTodcY9vEjOOdJu3gBxPFSW61Qs0RjTnwpbvencp7qAvXrwIiPXBMKTjQjteDCYlNcl3g325Ta7gtvoSJqIo6mPo/OlGKk6Otx2FmU1mGJf9SJB5nYpBQfUONWExoWcfSV5ScPSwz2Y4VzYYw+DMD7xFAf5urmERujExUoPlcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMIYWxih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBABC4CECC;
	Thu,  7 Nov 2024 11:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730978435;
	bh=xF8ZbGW400Arsn35oIvMaUkwIQp/crqb3h+5bmD2B1U=;
	h=From:To:Cc:Subject:Date:From;
	b=dMIYWxihqJd2f7YIyVUdr4osx65WrXPDKZzzCQHlutrf5SGCIsLYofcQxeo+ZtIeO
	 riio+hhM/Bc76/6iuFMJja+tmVZQsFqNglzqhnAEHRj2eIZMnm4tH+zISlro4nrBcc
	 OrDWGGYAQMR/2Rkl4CJfO0iOFGS4jsyavDa9KIhRCNgr9SDoxYEZfJh57kVUZQrG0Z
	 KTIbsGeF36UlNemRx1SYrsuHW1uT7rN09GWb8J4/MKXh+IAwzYImOenVv2KVmqquhR
	 /lsfnD9khFPook7TByWQqwzutMAqiz5Piv6qFqAvwcS9IHuAfi7TL7Wyrq4r+D49f1
	 Hsxh0Jg7tqZGA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH] tpm: Remove the documentation from tpm2-sessions.c
Date: Thu,  7 Nov 2024 13:20:22 +0200
Message-ID: <20241107112023.5731-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody will maintain this, i.e. it is destined to rotten. It is better to
just rip it off, and not have duplicate stuff that is already in the kernel
documentation and function headers.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2-sessions.c | 68 ++------------------------------
 1 file changed, 3 insertions(+), 65 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index a7c1b162251b..ff00e9483564 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1,71 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-
 /*
- * Copyright (C) 2018 James.Bottomley@HansenPartnership.com
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
+ * Copyright (c) 2018 James Bottomley <James.Bottomley@HansenPartnership.com>
  *
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
+ * Cryptographic helper routines for handling TPM2 sessions for authorization
+ * HMAC and request response encryption.
  */
 
 #include "tpm.h"
-- 
2.47.0


