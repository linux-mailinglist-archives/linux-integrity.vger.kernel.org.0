Return-Path: <linux-integrity+bounces-903-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E6283FA20
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Jan 2024 22:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C086128223B
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Jan 2024 21:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF263CF61;
	Sun, 28 Jan 2024 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OUnIzzVO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8D3C463
	for <linux-integrity@vger.kernel.org>; Sun, 28 Jan 2024 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706477246; cv=none; b=tLuRY/6VCvbAF+e3bSRTuJflhU5eKGdmfRkUjKEyeVzqIKhhhhpOFk19TRFh5eNb/8qPBalZEuoBnLXtx15a7XE8qMqIiB2EVqCxueqsyDcgWX1iTSu3//FwFOUzMMRMGGvxLLoUlQnwohFi1c+1jHBg3LXiTCxQkQtUWsduRcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706477246; c=relaxed/simple;
	bh=uCMir8UpOW/6Sz8HK3q/nTaZiN/nTURZjTlJjYqsDCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ng9eI1Zc0q4ZrW+k3C1eZ4qY1c+oE7cxzJhB2gG+/BcW+ZXp294vQANWGA4l6KSNcWIVkyz1qo7hOs9FzafPrj9c2p1jOC5ApJTveoPXc31/Xm2bKa74RC8ssozXGBcaqQav9sN2y2mceXUdUeespqwB/uubMJ9fYDhd7qNAFHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OUnIzzVO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso31033355e9.2
        for <linux-integrity@vger.kernel.org>; Sun, 28 Jan 2024 13:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706477243; x=1707082043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4CfMrpXU7mLg0Nr9hLBE9YLoMVHIJD5HpnMqiflm7A=;
        b=OUnIzzVOI4WcFVpRkm+qcb5JA/iLyEygneEyCn6PaF81yIZWw6kcTc7moA3JijrQV3
         hDsRK2nNp2zmb6YigLTT+rmj0f0Wz2WMSok2koMpSdwP7/+ULRI6eEyF6Ha5f427QKu6
         pnuYYPpmqm/VgOR87EIOyRJ7+NdtVXQmSgtslrZicrKKHNzw3XlocECogDqaZgquna5i
         RZJx/6UUC8sIJay/uaDFVJ8ZSIoO4lBaRmy2VZEYxm99+pxyhF7SJFNLbImJu1+p09+5
         DnReHNWkYeHCKdzl/MMh+sOiaz4sj72inTKFxmPbQmCNzWTysgSax2qMBstGl3DxD/aW
         V/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706477243; x=1707082043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4CfMrpXU7mLg0Nr9hLBE9YLoMVHIJD5HpnMqiflm7A=;
        b=aDkIGNJaE/tpqX9sFOelrYFhRh83ML8ENwFIkYHNu+RH82pj2vzzm0qHMbWBjUvZkF
         pHbu6199OAJ1KoZdrvBkbfDZ9tgBeattP3WmLtj2wZ6CPaZ23ik1t3BK+WmtSqvz0CFX
         6yeizx+B6JTVtzwnnHWAWXQ1RgLmSSA69g4h7EaOh0aB/z50V6QGakLWeT45kyTdaxUy
         Kpd/GaCZiqRpw8+DogBVqeuroZ/5TKSAjmc1dzohMDBuV0eRcOwSdXDMFBmo+EDx9Pot
         XbvBNowsz4hmJnmferFTDG+k2ZADUVQI15LExBsP/X9Z9K1yRd9d26wxXQUJnTP2NtyO
         FzeA==
X-Gm-Message-State: AOJu0YzAy2AMpoes2RCHxSyNc1Qk9u4qL8h7MpPrSLKL3aIkep3vsBEb
	hOsM1Nvm43Yxrab0Y+nITUf22PLs4FoxdEIkhtTz9WrIHWm0VjUj1vNFx8auX9g=
X-Google-Smtp-Source: AGHT+IFlkGrr3ppdEspRfcA7a89/Y0U2wI5XLbr2d3eVOIRo3fHhwMqy9985919yLYtc6tJ7AGn4WA==
X-Received: by 2002:a05:600c:310d:b0:40e:ce97:445c with SMTP id g13-20020a05600c310d00b0040ece97445cmr3978490wmo.13.1706477242886;
        Sun, 28 Jan 2024 13:27:22 -0800 (PST)
Received: from vermeer.ba.rivosinc.com (lfbn-mon-1-1176-165.w90-113.abo.wanadoo.fr. [90.113.119.165])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b0040d62f89381sm8218208wmo.35.2024.01.28.13.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 13:27:22 -0800 (PST)
From: Samuel Ortiz <sameo@rivosinc.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Qinkun Bao <qinkun@google.com>,
	"Yao, Jiewen" <jiewen.yao@intel.com>,
	"Xing, Cedric" <cedric.xing@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	biao.lu@intel.com,
	linux-coco@lists.linux.dev,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/4] tsm: Map RTMRs to TCG TPM PCRs
Date: Sun, 28 Jan 2024 22:25:22 +0100
Message-ID: <20240128212532.2754325-4-sameo@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240128212532.2754325-1-sameo@rivosinc.com>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many user space and internal kernel subsystems (e.g. the Linux IMA)
expect a Root of Trust for Storage (RTS) that allows for extending
and reading measurement registers that are compatible with the TCG TPM
PCRs layout, e.g. a TPM. In order to allow those components to
alternatively use a platform TSM as their RTS, a TVM could map the
available RTMRs to one or more TCG TPM PCRs. Once configured, those PCR
to RTMR mappings give the kernel TSM layer all the necessary information
to be a RTS for e.g. the Linux IMA or any other components that expects
a TCG compliant TPM PCRs layout.

