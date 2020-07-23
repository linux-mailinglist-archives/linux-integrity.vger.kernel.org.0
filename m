Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C8222B21F
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jul 2020 17:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgGWPF6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Jul 2020 11:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGWPF5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jul 2020 11:05:57 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83780C0619DC
        for <linux-integrity@vger.kernel.org>; Thu, 23 Jul 2020 08:05:57 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t23so1499183qto.3
        for <linux-integrity@vger.kernel.org>; Thu, 23 Jul 2020 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uQE9nATUat08gFgGuDAFHKIcBQO+wetG0Jcr+xOXQTc=;
        b=lPe9qe17/5nfZMfrKVuUqIsTO2lducOYzZlN0MBlnTRb+bFkMvngEYbeS9IjYreweE
         cvxuYQOrgfDm5M+PNAMvRbuJXcYiffSfOYMCxnlFTh0wkXgOpgLI10VhRw8r/IbCBF2M
         uYY2X8+F1TZKH8GuoTzlTndnSZh7FnR5t4WjoYaVrT28G7TbAGzTJC3Niwx8fIFJoooB
         MB5Xv8XCn3rciNMPG97HfUnPquXf/PRvkWOqF4+TGXbWRc9EsPCiNeDJk1oD4jJiC8sh
         nFhqfGf+VJZG8WcEssXzI8vpRmDAE51fYHv6bQxqy1Hfw/JrNwsyKKLdwpKENHT4ylzT
         dfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uQE9nATUat08gFgGuDAFHKIcBQO+wetG0Jcr+xOXQTc=;
        b=KVjPnmozElx+7E3gbhQ/6RARz+AGjzKd7yHCvz9N7E0g9F6HFKvfxl08oylyLMAC/U
         uuYjL3NNt1bCsKVFjBj8+987IS9iruk+dBK/POAGlMBwmJ7J8Ycl6fii/qIxEnIEw/ec
         Ckj+aZYUXRvFNTU71Iw/IHy1DNAURlj7pOX1j4fDnhq8NJLC2SZhPjJY6aKFHdbFxBgl
         KfjT7HOq1FMHG/ftYKPx4alAdxeLCRJ9ilyWphW5nN0WA9334ivAOLc8dwc1jV/4Bgzj
         3TW/RgoYtNBRYeQ283kfRtgvATEJ2j7pAYzqvtwqh4FxospLNg5LJL2FOh+IGa3lrfxe
         kHKw==
X-Gm-Message-State: AOAM533JlB+HT3oh4X34cLhp1tTm09Xq5AjMSDueVBor81C8MKfieddL
        v/N7LDe11rxrmfPY4W6UV1g=
X-Google-Smtp-Source: ABdhPJzi9icGfVnu3zNJa8VQORC+gIc2aE9WR8Xn3KOyWaax2yyG3JZUP8PFGj0BtBVX1yvxQCtAvw==
X-Received: by 2002:ac8:2c13:: with SMTP id d19mr4792595qta.137.1595516756644;
        Thu, 23 Jul 2020 08:05:56 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id t48sm2827086qtb.50.2020.07.23.08.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:05:55 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, bill.c.roberts@gmail.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] evmctl: extend ima_measurement --pcrs option to support per-bank pcr files
Date:   Thu, 23 Jul 2020 11:05:18 -0400
Message-Id: <20200723150518.16252-1-stephen.smalley.work@gmail.com>
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
unchanged.

Create per-bank pcr files, depends on "tpm: add sysfs exports for all banks
of PCR registers" kernel patch:
$ cat tpm2pcrread.sh
#!/bin/sh
for alg in sha1 sha256
do
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
$ sudo evmctl ima_measurement --pcrs pcr-sha1 /sys/kernel/security/integrity/ima/binary_runtime_measurements --validate

Pass only the sha1 PCRs to evmctl with explicit selection of sha1:
$ sudo evmctl ima_measurement --pcrs sha1,pcr-sha1 /sys/kernel/security/integrity/ima/binary_runtime_measurements --validate

