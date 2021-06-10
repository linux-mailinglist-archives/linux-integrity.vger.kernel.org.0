Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B513A2B92
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 14:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFJMbJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 08:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhFJMbI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 08:31:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69049613BC;
        Thu, 10 Jun 2021 12:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623328152;
        bh=NQNebRqVIJ+EEveLxSKjiJxW1a0VmjQLVCzTrdNA3W8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dur6OsGvxwrqFq3vo0cVzHnqQxU0NtYhq2rYcgm9XWL78lwdhzZ08l10ZZNf+CNUj
         oG/yQWnQWKK3cEVM64h9+DaeKuXS7vNtZUpYpW2d23/NhyAmFmoTO4TG5AZlH19xwe
         Npou6BRlI3WrW80e+9xvu8eOqByy0vU8ErmBJ3i/cjGsFM52IxapOq0k/nJhecty7k
         p5yH0uMu/sIYaGXF9I1e2fuMTiUo8ppNfPK+38PiLUX4a7c169hHy9sBC2Ry3tKX9d
         PaqzUhGFommotfVbqSwS5UI7oa8Xuj004VTkYkx/5nsXH4tnbr+tehDh+iQbRV8GrD
         iCNAHI4USM01Q==
Date:   Thu, 10 Jun 2021 15:29:09 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Laurent Bigonville <bigon@debian.org>
Cc:     linux-integrity@vger.kernel.org, Lukasz Majczak <lma@semihalf.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH] tpm, tpm_tis: Acquire locality in
 tpm_tis_gen_interrupt() and tpm_get_timeouts()
Message-ID: <20210610122909.qaczp6nbish6wzbt@kernel.org>
References: <YCvv9wvj4jUIKpa7@kernel.org>
 <YCvyS6eVjZCKMAyJ@kernel.org>
 <YCv0KFIdtmG8F1kT@kernel.org>
 <d5fd8a6b-5eb9-0b50-d66c-e9f4cc84b215@debian.org>
 <YC2YyO7mJ7E73Voy@kernel.org>
 <ed73c137-373d-9767-25e6-309534652354@debian.org>
 <20210603052857.44zppwdfz4aror34@kernel.org>
 <07fb4429-d0cc-c471-1baa-a1a1eb2e8ae6@debian.org>
 <20210609124327.xkaf3bkcvyw2yxkn@kernel.org>
 <bfb9fdc7-668a-ff9c-1f5d-152df2ca106e@debian.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vyklwdvksnkra3qg"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfb9fdc7-668a-ff9c-1f5d-152df2ca106e@debian.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--vyklwdvksnkra3qg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jun 10, 2021 at 01:35:47PM +0200, Laurent Bigonville wrote:
> # dmesg |grep -i tpm
> 
> [   13.019986] tpm_tis 00:06: 1.2 TPM (device-id 0x6871, rev-id 1)
> [   15.016198] tpm tpm0: tpm_try_transmit: send(): error -62
> [   15.016208] tpm tpm0: A TPM error (-62) occurred attempting to determine
> the timeouts
> [   15.016239] tpm_tis: probe of 00:06 failed with error -62
> [   15.053255] tpm_inf_pnp 00:06: Found TPM with ID IFX0102

If possible, can you check what happens when you apply the attached patch.
I'm not proposing it as a bug fix but it just simplifies the flow a lot,
and might help to observe something.

/Jarkko

--vyklwdvksnkra3qg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-tpm_tis-Use-request_locality-before-calling-tpm2_pro.patch"

From 0b0dfc48b47e44d547282b20f6d8c97103fadbe6 Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Thu, 10 Jun 2021 15:24:49 +0300
Subject: [PATCH] tpm_tis: Use request_locality() before calling tpm2_probe()

Avoid unnecessary round-tripping in and out of the TIS driver by calling
request_locality() directly, instead of going through tpm_chip_start(), and
for the consistency sake (other sites in initialization code work this
way).

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 69579efb247b..3b5a03f9efce 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -980,13 +980,11 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	intmask &= ~TPM_GLOBAL_INT_ENABLE;
 	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
 
-	rc = tpm_chip_start(chip);
-	if (rc)
+	rc = request_locality(chip, 0);
+	if (rc < 0)
 		goto out_err;
 	rc = tpm2_probe(chip);
-	tpm_chip_stop(chip);
-	if (rc)
-		goto out_err;
+	release_locality(chip, 0);
 
 	rc = tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
 	if (rc < 0)
-- 
2.31.1


--vyklwdvksnkra3qg--
