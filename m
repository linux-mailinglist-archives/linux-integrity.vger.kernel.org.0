Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBB16ABE52
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Mar 2023 12:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCFLhd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Mar 2023 06:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjCFLhc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Mar 2023 06:37:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CF75595
        for <linux-integrity@vger.kernel.org>; Mon,  6 Mar 2023 03:37:27 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326ARLqd032286;
        Mon, 6 Mar 2023 11:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=MGGXUSof/xhqzinK1czaq1nUWrVCC4mOQ8Gt1ftDoHU=;
 b=rsFajbYS+rtrJ8aUTKzIxDYsRlf9FECh8ttrOqeVqYnSFnPBG/sNwY4D6ixCSQ1zD9We
 a8v69msV6FVmuZmVCh6k/tGgYjJOMWygnyzgdTDMCUw9Atmx9KSzL4pvB2EvbKEG66eJ
 So3+z/lsTS/K6mRzpJx1AGV1in6orUhCHvvTmoETx1mmvC56B6ZOneLRYpXKHQX2B28b
 /QfVjrplpLLUewE94RqPBTg8b0+b3wO38lXYF1k8naLY4cs6N/jrZ0A+FCmsUpz8PXsi
 OaPzx42Z0au9GQz3geO1elYjntzDSkjlFIVch54rTsrN5/p3gYkZ23qpw1MC5vliU3Qz +w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4x1hksqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 11:37:17 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326BTVB7007531;
        Mon, 6 Mar 2023 11:37:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p4188amvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 11:37:15 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326BbDJD61866486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 11:37:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AB882004F;
        Mon,  6 Mar 2023 11:37:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FFC72004E;
        Mon,  6 Mar 2023 11:37:12 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.111.157])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 11:37:11 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>, Petr Vorel <pvorel@suse.cz>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: [PATCH ima-evm-utils 1/2] Update README
Date:   Mon,  6 Mar 2023 06:36:34 -0500
Message-Id: <20230306113635.350582-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BgKplqenmlLl9CC2xjnSFPMIg7d7r9tl
X-Proofpoint-ORIG-GUID: BgKplqenmlLl9CC2xjnSFPMIg7d7r9tl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_04,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303060101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Update the README to reflect the changes to "evmctl --help".

Update the "--pass" option format in both the README and evmctl usage
to reflect passing an optional password on the command line (not
recommended).  When providing the password, the format is:
 "[--pass[=<password>]]".

Also fix some typos.

Still include references to both the deprecated "--rsa" and "--engine"
options.

Related confiigure options:
--enable-sigv1          Build ima-evm-utils with signature v1 support
--disable-engine        build ima-evm-utils without OpenSSL engine support

Reported-by: Vitaly Chikunov <vt@altlinux.org> # typos, "--pass" format
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 README       | 37 +++++++++++++++++++++++++------------
 src/evmctl.c |  9 +++++----
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/README b/README
index ffe46ad75728..75e4fd2e8948 100644
--- a/README
+++ b/README
@@ -25,29 +25,34 @@ COMMANDS
 
  --version
  help <command>
- import [--rsa] pubkey keyring
- sign [-r] [--imahash | --imasig ] [--portable] [--key key] [--pass password] file
+ import  [--rsa (deprecated)] pubkey keyring
+ sign [-r] [--imahash | --imasig ] [--key key] [--pass[=<password>] file
  verify file
- ima_boot_aggregate [--pcrs hash-algorithm,file] [TPM 1.2 BIOS event log]
- ima_sign [--sigfile] [--key key] [--pass password] file
+ ima_sign [--sigfile] [--key key] [--pass[=<password>]] file
  ima_verify file
+ ima_setxattr [--sigfile file]
  ima_hash file
- ima_measurement [--ignore-violations] [--verify-sig [--key "key1, key2, ..."]]  [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file
+ ima_measurement [--ignore-violations] [--verify-sig [--key "key1, key2, ..."]]
+   [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...]
+   [--verify-bank hash-algorithm] file
+ ima_boot_aggregate [--pcrs hash-algorithm,file] [TPM 1.2 BIOS event log]
+   [--hwtpm]
  ima_fix [-t fdsxm] path
- sign_hash [--veritysig] [--key key] [--pass password]
+ ima_clear [-t fdsxm] path
+ sign_hash [--veritysig] [--key key] [--pass=<password>]
  hmac [--imahash | --imasig ] file
 
 
 OPTIONS
 -------
 
-  -a, --hashalgo     sha1, sha224, sha256, sha384, sha512
+  -a, --hashalgo     sha1, sha224, sha256, sha384, sha512, streebog256, streebog512 (default: sha256)
   -s, --imasig       make IMA signature
       --veritysig    sign an fs-verity file digest hash
   -d, --imahash      make IMA hash
   -f, --sigfile      store IMA signature in .sig file instead of xattr
       --xattr-user   store xattrs in user namespace (for testing purposes)
-      --rsa          use RSA key type and signing scheme v1
+      --rsa          use RSA key type and signing scheme v1 (deprecated)
   -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)
                      or a pkcs11 URI
       --keyid n      overwrite signature keyid with a 32-bit value in hex (for signing)
@@ -64,7 +69,15 @@ OPTIONS
       --smack        use extra SMACK xattrs for EVM
       --m32          force EVM hmac/signature for 32 bit target system
       --m64          force EVM hmac/signature for 64 bit target system
-      --engine e     preload OpenSSL engine e (such as: gost)
+      --engine e     preload OpenSSL engine e (such as: gost) is deprecated
+      --ino          use custom inode for EVM
+      --uid          use custom UID for EVM
+      --gid          use custom GID for EVM
+      --mode         use custom Mode for EVM
+      --generation   use custom Generation for EVM(unspecified: from FS, empty: use 0)
+      --ima          use custom IMA signature for EVM
+      --selinux      use custom Selinux label for EVM
+      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)
       --pcrs         file containing TPM pcrs, one per hash-algorithm/bank
       --ignore-violations ignore ToMToU measurement violations
       --verify-sig   verify the file signature based on the file hash, both