Pass both sha1 and sha256 PCRs to evmctl:
$ sudo evmctl ima_measurement --pcrs sha1,pcr-sha1 --pcrs sha256,pcr-sha256 /sys/kernel/security/integrity/ima/binary_runtime_measurements --validate

NB The file parser could be improved to be more robust but I left the existing
code unchanged from the code to read the TPM 1.2 sysfs file other than
generalizing it to support loading other banks.

NB The error handling is IMHO wrong; if any error occurs during handling of
the --pcrs option(s), evmctl will try to fall back to reading the PCRs in
some other way.  I think these should be fatal errors but left it as it was
for the TPM 1.2 sysfs file.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 src/evmctl.c | 156 ++++++++++++++++++++++++++++++++-------------------
 src/imaevm.h |   2 +-
 2 files changed, 100 insertions(+), 58 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index faddc3c..6eea989 100644
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
@@ -1829,16 +1783,100 @@ static void extend_tpm_banks(struct template_entry *entry, int num_banks,
 #endif
 }
 
-/* Read TPM 1.2 PCRs */
+static int read_one_bank(struct tpm_bank_info *tpm_bank, FILE *fp)
+{
+	char *p, pcr_str[8], buf[70]; /* length of the TPM string */
+	int i = 0;
+	int result = -1;
+	for (;;) {
+		p = fgets(buf, sizeof(buf), fp);
+		if (!p || i > 99)
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
+/* Read all of the TPM PCRs */
 static int read_tpm_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
 {
-	int i;
+	struct stat s;
+	FILE *fp = NULL;
+	char *p;
+	const char *alg, *path;
+	int i = 0, j;
+	int bank, result;
+
+	/* Use the provided TPM bank pcr file(s) */
+	if (npcrfile) {
+		for (i = 0; i < num_banks; i++)
+			tpm_banks[i].supported = 0;
+		for (i = 0; i < npcrfile; i++) {
+			p = strchr(pcrfile[i], ',');
+			if (p) {
+				*p = 0;
+				alg = pcrfile[i];
+				path = ++p;
+			} else {
+				alg = "sha1";
+				path = pcrfile[i];
+			}
 
-	if (tpm_pcr_read(tpm_banks, SHA_DIGEST_LENGTH)) {
-		log_debug("Failed to read TPM 1.2 PCRs.\n");
-		return -1;
+			bank = -1;
+			for (j = 0; j < num_banks; j++) {
+				if (!strcmp(tpm_banks[j].algo_name, alg)) {
+					bank = j;
+					break;
+				}
+			}
+			if (bank < 0) {
+				log_err("Unknown algorithm '%s'\n", alg);
+				return -1;
+			}
+
+			if (stat(path, &s) == -1) {
+				log_err("Could not stat '%s'\n", path);
+				return -1;
+			}
+
+			if (!S_ISREG(s.st_mode)) {
+				log_err("TPM PCR file: not a regular file or link to regular file\n");
+				return -1;
+			}
+
+			fp = fopen(path, "r");
+			if (!fp) {
+				log_err("Could not open '%s'\n", path);
+				return -1;
+			}
+
+			result = read_one_bank(&tpm_banks[bank], fp);
+			fclose(fp);
+			if (result < 0)
+				return result;
+			tpm_banks[bank].supported = 1;
+		}
+
+		return 0;
 	}
 
+	/* Read the TPM 1.2 sysfs file */
+	fp = fopen(pcrs, "r");
+	if (!fp)
+		fp = fopen(misc_pcrs, "r");
+	if (!fp)
+		return -1;
+
+	result = read_one_bank(&tpm_banks[0], fp);
+	fclose(fp);
+	if (result < 0)
+		return result;
 	tpm_banks[0].supported = 1;
 	for (i = 1; i < num_banks; i++)
 		tpm_banks[i].supported = 0;
@@ -1857,7 +1895,7 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 	int i, j;
 	int err;
 
-	/* First try reading PCRs from exported TPM 1.2 sysfs file */
+	/* First try reading PCRs from TPM pcr file(s) */
 	if (read_tpm_pcrs(num_banks, bank) == 0)
 		return 0;
 
@@ -2667,7 +2705,11 @@ int main(int argc, char *argv[])
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
index 30e9730..88a1291 100644
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

