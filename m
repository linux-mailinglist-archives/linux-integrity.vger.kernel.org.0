Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3843C19EDD1
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Apr 2020 22:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgDEUNn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 5 Apr 2020 16:13:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34326 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDEUNn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Apr 2020 16:13:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id 65so14986276wrl.1
        for <linux-integrity@vger.kernel.org>; Sun, 05 Apr 2020 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HcEOM9bLPpF1FsrctOKBnWI104KAZE+flsRx/h7VsIY=;
        b=j7CEHBnKGWOnPQcUHMsz40NYcWP9WvvpsB7XUJzluQITIchrX+toXFiTVHkFHBXb10
         Mlc4eFmwGn2+qrSd2JJ/zRDbrp/k+cbLOQNeNAVHDoN5rCUJS5KqPV0ppbMy28wsdx5p
         edx9IyW81er/q1q9l5xBlDPc/jDIqQHobtqbYFbnWk0DnqMKIkuHQl/EzQi57k9YI67o
         ovisaXz9UHbQe0YUEtLvZbI4l0DYy9Hjy87Dfxk5+nwm1yBfV9f8YN7LkcLbLT41vVzR
         S8ok2e4Kd36wlTrLnCY9E5G5sJAjSuj5L7jXYgnaN5MIA6b2eltoZBoaMhpWmXeSuezo
         qduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HcEOM9bLPpF1FsrctOKBnWI104KAZE+flsRx/h7VsIY=;
        b=ki8kSWyXy/9NluEjN5RcaiWWjTdDCC5cbtSQSNPuHWuBWXW5JnScyZYFoRIR/kD/EW
         AjZDoabBNKvlZpza+bvf9J6dh/IkbFRLPcFG7FlXWhSfgzOd43eLiAu1bFFCiCxCHe1l
         csAN1ota66TD93VJwCfXnrj2I13tVhyZoK7CmwcYvGPegdMxTKG7sReYrVYNTTjUn4qi
         XN2GTphOhB/SH4EyCMGVYU/HnUP6LkQnluEGCY9b6Ffaw+4czgQGP5JI26i3HhQYC9kY
         eMAmu02JPheia2pPW/lXmhuNOKPRJcdw5ekwDqAWncwDGo6idOlVhK528h6QoY6d5rAI
         NOOw==
X-Gm-Message-State: AGi0PuZinURmwQw75LgZWruas3K/05ZYWZQoeNkJFdjcG3wN23mVfeNo
        r5lOhxEVKhxU/p7pVBTzfyY=
X-Google-Smtp-Source: APiQypLhTrphrodbSR9yBPFAKLn6vJojtF5jZxehkpjWyqTXq/edJpRFg9k368drzw1RaZ5gyrLqdA==
X-Received: by 2002:adf:f841:: with SMTP id d1mr7975644wrq.381.1586117620148;
        Sun, 05 Apr 2020 13:13:40 -0700 (PDT)
Received: from localhost ([87.71.128.21])
        by smtp.gmail.com with ESMTPSA id c20sm7950246wmd.36.2020.04.05.13.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Apr 2020 13:13:39 -0700 (PDT)
Date:   Sun, 5 Apr 2020 23:13:37 +0300
From:   Lev Olshvang <levonshe@gmail.com>
To:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org
Subject: [RFC PATCH] integrity : utils Add 2 more inode atributes to hash
Message-ID: <20200405201337.GA10459@kl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From 0c48d5261ef653cc9ab73db7aa7bdf6bae4d9818 Mon Sep 17 00:00:00 2001
From: Lev Olshvang <levonshe@gmail.com>
Date: Sun, 5 Apr 2020 22:29:22 +0300
Subject: [RFC PATCH] integrity : utils Add 2 more inode atributes to hash

Added inode attr fields and  file size in to inode metadate hash.
Inode attr is importent because it may influence how filesystem
treats the file.
I think that some use cases relies on immutable attribute on files or
directories and some use cases marks encrypted files with a special
attribute
Therefore it is importent to check also integrity of inode->i_attr
Code refactored a bit to avoid duplicate code paths
I refactored also couple of very similar data types to avoid pointer conversions.

Signed-off-by: Lev Olshvang <levonshe@gmail.com>
---
 src/evmctl.c | 244 ++++++++++++++++++++++++---------------------------
 src/imaevm.h |  34 +++----
 2 files changed, 127 insertions(+), 151 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 3d2a10b..9a6c13c 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -117,7 +117,13 @@ static char *ino_str;
 static char *uid_str;
 static char *gid_str;
 static char *mode_str;
