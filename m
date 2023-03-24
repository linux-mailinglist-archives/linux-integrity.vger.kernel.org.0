Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABFB6C848B
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Mar 2023 19:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjCXSMO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Mar 2023 14:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjCXSMO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Mar 2023 14:12:14 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C5D1B30D
        for <linux-integrity@vger.kernel.org>; Fri, 24 Mar 2023 11:12:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PjqnT2GBqz9v7Ys
        for <linux-integrity@vger.kernel.org>; Sat, 25 Mar 2023 02:03:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCHXGPq5x1khGfFAQ--.26365S2;
        Fri, 24 Mar 2023 19:11:59 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils 1/2] Add --hmackey option for evmctl
Date:   Fri, 24 Mar 2023 19:11:48 +0100
Message-Id: <20230324181149.44694-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCHXGPq5x1khGfFAQ--.26365S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW8uFyUtr1fAF1fKF4kJFb_yoW8Gw4kpa
        98Xw15JrnYgr17AryUGFZ8Ga4ak3yxW3Wjqa1qgw1fXFZxGw1UJF43KF1F9343XFW0kay7
        Z3y2qrW5Gan7Wr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jI4E_UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBF1jj4clAQAEsW
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the --hmackey option, to specify an alternative path for the file
containing the HMAC key. By default evmctl looks in
/etc/keys/evm-key-plain.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 src/evmctl.c | 7 ++++++-
 src/imaevm.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 304b70de40f..df38e763041 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1413,7 +1413,8 @@ static int cmd_hmac_evm(struct command *cmd)
 			return err;
 	}
 
-	return hmac_evm(file, "/etc/keys/evm-key-plain");
+	return hmac_evm(file, imaevm_params.hmackeyfile ? :
+			"/etc/keys/evm-key-plain");
 }
 
 static int ima_fix(const char *path)
@@ -2940,6 +2941,7 @@ static struct option opts[] = {
 	{"keyid-from-cert", 1, 0, 145},
 	{"veritysig", 0, 0, 146},
 	{"hwtpm", 0, 0, 147},
+	{"hmackey", 1, 0, 148},
 	{}
 
 };
@@ -3185,6 +3187,9 @@ int main(int argc, char *argv[])
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

