Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D50AD8ED
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 14:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfIIMYa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 08:24:30 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48406 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726282AbfIIMYa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 08:24:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5D1688EE180;
        Mon,  9 Sep 2019 05:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031870;
        bh=AVrjyvgb3krMB/HHAo2SNQxEzajsFtqw/mMBv/svl58=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R6DfaewIXfs6Dm5D2QWcGedUmfaxHjkTlJXUNgZ9OvV4wzV3FQtlp36osHsyX8+A3
         3IaGS4yQaDlUC68vP+3jtoQ/kz2/EZrNo+z47EqALykUtbEldsDFXziJxHMKYlHfzM
         mByh8KVIp4NnQazjyhKagJUw++axfwSssiF9kWW8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EM2wXG0MAh1B; Mon,  9 Sep 2019 05:24:30 -0700 (PDT)
Received: from [192.168.6.117] (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2586C8EE105;
        Mon,  9 Sep 2019 05:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031870;
        bh=AVrjyvgb3krMB/HHAo2SNQxEzajsFtqw/mMBv/svl58=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R6DfaewIXfs6Dm5D2QWcGedUmfaxHjkTlJXUNgZ9OvV4wzV3FQtlp36osHsyX8+A3
         3IaGS4yQaDlUC68vP+3jtoQ/kz2/EZrNo+z47EqALykUtbEldsDFXziJxHMKYlHfzM
         mByh8KVIp4NnQazjyhKagJUw++axfwSssiF9kWW8=
Message-ID: <1568031867.6613.39.camel@HansenPartnership.com>
Subject: [PATCH v6 10/12] tpm: add the null key name as a tpm2 sysfs variable
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Sep 2019 13:24:27 +0100
In-Reply-To: <1568031408.6613.29.camel@HansenPartnership.com>
References: <1568031408.6613.29.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
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
 drivers/char/tpm/tpm-sysfs.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index d9caedda075b..07aa8f427b96 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -309,6 +309,19 @@ static ssize_t timeouts_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(timeouts);
 
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
 static struct attribute *tpm_dev_attrs[] = {
 	&dev_attr_pubek.attr,
 	&dev_attr_pcrs.attr,
@@ -323,17 +336,29 @@ static struct attribute *tpm_dev_attrs[] = {
 	NULL,
 };
 
+static struct attribute *tpm2_dev_attrs[] = {
+	&dev_attr_null_name.attr,
+	NULL,
+};
+
 static const struct attribute_group tpm_dev_group = {
 	.attrs = tpm_dev_attrs,
 };
 
+static const struct attribute_group tpm2_dev_group = {
+	.attrs = tpm2_dev_attrs,
+};
+
 void tpm_sysfs_add_device(struct tpm_chip *chip)
 {
 	/* XXX: If you wish to remove this restriction, you must first update
 	 * tpm_sysfs to explicitly lock chip->ops.
 	 */
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+		WARN_ON(chip->groups_cnt != 0);
+		chip->groups[chip->groups_cnt++] = &tpm2_dev_group;
 		return;
+	}
 
 	/* The sysfs routines rely on an implicit tpm_try_get_ops, device_del
 	 * is called before ops is null'd and the sysfs core synchronizes this
-- 
2.16.4