+static char *flags_str;
+static char *size_str;
+
+
+
 static char *generation_str;
+static uint32_t generation = 0;
 static char *caps_str;
 static char *ima_str;
 static char *selinux_str;
@@ -306,18 +312,24 @@ static int pack_uuid(const char *uuid_str, char *uuid)
 	return 0;
 }

-static int get_uuid(struct stat *st, char *uuid)
+static int get_uuid(const char *const file, char *uuid)
 {
 	uint32_t dev;
 	unsigned minor, major;
 	char path[PATH_MAX], _uuid[37];
 	FILE *fp;
 	size_t len;
+	struct stat st;

 	if (uuid_str)
 		return pack_uuid(uuid_str, uuid);

-	dev = st->st_dev;
+	if (lstat(file, &st)) {
+		log_err("Failed to stat: %s\n", file);
+		return -1;
+	}
+
+	dev = st.st_dev;
 	major = (dev & 0xfff00) >> 8;
 	minor = (dev & 0xff) | ((dev >> 12) & 0xfff00);

@@ -338,33 +350,42 @@ err:
 	log_err("Failed to read UUID. Root access might require.\n");
 	return -1;
 }
+static void store_inode_meta(uint32_t attr, file_common_t *hmac, const struct stat * const st) {
+	hmac->uid = st->st_uid;
+	hmac->gid = st->st_gid;
+	hmac->mode = st->st_mode;
+	hmac->attr = attr;
+	hmac->filesize = (uint32_t) st->st_size;
+}

