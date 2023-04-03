Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF606D53F7
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Apr 2023 23:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjDCVtS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Apr 2023 17:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbjDCVtI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Apr 2023 17:49:08 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BAFE48;
        Mon,  3 Apr 2023 14:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680558546;
        bh=KmhSFY8imv6p6T8huPvomy9EBANjw8a2mOEbtWpQpDY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=WoA19tUXRGCURDLr3CoDWHg3gRFdqqk21zJmsh+t88VP+cJThYyu4ZiTX1wReK4+i
         i4smzKRiQobKVirS93bRMQpDQsL2qgMIBwqUxq1BiK+uV83oZqnG+AmYKi0N0bwtZB
         XcQKI2/Fopc4mQeuCq4Bdqu6QqRPOU9KyVivtgsY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EF71E128020F;
        Mon,  3 Apr 2023 17:49:06 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 4IDvtVg98UhF; Mon,  3 Apr 2023 17:49:06 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6B0571280097;
        Mon,  3 Apr 2023 17:49:06 -0400 (EDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 12/13] tpm: add the null key name as a sysfs export
Date:   Mon,  3 Apr 2023 17:40:02 -0400
Message-Id: <20230403214003.32093-13-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is the last component of encrypted tpm2 session handling that
allows us to verify from userspace that the key derived from the NULL
seed genuinely belongs to the TPM and has not been spoofed.

The procedure for doing this involves creating an attestation identity
key (which requires verification of the TPM EK certificate) and then
using that AIK to sign a certification of the Elliptic Curve key over
the NULL seed.  Userspace must create this EC Key using the parameters
prescribed in TCG TPM v2.0 Provisioning Guidance for the SRK ECC; if
this is done correctly the names will match and the TPM can then run a
TPM2_Certify operation on this derived primary key using the newly
created AIK.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-sysfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 54c71473aa29..403dffea4ea6 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -309,6 +309,21 @@ static ssize_t tpm_version_major_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(tpm_version_major);
 
+#ifdef CONFIG_TPM_BUS_SECURITY
+static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+	int size = TPM2_NAME_SIZE;
+
+	bin2hex(buf, chip->tpmkeyname, size);
+	size *= 2;
+	buf[size++] = '\n';
+	return size;
+}
+static DEVICE_ATTR_RO(null_name);
+#endif
+
 static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_pubek.attr,
 	&dev_attr_pcrs.attr,
@@ -326,6 +341,9 @@ static struct attribute *tpm1_dev_attrs[] = {
 
 static struct attribute *tpm2_dev_attrs[] = {
 	&dev_attr_tpm_version_major.attr,
+#ifdef CONFIG_TPM_BUS_SECURITY
+	&dev_attr_null_name.attr,
+#endif
 	NULL
 };
 
-- 
2.35.3

