Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C29409675
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 16:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346626AbhIMOvm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 10:51:42 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:42989 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1347133AbhIMOsY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 10:48:24 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 18DEiX3j003109;
        Mon, 13 Sep 2021 17:44:33 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id AB7FA63A20; Mon, 13 Sep 2021 17:44:43 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko@kernel.org, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, benoit.houyere@st.com,
        eajames@linux.ibm.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v14 5/7] tpm: tpm_tis: verify TPM_STS register is valid after locality request
Date:   Mon, 13 Sep 2021 17:43:49 +0300
Message-Id: <20210913144351.101167-6-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20210913144351.101167-1-amirmizi6@gmail.com>
References: <20210913144351.101167-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

This issue could occur when the TPM does not update TPM_STS register after
a locality request (TPM_STS Initial value = 0xFF) and a TPM_STS register
read occurs in the tpm_tis_status(chip) function call.

When a call to tpm_tis_send_data() function is made after a
request_locality() call, the condition
("if ((status & TPM_STS_COMMAND_READY) == 0)") is checked. At this moment
if the status value is 0xFF, then it is considered, wrongly, in “ready”
state (by checking only one bit). However, at this moment the TPM is, in
fact, in "Idle" state and remains in "Idle" state because
"tpm_tis_ready(chip);" was not executed.
Waiting for the condition TPM_STS.tpmGo == 0, will ensure that the TPM
status register has the correct value.

Suggested-by: Benoit Houyere <benoit.houyere@st.com>
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 4145758..d527c43 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -177,8 +177,14 @@ static int request_locality(struct tpm_chip *chip, int l)
 	} else {
 		/* wait for burstcount */
 		do {
-			if (check_locality(chip, l))
+			if (check_locality(chip, l)) {
+				if (tpm_tis_wait_for_stat(chip, TPM_STS_GO, 0,
+							  chip->timeout_c,
+							  &priv->int_queue,
+							  false) < 0)
+					return -ETIME;
 				return l;
+			}
 			tpm_msleep(TPM_TIMEOUT);
 		} while (time_before(jiffies, stop));
 	}
-- 
2.7.4

