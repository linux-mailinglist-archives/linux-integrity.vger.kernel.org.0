Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9031543C33
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 17:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfFMPek (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 11:34:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44707 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbfFMKc0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 06:32:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so11556577pfe.11
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 03:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zAP35FMwIaJoHRTsWTgqlS+4eqrXf3lXTLZsbBgKALU=;
        b=I8WZqaHuq/yhoMfw5I5pMLLVxm8cNFa61hNwQ8JLEMlCB8EUyJDcawmklBfvxhPYCl
         5QfsPIYKqAlH9CKbXYD8qGVKPqgYgYNL5qFGx11M2gg4jknzMJ2je5vQxiIEo2GWD5G/
         RxhSDlH9Q9RQ/EG0N/XQAWCefLd9GHdFP0Ho9vndyKfvJW/F0y6GH3rSRSR/oA8ric1P
         KaJ5iam2I3ar+sVxc5p9E9Bfv94xReZjTfPJhJnUezS8g8jb+A8kp0qWVI4luHG7wWWh
         PrG1F5qZGOs5QlF8Jcng3xBuK+0z2rvPRMRUkxRXs3sbtmIRmZNB6mWw8sVkKHcVmOb8
         uK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zAP35FMwIaJoHRTsWTgqlS+4eqrXf3lXTLZsbBgKALU=;
        b=t6Df2h5CoQuE3kzBp5weTBCTa1XAP5UpwpLF4RzAbqPS8SzL7PRU3ZOGNHWALO/mvz
         9mRBQ5u5lcVcegv/3s3nEGAus+TxnMrpcnFa1SF0JHzxzMZgxHX51Ss8bgiYpInQhq45
         5/dsa8GsJi2/297UyolIqsSbTTDm3BiJyEibIkcxB3b3MSOXeKR1lrwWjnDLgillEHJI
         VksOC+yEBmFQhuyGWKrDRw/GyWLvvQjIya4Q+Do/wLiIW4x6rnVV8uuEjdmA3h+GRE+d
         X3C6ywCKYEHkzI2OurFTbuqRG6Zym2aCtF3jUpktwvkgwsEkBqdoGuFezbLbs/Duj33r
         O11Q==
X-Gm-Message-State: APjAAAXtY8P2XkAfsUi8HTB3Xg0Gd6iOkDC931L0798HWN1NRxBXHcnc
        N6NCn0MEMn97EhoTZ/ppoZEyTg==
X-Google-Smtp-Source: APXvYqy9ZWJWVG2HSV4XCNQ97i8SPNUISZ00sFzqKzjXi5CJzuVmgDH7W765D0LXzkPhO24L9HPVDA==
X-Received: by 2002:a17:90a:2525:: with SMTP id j34mr383810pje.11.1560421945985;
        Thu, 13 Jun 2019 03:32:25 -0700 (PDT)
Received: from localhost.localdomain ([117.196.234.139])
        by smtp.gmail.com with ESMTPSA id a12sm2265078pgq.0.2019.06.13.03.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 03:32:25 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC 5/7] KEYS: encrypted: Allow TEE based trusted master keys
Date:   Thu, 13 Jun 2019 16:00:31 +0530
Message-Id: <1560421833-27414-6-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allow search for TEE based trusted keys to act as master keys in case
TPM device is not present.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 security/keys/encrypted-keys/masterkey_trusted.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/keys/encrypted-keys/masterkey_trusted.c b/security/keys/encrypted-keys/masterkey_trusted.c
index c68528a..cfac27f 100644
--- a/security/keys/encrypted-keys/masterkey_trusted.c
+++ b/security/keys/encrypted-keys/masterkey_trusted.c
@@ -23,6 +23,9 @@
  * Trusted keys are sealed to PCRs and other metadata. Although userspace
  * manages both trusted/encrypted key-types, like the encrypted key type
  * data, trusted key type data is not visible decrypted from userspace.
+ *
+ * Also, check for alternate trusted keys provided via TEE in case there
+ * is no TPM available.
  */
 struct key *request_trusted_key(const char *trusted_desc,
 				const u8 **master_key, size_t *master_keylen)
@@ -31,8 +34,11 @@ struct key *request_trusted_key(const char *trusted_desc,
 	struct key *tkey;
 
 	tkey = request_key(&key_type_trusted, trusted_desc, NULL);
-	if (IS_ERR(tkey))
-		goto error;
+	if (IS_ERR(tkey)) {
+		tkey = request_key(&key_type_tee_trusted, trusted_desc, NULL);
+		if (IS_ERR(tkey))
+			goto error;
+	}
 
 	down_read(&tkey->sem);
 	tpayload = tkey->payload.data[0];
-- 
2.7.4

