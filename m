Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21D667A0B8
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jan 2023 18:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjAXR7t (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Jan 2023 12:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjAXR7m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Jan 2023 12:59:42 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F904269A;
        Tue, 24 Jan 2023 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1674583181;
        bh=zxOEdwuaalwNHiGC2e67a2mJ2T7BWRsyBWZcOivzm1I=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=WBwZNNdVcQedn70+KH/F3poPJUTeImKjoTcSVUPCc1sF5t3Rs1qIhoNK7MbNhZeSs
         Qoo+afcJVy570wxFj0vS81sBoVI0jhOgHJ+l8q1RiDhD7H1dg2S08SLhi6NLRdkdhY
         CC+nb5MDE3br/BKE5dGesQ1JavVlPVXM0NK6Oo9o=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E5A2A12861A7;
        Tue, 24 Jan 2023 12:59:41 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wjSJwqlKcA7A; Tue, 24 Jan 2023 12:59:41 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4BE2F12818AC;
        Tue, 24 Jan 2023 12:59:41 -0500 (EST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 10/11] tpm: add the null key name as a sysfs export
Date:   Tue, 24 Jan 2023 12:55:15 -0500
Message-Id: <20230124175516.5984-11-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124175516.5984-1-James.Bottomley@HansenPartnership.com>
References: <20230124175516.5984-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/char/tpm/tpm-sysfs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 54c71473aa29..27a16addab93 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -309,6 +309,19 @@ static ssize_t tpm_version_major_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(tpm_version_major);
 
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
+
 static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_pubek.attr,
 	&dev_attr_pcrs.attr,
@@ -326,6 +339,7 @@ static struct attribute *tpm1_dev_attrs[] = {
 
 static struct attribute *tpm2_dev_attrs[] = {
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_null_name.attr,
 	NULL
 };
 
-- 
2.35.3

