Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08D7122D64
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 14:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfLQNsT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Dec 2019 08:48:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40241 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfLQNsS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Dec 2019 08:48:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so11373460wrn.7
        for <linux-integrity@vger.kernel.org>; Tue, 17 Dec 2019 05:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VlkCjrCj9FNb19YZ9fC6iYkX/CBiUzWT6Vrxme6HlfA=;
        b=bDPl+WMk3WFNbDnt68C+TUcj+PjNeEiRwmCcXiAjv5OmXwYRjJVufZyY8/EP24Sp5O
         x1PDiNo6TSEHFIOG36fFFdJXNIOUDS2ZnXt36iPR1UlMyqBWhCM2tzTitLZiiSbyF8Ju
         nDKoT7Ev17ZRuCPm88NkfrMi1Fz6a4Z5BI+8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VlkCjrCj9FNb19YZ9fC6iYkX/CBiUzWT6Vrxme6HlfA=;
        b=mhlqbsKJ2UB5e877kkW9Nzsbv038TACCvmQMt9EOfWJoMROfsgwb30PCZvk2jS+ybr
         bnsZTaDJ9uwv2GDIUvyWLD4OuRAvR2SqofDiHfrN84D8f7TN38NmFXsXDfn0X1Ge5B8x
         OjsFmqvRydMZIJnRoWDnYywCPB91MlY15jYi7znk7YFLLvvil3ZG7Lp+fYF99skBaC3K
         dVGA5CywBvFsHPMCsudxXnlJiVhTfxdrar5gfEuxMTiSdbXwc8eFWtEsEr8AEkhZnJ36
         3jrzi486vVgbbVERoqu6mHu8DS+CvoCnWvo3CV8z2Sx+QCHy03kjAhee0x60oMxVBrNJ
         WPvA==
X-Gm-Message-State: APjAAAULX4U1agoDKOIl33otNWcbfNUELHjemdsy3th2OaN9mqt/G98m
        m4L83/JatkKPGdqOawzwakk9GVt6siAGefIX
X-Google-Smtp-Source: APXvYqyEIazdI9XZRe+Nk4M8kem6L2MPcQn9k7JUIl+vLZ15bVV24SJ+Mt9dJ0qFgsi7U3cU0sCSnA==
X-Received: by 2002:adf:a746:: with SMTP id e6mr38769834wrd.329.1576590496291;
        Tue, 17 Dec 2019 05:48:16 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:51d1:d96e:f72e:c8c0])
        by smtp.gmail.com with ESMTPSA id x18sm25227055wrr.75.2019.12.17.05.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 05:48:15 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-integrity@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, revest@google.com,
        allison@lohutok.net, armijn@tjaldur.nl, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH] integrity: Expose data structures required for include/linux/integrity.h
Date:   Tue, 17 Dec 2019 14:47:48 +0100
Message-Id: <20191217134748.198011-1-revest@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Florent Revest <revest@google.com>

include/linux/integrity.h exposes the prototype of integrity_inode_get().
However, it relies on struct integrity_iint_cache which is currently
defined in an internal header, security/integrity/integrity.h.

To allow the rest of the kernel to use integrity_inode_get, this patch
moves the definition of the necessary structures from a private header
to a global kernel header.

Signed-off-by: Florent Revest <revest@google.com>
---
 include/linux/integrity.h      | 37 ++++++++++++++++++++++++++++++++++
 security/integrity/integrity.h | 37 ----------------------------------
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index 2271939c5c31..15a0d5e91737 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -18,6 +18,43 @@ enum integrity_status {
 	INTEGRITY_UNKNOWN,
 };
 
+#define IMA_MAX_DIGEST_SIZE	64
+
+struct ima_digest_data {
+	u8 algo;
+	u8 length;
+	union {
+		struct {
+			u8 unused;
+			u8 type;
+		} sha1;
+		struct {
+			u8 type;
+			u8 algo;
+		} ng;
+		u8 data[2];
+	} xattr;
+	u8 digest[0];
+} __packed;
+
+/* integrity data associated with an inode */
+struct integrity_iint_cache {
+	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
+	struct mutex mutex;	/* protects: version, flags, digest */
+	struct inode *inode;	/* back pointer to inode in question */
+	u64 version;		/* track inode changes */
+	unsigned long flags;
+	unsigned long measured_pcrs;
+	unsigned long atomic_flags;
+	enum integrity_status ima_file_status:4;
+	enum integrity_status ima_mmap_status:4;
+	enum integrity_status ima_bprm_status:4;
+	enum integrity_status ima_read_status:4;
+	enum integrity_status ima_creds_status:4;
+	enum integrity_status evm_status:4;
+	struct ima_digest_data *ima_hash;
+};
+
 /* List of EVM protected security xattrs */
 #ifdef CONFIG_INTEGRITY
 extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 65377848fbc5..2d5e69ab4646 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -77,25 +77,6 @@ struct evm_ima_xattr_data {
 	u8 digest[SHA1_DIGEST_SIZE];
 } __packed;
 
-#define IMA_MAX_DIGEST_SIZE	64
-
-struct ima_digest_data {
-	u8 algo;
-	u8 length;
-	union {
-		struct {
-			u8 unused;
-			u8 type;
-		} sha1;
-		struct {
-			u8 type;
-			u8 algo;
-		} ng;
-		u8 data[2];
-	} xattr;
-	u8 digest[0];
-} __packed;
-
 /*
  * signature format v2 - for using with asymmetric keys
  */
@@ -108,24 +89,6 @@ struct signature_v2_hdr {
 	uint8_t sig[0];		/* signature payload */
 } __packed;
 
-/* integrity data associated with an inode */
-struct integrity_iint_cache {
-	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
-	struct mutex mutex;	/* protects: version, flags, digest */
-	struct inode *inode;	/* back pointer to inode in question */
-	u64 version;		/* track inode changes */
-	unsigned long flags;
-	unsigned long measured_pcrs;
-	unsigned long atomic_flags;
-	enum integrity_status ima_file_status:4;
-	enum integrity_status ima_mmap_status:4;
-	enum integrity_status ima_bprm_status:4;
-	enum integrity_status ima_read_status:4;
-	enum integrity_status ima_creds_status:4;
-	enum integrity_status evm_status:4;
-	struct ima_digest_data *ima_hash;
-};
-
 /* rbtree tree calls to lookup, insert, delete
  * integrity data associated with an inode.
  */
-- 
2.24.1.735.g03f4e72817-goog

