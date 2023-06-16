Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A0E7339D5
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jun 2023 21:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346230AbjFPT1g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jun 2023 15:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346234AbjFPT1V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jun 2023 15:27:21 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF4B44AA
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jun 2023 12:25:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QjTNW4b64z9xFQY
        for <linux-integrity@vger.kernel.org>; Sat, 17 Jun 2023 03:14:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAH2F7TtoxksMlFAw--.17356S5;
        Fri, 16 Jun 2023 20:24:24 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 ima-evm-utils 3/4] Add --hmackey option for evmctl
Date:   Fri, 16 Jun 2023 21:23:57 +0200
Message-Id: <20230616192358.314906-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616192358.314906-1-roberto.sassu@huaweicloud.com>
References: <20230616192358.314906-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAH2F7TtoxksMlFAw--.17356S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4rtry5Ar1rWF13Xr13urg_yoW5tF43pa
        98J345JryktF17Jrn8GF1kt3W7Can3ur13tr47Wws7uF98XF92gFs3Kr1F9rW3ZFWrtFy3
        ZrWIqFWfWa9rGrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jIBT5UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4rIbAACsR
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

"evmctl --hmac" was only enabled in debug mode, since the hmac key was not
exposed to userspace. It was never really used. With the ability of
creating an encrypted key based on user-provided decrypted data, verifying
the EVM hmac is now feasible.

Make "evmctl --hmac" more configurable by adding the --hmackey option, to
specify an alternate path for the file containing the HMAC key. By default
evmctl looks in /etc/keys/evm-key-plain.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 README       |  3 ++-
 src/evmctl.c | 12 ++++++++++--
 src/imaevm.h |  1 +
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 40a61f94315..7239dda257e 100644
--- a/README
+++ b/README
@@ -40,7 +40,7 @@ COMMANDS
  ima_fix [-t fdsxm] path
  ima_clear [-t fdsxm] path
  sign_hash [--veritysig] [--key key] [--pass=<password>]
- hmac [--imahash | --imasig ] file
+ hmac [--imahash | --imasig] [--hmackey key] file
 
 
 OPTIONS
@@ -82,6 +82,7 @@ OPTIONS
       --ignore-violations ignore ToMToU measurement violations
       --verify-sig   verify the file signature based on the file hash, both
                      stored in the template data.
+      --hmackey      path to symmetric key (default: /etc/keys/evm-key-plain)
   -v                 increase verbosity level
   -h, --help         display this help and exit
 
diff --git a/src/evmctl.c b/src/evmctl.c
index 7a3ffd7c823..8caf9bd83fb 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1417,7 +1417,8 @@ static int cmd_hmac_evm(struct command *cmd)
 			return err;
 	}
 
-	return hmac_evm(file, "/etc/keys/evm-key-plain");
+	return hmac_evm(file, imaevm_params.hmackeyfile ? :
+			"/etc/keys/evm-key-plain");
 }
 
 static int ima_fix(const char *path)
@@ -2873,6 +2874,9 @@ static void usage(void)
 		"      --engine e     preload OpenSSL engine e (such as: gost) is deprecated\n"
 #endif
 		"      --ignore-violations ignore ToMToU measurement violations\n"
+#ifdef DEBUG
+		"      --hmackey      path to symmetric key (default: /etc/keys/evm-key-plain)\n"
+#endif
 		"  -v                 increase verbosity level\n"
 		"  -h, --help         display this help and exit\n"
 		"\n"
@@ -2902,7 +2906,7 @@ struct command cmds[] = {
 	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
 	{"sign_hash", cmd_sign_hash, 0, "[--veritysig] [--key key] [--pass[=<password>]]", "Sign hashes from either shaXsum or \"fsverity digest\" output.\n"},
 #ifdef DEBUG
-	{"hmac", cmd_hmac_evm, 0, "[--imahash | --imasig ] file", "Sign file metadata with HMAC using symmetric key (for testing purpose).\n"},
+	{"hmac", cmd_hmac_evm, 0, "[--imahash | --imasig] [--hmackey key] file", "Sign file metadata with HMAC using symmetric key (for testing purpose).\n"},
 #endif
 	{0, 0, 0, NULL}
 };
@@ -2944,6 +2948,7 @@ static struct option opts[] = {
 	{"keyid-from-cert", 1, 0, 145},
 	{"veritysig", 0, 0, 146},
 	{"hwtpm", 0, 0, 147},
+	{"hmackey", 1, 0, 148},
 	{}
 
 };
@@ -3189,6 +3194,9 @@ int main(int argc, char *argv[])
 		case 147:
 			hwtpm = 1;
 			break;
+		case 148:
+			imaevm_params.hmackeyfile = optarg;
+			break;
 		case '?':
 			exit(1);
 			break;
diff --git a/src/imaevm.h b/src/imaevm.h
index 78e7ed5e89d..18d7b0e447e 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -221,6 +221,7 @@ struct libimaevm_params {
 	const char *keypass;
 	uint32_t keyid;		/* keyid overriding value, unless 0. (Host order.) */
 	ENGINE *eng;
+	const char *hmackeyfile;
 };
 
 struct RSA_ASN1_template {
-- 
2.25.1

