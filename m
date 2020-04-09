Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5484C1A2E05
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Apr 2020 05:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDIDjN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Apr 2020 23:39:13 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:59673 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726552AbgDIDjN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Apr 2020 23:39:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tv0dk.x_1586403549;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Tv0dk.x_1586403549)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Apr 2020 11:39:10 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, zhangliguang@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ima: support to tune appraise mode in runtime
Date:   Thu,  9 Apr 2020 11:39:07 +0800
Message-Id: <20200409033907.102833-3-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409033907.102833-1-tianjia.zhang@linux.alibaba.com>
References: <20200409033907.102833-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In order to tune appraise mode in runtime, writing a PKCS#7 signature
corresponding the signed content is required. The content should be off,
enforce, log or fix. Given a simple way to archive this:

$ echo -n off > mode
$ openssl smime -sign -nocerts -noattr -binary \
    -in mode -inkey <system_trusted_key> \
    -signer <cert> -outform der -out mode.p7s
$ sudo cat mode.p7s \
    > /sys/kernel/security/ima/appraise_mode

Note that the signing key must be a trust key located in
system trusted keyring. So even the root privilege cannot
simply disable the enforcement.

Signed-off-by: luanshi <zhangliguang@linux.alibaba.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 security/integrity/ima/ima_fs.c | 102 ++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 65384f6ac0d9..c21ca145de0f 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -20,11 +20,15 @@
 #include <linux/rcupdate.h>
 #include <linux/parser.h>
 #include <linux/vmalloc.h>
+#include <linux/verification.h>
 
 #include "ima.h"
 
 static DEFINE_MUTEX(ima_write_mutex);
 
+/* maximum length of token allowed for signed appraise mode */
+#define APPRAISE_MAX_TOKEN_SIZE (512 * 1024)
+
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
 {
@@ -466,8 +470,106 @@ static ssize_t ima_appraise_mode_read(struct file *filp,
 	return simple_read_from_buffer(buf, count, ppos, mode, strlen(mode));
 }
 
+static int check_signature_info(char *buf, size_t count)
+{
+	u8 *p;
+
+	/*
+	 * In order to tune the appraise mode, a PKCS#7 signature is
+	 * supplied.
+	 *
+	 * Assuming ASN.1 encoding supplied, the minimal length would be
+	 * 4-byte header plus at least 256-byte payload.
+	 */
+	if (count < 260)
+		return -EINVAL;
+
+	p = (u8 *)buf;
+
+	/* The primitive type must be a sequence */
+	if (p[0] != 0x30 || p[1] != 0x82)
+		return -EINVAL;
+
+	/* Match up the length of the supplied buffer */
+	if (be16_to_cpup((__be16 *)(p + 2)) != count - 4)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Verify the supplied PKCS#7 signature. The signed content may be off,
+ * enforce, log, fix.
+ */
+static int repopulate_ima_appraise_mode(void *pkcs7, size_t pkcs7_len)
+{
+	static char *appraise_mode_strings[] = { "off", "enforce", "fix", "log" };
+	static int appraise_modes[] = {
+		0,
+		IMA_APPRAISE_ENFORCE,
+		IMA_APPRAISE_FIX,
+		IMA_APPRAISE_LOG,
+	};
+	int index, ret = -1;
+	const char *s;
+	int size = ARRAY_SIZE(appraise_mode_strings);
+
+	for (index = 0; index < size; index++) {
+		s = appraise_mode_strings[index];
+		ret = verify_pkcs7_signature(s, strlen(s), pkcs7, pkcs7_len,
+					    NULL, VERIFYING_UNSPECIFIED_SIGNATURE,
+					    NULL, NULL);
+		if (!ret)
+			break;
+	}
+
+	if (index == size)
+		goto out;
+
+	ima_appraise = appraise_modes[index];
+
+out:
+	return ret;
+}
+
+static ssize_t ima_appraise_mode_write(struct file *filp,
+					const char __user *ubuf,
+					size_t count, loff_t *ppos)
+{
+	char *buf;
+	ssize_t ret;
+
+	if (*ppos > 1)
+		return -EFBIG;
+
+	if (count > APPRAISE_MAX_TOKEN_SIZE)
+		return -EFBIG;
+
+	buf = kmalloc(count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = simple_write_to_buffer(buf, count, ppos, ubuf, count);
+	if (ret <= 0)
+		goto out;
+
+	ret = check_signature_info(buf, count);
+	if (ret)
+		goto out;
+
+	ret = repopulate_ima_appraise_mode(buf, count);
+	if (ret)
+		goto out;
+
+	ret = count;
+
+out:
+	kfree(buf);
+	return ret;
+}
+
 static const struct file_operations ima_appraise_mode_ops = {
 	.read = ima_appraise_mode_read,
+	.write = ima_appraise_mode_write,
 	.llseek = generic_file_llseek,
 };
 
-- 
2.17.1

