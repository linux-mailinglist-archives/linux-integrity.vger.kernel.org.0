Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6819831C740
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Feb 2021 09:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhBPIUM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Feb 2021 03:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhBPISr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 03:18:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB8AF64E00;
        Tue, 16 Feb 2021 08:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613463487;
        bh=3+KOmihDg3ngn6imHg5uAKjDla5mxWLANjT8x0+zpd8=;
        h=From:To:Cc:Subject:Date:From;
        b=IjboentEOVGUyDhdViLNjoo10oGxPgCUKl75EvAEFd2jdmlA0/iif3vTH/z/HHzAb
         EVI32l4kQY2kV8iYW9aPXdQsy+Dxn9rU4GmORIek3YC1zlka411ZKMjm6q1ugVLNBv
         WkU8PEW+4moBP3SBt4apGPPVNkLDTVSk+UCHwh2PtlVkmGQaOlbTQ8dkhpxFNsx/oQ
         BbRrHNAGjmNZaVDoqMuSV6bWRepSykq7xlTRq3KkufRE3oPK0D+k23B8SumTopm2n9
         0dbOjVpdmpM//eOa5ix+oMG7gC2QZHVfBUKaZSaOyboYdZdZn24DhMSyUIj6R0cr5M
         qiz7xyNMWU45w==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     Lukasz Majczak <lma@semihalf.com>,
        Laurent Bigonville <bigon@debian.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH] tpm, tpm_tis: Acquire locality in tpm_tis_gen_interrupt() and tpm_get_timeouts()
Date:   Tue, 16 Feb 2021 10:17:49 +0200
Message-Id: <20210216081750.191250-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Lukasz Majczak <lma@semihalf.com>

This is shown with Samsung Chromebook Pro (Caroline) with TPM 1.2
(SLB 9670):

[    4.324298] TPM returned invalid status
[    4.324806] WARNING: CPU: 2 PID: 1 at drivers/char/tpm/tpm_tis_core.c:275 tpm_tis_status+0x86/0x8f

Background
==========

TCG PC Client Platform TPM Profile (PTP) Specification, paragraph 6.1 FIFO
Interface Locality Usage per Register, Table 39 Register Behavior Based on
Locality Setting for FIFO - a read attempt to TPM_STS_x Registers returns
0xFF in case of lack of locality. The described situation manifests itself
with the following warning trace:

The fix
=======

Add the proper decorations to tpm_tis_gen_interrupt() and
tpm_get_timeouts().

Cc: Laurent Bigonville <bigon@debian.org>
Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
Signed-off-by: Lukasz Majczak <lma@semihalf.com>
Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
It was easier to write a new patch based on v5. Since v5 had a crippled
change log I just restarted the version count.
 drivers/char/tpm/tpm-interface.c | 16 ++++++++++++++--
 drivers/char/tpm/tpm_tis_core.c  | 16 +++++++++++++---
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1621ce818705..9ab155ae5726 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -238,13 +238,25 @@ EXPORT_SYMBOL_GPL(tpm_transmit_cmd);
 
 int tpm_get_timeouts(struct tpm_chip *chip)
 {
+	int ret;
+
 	if (chip->flags & TPM_CHIP_FLAG_HAVE_TIMEOUTS)
 		return 0;
 
+	/* TPM 2.0 */
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		return tpm2_get_timeouts(chip);
-	else
-		return tpm1_get_timeouts(chip);
+
+
+	ret = tpm_chip_start(chip);
+	if (ret)
+		return ret;
+
+	ret = tpm1_get_timeouts(chip);
+
+	tpm_chip_stop(chip);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(tpm_get_timeouts);
 
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 431919d5f48a..ce80e7a2d420 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -707,12 +707,22 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
 	const char *desc = "attempting to generate an interrupt";
 	u32 cap2;
 	cap_t cap;
+	int ret;
 
+	/* TPM 2.0 */
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		return tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
-	else
-		return tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc,
-				  0);
+
+	/* TPM 1.2 */
+	ret = request_locality(chip, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc, 0);
+
+	release_locality(chip, 0);
+
+	return ret;
 }
 
 /* Register the IRQ and issue a command that will cause an interrupt. If an
-- 
2.30.1

