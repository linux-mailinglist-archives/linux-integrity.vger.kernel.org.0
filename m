Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0133700DA
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Apr 2021 20:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhD3S7I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Apr 2021 14:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230356AbhD3S7G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Apr 2021 14:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619809097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=k42L3xryaez+oSKmSu1QdAMryLEAIpMx64ypVwr/urA=;
        b=HSCfNmcC5FNNo0sClUmd7Qv56qS+P6IBK7c2S84PLUFA2CtCYPAVlNIlBQe/TYGH6KRh+3
        A5TpflRhccUa2yx20sbmKW1p56t9ewBTFZdVjOWoCRhNNHhCyRAkK1EC4XEfy38ZZbiQ6J
        CiqdsDsoNnHH7fxHVqbBQV3FYoZNhTQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-YraDYJYiME6vIJ-uRN4tnw-1; Fri, 30 Apr 2021 14:58:15 -0400
X-MC-Unique: YraDYJYiME6vIJ-uRN4tnw-1
Received: by mail-qt1-f197.google.com with SMTP id i7-20020ac84f470000b02901b944d49e13so21975222qtw.7
        for <linux-integrity@vger.kernel.org>; Fri, 30 Apr 2021 11:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k42L3xryaez+oSKmSu1QdAMryLEAIpMx64ypVwr/urA=;
        b=EoAXcMS9rTcywF6kfol23/OMlWbqzJNp3ILKDfdW7MT4IVjogAEOTteK1Sjusa/wvI
         GYdUNIAw3/vE+h4rBustNiCPVWNdL/nxoPX9eFRfwkJ1lXPRA90tdqptYIeJ3/Bh123h
         mP8ncC3wHSMHxywRu6Ch/FRIrJ6sFKAROe+0E3SzqcZKT9jAu0xk7ehEn1nLdnNU4kML
         VTjcJcKZRucbqYfuafonq4wsizCPgJNt5EYxBbyooBEAVEEnFJRQBsFKylpckFutaJjM
         jAuTbwN+aFxZ3r8hB2bhC17GQVGQ1vpBvtIhbbNTUvTjpfMxk2tnbFBjV8cvencGgAkH
         zHcg==
X-Gm-Message-State: AOAM531fc4fsoJTBEEc8d+0ztq4SyjP94etP1TamP2ZIEibMLzz+Teyj
        B2Zx6d5zsTZfDfY6AbidGDbGsePDbHQrKw8nl9r6Hgw03k4CAs6IbqfWV8+yvz3ENQQ8fl2WDU9
        FeJbKcfySINSHpXIR5wBfhKgNz4jT
X-Received: by 2002:ae9:f205:: with SMTP id m5mr6950979qkg.101.1619809095101;
        Fri, 30 Apr 2021 11:58:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR2o64jnSyLn3IiYpCSQfqm0Tweb+Lrh1Ejl4G4c7Bimvr+FTabvOuLg5CiYAx+Ty5nMnEEg==
X-Received: by 2002:ae9:f205:: with SMTP id m5mr6950963qkg.101.1619809094911;
        Fri, 30 Apr 2021 11:58:14 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b17sm2802557qto.88.2021.04.30.11.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 11:58:14 -0700 (PDT)
From:   trix@redhat.com
To:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] KEYS: trusted: fix memory leak
Date:   Fri, 30 Apr 2021 11:58:10 -0700
Message-Id: <20210430185810.3331311-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem
trusted-keys/trusted_tpm1.c:496:10: warning: Potential memory leak
  return ret;
         ^~~

In tpm_seal() some failure handling returns directly, without
freeing memory.

Fixes: 5df16caada3f ("KEYS: trusted: Fix incorrect handling of tpm_get_random()")
Signed-off-by: Tom Rix <trix@redhat.com>
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
2.26.3

