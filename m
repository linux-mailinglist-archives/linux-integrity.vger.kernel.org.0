Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B49D199314
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 12:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgCaKFz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 06:05:55 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:40395 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgCaKFz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 06:05:55 -0400
Received: by mail-wm1-f42.google.com with SMTP id a81so1873435wmf.5
        for <linux-integrity@vger.kernel.org>; Tue, 31 Mar 2020 03:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=D8yUbXH4HenCV8TgB7jhzyJ+fshkHd8iBN77HUZ44dk=;
        b=EgeNGwGS8btJZL1tPH3RT6pRggqezoFtgFjQ6FosxBVW9NfU/iCpQfgRRbT/QR13H0
         xu41THFtIA8Qt53FR/2jh3sNnBm+s1w9BzGKtAHZdsGBjpGuGXEMUbCVVMpExG2KjY33
         +WmmoesVj1AUWSqlC6TkIsjeiuzhgOqh5MVpLB0N2W3fYktSa3iERjzHl9vHovNtN4wQ
         LLigYUdvaI2z9w6BSqd3qfUDAHG2s1mLMoF8ob9cdpYeKW4auF1SVMz1voi1qLDAB6hv
         FUW/HafaMEcN3OHwHoe3TRIXJmP39zQnJVeVN5NIuoWB2MNAUVaYFy1Ye/YPHgLlyQ2z
         OBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=D8yUbXH4HenCV8TgB7jhzyJ+fshkHd8iBN77HUZ44dk=;
        b=QJAOFccijARn2I84lXe9hnN1PouwzChbJDvYqwA4ijIImyyg1FX3VulMOHidgpxwOH
         fJq2Xyoi1xveUvCVBiQkjMiRVqFrPLb3pn/QpdVyLa1Jur19WxFlKCbmi4S+LnNk95JL
         VZAPC4RuFm9l74d1oqJYxQUqEl3Qa1WNPYjO0i8oG1PZl3CY42o073M5gXP8BRAjs5nL
         H8otQ+Ao68PJ1FjON9GiWTYrZfVUs4YsmT6RlIXnJB5y5UjByqksPDxjNpYucznu3PLQ
         88HUehjNp8/1ymU30pja7jJwdWNj3U7AIGTJPtFj/Hyy6NkFVv3acuEm/NxKDN1YrltP
         xX7w==
X-Gm-Message-State: ANhLgQ1kQQLF/vdRsleMPBh6LEv5gwiPqJw2+rTL9so6Xbil4vA9GiEg
        DbGJF+8Hgsnl04R99auRHnGVRrgyRCINcQ==
X-Google-Smtp-Source: ADFU+vtpQZNsIcW1MaNslrVVGqnmX4gBExvRic6PaxmULTd88v9ek5XdpU5KbNqknjXTECR94S+fEA==
X-Received: by 2002:a7b:caaa:: with SMTP id r10mr2608885wml.119.1585649153126;
        Tue, 31 Mar 2020 03:05:53 -0700 (PDT)
Received: from localhost ([87.71.129.31])
        by smtp.gmail.com with ESMTPSA id i21sm3297470wmb.23.2020.03.31.03.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Mar 2020 03:05:52 -0700 (PDT)
Date:   Tue, 31 Mar 2020 13:05:51 +0300
From:   Lev Olshvang <levonshe@gmail.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: [RFC] Add more inode fields to inode metadata signature
Message-ID: <20200331100551.GA8259@kl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From b696085c6e65e82237150e13d14736a914a0b394 Mon Sep 17 00:00:00 2001
From: Lev Olshvang <levonshe@gmail.com>
Date: Mon, 30 Mar 2020 16:00:27 +0300
Subject: [PATCH] integrity - add more inode metadata to signature, handle
 errors

Add more inode fields to inode HMAC : times and flags.
File flags define (affect) how OS utilities and filesystem treats
them. For example immutable flag preserve file from removal or change.
It is important to verify these flags were not changed.
ctime and mtime may also affect programs that depends on files
timestamps.
File size might be used as a first indicator of file change and spare
from other IMA/EVM checks.

Function hmac_add_misc() ignored errors from crypto functions
This patch changes hmac_add_misc() not to be silent about errors

Signed-off-by: Lev Olshvang <levonshe@gmail.com>
---
 security/integrity/evm/evm_crypto.c | 34 ++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index d485f6fc908e..9c71c321e988 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -139,15 +139,20 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
  * (Additional directory/file metadata needs to be added for more complete
  * protection.)
  */
-static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
+static int hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 			  char type, char *digest)
 {
+	int rc = 0;
 	struct h_misc {
 		unsigned long ino;
 		__u32 generation;
 		uid_t uid;
 		gid_t gid;
 		umode_t mode;
+		struct timespec64 ctime;
+		struct timespec64 mtime;
+		__u32   flags;
+		__u32 filesize;
 	} hmac_misc;

 	memset(&hmac_misc, 0, sizeof(hmac_misc));
@@ -169,11 +174,26 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 	hmac_misc.uid = from_kuid(&init_user_ns, inode->i_uid);
 	hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
 	hmac_misc.mode = inode->i_mode;
-	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
+	hmac_misc.flags = inode->i_flags;
+	hmac_misc.ctime = inode->i_ctime;
+	hmac_misc.mtime = inode->i_mtime;
+
+	/* hardly imagine calculating hash for file  > 4G */
+	if (likely(inode->i_size < 0xFFFFFFFF))
+		hmac_misc.filesize = (__u32) inode->i_size;
+	else
+		return -E2BIG;
+	rc = crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
+	if (unlikely(!rc))
+		return rc;
 	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
-	    type != EVM_XATTR_PORTABLE_DIGSIG)
-		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
-	crypto_shash_final(desc, digest);
+	    type != EVM_XATTR_PORTABLE_DIGSIG) {
+		rc = crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
+		if (unlikely(!rc))
+			return rc;
+	}
+	rc = crypto_shash_final(desc, digest);
+	return rc;
 }

 /*
@@ -239,7 +259,9 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		if (is_ima)
 			ima_present = true;
 	}
-	hmac_add_misc(desc, inode, type, data->digest);
+	error = hmac_add_misc(desc, inode, type, data->digest);
+	if (error < 0)
+		return error;

 	/* Portable EVM signatures must include an IMA hash */
 	if (type == EVM_XATTR_PORTABLE_DIGSIG && !ima_present)
--
2.17.1


