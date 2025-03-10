Return-Path: <linux-integrity+bounces-5203-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD34A5941F
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 13:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D2F3A54A5
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 12:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F35225785;
	Mon, 10 Mar 2025 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="l8Sa+wt4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8E158D94;
	Mon, 10 Mar 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609335; cv=none; b=AqZxKW5hsfync/Yq62PKhXslnoJgcAqAyOf5EcTJUwviOQMxgldssMDygE9/Bu9leqDatAb23yQpvMJ1a4Ii8jbhv9yEG/p0T/NHdPHqeusT8DvtzF7c2DYe+I58Zg9YbaG6icfoyTed/f1GRreWmKi0VssHuJYUWFvcJK8l2tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609335; c=relaxed/simple;
	bh=1SZ5xOL/5pcHtlEBTYpzG26p4xb7Unyj++Kx995nIZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9L2XP6CHtwzWr9/jcQS8sA/05slf0L7VhM7gl8VBcEJsCAw4iGxOar4E46IjjUGg+zI5frXpYph66bocjvXm2A3mPEgjc+wwC8o/sQ3obSoO5ylO16C7Iuo4ha67mZ1AvXo5UvV7s+2qpSMzTq/oHqFPgQGmQ0g8hfOQgmfv9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=l8Sa+wt4; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=A5+NM3ovOfZLZdp1C2veCkBZJ2FQu8Fe/Fr8GA13dzw=; b=l8Sa+wt4m2k9KAQSeOCg3yVoD7
	aNVQmWbm2dolaZytiLbVu2RIQZ383zLayw2FO0GFaK2Dvyi/bbJoQmMXBenNF9IyNgebijFwiaASu
	TZtFHURdYDKE7EFS9C7x8LPfABhQhLo8DEBCB1ecx3H0Pfw7e4KiKpGGBly2QCtep3buFkLgywd87
	BPoRPkREMZ+aN3wQKv1ljxdp7juRIedShkC4z96JzJ2nYsMBmixHR0VKPmYjIM5Rcp9GR5vtJrSRQ
	8h9wUsj7FMMQqHuBeAyZpamlJpxzF8NFBzyAaDXxO2Il8WyGGymjfZNFWmDVWQ2XUfMmgM8pwSq6c
	IFhvfbuQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1trc92-00GV4S-18;
	Mon, 10 Mar 2025 12:22:08 +0000
Date: Mon, 10 Mar 2025 12:22:08 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm, tpm_tis: Fix timeout handling when waiting for TPM
 status
Message-ID: <Z87ZcPZvoUXZ7M_f@earth.li>
References: <Z8gdKxsw2unC5UID@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8gdKxsw2unC5UID@earth.li>

The change to only use interrupts to handle supported status changes
introduced an issue when it is necessary to poll for the status. Rather
than checking for the status after sleeping the code now sleeps after
the check. This means a correct, but slower, status change on the part
of the TPM can be missed, resulting in a spurious timeout error,
especially on a more loaded system. Switch back to sleeping *then*
checking. An up front check of the status has been done at the start of
the function, so this does not cause an additional delay when the status
is already what we're looking for.

Cc: stable@vger.kernel.org # v6.4+
Fixes: e87fcf0dc2b4 ("tpm, tpm_tis: Only handle supported interrupts")
Signed-off-by: Jonathan McDowell <noodles@meta.com>
Reviewed-by: Michal Suchánek <msuchanek@suse.de>
Reviewed-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
---
v2: Reword commit message
     Don't needlessly wrap line

  drivers/char/tpm/tpm_tis_core.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index fdef214b9f6b..c969a1793184 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -114,11 +114,10 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
  		return 0;
  	/* process status changes without irq support */
  	do {
+		usleep_range(priv->timeout_min, priv->timeout_max);
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


