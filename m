Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE38F35E771
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Apr 2021 22:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhDMUN4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Apr 2021 16:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhDMUNz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Apr 2021 16:13:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82518C061574;
        Tue, 13 Apr 2021 13:13:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w4so13919578wrt.5;
        Tue, 13 Apr 2021 13:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=VLF6/P7EZjK4b9JVKvC4s0oerk5rpO6dK9mxoGQATgk=;
        b=QBMerjyfmkBCZjkkYTsAlMSuXiu3Z0Jzf81vhQdmkJxcRdnOPQdw53ibPDLTQm9beD
         9crudOocqZowDvYl+ESSSmVQFQ3xNWXlQTWJJKOB2S3ISVv1SyHDSZhc5c6lLTfs3Icj
         G6A/wmFfv4bdKBHVP8N+ctQoLWa+iArTfjJEqDvabCAH2DHrLspZiy4CbZaoHwqwYbP6
         Cf3HSrWabCPq9XOE67ePcQmxGuZejRRh08VOdANdzCU4PC2z19O9ESjqdtUK71fTj+Db
         ZlU0xtlwgrryRWP3Uet6aw6DY19FdSnztVZ+SPmwyHxWR4byHksNnHgaoudGaencyEYs
         Y0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VLF6/P7EZjK4b9JVKvC4s0oerk5rpO6dK9mxoGQATgk=;
        b=r6zFhe6PC44fdrahOFLNfYhbosy/TK7UiPttp3UGm/22Zd1n+oyZUzLVGM+3c0gddt
         ezyP8GwHdS6WAhMkuo/YkAJxpuZarEzoMv38p6bpVnWqpKUKI9Yh+Myo6+GU+dU5KAzo
         Pth4m751EVWmDpo9gORHLSazMpmBNGzktUBJOSkhcIrX3u/i3h/+vOGWvnj/QqUJ92Ak
         3dy0GsUZCB8usjdhVrJ9OwLwFWb+3GgiwV7ZcZIkjtZgMJ3nNHAzS5/VgEYE/PJW7fsB
         pIK2U5BKpnm7+4qYaGzTghAsmZjAV9ge1MdUlhXyFEDxs8V45HGmtjr3ciyhthydmL/O
         qNgw==
X-Gm-Message-State: AOAM5302k6fCWM638mROFWRVknEaju5lwa+7ussrXeltiJ4YPdo4aXbj
        2qVapT8SWfupO6y3AhEAPYU=
X-Google-Smtp-Source: ABdhPJwZCfFj02Edi3FehLcM4AGqWBkDDDDqv5RLROfIpiZbFdprbOFl3OcX7pxq7HPnjvlkfy45GA==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr19299060wru.163.1618344814180;
        Tue, 13 Apr 2021 13:13:34 -0700 (PDT)
Received: from LEGION ([39.46.65.172])
        by smtp.gmail.com with ESMTPSA id f6sm9820799wrt.19.2021.04.13.13.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 13:13:33 -0700 (PDT)
Date:   Wed, 14 Apr 2021 01:13:26 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     James.Bottomley@HansenPartnership.com,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:KEYS-TRUSTED" <linux-integrity@vger.kernel.org>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     musamaanjum@gmail.com, kernel-janitors@vger.kernel.org,
        dan.carpenter@oracle.com, colin.king@canonical.com
Subject: [PATCH] security: keys: trusted: prevent memory leak in error path
Message-ID: <20210413201326.GA649679@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tpm2_key_decode sometimes allocates blob. This blob should be freed if
some error occurs later in the function. Free the blob before returning
from this function if it was allocated.

Addresses-Coverity: ("Prevent memory leak")
Fixes: 14676f1eb796 ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
This is only build tested. 

 security/keys/trusted-keys/trusted_tpm2.c | 37 +++++++++++++++--------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index d225ad140960..4551384124e0 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -378,22 +378,30 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	}
 
 	/* new format carries keyhandle but old format doesn't */
-	if (!options->keyhandle)
-		return -EINVAL;
+	if (!options->keyhandle) {
+		rc = -EINVAL;
+		goto err;
+	}
 
 	/* must be big enough for at least the two be16 size counts */
-	if (payload->blob_len < 4)
-		return -EINVAL;
+	if (payload->blob_len < 4) {
+		rc = -EINVAL;
+		goto err;
+	}
 
 	private_len = get_unaligned_be16(blob);
 
 	/* must be big enough for following public_len */
-	if (private_len + 2 + 2 > (payload->blob_len))
-		return -E2BIG;
+	if (private_len + 2 + 2 > (payload->blob_len)) {
+		rc = -E2BIG;
+		goto err;
+	}
 
 	public_len = get_unaligned_be16(blob + 2 + private_len);
-	if (private_len + 2 + public_len + 2 > payload->blob_len)
-		return -E2BIG;
+	if (private_len + 2 + public_len + 2 > payload->blob_len) {
+		rc = -E2BIG;
+		goto err;
+	}
 
 	pub = blob + 2 + private_len + 2;
 	/* key attributes are always at offset 4 */
@@ -406,12 +414,14 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		payload->migratable = 1;
 
 	blob_len = private_len + public_len + 4;
-	if (blob_len > payload->blob_len)
-		return -E2BIG;
+	if (blob_len > payload->blob_len) {
+		rc = -E2BIG;
+		goto err;
+	}
 
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
 	if (rc)
-		return rc;
+		goto err;
 
 	tpm_buf_append_u32(&buf, options->keyhandle);
 	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
@@ -433,12 +443,13 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
 
 out:
-	if (blob != payload->blob)
-		kfree(blob);
 	tpm_buf_destroy(&buf);
 
 	if (rc > 0)
 		rc = -EPERM;
+err:
+	if (blob != payload->blob)
+		kfree(blob);
 
 	return rc;
 }
-- 
2.25.1

