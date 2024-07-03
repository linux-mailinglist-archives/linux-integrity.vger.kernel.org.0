Return-Path: <linux-integrity+bounces-2971-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFAA924CC6
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 02:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09651C221E0
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 00:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5173C637;
	Wed,  3 Jul 2024 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5he+TCD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC54A2D;
	Wed,  3 Jul 2024 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719966641; cv=none; b=cdDVJREpfUjw8nMD5dCX4sMFdwXm2z7ch1Yfj3Q4Rc+KL1OjhocMG7QIl8kINbVmqJXdtMEQ5wC3l5/8HO6GgTmP+6VIlare5Bu8uPjxXfHtGGTc8RHliyyWdmwrgS9PsZuaX2oIbEJTpg0rz+1NtAb7zRGJmrva5Cxn6bXmkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719966641; c=relaxed/simple;
	bh=raEwlZhSHvYn4cb14CLaNp2VOnySoTc5QBSm+v6TF+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rqG2bNkwYWi7lz8c8cUwdswBHQPHd7fVLkNkXW4levF02Uaqqm+KlWkuPYcTqqQrTxpA4N8di05Lis9Mm1TmzDLybAYucq/Q3X21wq+e/77wDtKtCR0u2JjJkf8RKxBYQWolVQ2RzMolsCooRvyaWeZDVN9m2Xuof4OQ+YLWJ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5he+TCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079E3C116B1;
	Wed,  3 Jul 2024 00:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719966640;
	bh=raEwlZhSHvYn4cb14CLaNp2VOnySoTc5QBSm+v6TF+4=;
	h=From:To:Cc:Subject:Date:From;
	b=U5he+TCDKSDjGF5TaWQ6tooTmoFozUEudg/FdBlyD6PloDlswMaZVuZmnr4MUabjw
	 3SviNgTr/chLzJnC6zBdopptPpkMyZ/Z4412rxqng218o84Isu6JNeV5Lu3O6HY+Se
	 XAXhuDGIhB+jjM1J3TacN4TS80stMY/ygOt9qmaTNatV80lmcXxM/x5MJUI/3VDWry
	 FoUmqbc4NV8QrSS/zSZCc0d99hmxdXac6GntSnHCecqwWYbu1vPeWOme+1g7CE/GXJ
	 W6/p9ZWkb/QYxhSeFx3VFoqErp3UuHumE0fCZ88/g3bXt6tDxTgdl6VnR+Fu6bnfRq
	 Tx6waO8u7K3TQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] tpm: Limit TCG_TPM2_HMAC to known good drivers
Date: Wed,  3 Jul 2024 03:30:33 +0300
Message-ID: <20240703003033.19057-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IBM vTPM driver lacks a call to tpm2_sessions_init() and reports:

[    2.987131] tpm tpm0: tpm2_load_context: failed with a TPM error 0x01C4
[    2.987140] ima: Error Communicating to TPM chip, result: -14

HMAC encryption code also has a risk of null derefence, given that when
uninitialized, chip->auth is a null pointer.

Limit TCG_TPM2_HMAC to known good drivers until these issues have been
properly fixed.

Cc: stable@vger.kernel.org # v6.10+
Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
Reported-by: Stefan Berger <stefanb@linux.ibm.com>
Closes: https://lore.kernel.org/linux-integrity/20240617193408.1234365-1-stefanb@linux.ibm.com/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index cf0be8a7939d..c310588a5958 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -30,6 +30,7 @@ if TCG_TPM
 config TCG_TPM2_HMAC
 	bool "Use HMAC and encrypted transactions on the TPM bus"
 	default X86_64
+	depends on TCG_CRB || TCG_TIS_CORE
 	select CRYPTO_ECDH
 	select CRYPTO_LIB_AESCFB
 	select CRYPTO_LIB_SHA256
-- 
2.45.2


