Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDED36F96B
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Apr 2021 13:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhD3LiU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Apr 2021 07:38:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56602 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhD3LiT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Apr 2021 07:38:19 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lcRSW-0004rU-TC; Fri, 30 Apr 2021 11:37:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] KEYS: trusted: Fix memory leak on object td
Date:   Fri, 30 Apr 2021 12:37:24 +0100
Message-Id: <20210430113724.110746-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Two error return paths are neglecting to free allocated object td,
causing a memory leak. Fix this by returning via the error return
path that securely kfree's td.

Fixes clang scan-build warning:
security/keys/trusted-keys/trusted_tpm1.c:496:10: warning: Potential
memory leak [unix.Malloc]

Fixes: 5df16caada3f ("KEYS: trusted: Fix incorrect handling of tpm_get_random()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 469394550801..aa108bea6739 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -493,10 +493,12 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 
 	ret = tpm_get_random(chip, td->nonceodd, TPM_NONCE_SIZE);
 	if (ret < 0)
-		return ret;
+		goto out;
 
-	if (ret != TPM_NONCE_SIZE)
-		return -EIO;
+	if (ret != TPM_NONCE_SIZE) {
+		ret = -EIO;
+		goto out;
+	}
 
 	ordinal = htonl(TPM_ORD_SEAL);
 	datsize = htonl(datalen);
-- 
2.30.2