-static int calc_evm_hash(const char *file, unsigned char *hash)
-{
-        const EVP_MD *md;
+static int fill_hmac(const char * const file,  file_meta_t * hmac_misc) {
+	uint16_t hmac_size = sizeof(*hmac_misc);
+	uint32_t attr = 0;
 	struct stat st;
-	int err;
-	uint32_t generation = 0;
-	EVP_MD_CTX *pctx;
-	unsigned int mdlen;
-	char **xattrname;
-	char xattr_value[1024];
-	char list[1024];
-	ssize_t list_size;
-	char uuid[16];
-	struct h_misc_64 hmac_misc;
-	int hmac_size;
-#if OPENSSL_VERSION_NUMBER < 0x10100000
-	EVP_MD_CTX ctx;
-	pctx = &ctx;
-#else
-	pctx = EVP_MD_CTX_new();
-#endif
+
+	generation = 0;

 	if (lstat(file, &st)) {
 		log_err("Failed to stat: %s\n", file);
 		return -1;
 	}
+	if ( st.st_size > 0xFFFFFFFF) {
+		log_err("File too big %s\n", file);
+		return -E2BIG;
+	}
+	int fd = open(file, 0);
+	if (fd < 0) {
+				log_err("Failed to open: %s\n", file);
+				return -1;
+	}
+	int rc = ioctl(fd, FS_IOC_GETFLAGS, &attr);
+	if (rc) {
+			log_err("ioctl() FS_IOC_GETFLAGS failed, rc=%d\n", rc);
+			close(fd);
+			return -1;
+		}
+	close(fd);
+	log_info("attr: %x\n", attr);

 	if (generation_str)
 		generation = strtoul(generation_str, NULL, 10);
@@ -376,6 +397,10 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 		st.st_gid = strtoul(gid_str, NULL, 10);
 	if (mode_str)
 		st.st_mode = strtoul(mode_str, NULL, 10);
+	if (size_str)
+		st.st_size = strtoul(size_str, NULL, 10);
+	if (flags_str)
+		st.st_size = strtoul(flags_str, NULL, 10);

 	if (!evm_immutable) {
 		if ((S_ISREG(st.st_mode) || S_ISDIR(st.st_mode)) && !generation_str) {
@@ -396,6 +421,57 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 		}
 		log_info("generation: %u\n", generation);
 	}
+
+	memset(hmac_misc, 0, hmac_size);
+
+	if (evm_immutable) {
+		// hmac_dig_sig, portable
+		file_common_t *hmac = &(hmac_misc->portable_fstat);
+
+		hmac_size = sizeof(*hmac);
+		store_inode_meta(attr, hmac, &st);
+
+	} else {
+		file_extra_t *hmac = &(hmac_misc->non_portable_fstat);
+		hmac_size = sizeof(*hmac);
+		if (!evm_portable) {
+			hmac->ino = st.st_ino;
+			hmac->generation = generation;
+		}
+		file_common_t *hmac_p = &(hmac_misc->portable_fstat);
+		store_inode_meta(attr, hmac_p, &st);
+	}
+	return hmac_size;
+}
+
+static int calc_evm_hash(const char *file, unsigned char *hash)
+{
+    const EVP_MD *md;
+	int err;
+	uint16_t hmac_size;
+	EVP_MD_CTX *pctx;
+	unsigned int mdlen;
+	char **xattrname;
+	char xattr_value[1024];
+	char list[1024];
+	ssize_t list_size;
+	char uuid[16];
+	file_meta_t hmac_misc;
+
+	err = fill_hmac(file, &hmac_misc);
+	if  (err < 0) {
+		return err;
+	}
+	hmac_size = (uint16_t) err;
+	log_debug("hmac_misc (%d): ", hmac_size);
+	log_debug_dump(&hmac_misc, hmac_size);
+
+#if OPENSSL_VERSION_NUMBER < 0x10100000
+	EVP_MD_CTX ctx;
+	pctx = &ctx;
+#else
+	pctx = EVP_MD_CTX_new();
+#endif

 	list_size = llistxattr(file, list, sizeof(list));
 	if (list_size < 0) {
@@ -464,51 +540,8 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 		}
 	}

-	memset(&hmac_misc, 0, sizeof(hmac_misc));
-
-	if (evm_immutable) {
-		struct h_misc_digsig *hmac = (struct h_misc_digsig *)&hmac_misc;
-
-		hmac_size = sizeof(*hmac);
-		hmac->uid = st.st_uid;
-		hmac->gid = st.st_gid;
-		hmac->mode = st.st_mode;
-	} else if (msize == 0) {
-		struct h_misc *hmac = (struct h_misc *)&hmac_misc;

-		hmac_size = sizeof(*hmac);
-		if (!evm_portable) {
-			hmac->ino = st.st_ino;
-			hmac->generation = generation;
-		}
-		hmac->uid = st.st_uid;
-		hmac->gid = st.st_gid;
-		hmac->mode = st.st_mode;
-	} else if (msize == 64) {
-		struct h_misc_64 *hmac = (struct h_misc_64 *)&hmac_misc;
-
-		hmac_size = sizeof(*hmac);
-		if (!evm_portable) {
-			hmac->ino = st.st_ino;
-			hmac->generation = generation;
-		}
-		hmac->uid = st.st_uid;
-		hmac->gid = st.st_gid;
-		hmac->mode = st.st_mode;
-	} else {
-		struct h_misc_32 *hmac = (struct h_misc_32 *)&hmac_misc;
-
-		hmac_size = sizeof(*hmac);
-		if (!evm_portable) {
-			hmac->ino = st.st_ino;
-			hmac->generation = generation;
-		}
-		hmac->uid = st.st_uid;
-		hmac->gid = st.st_gid;
-		hmac->mode = st.st_mode;
-	}
-
-	log_debug("hmac_misc (%d): ", hmac_size);
+	log_debug("hmac_misc (%u): ", hmac_size);
 	log_debug_dump(&hmac_misc, hmac_size);

 	err = EVP_DigestUpdate(pctx, &hmac_misc, hmac_size);
@@ -519,7 +552,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)

 	if (!evm_immutable && !evm_portable &&
 	    !(hmac_flags & HMAC_FLAG_NO_UUID)) {
-		err = get_uuid(&st, uuid);
+		err = get_uuid(file, uuid);
 		if (err)
 			return -1;

@@ -1064,10 +1097,9 @@ static int cmd_setxattr_ima(struct command *cmd)

 static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *hash)
 {
-        const EVP_MD *md;
-	struct stat st;
+    const EVP_MD *md;
+
 	int err = -1;
-	uint32_t generation = 0;
 	HMAC_CTX *pctx;
 	unsigned int mdlen;
 	char **xattrname;
@@ -1077,8 +1109,19 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 	unsigned char evmkey[MAX_KEY_SIZE];
 	char list[1024];
 	ssize_t list_size;
-	struct h_misc_64 hmac_misc;
+	file_meta_t hmac_misc;
 	int hmac_size;
+
+
+	hmac_size = fill_hmac(file, &hmac_misc);
+	if  (hmac_size < 0) {
+		return hmac_size;
+	}
+
+	log_debug("hmac_misc (%d): ", hmac_size);
+	log_debug_dump(&hmac_misc, hmac_size);
+
+
 #if OPENSSL_VERSION_NUMBER < 0x10100000
 	HMAC_CTX ctx;
 	pctx = &ctx;
@@ -1101,30 +1144,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 	memcpy(evmkey, key, keylen);
 	memset(evmkey + keylen, 0, sizeof(evmkey) - keylen);

-	if (lstat(file, &st)) {
-		log_err("Failed to stat: %s\n", file);
-		goto out;
-	}
-
-	if (S_ISREG(st.st_mode) || S_ISDIR(st.st_mode)) {
-		/* we cannot at the momement to get generation of special files..
-		 * kernel API does not support it */
-		int fd = open(file, 0);
-
-		if (fd < 0) {
-			log_err("Failed to open %s\n", file);
-			goto out;
-		}
-		if (ioctl(fd, FS_IOC_GETVERSION, &generation)) {
-			log_err("ioctl() failed\n");
-			close(fd);
-			goto out;
-		}
-		close(fd);
-	}
-
-	log_info("generation: %u\n", generation);
-
+
 	list_size = llistxattr(file, list, sizeof(list));
 	if (list_size <= 0) {
 		log_err("llistxattr() failed: %s\n", file);
@@ -1164,40 +1184,6 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 		}
 	}

