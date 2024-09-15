Return-Path: <linux-integrity+bounces-3603-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA23A979804
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 20:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8263D281F98
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C471C9ED1;
	Sun, 15 Sep 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9XWtdKv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33717C91;
	Sun, 15 Sep 2024 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726423498; cv=none; b=DurcEvKJmeo3ibW4qosmwUWy51nTcQiQuUEkJWjtNIcdBzRmgLWY6mgta1dd8rZQ3nVxSwF/N6/ejcd1F3Czki0htuMWxDSfRv6BNVylkxHkbnmxBnXCmzTFv4PAySvofNAVjH3vaJ7UsVWwVDZV1834JOQYcQkEeAO59yB4rGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726423498; c=relaxed/simple;
	bh=PSWKFNVV/x7KpttZabN/IKNBqvoJsZn3/j63V1Q+yhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cp1VWLN4yRhfzsCSTVE7m2hTce42AwDOOI+vVuzgJFREP3friIr2DNr+UHATwc7wv7/+3uNRmzd5sspVMe1ZrbyYlDz7ygJ7l2j/sm1GFPHpwn5vHYqMp1L912ce/zWahnL2s37Azto0m06GOSsFA1NzQT08TKb1qcEHtsNm8gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9XWtdKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6381CC4CEC3;
	Sun, 15 Sep 2024 18:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726423497;
	bh=PSWKFNVV/x7KpttZabN/IKNBqvoJsZn3/j63V1Q+yhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9XWtdKvVF96aEWW9cmZziMlCeDNDs/oSorS4PuMVXTQ3ASUrBvM8TPAJVXRU5R5G
	 qua/ZXfhIq4XWVvYZicPSEgNGejh1eXk19fjDGTqrOl2qQ1Dgat/bvIJ/iXc3fjZHa
	 DTsXA006pFieyCX+kkPHz8JSPuDnNV5ZF4zU2EDw92Dqx+akuLAJaNyPkd1Z41WDJP
	 Tx8b4KUki9bTOmMifnihQqI9oFY/032toHiiiAKEMgvdzLk8ZTbi3poWN23rrtWT/v
	 oXXLmaCACaVGKJnYF2Z9jfNolb/yDu5zSmTAyIIZb2o7X5lFLCAwoP6f5NLCb+g1eU
	 OPl7t74cyTKpg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] tpm: remove file header documentation from tpm2-sessions.c
Date: Sun, 15 Sep 2024 21:04:43 +0300
Message-ID: <20240915180448.2030115-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240915180448.2030115-1-jarkko@kernel.org>
References: <20240915180448.2030115-1-jarkko@kernel.org>
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


