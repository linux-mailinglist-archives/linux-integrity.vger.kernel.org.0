Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3480C22ED13
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jul 2020 15:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgG0NWJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 09:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0NWI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 09:22:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F09C061794
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jul 2020 06:22:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id h7so15128020qkk.7
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jul 2020 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3SqLgj1I4oArNsIdAHHLdE5HtQD3OIBCJyiZBxmSoUA=;
        b=avgBxR4gO1HpsBrIx7Hc8yW+ZYN+mL8xaEOXU26puxUOrVtsE+kf9zraaR5Ml6yOwZ
         aP50S/eGObgs9GsaB+SNjTX558oJaCdNpeOL34lDYyxS/z7jgg84YcH8u/K8CI9ne8Kt
         Nr25zPeftpye0UbTsERl7XxGkXqUrTEesyWgbXXb+IuFP5+yrFZnWlHHRqpRztusRNa4
         MYU7BN+iggSm2HhqFyIuSQS2pj78AM1N0jEvM0SlEcfjqrBGc6aiPot5yjZmjBwNKmRm
         6TlXmfQqH7Q2vtloCVOoFt6sIqazzF+wVC/iQ2msMGtKTDHobnNOrgf37t9+CH4On4Yj
         /JiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3SqLgj1I4oArNsIdAHHLdE5HtQD3OIBCJyiZBxmSoUA=;
        b=dp9wrOVjny59T4+f1e/VazLiXMoEnDn+jGVo87i1AHCMsB5BuP72FCTUPleTPUMTFu
         I8O/R/CpfgtDWIBuQzBs+fZOEujJL/+pYaDttXYExwRM1vV7/9YmpNaG2HqnfObYIeye
         dViUlF4AnDjFjiu4T19OeAAtTStbrNP0psxu3dAsGtPMyULgyLljFN58kdweKx5MekST
         ZLvUDVtfIAwLGxH76vv90iR7FOMWBn3L3WSPsxIOiZ84tWh081NyMph2Qb+IQxT8nyEm
         nbhECqzkojhbmBc02DB6olpD6C0/WOtE+ioR7lxclvflcqtCYgI6YJm9HoQ2qAqZ3+u/
         C9gg==
X-Gm-Message-State: AOAM530cLLu3mR7povSWcHE4dqm6WeZfIWb8EM802cqT8bBJPFT16jzR
        5uZVEtfX3jokliaYzyo0Mf4=
X-Google-Smtp-Source: ABdhPJzf1OYIe6de+1SwXOTdIrk3GVFDZJ2rTGI6qrK/HEeIuARL9+xhnoEdxyy2Lp8WX4PMqcw+Og==
X-Received: by 2002:a37:717:: with SMTP id 23mr22742633qkh.41.1595856126816;
        Mon, 27 Jul 2020 06:22:06 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id s190sm17686362qkh.116.2020.07.27.06.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 06:22:06 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, bill.c.roberts@gmail.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 ima-evm-utils] extend ima_measurement --pcrs option to support per-bank pcr files
Date:   Mon, 27 Jul 2020 09:21:10 -0400
Message-Id: <20200727132110.5057-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Extend the ima_measurement --pcrs option to support per-bank pcr files.
The extended syntax is "--pcrs algorithm,pathname".  If no algorithm
is specified, it defaults to sha1 as before.  Multiple --pcrs options
are now supported, one per bank of PCRs. The file format remains
unchanged.  If --pcrs is specified, only try to read PCRs from the
specified file(s); do not fall back to trying to read from sysfs
or the TPM itself in this case since the user requested use of
the files.

Create per-bank pcr files, depends on "tpm: add sysfs exports for all
banks of PCR registers" kernel patch:
$ cat tpm2pcrread.sh
#!/bin/sh
for alg in sha1 sha256
do
  rm -f pcr-$alg
  pcr=0;
  while [ $pcr -lt 24 ];
  do
    printf "PCR-%02d: " $pcr >> pcr-$alg;
    cat /sys/class/tpm/tpm0/pcr-$alg/$pcr >> pcr-$alg;
    pcr=$[$pcr+1];
  done
done
$ sh ./tpm2pcrread.sh

Pass only the sha1 PCRs to evmctl defaulting to sha1:
$ sudo evmctl ima_measurement --pcrs pcr-sha1 /sys/kernel/security/integrity/ima/binary_runtime_measurements

Pass only the sha1 PCRs to evmctl with explicit selection of sha1:
$ sudo evmctl ima_measurement --pcrs sha1,pcr-sha1 /sys/kernel/security/integrity/ima/binary_runtime_measurements

Pass both sha1 and sha256 PCRs to evmctl:
$ sudo evmctl ima_measurement --pcrs sha1,pcr-sha1 --pcrs sha256,pcr-sha256 /sys/kernel/security/integrity/ima/binary_runtime_measurements

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v4 updates the usage in the README and usage message, reduces MAX_NPCRFILE
to 2 (for sha1 and sha256) and changes the buffer size to
MAX_DIGEST_SIZE * 2 + 8 for the lines read from the pcrs file(s).