TPM PCR mappings are statically configured through the TSM provider
capabilities. A TSM backend defines its number of RTMRs, and for each
one of them can define a bitmask of TCG TPM PCR it maps to. As they are
TSM backend specific, those mappings are to some extend architecture
specific. Each architecture is free to decide and choose how it builds
it, e.g. by requesting an EFI firmware when it supports the EFI_CC
protocol.

The tsm-configfs rtmrs/<rtmrN>tcg_map describes these static mappings.

Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
---
 Documentation/ABI/testing/configfs-tsm | 14 +++++
 drivers/virt/coco/tsm.c                | 74 ++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
index 590e103a9bcd..5d20a872475e 100644
--- a/Documentation/ABI/testing/configfs-tsm
+++ b/Documentation/ABI/testing/configfs-tsm
@@ -91,3 +91,17 @@ Description:
                 can be mapped to a hardware RTMR by writing into its index
                 attribute. The TSM provider will then map the configfs entry to
                 its corresponding hardware register.
+
+What:		/sys/kernel/config/tsm/rtmrs/$name/tcg_map
+Date:		January, 2024
+KernelVersion:	v6.8
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RO) A representation of the architecturally defined mapping
+		between this RTMR and one or more TCG TPM PCRs [1]. When using
+		a TSM as Root of Trust for Storage (RTS), TCG TPM PCRs
+		associated semantics and indexes can be used when RTMRs are
+		logically mapped to TPM PCRs.
+
+		[1]: TCG PC Client Specific Platform Firmware Profile Specification
+		https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index bb9ed2d2accc..d03cf5173bc9 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -419,6 +419,46 @@ static const struct config_item_type tsm_reports_type = {
 	.ct_group_ops = &tsm_report_group_ops,
 };
 
+static int tsm_rtmr_build_tcg_map(const struct tsm_provider *tsm,
+				const struct tsm_rtmr_state *rtmr_state,
+				u32 rtmr_idx)
+{
+	const struct tsm_ops *ops;
+	unsigned long pcr_mask;
+	int i;
+
+	lockdep_assert_held_write(&tsm_rwsem);
+
+	ops = tsm->ops;
+	if (!ops)
+		return -ENOTTY;
+
+	if (!ops->capabilities.rtmrs)
+		return -ENXIO;
+
+	pcr_mask = ops->capabilities.rtmrs[rtmr_idx].tcg_pcr_mask;
+
+	/* Check that the PCR mask is valid  */
+	for (i = 0; i < TPM2_PLATFORM_PCR; i++) {
+		if (!(pcr_mask & BIT(i)))
+			continue;
+
+		/* If another RTMR maps to this PCR, the mask is discarded */
+		if (tsm_rtmrs->tcg_map[i] &&
+			tsm_rtmrs->tcg_map[i] != rtmr_state)
+			return -EBUSY;
+	}
+
+	for (i = 0; i < TPM2_PLATFORM_PCR; i++) {
+		if (!(pcr_mask & BIT(i)))
+			continue;
+
+		tsm_rtmrs->tcg_map[i] = rtmr_state;
+	}
+
+	return 0;
+}
+
 static ssize_t tsm_rtmr_index_store(struct config_item *cfg,
 				    const char *buf, size_t len)
 {
@@ -449,6 +489,10 @@ static ssize_t tsm_rtmr_index_store(struct config_item *cfg,
 	if (tsm_rtmrs->rtmrs[val])
 		return -EINVAL;
 
+	rc = tsm_rtmr_build_tcg_map(&provider, rtmr_state, val);
+	if (rc)
+		return rc;
+
 	rtmr_state->index = val;
 	rtmr_state->alg = ops->capabilities.rtmrs[val].hash_alg;
 
@@ -472,8 +516,38 @@ static ssize_t tsm_rtmr_index_show(struct config_item *cfg,
 }
 CONFIGFS_ATTR(tsm_rtmr_, index);
 
+static ssize_t tsm_rtmr_tcg_map_show(struct config_item *cfg,
+				     char *buf)
+{
+	struct tsm_rtmr_state *rtmr_state = to_tsm_rtmr_state(cfg);
+	unsigned int nr_pcrs = ARRAY_SIZE(tsm_rtmrs->tcg_map), i;
+	unsigned long *pcr_mask;
+	ssize_t len;
+
+	/* Build a bitmap mask of all PCRs that this RTMR covers */
+	pcr_mask = bitmap_zalloc(nr_pcrs, GFP_KERNEL);
+	if (!pcr_mask)
+		return -ENOMEM;
+
+	guard(rwsem_read)(&tsm_rwsem);
+	for (i = 0; i < nr_pcrs; i++) {
+		if (tsm_rtmrs->tcg_map[i] != rtmr_state)
+			continue;
+
+		__set_bit(i, pcr_mask);
+	}
+
+	len = bitmap_print_list_to_buf(buf, pcr_mask, nr_pcrs, 0,
+				       nr_pcrs * 3 /* 2 ASCII digits and one comma */);
+	bitmap_free(pcr_mask);
+
+	return len;
+}
+CONFIGFS_ATTR_RO(tsm_rtmr_, tcg_map);
+
 static struct configfs_attribute *tsm_rtmr_attrs[] = {
 	&tsm_rtmr_attr_index,
+	&tsm_rtmr_attr_tcg_map,
 	NULL,
 };
 
-- 
2.42.0