@@ -206,7 +219,7 @@ asymmetric keys support:
 
 Configuration file x509_evm.genkey:
 
-	# Begining of the file
+	# Beginning of the file
 	[ req ]
 	default_bits = 1024
 	distinguished_name = req_distinguished_name
@@ -257,7 +270,7 @@ following steps:
 
 Configuration file ima-local-ca.genkey:
 
-	# Begining of the file
+	# Beginning of the file
 	[ req ]
 	default_bits = 2048
 	distinguished_name = req_distinguished_name
@@ -288,7 +301,7 @@ Produce X509 in DER format for using while building the kernel:
 
 Configuration file ima.genkey:
 
-	# Begining of the file
+	# Beginning of the file
 	[ req ]
 	default_bits = 1024
 	distinguished_name = req_distinguished_name
diff --git a/src/evmctl.c b/src/evmctl.c
index 95281df08051..6d2bb67427da 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2820,6 +2820,7 @@ static void usage(void)
 		"\n"
 		"  -a, --hashalgo     sha1, sha224, sha256, sha384, sha512, streebog256, streebog512 (default: %s)\n"
 		"  -s, --imasig       make IMA signature\n"
+		"      --veritysig    sign an fs-verity file digest hash\n"
 		"  -d, --imahash      make IMA hash\n"
 		"  -f, --sigfile      store IMA signature in .sig file instead of xattr\n"
 		"      --xattr-user   store xattrs in user namespace (for testing purposes)\n"
@@ -2867,14 +2868,14 @@ struct command cmds[] = {
 	{"--version", NULL, 0, ""},
 	{"help", cmd_help, 0, "<command>"},
 #if CONFIG_SIGV1
-	{"import", cmd_import, 0, "[--rsa] pubkey keyring", "Import public key into the keyring. ([--rsa] deprecated)\n"},
+	{"import", cmd_import, 0, "[--rsa (deprecated)] pubkey keyring", "Import public key into the keyring.\n"},
 	{"convert", cmd_convert, 0, "key", "convert public key into the keyring. (deprecated)\n"},
 #else
 	{"import", cmd_import, 0, "pubkey keyring", "Import public key into the keyring.\n"},
 #endif
-	{"sign", cmd_sign_evm, 0, "[-r] [--imahash | --imasig ] [--key key] [--pass [password] file", "Sign file metadata.\n"},
+	{"sign", cmd_sign_evm, 0, "[-r] [--imahash | --imasig ] [--key key] [--pass[=<password>]] file", "Sign file metadata.\n"},
 	{"verify", cmd_verify_evm, 0, "file", "Verify EVM signature (for debugging).\n"},
-	{"ima_sign", cmd_sign_ima, 0, "[--sigfile] [--key key] [--pass [password] file", "Make file content signature.\n"},
+	{"ima_sign", cmd_sign_ima, 0, "[--sigfile] [--key key] [--pass[=<password>]] file", "Make file content signature.\n"},
 	{"ima_verify", cmd_verify_ima, 0, "file", "Verify IMA signature (for debugging).\n"},
 	{"ima_setxattr", cmd_setxattr_ima, 0, "[--sigfile file]", "Set IMA signature from sigfile\n"},
 	{"ima_hash", cmd_hash_ima, 0, "file", "Make file content hash.\n"},
@@ -2882,7 +2883,7 @@ struct command cmds[] = {
 	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[--pcrs hash-algorithm,file] [TPM 1.2 BIOS event log] [--hwtpm]", "Calculate per TPM bank boot_aggregate digests\n"},
 	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
 	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
-	{"sign_hash", cmd_sign_hash, 0, "[--veritysig] [--key key] [--pass password]", "Sign hashes from either shaXsum or \"fsverity digest\" output.\n"},
+	{"sign_hash", cmd_sign_hash, 0, "[--veritysig] [--key key] [--pass[=<password>]]", "Sign hashes from either shaXsum or \"fsverity digest\" output.\n"},
 #ifdef DEBUG
 	{"hmac", cmd_hmac_evm, 0, "[--imahash | --imasig ] file", "Sign file metadata with HMAC using symmetric key (for testing purpose).\n"},
 #endif
-- 
2.31.1

