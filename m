Return-Path: <linux-integrity+bounces-5366-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F498A6C090
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 17:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A4A1692A6
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 16:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC40F22CBC4;
	Fri, 21 Mar 2025 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="B3A3UUcl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4B2AE84;
	Fri, 21 Mar 2025 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575772; cv=none; b=mcPyn/+72/J0dgpc46Og+toRnHGjOw+2/DfX/RtTAQOQbKoCpp35q3rY+OuWrE6c3FBkpmX6Vkt6qvX0s1qRRpVtp8N/zRAsYwYG9WZT3O4mtye+2VQKGU6rBXf4AJDc7GVsR6PmiHpqk18u8smxwEja+LkEg+gBDRxBpg7AtBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575772; c=relaxed/simple;
	bh=nii9VmHDsEAVisWEFrOJ25tH5S57fQqoG/+RCdSS60w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhvJwsdzBIAXoNq/gH3dJ28ilJi6A9iH00jH377dzByyxGO010SWzd8yizLkOkDYJ/IfSBDkJ2BsoCBZuLFvtKGx6h1LILQxchvu+l9ByafPx3tdO8ORSz/K3B/B6RLxYi1UL1DHuW8we9kJEsfbddVa2cYI5TbKUaS1lnTy0qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=B3A3UUcl; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tMR6h6WbX3gykTG6+F+ZNl0W3PO7iv0LEpOU8ndGoqY=; b=B3A3UUclkONidBQGy8SmraYKej
	qYcZxBnGqEPWN2v2R7ciiksydGj78rh+Xt8NlF7KwXZNcfoBekzeWOcdAPJJzU8R//ZMOiELBbJ7u
	MjonnF8VGzYD+uuPwNUb3+qkHfyyY8AGgFjqx4DKJNVZft/b+Q6ciNz7nw7jpHi70ghPKqn47coML
	KVoaEoYvmJsRRHdeO4wbWywiNC+3jv6uxSkpzMvc1J07uOInYRNUJd9siGsujs/Yh4UBrXUNOoEkC
	yh5TZuJvub3hWNGw+cGkTzhflDVENemuYZVJx5IpREaaQ2WvG77Mml5z2Batza9OOuTiOFoKQ2dIy
	3XNOohaw==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1tvfYZ-00CUnZ-23;
	Fri, 21 Mar 2025 16:49:15 +0000
Date: Fri, 21 Mar 2025 16:49:15 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm, tpm_tis: Workaround failed command reception on
 Infineon devices
Message-ID: <Z92YiwubEvzsm1SO@earth.li>
References: <Z8lkSKOqBgt78pU2@earth.li>
 <Z8ogT_gERUYstPbK@kernel.org>
 <Z8sgfMmsfn894yLj@earth.li>
 <Z8sixTuKG5sxO-D1@kernel.org>
 <Z87Y69l5_GbzlLfp@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z87Y69l5_GbzlLfp@earth.li>

Jarkko, I've realised I've somehow introduced a typo in the patch below 
that means it doesn't fire correctly; I'm not sure how this happened as 
my local copy I was testing on is definitely correct. Would you like a 
one line fix up patch, or can you manually fix it up in your tree?

This hunk:

>@@ -545,9 +551,11 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
> 		if (rc >= 0)
> 			/* Data transfer done successfully */
> 			break;
>-		else if (rc != -EIO)
>+		else if (rc != EAGAIN && rc != -EIO)
> 			/* Data transfer failed, not recoverable */
> 			return rc;
>+
>+		usleep_range(priv->timeout_min, priv->timeout_max);
> 	}
> 	/* go and do it */

should be "rc != -EAGAIN" - the "-" sign has somehow been lost.

Apologies for this, let me know what's easiest for you in terms of 
resolving it.

