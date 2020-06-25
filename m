Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D3C20A135
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 16:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405570AbgFYOs1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 10:48:27 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:51444 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405522AbgFYOsM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 10:48:12 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 05PEloXb015294;
        Thu, 25 Jun 2020 17:47:51 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id F2620639BE; Thu, 25 Jun 2020 17:47:50 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org,
        "benoit.houyere@st.com--to=mark.rutland"@arm.com,
        peterhuewe@gmx.de, christophe-h.richard@st.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>,
        Benoit Houyere <benoit.houyere@st.com>
Subject: [PATCH v12 7/9] tpm: tpm_tis: verify TPM_STS register is valid after locality request
Date:   Thu, 25 Jun 2020 17:46:47 +0300
Message-Id: <20200625144650.269719-8-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200625144650.269719-1-amirmizi6@gmail.com>
References: <20200625144650.269719-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Issue could result when the TPM does not update TPM_STS register after
a locality request (TPM_STS Initial value = 0xFF) and a TPM_STS register
read occurs (tpm_tis_status(chip)).

Checking the next condition("if ((status & TPM_STS_COMMAND_READY) == 0)"),
the status will be at 0xFF and will be considered, wrongly, in "Ready"
state (by checking only one bit). However, at this moment the TPM is, in
fact, in "Idle" state and remains in "Idle" state because
"tpm_tis_ready(chip);" was not executed.

Suggested-by: Benoit Houyere <benoit.houyere@st.com>
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index a38465f..b876db2 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -221,8 +221,14 @@ static int request_locality(struct tpm_chip *chip, int l)
 	} else {
 		/* wait for burstcount */
 		do {
-			if (check_locality(chip, l))
+			if (check_locality(chip, l)) {
+				if (wait_for_tpm_stat(chip, TPM_STS_GO, 0,
+						      chip->timeout_c,
+						      &priv->int_queue,
+						      false) < 0)
+					return -ETIME;
 				return l;
+			}
 			tpm_msleep(TPM_TIMEOUT);
 		} while (time_before(jiffies, stop));
 	}
-- 
2.7.4

