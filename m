Return-Path: <linux-integrity+bounces-5108-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA0EA4FB27
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 11:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C582165BB9
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 10:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACF1205501;
	Wed,  5 Mar 2025 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="moFFaNTZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D051C8612;
	Wed,  5 Mar 2025 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169119; cv=none; b=FKfMktuMCqMUy4RbgItAy1CIItAMr10q8QOo0uhfTNFCNn6D/cuWPoIaPjWJ/I1GOwTVs4pAIqe+jWO7TKabdey9l3K4NPL8Nqm8s+Toexu45aT+eyl1i8egR04BlwSnASn+n045xgcMUQnkD119IvPOXo5L/CSZHfvkd1Lzn5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169119; c=relaxed/simple;
	bh=Q+UcLBGbaunhRK9+TGvci4Rf/Tm3PJ1T8ztM7cMxtkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ejWb47d94XqlTzKSWyqW6Vj6HZ1d3Rh1PHRUgysHBonGmV8P+Q/egY4k8uXQuqfwmLkwih3Pnym8oUvgE3014QMjAM4F8aUKcYl8N6YLQcPkuH2b0l+fIqcHg8B5b+Qu+5t4TjrQi1p3e+6Pjl2RsLTEKsO8Ups0+lkkgjmYAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=moFFaNTZ; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9zRxtVYKtcy4a7k9RzqyNji6yQAZKeaZJwhRvL0/Bm4=; b=moFFaNTZwRmnRwOJdJOorSVwFq
	vINEORDiAWAOXxD9sbqvNjTfmDP4fSLE7bmcpV8S9CUHYX9iaEkgH7lhdGTrKI7Bilii8tz2uwiqx
	yTjL0PfDoeHvfYO/YuogwaxR/GU9ZUQw5l0q+M+Xx9d6k45H3d3B9gF3EokK4lPd04V08hBDM/k25
	f94v2BnT/Q1cmMXZuaMFBD7wH66CU6Ypvp5MFG3VTXqy7Nb5JQWn5JBW2Jiz5qKpNi15VqDXbuF27
	8dQqdnvhYdStjCTZZ1AJI9vxMyu2DvRp4wiKSXl/yx7TrAPN70QB1iiow81JC1jwcxFP38v/lvEgn
	du7lUSPQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1tplJT-00AWMV-1C;
	Wed, 05 Mar 2025 09:45:15 +0000
Date: Wed, 5 Mar 2025 09:45:15 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm, tpm_tis: Fix timeout handling when waiting for TPM
 status
Message-ID: <Z8gdKxsw2unC5UID@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

From: Jonathan McDowell <noodles@meta.com>

The change to only use interrupts to handle supported status changes,
then switch to polling for the rest, inverted the status test and sleep
such that we can end up sleeping beyond our timeout and not actually
checking the status. This can result in spurious TPM timeouts,
especially on a more loaded system. Fix by switching the order back so
we sleep *then* check. We've done a up front check when we enter the
function so this won't cause an additional delay when the status is
already what we're looking for.

Cc: stable@vger.kernel.org # v6.4+
Fixes: e87fcf0dc2b4 ("tpm, tpm_tis: Only handle supported interrupts")
Signed-off-by: Jonathan McDowell <noodles@meta.com>
Reviewed-by: Michal Suchánek <msuchanek@suse.de>
---
 drivers/char/tpm/tpm_tis_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index fdef214b9f6b..167d71747666 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -114,11 +114,11 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		return 0;
 	/* process status changes without irq support */
 	do {
+		usleep_range(priv->timeout_min,
+			     priv->timeout_max);
 		status = chip->ops->status(chip);
 		if ((status & mask) == mask)
 			return 0;
-		usleep_range(priv->timeout_min,
-			     priv->timeout_max);
 	} while (time_before(jiffies, stop));
 	return -ETIME;
 }
-- 
2.48.1


