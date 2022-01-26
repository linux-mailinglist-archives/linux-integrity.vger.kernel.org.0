Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F73349C003
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 01:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiAZAOW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 19:14:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233330AbiAZAOT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 19:14:19 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PNgYAS026700;
        Wed, 26 Jan 2022 00:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=DW8iUEmNKvEKheM+KZ/UPfi4LM0diG6Smzh4QxmPUl0=;
 b=VLhL0UlmkleYwoOKh3qfzANh8qT+Qae2cu72OYfRrQih3V3Deha0nfA0idzmVpKpweNj
 dnBf2UGspS6GanZleb/Bz0oWtYWTQK3T6dRsJW5ziMCJO0QO77f5ZoSMGDQMptxbn2mN
 /MPhTJnFQeJf6LPxpDmKIoCW9AgOY2PJVgHTLBvF3bEu3DJlKeBnFPjwC+m0wQpk/OdU
 +9OTifs7Mg3PN9GSNbGviqAePHyrfFCLbQKxzqgf9fUmzT9eu7ntzi1EPn+G5oY93YsT
 g+hVy8E3+Q1HTaNbKYFfOKDToDWh69kGaNjYYrPiHQAltBYWuxnnnU6M3AJAxzMxIu9O Tw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtu3u8jay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 00:14:17 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20Q08Mse025079;
        Wed, 26 Jan 2022 00:14:15 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3dr96jjbr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 00:14:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20Q0EArE42729794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 00:14:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48978A4040;
        Wed, 26 Jan 2022 00:14:10 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82F4CA404D;
        Wed, 26 Jan 2022 00:14:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.78.94])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jan 2022 00:14:09 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH ima-evm-utils] Signing fs-verity file digest based on existing evmctl commands
Date:   Tue, 25 Jan 2022 19:13:51 -0500
Message-Id: <20220126001351.138913-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HDKEt73ed_5_NrAMNem_qpExbqmMo3MB
X-Proofpoint-GUID: HDKEt73ed_5_NrAMNem_qpExbqmMo3MB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_06,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250145
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Instead of calculating a file hash and directly signing it, the new
IMA signature version 3 is a signature of the ima_file_id struct hash.
fs-verity only supports IMA signature version 3.

struct ima_file_id {
        __u8 hash_type;         /* xattr type [enum evm_ima_xattr_type] */
        __u8 hash_algorithm;    /* Digest algorithm [enum hash_algo] */
        __u8 hash[HASH_MAX_DIGESTSIZE];
} __packed;

The following steps are provided as a PoC and assume an existing fsverity
enabled file:

1. Calculate the hash of the fsverity_descriptor struct digest, prefixed
with the xattr type and hash algorithm.

The following commands call "fsverity measure" to read the
fsverity_descriptor struct digest, prefix the digest with the
IMA_VERITY_DIGSIG(06) and hash_algo_name enumeration (e.g. sha256 is 04),
before calculating the hash.

$ line=$(fsverity measure <file>)
$ hash=$(echo $line | sed -e  's/^.*:/0604/' -e 's/\s.*$//' | xxd -r -p - | sha256sum | sed 's/\s.*$//')
$ filename=$(echo $line | sed -e 's/^.* //')

2. "evmctl sign_hash" with the new "--veritysig" option may be used to
sign the resulting "ima_file_id" struct hash, provided in sha*sum output
format [hash filename].

$ echo $hash $filename | evmctl sign_hash --veritysig --hashalgo sha256 \
 --key <signing key.pem>  > <signed hash>

3. Prefix the resulting signature with '0x' before writing it as
security.ima xattr.  ('setfattr' requires root privileges.)

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 README       |  3 ++-
 src/evmctl.c | 12 +++++++++++-
 src/imaevm.h |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 5b5ecb52a74b..ffe46ad75728 100644
--- a/README
+++ b/README
@@ -34,7 +34,7 @@ COMMANDS
  ima_hash file
  ima_measurement [--ignore-violations] [--verify-sig [--key "key1, key2, ..."]]  [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file
  ima_fix [-t fdsxm] path
- sign_hash [--key key] [--pass password]
+ sign_hash [--veritysig] [--key key] [--pass password]
  hmac [--imahash | --imasig ] file
 
 
@@ -43,6 +43,7 @@ OPTIONS
 
   -a, --hashalgo     sha1, sha224, sha256, sha384, sha512
   -s, --imasig       make IMA signature
+      --veritysig    sign an fs-verity file digest hash
   -d, --imahash      make IMA hash
   -f, --sigfile      store IMA signature in .sig file instead of xattr
       --xattr-user   store xattrs in user namespace (for testing purposes)
diff --git a/src/evmctl.c b/src/evmctl.c
index 8bdd34817408..a445748c069a 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -135,6 +135,7 @@ static int msize;
 static dev_t fs_dev;
 static bool evm_immutable;
 static bool evm_portable;
+static bool veritysig;
 
 #define HMAC_FLAG_NO_UUID	0x0001
 #define HMAC_FLAG_CAPS_SET	0x0002
@@ -759,6 +760,11 @@ static int cmd_sign_hash(struct command *cmd)
 
 		fwrite(line, len, 1, stdout);
 		fprintf(stdout, " ");
+
+		if (veritysig) {
+			sig[0] = IMA_VERITY_DIGSIG;
+			sig[1] = 3;	/* signature version 3 */
+		}
 		bin2hex(sig, siglen + 1, stdout);
 		fprintf(stdout, "\n");
 	}
@@ -2556,7 +2562,7 @@ struct command cmds[] = {
 	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[--pcrs hash-algorithm,file] [TPM 1.2 BIOS event log]", "Calculate per TPM bank boot_aggregate digests\n"},
 	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
 	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
-	{"sign_hash", cmd_sign_hash, 0, "[--key key] [--pass [password]", "Sign hashes from shaXsum output.\n"},
+	{"sign_hash", cmd_sign_hash, 0, "[--veritysig] [--key key] [--pass [password]", "Sign hashes from either shaXsum or \"fsverity measure\" output.\n"},
 #ifdef DEBUG
 	{"hmac", cmd_hmac_evm, 0, "[--imahash | --imasig ] file", "Sign file metadata with HMAC using symmetric key (for testing purpose).\n"},
 #endif
@@ -2596,6 +2602,7 @@ static struct option opts[] = {
 	{"verify-bank", 2, 0, 143},
 	{"keyid", 1, 0, 144},
 	{"keyid-from-cert", 1, 0, 145},
+	{"veritysig", 0, 0, 146},
 	{}
 
 };
@@ -2826,6 +2833,9 @@ int main(int argc, char *argv[])
 			}
 			imaevm_params.keyid = keyid;
 			break;
+		case 146:
+			veritysig = 1;
+			break;
 		case '?':
 			exit(1);
 			break;
diff --git a/src/imaevm.h b/src/imaevm.h
index 0d53a0232ae4..535a9bafd9e7 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -93,6 +93,7 @@ enum evm_ima_xattr_type {
 	EVM_IMA_XATTR_DIGSIG,
 	IMA_XATTR_DIGEST_NG,
 	EVM_XATTR_PORTABLE_DIGSIG,
+	IMA_VERITY_DIGSIG,
 };
 
 struct h_misc {
-- 
2.27.0

