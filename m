Return-Path: <linux-integrity+bounces-9686-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BsJM+UrFmqdigcAu9opvQ
	(envelope-from <linux-integrity+bounces-9686-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 01:25:25 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A585DD87F
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 01:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB7AB30578CF
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 23:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236A33CF68C;
	Tue, 26 May 2026 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaxGosj7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585D23CF045
	for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 23:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779837820; cv=none; b=u5VaNqGtHhDMniFEuNc9CnH7Y/0sYnst2GPWibmqf0nQG1ZE6aCYgB3OfKddH8zm/iWdtZbXmyW2JkutRgDOO6hkskk9kIFN5CVUm++WcaE3vrTJngOisb9rO04X0QrTQUeaTVRwQX+gaVRjnrk6wsIPhBE4ySPkH6McUTvMWYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779837820; c=relaxed/simple;
	bh=BEyPeMDl5nAXSzWv4091vlic9CMAd3/SfmxGqNG9MPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qo1R6cXN2qhkCyLZ/dVm8vFzutb4q2+3NGH3ea0THFuZBTjvzJmclMqocssjg6Nd4/j38vHU7FrnxWtSqT9kNK0GBhUT+hFdnpZMtdqGaHhy6t7w19lYbuwO9fanka4mgF97CBVQYBZHQDdNCAzO+HdOVAaOZ3yc/5FV6q2d0FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaxGosj7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso126047145ad.0
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 16:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779837817; x=1780442617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxHtjdRc2OkY6aJQKSQqj47m3Loeixs8cm6oSLIwFEU=;
        b=LaxGosj7EA4uKSsfOx+iF3x1ePE2n0l0uBhfU4UCSQuKZqx/q6botLWUtZc4JwZLzy
         50zTeyV6WywfS3ZXhDlOqdfIbQdloOYk3pe7t2OInr9hlRycEgBeniu3qz6Yfo3Ira1h
         57zjIYN282Ir3amS8GUxIvLiBgDodZS0f7a4qKI3/KWb0t/MlQrPHR/g/64hrbzFHbG1
         xUDaKXtlk8uJVmQZtmlrwtkCvCs6UK+zuVxuRhyu2e4K5xumyt4myT305+kDLwb+XpoX
         UMIq4tTru5lobhV5euJ5QKzvqIDLnwDDeFaN0Qlcrkz3rwlhKsdKNOOZAV0Yo5DjRMP9
         QpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779837817; x=1780442617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rxHtjdRc2OkY6aJQKSQqj47m3Loeixs8cm6oSLIwFEU=;
        b=XLsg5Nu4804PjZhRiobebM+dc7LrWuznMGEGxB7SNcFerbRTCVtSFs90QsOqFphLfh
         Jzw7Yfs587y0E4gegZvAn1Hws9VxVko7V+q7IEFlnzvVY4/scWFqwc7ITgXjNyn9oR5O
         M83yEAPwOUP4pgf7pklF6m+dPfOj5v1Mdze9MTMzdopY8jnBINgQj6CfNVC8nd8ZphX6
         zaD+wnYyrKhil2nD0FtUL9qeeWczbyd8RhdBPX1T6OAswgdWJ/MjldAbpXYgbx6Y27CM
         BrmFHP+Zqr/lVbFVPGw9q72L8V/N5aabodIZ6oW55f2Qv7qk1JmIsgz5QC5Z6B7NS1Io
         RZzw==
X-Forwarded-Encrypted: i=1; AFNElJ/d3xJkG/SCOCDwVzhaGUr300Dfh4nTh7iiYJdboCp6LIpE1Y4cVUzF78lF+EaU3MqQzSpV52mKRBxBJF4ZZyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu5BbaHC5N9G0btTOH40mFwfb6L8UQ5EWYmyOSlELDVs0bXcqs
	nE0igQ02PRk1p/CuzVgKQm6Rcw/zcN+czzuxrLYPqsIJyGjBNp27wV+/PAXCAUa6WfY=
X-Gm-Gg: Acq92OFIU8ZCEX+usmVV6NYiitqPrWNGweyOie8HhW1m952GJReuB9yUslMW60vStgD
	9465Y+pDZzKyhpInypWS8QR4ULkz7BjgwL0V87baoTkVRZ5vuHtxNxGqjZsGqYd+PKvBs46+JIm
	ATRMpz/coCsnoBcgwoOahGndr2JC5IygGuRDdKaeRVdE9gRXCJIThY1ozXWQv+1pEPjQQHHgI+X
	XrdzbBm7pvzQ65uYcujg6yhe2jLrC58aTQp6s/8//DLUlaGhz1eI3kTBH001XFsiE0ej+6t+ues
	ZVvD7qnJldJdEDHa0d5YANaCWELDqag8MMDLaEyb16Bvb5MCB6UU/aFUZZI0//dzJymC8GbT0cB
	/3FIok4kHw7IlFxwnDKM1gOasud80h6t5um1+s8Uo196XURoOaTtSd2RkgWpcaZfy5YKPd5gfjO
	K+YSlyeJtdwBZa5k7/4bbqJkeA0SPiJoI7ohlprqWp6bmdij385e5uyAg=
X-Received: by 2002:a17:902:cf08:b0:2bd:49ce:d240 with SMTP id d9443c01a7336-2beb03909bdmr229191055ad.5.1779837816439;
        Tue, 26 May 2026 16:23:36 -0700 (PDT)
Received: from harvey.lan (c-73-83-32-130.hsd1.wa.comcast.net. [73.83.32.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5903bcasm142501045ad.77.2026.05.26.16.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 16:23:35 -0700 (PDT)
From: Jim Broadus <jbroadus@gmail.com>
To: jarkko@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: peterhuewe@gmx.de,
	jgg@ziepe.ca,
	Jim Broadus <jbroadus@gmail.com>
Subject: [PATCH v3 1/2] tpm: tpm_tis: store entire did_vid
Date: Tue, 26 May 2026 16:22:43 -0700
Message-ID: <20260526232245.5409-2-jbroadus@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526232245.5409-1-jbroadus@gmail.com>
References: <20260519154530.6386-1-jbroadus@gmail.com>
 <20260526232245.5409-1-jbroadus@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,gmail.com];
	TAGGED_FROM(0.00)[bounces-9686-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbroadus@gmail.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 31A585DD87F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The entire 32 bit did_vid is read from the device, but only the 16 bit
vendor id portion was stored in the tpm_tis_data structure. Storing the
entire value allows the device id to be used to handle quirks. Printing
the vid and did in the error case also helps identify problem devices.

Signed-off-by: Jim Broadus <jbroadus@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 22 ++++++++++++++--------
 drivers/char/tpm/tpm_tis_core.h |  2 +-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 21d79ad3b164..d0b87f5daa3e 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -792,9 +792,10 @@ static int probe_itpm(struct tpm_chip *chip)
 static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	u16 vendor_id = priv->did_vid;
 
 	if (!test_bit(TPM_TIS_DEFAULT_CANCELLATION, &priv->flags)) {
-		switch (priv->manufacturer_id) {
+		switch (vendor_id) {
 		case TPM_VID_WINBOND:
 			return ((status == TPM_STS_VALID) ||
 				(status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
@@ -1115,7 +1116,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		      const struct tpm_tis_phy_ops *phy_ops,
 		      acpi_handle acpi_dev_handle)
 {
-	u32 vendor;
+	u16 vendor_id;
+	u16 device_id;
 	u32 intfcaps;
 	u32 intmask;
 	u32 clkrun_val;
@@ -1148,19 +1150,20 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 
 	dev_set_drvdata(&chip->dev, priv);
 
-	rc = tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
+	rc = tpm_tis_read32(priv, TPM_DID_VID(0), &priv->did_vid);
 	if (rc < 0)
 		return rc;
 
-	priv->manufacturer_id = vendor;
+	vendor_id = priv->did_vid;
+	device_id = priv->did_vid >> 16;
 
-	if (priv->manufacturer_id == TPM_VID_ATML &&
+	if (vendor_id == TPM_VID_ATML &&
 		!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
 		priv->timeout_min = TIS_TIMEOUT_MIN_ATML;
 		priv->timeout_max = TIS_TIMEOUT_MAX_ATML;
 	}
 
-	if (priv->manufacturer_id == TPM_VID_IFX)
+	if (vendor_id == TPM_VID_IFX)
 		set_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags);
 
 	if (is_bsw()) {
@@ -1247,9 +1250,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (rc < 0)
 		goto out_err;
 
-	dev_info(dev, "%s TPM (device-id 0x%X, rev-id %d)\n",
+	dev_info(dev, "%s TPM (vendor-id 0x%X, device-id 0x%X, rev-id %d)\n",
 		 (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2",
-		 vendor >> 16, rid);
+		 vendor_id, device_id, rid);
 
 	probe = probe_itpm(chip);
 	if (probe < 0) {
@@ -1315,6 +1318,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 
 	return 0;
 out_err:
+	dev_err(dev, "TPM vid 0x%X, did 0x%X init failed with error %d\n",
+		vendor_id, device_id, rc);
+
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, false);
 
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 6c3aa480396b..f2c77844062a 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -94,7 +94,7 @@ enum tpm_tis_flags {
 
 struct tpm_tis_data {
 	struct tpm_chip *chip;
-	u16 manufacturer_id;
+	u32 did_vid;
 	struct mutex locality_count_mutex;
 	unsigned int locality_count;
 	int locality;
-- 
2.54.0


