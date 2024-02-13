Return-Path: <linux-integrity+bounces-1182-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85FD853735
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 18:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7D71C2408E
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CD55FEF1;
	Tue, 13 Feb 2024 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tS94CNPs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D835FBB5;
	Tue, 13 Feb 2024 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844975; cv=none; b=YIsMFYv7666gn3AupJ2yUmwyThoxfL42TibiTNmFphhEDIuJpVG1xgI7uOM5LswxjvhKoSYk3Wvcp5YNdm4YRJ1fhZ9pS5neIqXaIGIBONk/PrCYOBg8hnCpDlQJbCCRzSuZF7lknvLyCKrc7F4dNXDnqqZkyJ4nkGg06tIvQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844975; c=relaxed/simple;
	bh=JTFrQQ5rppx6jOZ9mbxK6nJZ7H2uf97pjMOLtahQVEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=goBWDCpdIFm8cdIEpdrgOpnyykobIN09+iW7Es6+CtlJRfreoej67qpejGcmppAb7eSEmr7qLCfaqYYdqZdclrNtHZ7EGlZQmspA8vyo5EPmiQvn0Oa3OSr1Bu6IRkzBj/nWz2WnVL+1XeFsyUQvJbtbnkJ84wNvDT1WyvupflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=tS94CNPs; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707844973;
	bh=JTFrQQ5rppx6jOZ9mbxK6nJZ7H2uf97pjMOLtahQVEU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=tS94CNPsTOtDWcVuE8idMxjQZnosqVgqHrPvLu2VIhdoKKiBT+ujERUpWKfSy1Ixk
	 VlI13t6S8e9NPNkn1XkLGzdi3U2BXe+JYbQHuc6eBherE/ruF9UUu2KbhgamVoNLDc
	 cIhEZNuSbkYTHNW2kwBCZGTeAlXVpPvzwAYAF5ds=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 78F59128120F;
	Tue, 13 Feb 2024 12:22:53 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id DM-7UoVr_v4m; Tue, 13 Feb 2024 12:22:53 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E29AF1280E33;
	Tue, 13 Feb 2024 12:22:52 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v7 19/21] tpm: add the null key name as a sysfs export
Date: Tue, 13 Feb 2024 12:13:32 -0500
Message-Id: <20240213171334.30479-20-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

---
v6: change config name
v7: add review
---
 drivers/char/tpm/tpm-sysfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 54c71473aa29..94231f052ea7 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -309,6 +309,21 @@ static ssize_t tpm_version_major_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(tpm_version_major);
 
+#ifdef CONFIG_TCG_TPM2_HMAC
+static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+	int size = TPM2_NAME_SIZE;
+
+	bin2hex(buf, chip->null_key_name, size);
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
+#ifdef CONFIG_TCG_TPM2_HMAC
+	&dev_attr_null_name.attr,
+#endif
 	NULL
 };
 
-- 
2.35.3