-	memset(&hmac_misc, 0, sizeof(hmac_misc));
-
-	if (msize == 0) {
-		struct h_misc *hmac = (struct h_misc *)&hmac_misc;
-
-		hmac_size = sizeof(*hmac);
-		hmac->ino = st.st_ino;
-		hmac->generation = generation;
-		hmac->uid = st.st_uid;
-		hmac->gid = st.st_gid;
-		hmac->mode = st.st_mode;
-	} else if (msize == 64) {
-		struct h_misc_64 *hmac = (struct h_misc_64 *)&hmac_misc;
-
-		hmac_size = sizeof(*hmac);
-		hmac->ino = st.st_ino;
-		hmac->generation = generation;
-		hmac->uid = st.st_uid;
-		hmac->gid = st.st_gid;
-		hmac->mode = st.st_mode;
-	} else {
-		struct h_misc_32 *hmac = (struct h_misc_32 *)&hmac_misc;
-
-		hmac_size = sizeof(*hmac);
-		hmac->ino = st.st_ino;
-		hmac->generation = generation;
-		hmac->uid = st.st_uid;
-		hmac->gid = st.st_gid;
-		hmac->mode = st.st_mode;
-	}
-
-	log_debug("hmac_misc (%d): ", hmac_size);
-	log_debug_dump(&hmac_misc, hmac_size);
-
 	err = !HMAC_Update(pctx, (const unsigned char *)&hmac_misc, hmac_size);
 	if (err) {
 		log_err("HMAC_Update() failed\n");
diff --git a/src/imaevm.h b/src/imaevm.h
index b881d92..6bc66e8 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -90,35 +90,25 @@ enum evm_ima_xattr_type {
 	EVM_XATTR_PORTABLE_DIGSIG,
 };

-struct h_misc {
-	unsigned long ino;
-	uint32_t generation;
+typedef struct _common {
 	uid_t uid;
 	gid_t gid;
 	unsigned short mode;
-};
+	uint32_t attr;
+	uint32_t filesize;
+} file_common_t;

-struct h_misc_32 {
-	uint32_t ino;
+typedef struct _extra {
+	file_common_t inode_common;
 	uint32_t generation;
-	uid_t uid;
-	gid_t gid;
-	unsigned short mode;
-};
-
-struct h_misc_64 {
 	uint64_t ino;
-	uint32_t generation;
-	uid_t uid;
-	gid_t gid;
-	unsigned short mode;
-};
+} file_extra_t;
+
+typedef union _extended {
+	file_common_t portable_fstat;
+	file_extra_t  non_portable_fstat;
+} file_meta_t;

-struct h_misc_digsig {
-	uid_t uid;
-	gid_t gid;
-	unsigned short mode;
-};

 enum pubkey_algo {
 	PUBKEY_ALGO_RSA,
--
2.17.1

