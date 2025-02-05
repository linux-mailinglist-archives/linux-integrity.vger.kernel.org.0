Return-Path: <linux-integrity+bounces-4730-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28FDA28FEB
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 15:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32921888A4B
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 14:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA405155A21;
	Wed,  5 Feb 2025 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="Gll3776w"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF04155756
	for <linux-integrity@vger.kernel.org>; Wed,  5 Feb 2025 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765788; cv=none; b=Mr4VpBkXy0LeTEFyoZWkOZGaCM+tl2C/Ukc4OrlbeFSuCI1Co5J90JA+yUvhQ6Km9AyedAtF5MJ9PBJ6FpAHff57/Z0Ol7RBczABjgHdrtN0AI/zre9zGawvbORd/aY/bWkW3ZpWLxaDHcyZwo9RVA0197ZqLc25ZGE8lrQEapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765788; c=relaxed/simple;
	bh=xUUMu6loJkI5y5k5Yh8UImyYwB9EmZ/JMHzvrlMOahw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQ638v8LCst0W7UznkUloRRbRCCpupGD7FQK9IHtPrW/feALAQHroSzfjNTbD9IEjXo9OzNdtRd99OIucBEwpczlPiXIY3d5wJ02dVvXNTuQcfVLif7XSwW19X9M1J1X7/GsZk9WLGCmk0a3z/HGvY+J7QclC+OhWzHu/10nNoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=Gll3776w; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=M5axN84Ckv+7SBA1684TxKD2M1FTz4Y3rlequnFRO5w=; b=Gll3776w7+q583Ap5tReWqoXwH
	hBz6QLT9XjvJHPr8xUGyoQvN2GH0WM5kr4dc/NVSyEUtHqGE0OakSxEocZV8nV22eUZNFCcs5mMA/
	gyWvhlPPVgVUY1lNtalpWdLnlFBN+91WHUMiH6gD2FnOH4CV4ZIIJq5Ttb2f1iAYJj1Uk+wFemreN
	0OZo3OilXNy4YuB7bOgScVIX5RcWbexXrn614CRSCChec6TP8szhSHX/heV7jqcCUcBiZf5ir++Bz
	jQXHGMKJYd4ARhPUvo4YPg13KpW/Jt/O5oGhMsDN8B4EpievaImuhZcMRXywCH8sVE9QxJGqEAe+A
	boC14seQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1tfgPJ-002I4o-02;
	Wed, 05 Feb 2025 14:29:37 +0000
Date: Wed, 5 Feb 2025 14:29:36 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z6N10NQY75hpX0Ed@earth.li>
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz>
 <Z5pRKcZKc3FUzP8Q@earth.li>
 <D7FSS837QLNR.5XOU66J6FBTU@kernel.org>
 <Z5yLYVBn6inIH8cG@kitsune.suse.cz>
 <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org>
 <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>
 <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
 <Z50IKdYe42_n2B0b@kitsune.suse.cz>
 <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>

On Wed, Feb 05, 2025 at 02:26:05PM +0100, Michal Suchánek wrote:
> On Fri, Jan 31, 2025 at 09:31:30PM +0200, Jarkko Sakkinen wrote:
> > On Fri Jan 31, 2025 at 7:28 PM EET, Michal Suchánek wrote:
> > > On Fri, Jan 31, 2025 at 07:12:06PM +0200, Jarkko Sakkinen wrote:
> > > > On Fri Jan 31, 2025 at 3:02 PM EET, Michal Suchánek wrote:
> > > > > It looks like the timeout_b is used exclusively as the ready timeout *),
> > > > > with various sources of the value depending on chip type.
> > > > >
> > > > > Then increasing it should not cause any problem other than the kernel
> > > > > waiting longer when the TPM chip is really stuck.
> > > > >
> > > > > * There is one instance of use of timeout_b for TPM_STS_VALID in
> > > > > st33zp24_pm_resume.
> > > > 
> > > > Possible for you to give a shot for patch and try it out for a while?
> > > > I'm fine with 2x, or even 4x in this case.
> > >
> > > I will see what I can do. It will definitely take a while.
> > >
> > > How would you like to multiply it?
> > >
> > > At the sime the timeout_b is assigned, or at the time it's used?
> > >
> > > Any specific patch that you have in mind?
> > 
> > I'll think about this a bit and send a patch with RFC tag. Might take
> > to late next week.
> 
> The ready timeout is not the only one exceeded:
> 
> > Jan 29 19:01:55 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Timed out (2232 of 2000 ms)
> > Jan 29 19:01:55 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Took (2232 of 2000 ms)
> > Jan 30 09:08:20 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Timed out (2228 of 2000 ms)
> > Jan 30 09:08:20 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Took (2228 of 2000 ms)
> > Jan 30 14:26:16 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (540 of 200 ms)
> > Jan 30 14:26:16 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (540 of 200 ms)
> > Jan 30 23:25:13 localhost kernel: tpm tpm0: tpm_tis_send_data: 354: stat: Timed out (2224 of 200 ms)
> > Jan 30 23:25:13 localhost kernel: tpm tpm0: tpm_tis_send_data: 354: stat: Took (2224 of 200 ms)
> > Feb 01 05:25:33 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Timed out (2228 of 2000 ms)
> > Feb 01 05:25:33 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Took (2228 of 2000 ms)
> > Feb 01 07:02:53 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (556 of 200 ms)
> > Feb 01 07:02:53 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (556 of 200 ms)
> > Feb 01 09:26:22 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (540 of 200 ms)
> > Feb 01 09:26:22 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (540 of 200 ms)
> > Feb 02 02:45:35 localhost kernel: tpm tpm0: tpm_tis_send_data: 379: stat: Timed out (272 of 200 ms)
> > Feb 02 02:45:35 localhost kernel: tpm tpm0: tpm_tis_send_data: 379: stat: Took (272 of 200 ms)
> > Feb 02 03:40:04 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (536 of 200 ms)
> > Feb 02 03:40:04 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (536 of 200 ms)
> > Feb 02 04:09:50 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Timed out (2236 of 2000 ms)
> > Feb 02 04:09:50 localhost kernel: tpm tpm0: tpm_tis_send_data: 357: ready: Took (2236 of 2000 ms)
> > Feb 02 09:57:41 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (540 of 200 ms)
> > Feb 02 09:57:41 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (540 of 200 ms)
> > Feb 02 10:59:00 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Timed out (536 of 200 ms)
> > Feb 02 10:59:00 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: stat: Took (536 of 200 ms)
> > Feb 03 03:58:09 localhost kernel: tpm tpm0: tpm_tis_send_data: 354: stat: Timed out (540 of 200 ms)
> > Feb 03 03:58:09 localhost kernel: tpm tpm0: tpm_tis_send_data: 354: stat: Took (540 of 200 ms)
> 
> While the ready timeout is quite consistently exceeded by around 230ms
> so far the stat timeout a few lines lower is less consistent.

