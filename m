Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E575844318D
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Nov 2021 16:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhKBP1u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Nov 2021 11:27:50 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:47444 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231721AbhKBP1u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Nov 2021 11:27:50 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 1A2FMbqh005898;
        Tue, 2 Nov 2021 17:22:37 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 9487763A1E; Tue,  2 Nov 2021 17:22:49 +0200 (IST)
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
Subject: [PATCH v18 4/6] tpm: tpm_tis: Verify TPM_STS register is valid after locality request
Date:   Tue,  2 Nov 2021 17:20:54 +0200
Message-Id: <20211102152056.241769-5-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20211102152056.241769-1-amirmizi6@gmail.com>
References: <20211102152056.241769-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

An invalid TPM_STS value could be used when the following two events occur:
TPM does not update TPM_STS register after a locality request (TPM_STS
Initial value = 0xFF), and a TPM_STS register read occurs in the
tpm_tis_status(chip) function call.

In probe_itpm(), a call to tpm_tis_send_data() function is made after a
request_locality() call, and the condition
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
index 90d92a1..f06c6c6 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -177,8 +177,14 @@ static int request_locality(struct tpm_chip *chip, int l)
 	} else {
 		/* wait for burstcount */
 		do {
-			if (check_locality(chip, l))
+			if (check_locality(chip, l)) {
+				if (wait_for_tpm_stat(chip, TPM_STS_GO, 0,
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

