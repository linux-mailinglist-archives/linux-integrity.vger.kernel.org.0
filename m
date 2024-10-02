Return-Path: <linux-integrity+bounces-3725-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D50A298E174
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2024 19:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6121F22D4E
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2024 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92FD1D0F6F;
	Wed,  2 Oct 2024 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="g9NS95SE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339116419;
	Wed,  2 Oct 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888656; cv=none; b=sLpOBYCRj68m6vxsff2fjm9nFCMUbitjmPyT+0HYeKsdvYFBTPl4Syv6q3GSvdkZL8l5uIcq97pDvmocuj4mW06J2A1CAGrUpmmAme90bSfAQoYdt1WAKLoy6L9UdTaPajDIClN867P3TQc+G0DtbkVvLUjSJInGGYxpmMERe+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888656; c=relaxed/simple;
	bh=dtA6ihJ6ZDTS8cZbEjeZKcVTbNIuYWa+Z1KN/pjSWzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kX2DwyW9/xtyy5u4OPAM0sHinncj/uB5BxO6Pj9bSehtSN/B7s7pxR2p4pbJyfiOYEMXgmq5/gCtlK36zuHCRbQgwIwrMefs/p4NKtroWB4Uk1MbmLeA6ArnvegydnMUASjq2ppQPid/nzK3Wp2/p8ZkFCNaj20EJBWiJomXXQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=g9NS95SE; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fHU6ZUnI2iqI/oyQsEj+rzsK7fSeyFKuMIL8oz3W1Lk=; b=g9NS95SEtYOxgRO/fKFwucaLHJ
	hnjbv6RbVFEhZpPX38DHNsjz8ppAAb0KehR18wZ5bxbuvgYbFz4PBx7PpnhocMyuULDZqJpiLvJax
	jiJVyT40M1ebyhbE+RqqodNlimvD1axZTVVVz9/pTy0PoQuTLczRDhS72WI4Gxg9juEFyw4kmuhbV
	SyjFmCZs09ZCLF7/Lr0OeNuH9PNy1LLZJVR0tZoLYkCTMqNOlPLfUIFtoeG6h00MuqAb//vqNfCP8
	jaCAe8yx11942QNaqgGG9Q6M+5/CV2P4yXp81zA6vnIcbLfRbL0kFpXkO0kCj6nDoa8ZzSmashMSH
	aYZH0nRA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1sw2ll-00DFjK-2y;
	Wed, 02 Oct 2024 18:04:09 +0100
Date: Wed, 2 Oct 2024 18:04:09 +0100
From: Jonathan McDowell <noodles@earth.li>
To: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] tpm: Workaround failed command reception on Infineon
 devices
Message-ID: <Zv19Cc-oTOzv8wVO@earth.li>
References: <Zv1810ZfEBEhybmg@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv1810ZfEBEhybmg@earth.li>

(I'm still in the process of testing this to confirm it fixes the
errata I've seen, but I wanted to send it out for comments to make sure
it's a reasonable approach.)

Some Infineon devices have a issue where the status register will get
stuck with a quick REQUEST_USE / COMMAND_READY sequence. The work around
is to retry the command submission. Add appropriate logic to do this in
the send path.

Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
 drivers/char/tpm/tpm_tis_core.c | 24 +++++++++++++++++++-----
 drivers/char/tpm/tpm_tis_core.h |  1 +
 include/linux/tpm.h             |  1 +
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index f6aa0dfadb93..940abd1a868e 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -432,16 +432,27 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-	int rc, status, burstcnt;
+	int rc, status, burstcnt, retry;
+	bool status_fix = test_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags);
 	size_t count = 0;
 	bool itpm = test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
 
 	status = tpm_tis_status(chip);
 	if ((status & TPM_STS_COMMAND_READY) == 0) {
-		tpm_tis_ready(chip);
-		if (wait_for_tpm_stat
-		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
-		     &priv->int_queue, false) < 0) {
+		retry = status_fix ? 3 : 1;
+
+		while (retry > 0) {
+			tpm_tis_ready(chip);
+			if (wait_for_tpm_stat
+			    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
+			     &priv->int_queue, false) >= 0) {
+				break;
+			}
+
+			retry--;
+		}
+
+		if (retry == 0) {
 			rc = -ETIME;
 			goto out_err;
 		}
@@ -1147,6 +1158,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		priv->timeout_max = TIS_TIMEOUT_MAX_ATML;
 	}
 
+	if (priv->manufacturer_id == TPM_VID_IFX)
+		set_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags);
+
 	if (is_bsw()) {
 		priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
 					ILB_REMAP_SIZE);
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 13e99cf65efe..f888da57535d 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -89,6 +89,7 @@ enum tpm_tis_flags {
 	TPM_TIS_INVALID_STATUS		= 1,
 	TPM_TIS_DEFAULT_CANCELLATION	= 2,
 	TPM_TIS_IRQ_TESTED		= 3,
+	TPM_TIS_STATUS_WORKAROUND	= 4,
 };
 
 struct tpm_tis_data {
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4ee9d13749ad..5f4998626a98 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -272,6 +272,7 @@ enum tpm2_cc_attrs {
 #define TPM_VID_WINBOND  0x1050
 #define TPM_VID_STM      0x104A
 #define TPM_VID_ATML     0x1114
+#define TPM_VID_IFX      0x15D1
 
 enum tpm_chip_flags {
 	TPM_CHIP_FLAG_BOOTSTRAPPED		= BIT(0),
-- 
2.39.5