Interesting. TPM2_CC_CONTEXT_LOAD (353) / TPM2_CC_FLUSH_CONTEXT (357) /
TPM2_CC_CONTEXT_SAVE (354) I kinda expect to maybe take a bit longer,
but TPM2_CC_GET_RANDOM (379) is a little surprising.

> Failure is observed with another chip type as well:
> 
> localhost kernel: tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id
> 22)
> 
> TPM Device
>         Vendor ID: IFX
>         Specification Version: 2.0
>         Firmware Revision: 7.83
>         Description: TPM 2.0, ManufacturerID: IFX , Firmware Version: 7.83.3358.0
>         Characteristics:
>                 Family configurable via firmware update
>                 Family configurable via OEM proprietary mechanism
>         OEM-specific Information: 0x00000000

That looks like an SLB9670, not running the latest firmware (7.85). I
think that might have the errata I've been trying to work around; my
current patch in testing (with logging to see how effective it is):

commit d8c680ec34e7f42f731e7d64605a670fb7b3b4d1
Author: Jonathan McDowell <noodles@meta.com>
Date:   Mon Aug 19 09:22:46 2024 -0700

    tpm: Workaround failed command reception on Infineon devices
    
    Some Infineon devices have a issue where the status register will get
    stuck with a quick REQUEST_USE / COMMAND_READY sequence. The work around
    is to retry the command submission. Add appropriate logic to do this in
    the send path.
    
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index fdef214b9f6b..561d6801e299 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -464,7 +464,12 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 
 		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
 					&priv->int_queue, false) < 0) {
-			rc = -ETIME;
+			if (test_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags)) {
+				dev_err(&chip->dev, "Timed out waiting for status valid in send, retrying\n");
+				rc = -EAGAIN;
+			} else {
+				rc = -ETIME;
+			}
 			goto out_err;
 		}
 		status = tpm_tis_status(chip);
@@ -481,7 +486,13 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 
 	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
 				&priv->int_queue, false) < 0) {
-		rc = -ETIME;
+
+		if (test_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags)) {
+			dev_err(&chip->dev, "Timed out waiting for status after send, retrying\n");
+			rc = -EAGAIN;
+		} else {
+			rc = -ETIME;
+		}
 		goto out_err;
 	}
 	status = tpm_tis_status(chip);
@@ -546,10 +557,13 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 		if (rc >= 0)
 			/* Data transfer done successfully */
 			break;
-		else if (rc != -EIO)
+		else if (rc != -EAGAIN && rc != -EIO)
 			/* Data transfer failed, not recoverable */
 			return rc;
 	}
+	if (try)
+		dev_info(&chip->dev,
+			"Took %d attempts to send command\n", try + 1);
 
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
@@ -563,6 +577,8 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 		if (wait_for_tpm_stat
 		    (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, dur,
 		     &priv->read_queue, false) < 0) {
+			dev_err(&chip->dev,
+				"Timed out waiting for command to complete after send\n");
 			rc = -ETIME;
 			goto out_err;
 		}
@@ -1144,6 +1160,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		priv->timeout_max = TIS_TIMEOUT_MAX_ATML;
 	}
 
+	if (priv->manufacturer_id == TPM_VID_IFX)
+		set_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags);
+
 	if (is_bsw()) {
 		priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
 					ILB_REMAP_SIZE);
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 690ad8e9b731..ce97b58dc005 100644
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
index 20a40ade8030..6c3125300c00 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -335,6 +335,7 @@ enum tpm2_cc_attrs {
 #define TPM_VID_WINBOND  0x1050
 #define TPM_VID_STM      0x104A
 #define TPM_VID_ATML     0x1114
+#define TPM_VID_IFX      0x15D1
 
 enum tpm_chip_flags {
 	TPM_CHIP_FLAG_BOOTSTRAPPED		= BIT(0),


-- 
Web [  "A true friend knows who you are...but likes you anyway."   ]
site: https:// [                                          ]      Made by
www.earth.li/~noodles/  [                      ]         HuggieTag 0.0.24

