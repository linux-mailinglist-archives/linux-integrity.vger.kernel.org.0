Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D4E3A28B7
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 11:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFJJwU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 05:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhFJJwU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 05:52:20 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142D7C061574;
        Thu, 10 Jun 2021 02:50:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a20so1569929wrc.0;
        Thu, 10 Jun 2021 02:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ttr6YN1lz3HlA7JpnhNQqRjKhBQi4menpBStyTqJFI0=;
        b=aGFtsBpo7/zgt1hm3mMxBXTN35Ob9QVJ3Fd+e5btkS8d483FCslcwRhZ60IbIvhVdh
         pGslzkesy3RQy6tCeMeA7eO5NsC5ovqRb6eI7XhxYOCXVRt1xt9f418vLf1l79SzJE1I
         i9QNUlD71x+LD1PqXVMcTL+ffKk5hkSsVvKMRdzxAX8IrMbXsugWsSqotEQ7apMPZS2h
         T7cwH4VkKb/8dzCHoBbZ9GTvD4qbx1Lkyy0EUIDEt6CDuu00xvVlTqLyFTqmrNMLES4h
         0vxZAadPBsMGRYzj1ZBFq3kw73ZPb6dzZXUgI6gM9svc6WxTbSem4pq/kyRpkwqECQqo
         JxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ttr6YN1lz3HlA7JpnhNQqRjKhBQi4menpBStyTqJFI0=;
        b=acKyN/YXysmQLiSw3YW+Mbv+oatEnnk92h6HvZw7fWo8WMjOrO4ktEMWpD5IUYc51z
         MpGb6wFbMUB95N77GERxCATxCAPCiMO+noLw+gwh+SvLPjSyhUPs7hjTwduk/p5GtUt2
         iocAW4i7DpkQmTuWQ0TPSCqTddtFLGgEvKfGOuKi7keTwm5JzGKiwdd1lYA5UTOkdr3E
         f/ZvlOqvd+a+bUtNPkfk0ko9iZK33PbyZ+uS6/bTM8SJbD6fmBUu1yPmyLK0AzvSPqOj
         a7ofZsFHWKwB4k9AmEzKszUDzlYRv8elmutziuNwM7ySXypn2/AflumrKCy2uXtdigVu
         fx2A==
X-Gm-Message-State: AOAM531IQO2lOGSMxbLv2poiGKb+C7FmGAVU501OONRpcymwTU5F4Sqv
        r0SgFTL9ENCbMm4reA49M/iZJ8rEXA6XKQ==
X-Google-Smtp-Source: ABdhPJyIfVDgdrW8pz+W8ACyqC9SBgmnQiwZRDdDgVt0vwXbQaoWTl5RrGgiyzkeIthPX1tcF2l75A==
X-Received: by 2002:a05:6000:1563:: with SMTP id 3mr4325714wrz.59.1623318608487;
        Thu, 10 Jun 2021 02:50:08 -0700 (PDT)
Received: from localhost.localdomain (190.1.93.209.dyn.plus.net. [209.93.1.190])
        by smtp.gmail.com with ESMTPSA id p16sm3006200wrs.52.2021.06.10.02.50.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 02:50:08 -0700 (PDT)
From:   Dhiraj Shah <find.dhiraj@gmail.com>
Cc:     find.dhiraj@gmail.com, James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm2_load_command leaks memory
Date:   Thu, 10 Jun 2021 10:49:51 +0100
Message-Id: <20210610094952.17068-1-find.dhiraj@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tpm2_key_decode allocates memory which is stored in blob and it's not freed.

Signed-off-by: Dhiraj Shah <find.dhiraj@gmail.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 41 +++++++++++++++--------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 0165da386289..52dd43bb8cdb 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -378,22 +378,31 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
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
+
+	if (private_len + 2 + public_len + 2 > payload->blob_len) {
+		rc = -E2BIG;
+		goto err;
+	}
 
 	pub = blob + 2 + private_len + 2;
 	/* key attributes are always at offset 4 */
@@ -406,13 +415,16 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		payload->migratable = 1;
 
 	blob_len = private_len + public_len + 4;
-	if (blob_len > payload->blob_len)
-		return -E2BIG;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
-	if (rc)
-		return rc;
+	if (blob_len > payload->blob_len) {
+		rc = -E2BIG;
+		goto err;
+	}
 
+	if (tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD) != 0)
+		rc = -ENOMEM;
+		goto out;
+	}
 	tpm_buf_append_u32(&buf, options->keyhandle);
 	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
 			     NULL /* nonce */, 0,
@@ -433,9 +445,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
 
 out:
+	tpm_buf_destroy(&buf);
+err:
 	if (blob != payload->blob)
 		kfree(blob);
-	tpm_buf_destroy(&buf);
 
 	if (rc > 0)
 		rc = -EPERM;
-- 
2.30.1 (Apple Git-130)

