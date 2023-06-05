Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571D2722D1B
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jun 2023 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFEQ4w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jun 2023 12:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjFEQ4v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 12:56:51 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3796EE8
        for <linux-integrity@vger.kernel.org>; Mon,  5 Jun 2023 09:56:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QZfdG2mpHz9ypbg
        for <linux-integrity@vger.kernel.org>; Tue,  6 Jun 2023 00:46:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDXU_+pE35kXiQSAw--.3839S5;
        Mon, 05 Jun 2023 17:56:31 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 ima-evm-utils 3/4] Add --hmackey option for evmctl
Date:   Mon,  5 Jun 2023 18:55:53 +0200
Message-Id: <20230605165554.1965238-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605165554.1965238-1-roberto.sassu@huaweicloud.com>
References: <20230605165554.1965238-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDXU_+pE35kXiQSAw--.3839S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1fGr1DCF1xJr17ArWrKrg_yoW5Zr48pa
        98J345J3s5XF17Jrn8GF1kJ3WUCan3ur1ftr4UWwn3WF98XFn2gFs3KF1F9ry3ZFWFqFy3
        Zr4IqFWfWa9rGrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
        Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBF1jj4o+5gAAs2
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the --hmackey option, to specify an alternate path for the file
containing the HMAC key. By default evmctl looks in
/etc/keys/evm-key-plain.

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