One thing that is unclear to me is correct/expected usage of the
--verify and --validate options to evmctl ima_measurement. For an
appraisal of a remote attestation, when would one NOT want to use
--verify (i.e. doesn't lack of --verify render the result insecure)
and when would one want to use --validate (i.e. doesn't use of --validate
render the result insecure)? And shouldn't the default in both cases
be the more secure case (i.e. verify = 1, validate = 0)?  The naming of
--validate is also confusing since one might expect it to mean
to validate/check the result as opposed to ignore violations?

 README       |   4 +-
 src/evmctl.c | 170 +++++++++++++++++++++++++++++++++------------------
 src/imaevm.h |   2 +-
 3 files changed, 113 insertions(+), 63 deletions(-)

diff --git a/README b/README
index 596b3b0..73b38a1 100644
--- a/README
+++ b/README
@@ -31,7 +31,7 @@ COMMANDS
  ima_sign [--sigfile] [--key key] [--pass password] file
  ima_verify file
  ima_hash file
- ima_measurement [--validate] [--verify] [--verify-sig [--key "key1, key2, ..."]]  [--pcrs file] file
+ ima_measurement [--validate] [--verify] [--verify-sig [--key "key1, key2, ..."]]  [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file
  ima_fix [-t fdsxm] path
  sign_hash [--key key] [--pass password]
  hmac [--imahash | --imasig ] file
@@ -59,7 +59,7 @@ OPTIONS
       --m32          force EVM hmac/signature for 32 bit target system
       --m64          force EVM hmac/signature for 64 bit target system
       --engine e     preload OpenSSL engine e (such as: gost)
-      --pcrs         file containing TPM 1.2 pcrs
+      --pcrs         file containing TPM pcrs, one per hash-algorithm/bank
       --validate     ignore ToMToU measurement violations
       --verify       verify the template data digest
       --verify-sig   verify the file signature based on the file hash, both
diff --git a/src/evmctl.c b/src/evmctl.c
index faddc3c..448e4a9 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -160,7 +160,10 @@ struct tpm_bank_info {
 	uint8_t pcr[NUM_PCRS][MAX_DIGEST_SIZE];
 };
 
-static char *pcrfile;
+/* One --pcrs file per hash-algorithm/bank */
+#define MAX_PCRFILE 2
+static char *pcrfile[MAX_PCRFILE];
+static unsigned npcrfile;
 
 static int bin2file(const char *file, const char *ext, const unsigned char *data, int len)
 {
@@ -1373,55 +1376,6 @@ static int cmd_ima_clear(struct command *cmd)
 	return do_cmd(cmd, ima_clear);
 }
 
-static char *pcrs = "/sys/class/tpm/tpm0/device/pcrs";  /* Kernels >= 4.0 */
-static char *misc_pcrs = "/sys/class/misc/tpm0/device/pcrs";
-
-/* Read all of the TPM 1.2 PCRs */
-static int tpm_pcr_read(struct tpm_bank_info *tpm_banks, int len)
-{
-	struct stat s;
-	FILE *fp = NULL;
-	char *p, pcr_str[8], buf[70]; /* length of the TPM string */
-	int result = -1;
-	int i = 0;
-
-	/* Use the provided TPM 1.2 pcrs file */
-	if (pcrfile) {
-		if (stat(pcrfile, &s) == -1) {
-			errno = 0;
-			return 1;
-		}
-
-		if (!S_ISREG(s.st_mode)) {
-			log_info("TPM 1.2 PCR file: not a regular file or link to regular file\n");
-			return 1;
-		}
-
-		fp = fopen(pcrfile, "r");
-	}
-
-	if (!fp)
-		fp = fopen(pcrs, "r");
-
-	if (!fp)
-		fp = fopen(misc_pcrs, "r");
-
-	if (!fp)
-		return -1;
-
-	for (;;) {
-		p = fgets(buf, sizeof(buf), fp);
-		if (!p || i > 99)
-			break;
-		sprintf(pcr_str, "PCR-%2.2d", i);
-		if (!strncmp(p, pcr_str, 6))
-			hex2bin(tpm_banks[0].pcr[i++], p + 7, len);
-		result = 0;
-	}
-	fclose(fp);
-	return result;
-}
-
 #define TCG_EVENT_NAME_LEN_MAX	255
 
 struct template_entry {
@@ -1829,20 +1783,108 @@ static void extend_tpm_banks(struct template_entry *entry, int num_banks,
 #endif
 }
 
-/* Read TPM 1.2 PCRs */
-static int read_tpm_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
+static int read_one_bank(struct tpm_bank_info *tpm_bank, FILE *fp)
 {
-	int i;
+	char *p, pcr_str[8], buf[MAX_DIGEST_SIZE * 2 + 8];
+	int i = 0;
+	int result = -1;
+	for (;;) {
+		p = fgets(buf, sizeof(buf), fp);
+		if (!p || i >= NUM_PCRS)
+			break;
+		sprintf(pcr_str, "PCR-%2.2d", i);
+		if (!strncmp(p, pcr_str, 6))
+			hex2bin(tpm_bank->pcr[i++], p + 7, tpm_bank->digest_size);
+		result = 0;
+	}
+	return result;
+}
+
+static char *pcrs = "/sys/class/tpm/tpm0/device/pcrs";  /* Kernels >= 4.0 */
+static char *misc_pcrs = "/sys/class/misc/tpm0/device/pcrs";
+
+/* Read one of the TPM 1.2 sysfs files if present */
+static int read_sysfs_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
+{
+	FILE *fp;
+	int i, result;
 
-	if (tpm_pcr_read(tpm_banks, SHA_DIGEST_LENGTH)) {
-		log_debug("Failed to read TPM 1.2 PCRs.\n");
+	fp = fopen(pcrs, "r");
+	if (!fp)
+		fp = fopen(misc_pcrs, "r");
+	if (!fp)
 		return -1;
-	}
 
+	result = read_one_bank(&tpm_banks[0], fp);
+	fclose(fp);
+	if (result < 0)
+		return result;
 	tpm_banks[0].supported = 1;
 	for (i = 1; i < num_banks; i++)
 		tpm_banks[i].supported = 0;
 	return 0;
+
+}
+
+/* Read PCRs from per-bank file(s) specified via --pcrs */
+static int read_file_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
+{
+	struct stat s;
+	FILE *fp;
+	char *p;
+	const char *alg, *path;
+	int i, j, bank, result;
+
+	for (i = 0; i < num_banks; i++)
+		tpm_banks[i].supported = 0;
+
+	for (i = 0; i < npcrfile; i++) {
+		p = strchr(pcrfile[i], ',');
+		if (p) {
+			*p = 0;
+			alg = pcrfile[i];
+			path = ++p;
+		} else {
+			alg = "sha1";
+			path = pcrfile[i];
+		}
+
+		bank = -1;
+		for (j = 0; j < num_banks; j++) {
+			if (!strcmp(tpm_banks[j].algo_name, alg)) {
+				bank = j;
+				break;
+			}
+		}
+		if (bank < 0) {
+			log_err("Unknown algorithm '%s'\n", alg);
+			return -1;
+		}
+
+		if (stat(path, &s) == -1) {
+			log_err("Could not stat '%s'\n", path);
+			return -1;
+		}
+
+		if (!S_ISREG(s.st_mode)) {
+			log_err("PCR file: not a regular file or link to regular file\n");
+			return -1;
+		}
+
+		fp = fopen(path, "r");
+		if (!fp) {
+			log_err("Could not open '%s'\n", path);
+			return -1;
+		}
+
+		result = read_one_bank(&tpm_banks[bank], fp);
+		fclose(fp);
+		if (result < 0)
+			return result;
+		tpm_banks[bank].supported = 1;
+	}
+
+	return 0;
 }
 
 /*
@@ -1857,8 +1899,12 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 	int i, j;
 	int err;
 
-	/* First try reading PCRs from exported TPM 1.2 sysfs file */
-	if (read_tpm_pcrs(num_banks, bank) == 0)
+	/* If --pcrs was specified, read only from the specified file(s) */
+	if (npcrfile)
+		return read_file_pcrs(num_banks, bank);
+
+	/* Else try reading PCRs from the sysfs file if present */
+	if (read_sysfs_pcrs(num_banks, bank) == 0)
 		return 0;
 
 	/* Any userspace applications available for reading TPM 2.0 PCRs? */
@@ -2440,7 +2486,7 @@ struct command cmds[] = {
 	{"ima_verify", cmd_verify_ima, 0, "file", "Verify IMA signature (for debugging).\n"},
 	{"ima_setxattr", cmd_setxattr_ima, 0, "[--sigfile file]", "Set IMA signature from sigfile\n"},
 	{"ima_hash", cmd_hash_ima, 0, "file", "Make file content hash.\n"},
-	{"ima_measurement", cmd_ima_measurement, 0, "[--validate] [--verify] [--verify-sig [--key key1, key2, ...]] [--pcrs file] file", "Verify measurement list (experimental).\n"},
+	{"ima_measurement", cmd_ima_measurement, 0, "[--validate] [--verify] [--verify-sig [--key key1, key2, ...]] [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file", "Verify measurement list (experimental).\n"},
 	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[file]", "Calculate per TPM bank boot_aggregate digests\n"},
 	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
 	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
@@ -2667,7 +2713,11 @@ int main(int argc, char *argv[])
 			verify = 1;
 			break;
 		case 143:
-			pcrfile = optarg;
+			if (npcrfile >= MAX_PCRFILE) {
+				log_err("too many --pcrfile options\n");
+				exit(1);
+			}
+			pcrfile[npcrfile++] = optarg;
 			break;
 		case '?':
 			exit(1);
diff --git a/src/imaevm.h b/src/imaevm.h
index 3f1db97..4503919 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -203,7 +203,7 @@ struct RSA_ASN1_template {
 	size_t size;
 };
 
-#define	NUM_PCRS 20
+#define	NUM_PCRS 24
 #define DEFAULT_PCR 10
 
 extern struct libimaevm_params imaevm_params;
-- 
2.25.1

