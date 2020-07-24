Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2FB22C87E
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgGXOxC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgGXOxC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 10:53:02 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51141C0619D3
        for <linux-integrity@vger.kernel.org>; Fri, 24 Jul 2020 07:53:02 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id e13so8832915qkg.5
        for <linux-integrity@vger.kernel.org>; Fri, 24 Jul 2020 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pW5CWUv38Yq8P4zmVV6x9Jc/YJfKu2AK9DAYsOqezD0=;
        b=DNtmlqmotVZ7s4qq0gUlt4onnPasjPOh7GdGGMCwdYiecwo4cXOexjaTDT+XMwYYz2
         t8+ZRCh7Iu636YHXp7EO5sHcWsj7HzwzMTx6i7QqoHFhcLwfaYEhi0mVW3Fdyklk9E8A
         j/utaUUuReCbjw6mttRd2OXaL26ExxagEEtPzOsKciNR07iajm/g30y1OBkoIiI1+Xvk
         +IjptrAYfmOcDVdbRc8z/15OjYtzKcI4ke0mmfHqI88fu3rnW/JtceK66+O9TUl0gPKD
         ITEBfd2HUJjrnhakZu5yWv8gYjKO3bkYaRWRqbYfaI2o75P0S5A2nPvTZxnFx1PQR+xc
         //xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pW5CWUv38Yq8P4zmVV6x9Jc/YJfKu2AK9DAYsOqezD0=;
        b=fxAggIGmf8n37JLrxh7UyWEodLASxE+6Ua4BOdIKCUqwxjexjZxeADqzS7vAKz8auF
         OSKOe0Wtd2hwwSSH++pEBwrU9h/T6xwgrNHfnGymVjuAtFrrKvvsYn9Bb7XX7gJg0tHB
         /fPDcLXUqEPv3y/SLhdZD2xVSKOEeh5Kl/MpboyuM83jgBweDD0UKKMFIboVw+2cDKX0
         8jd6DAGnj7THCkPLvyNtXdp/lewaoadATk+X7CeHTreSiUeb/t1yhsO/XWJ3L7iaacUK
         JZ8yC6ZXKHNOAxnPzmJBQUku86EqbdynNbKZ2oLXMZXXWepfneosuVIdPJN04g3Ok4dF
         PfLg==
X-Gm-Message-State: AOAM5312qqQZuRXfkQ6kwICI4yeg7q/8lDHtOoiWSeZWXS5af+/FbeDz
        MoYbRMUar88UIKCXOpkFZsA=
X-Google-Smtp-Source: ABdhPJx/StUPkCMGY8k9/bd4iTZe4QKepn3vBrXEUpMrn6op8fcN9VZySaFCKC/+BKcWurE4GpStgw==
X-Received: by 2002:a05:620a:1089:: with SMTP id g9mr10923643qkk.252.1595602381497;
        Fri, 24 Jul 2020 07:53:01 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id y26sm1462746qto.75.2020.07.24.07.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 07:53:00 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, bill.c.roberts@gmail.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 ima-evm-utils] extend ima_measurement --pcrs option to support per-bank pcr files
Date:   Fri, 24 Jul 2020 10:52:42 -0400
Message-Id: <20200724145242.31178-1-stephen.smalley.work@gmail.com>
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
v3 splits reading the pcr files and the sysfs files into two separate functions
each called from read_tpm_banks() with different error handling. Thus, if
--pcrs is specified, then evmctl will only try to read from the specified
file(s) and any errors will cause it to fail rather than trying to read
directly from the TPM.  If --pcrs is not specified, then evmctl will try
to read from the sysfs files and then fall back to reading directly
from the TPM if that fails. v3 also reduces the limit on the number of
PCRs read from the files to NUM_PCRS since otherwise it will overflow
the pcrs[] array.  Further improvements to the file parser are deferred
to future patches.

 src/evmctl.c | 168 +++++++++++++++++++++++++++++++++------------------
 src/imaevm.h |   2 +-
 2 files changed, 110 insertions(+), 60 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index faddc3c..4793b3e 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -160,7 +160,10 @@ struct tpm_bank_info {
 	uint8_t pcr[NUM_PCRS][MAX_DIGEST_SIZE];
 };
 
-static char *pcrfile;
+
+#define MAX_PCRFILE 16
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
+	char *p, pcr_str[8], buf[80];
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