On Mon, Mar 10, 2025 at 12:19:55PM +0000, Jonathan McDowell wrote:
>From: Jonathan McDowell <noodles@meta.com>
>
>Some Infineon devices have a issue where the status register will get
>stuck with a quick REQUEST_USE / COMMAND_READY sequence. This is not
>simply a matter of requiring a longer timeout; the work around is to
>retry the command submission. Add appropriate logic to do this in the
>send path.
>
>This is fixed in later firmware revisions, but those are not always
>available, and cannot generally be easily updated from outside a
>firmware environment.
>
>Testing has been performed with a simple repeated loop of doing a
>TPM2_CC_GET_CAPABILITY for TPM_CAP_PROP_MANUFACTURER using the Go code
>at:
>
> https://the.earth.li/~noodles/tpm-stuff/timeout-reproducer-simple.go
>
>It can take several hours to reproduce, and several million operations.
>
>Signed-off-by: Jonathan McDowell <noodles@meta.com>
>---
>v2: Rename flag to TPM_TIS_STATUS_VALID_RETRY
>
> drivers/char/tpm/tpm_tis_core.c | 17 ++++++++++++++---
> drivers/char/tpm/tpm_tis_core.h |  1 +
> include/linux/tpm.h             |  1 +
> 3 files changed, 16 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>index c969a1793184..4ab69c3e103c 100644
>--- a/drivers/char/tpm/tpm_tis_core.c
>+++ b/drivers/char/tpm/tpm_tis_core.c
>@@ -463,7 +463,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
> 		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> 					&priv->int_queue, false) < 0) {
>-			rc = -ETIME;
>+			if (test_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags))
>+				rc = -EAGAIN;
>+			else
>+				rc = -ETIME;
> 			goto out_err;
> 		}
> 		status = tpm_tis_status(chip);
>@@ -480,7 +483,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
> 	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> 				&priv->int_queue, false) < 0) {
>-		rc = -ETIME;
>+		if (test_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags))
>+			rc = -EAGAIN;
>+		else
>+			rc = -ETIME;
> 		goto out_err;
> 	}
> 	status = tpm_tis_status(chip);
>@@ -545,9 +551,11 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
> 		if (rc >= 0)
> 			/* Data transfer done successfully */
> 			break;
>-		else if (rc != -EIO)
>+		else if (rc != EAGAIN && rc != -EIO)
> 			/* Data transfer failed, not recoverable */
> 			return rc;
>+
>+		usleep_range(priv->timeout_min, priv->timeout_max);
> 	}
> 	/* go and do it */
>@@ -1143,6 +1151,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
> 		priv->timeout_max = TIS_TIMEOUT_MAX_ATML;
> 	}
>+	if (priv->manufacturer_id == TPM_VID_IFX)
>+		set_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags);
>+
> 	if (is_bsw()) {
> 		priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
> 					ILB_REMAP_SIZE);
>diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
>index 690ad8e9b731..970d02c337c7 100644
>--- a/drivers/char/tpm/tpm_tis_core.h
>+++ b/drivers/char/tpm/tpm_tis_core.h
>@@ -89,6 +89,7 @@ enum tpm_tis_flags {
> 	TPM_TIS_INVALID_STATUS		= 1,
> 	TPM_TIS_DEFAULT_CANCELLATION	= 2,
> 	TPM_TIS_IRQ_TESTED		= 3,
>+	TPM_TIS_STATUS_VALID_RETRY	= 4,
> };
> struct tpm_tis_data {
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index 20a40ade8030..6c3125300c00 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -335,6 +335,7 @@ enum tpm2_cc_attrs {
> #define TPM_VID_WINBOND  0x1050
> #define TPM_VID_STM      0x104A
> #define TPM_VID_ATML     0x1114
>+#define TPM_VID_IFX      0x15D1
> enum tpm_chip_flags {
> 	TPM_CHIP_FLAG_BOOTSTRAPPED		= BIT(0),
>-- 
>2.48.1
>
>

J.

-- 
101 things you can't have too much of : 7 - Memory.

