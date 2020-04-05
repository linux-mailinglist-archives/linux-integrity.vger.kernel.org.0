Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D2619EB50
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Apr 2020 14:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgDEMzb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 5 Apr 2020 08:55:31 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:40235 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726410AbgDEMzb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Apr 2020 08:55:31 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 035CtEkp005493;
        Sun, 5 Apr 2020 15:55:14 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 2CED4639B0; Sun,  5 Apr 2020 15:55:14 +0300 (IDT)
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
Subject: [PATCH v5 4/7] tpm: tpm_tis: Fix expected bit handling and send all  bytes in one shot without last byte in exception
Date:   Sun,  5 Apr 2020 15:53:49 +0300
Message-Id: <20200405125352.183693-5-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200405125352.183693-1-amirmizi6@gmail.com>
References: <20200405125352.183693-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Incorrect implementation to send message has been detected. We check
and loop only on TPM_STS.stsValid bit and next we single check
TPM_STS.expect bit value.
TPM_STS.expected bit should be checked in the same time of
TPM_STS.stsValid, and shall be repeated until timeout_A.

To detect TPM_STS.expected bit reset "wait_for_tpm_stat" function is
modified to "wait_for_tpm_stat_result". This function read regularly
status register and check bit defined by "mask" to reach value defined in
"mask_result".

This correct implementation is mandatory to use new CRC calculation on I2C
TPM command bytes or I2C TPM answer bytes. TPM_STS.expected bit is reset
after all bytes acquired and CRC result inserted in dedicated register. It
introduces a normal latency to have TPM_STS.expected bit reset.

Respectively, to send message as defined in
TCG_DesignPrinciples_TPM2p0Driver_vp24_pubrev.pdf, all bytes should be
sent in one shot instead of sending last byte in exception.

Suggested-by: Benoit Houyere <benoit.houyere@st.com>
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 72 ++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 44 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 453d7ef..0a340c0 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -44,9 +44,10 @@ static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
 	return false;
 }
 
-static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
-		unsigned long timeout, wait_queue_head_t *queue,
-		bool check_cancel)
+static int wait_for_tpm_stat_result(struct tpm_chip *chip, u8 mask,
+				    u8 mask_result, unsigned long timeout,
+				    wait_queue_head_t *queue,
+				    bool check_cancel)
 {
 	unsigned long stop;
 	long rc;
@@ -55,7 +56,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 
 	/* check current status */
 	status = chip->ops->status(chip);
-	if ((status & mask) == mask)
+	if ((status & mask) == mask_result)
 		return 0;
 
 	stop = jiffies + timeout;
@@ -83,7 +84,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 			usleep_range(TPM_TIMEOUT_USECS_MIN,
 				     TPM_TIMEOUT_USECS_MAX);
 			status = chip->ops->status(chip);
-			if ((status & mask) == mask)
+			if ((status & mask) == mask_result)
 				return 0;
 		} while (time_before(jiffies, stop));
 	}
@@ -290,10 +291,11 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
 	int size = 0, burstcnt, rc;
 
 	while (size < count) {
-		rc = wait_for_tpm_stat(chip,
-				 TPM_STS_DATA_AVAIL | TPM_STS_VALID,
-				 chip->timeout_c,
-				 &priv->read_queue, true);
+		rc = wait_for_tpm_stat_result(chip,
+					TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+					TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+					chip->timeout_c,
+					&priv->read_queue, true);
 		if (rc < 0)
 			return rc;
 		burstcnt = get_burstcount(chip);
@@ -348,8 +350,9 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 			goto out;
 		}
 
-		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
-				      &priv->int_queue, false) < 0) {
+		if (wait_for_tpm_stat_result(chip, TPM_STS_VALID,
+					     TPM_STS_VALID, chip->timeout_c,
+					     &priv->int_queue, false) < 0) {
 			size = -ETIME;
 			goto out;
 		}
@@ -385,61 +388,40 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int rc, status, burstcnt;
 	size_t count = 0;
-	bool itpm = priv->flags & TPM_TIS_ITPM_WORKAROUND;
 
 	status = tpm_tis_status(chip);
 	if ((status & TPM_STS_COMMAND_READY) == 0) {
 		tpm_tis_ready(chip);
-		if (wait_for_tpm_stat
-		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
-		     &priv->int_queue, false) < 0) {
+		if (wait_for_tpm_stat_result(chip, TPM_STS_COMMAND_READY,
+					     TPM_STS_COMMAND_READY,
+					     chip->timeout_b,
+					     &priv->int_queue, false) < 0) {
 			rc = -ETIME;
 			goto out_err;
 		}
 	}
 
-	while (count < len - 1) {
+	while (count < len) {
 		burstcnt = get_burstcount(chip);
 		if (burstcnt < 0) {
 			dev_err(&chip->dev, "Unable to read burstcount\n");
 			rc = burstcnt;
 			goto out_err;
 		}
-		burstcnt = min_t(int, burstcnt, len - count - 1);
+		burstcnt = min_t(int, burstcnt, len - count);
 		rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
 					 burstcnt, buf + count);
 		if (rc < 0)
 			goto out_err;
 
 		count += burstcnt;
-
-		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
-					&priv->int_queue, false) < 0) {
-			rc = -ETIME;
-			goto out_err;
-		}
-		status = tpm_tis_status(chip);
-		if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
-			rc = -EIO;
-			goto out_err;
-		}
 	}
-
-	/* write last byte */
-	rc = tpm_tis_write8(priv, TPM_DATA_FIFO(priv->locality), buf[count]);
-	if (rc < 0)
-		goto out_err;
-
-	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
-				&priv->int_queue, false) < 0) {
+	if (wait_for_tpm_stat_result(chip, TPM_STS_VALID | TPM_STS_DATA_EXPECT,
+				     TPM_STS_VALID, chip->timeout_a,
+				     &priv->int_queue, false) < 0) {
 		rc = -ETIME;
 		goto out_err;
 	}
-	status = tpm_tis_status(chip);
-	if (!itpm && (status & TPM_STS_DATA_EXPECT) != 0) {
-		rc = -EIO;
-		goto out_err;
-	}
 
 	return 0;
 
@@ -496,9 +478,11 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 		ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
 
 		dur = tpm_calc_ordinal_duration(chip, ordinal);
-		if (wait_for_tpm_stat
-		    (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, dur,
-		     &priv->read_queue, false) < 0) {
+		if (wait_for_tpm_stat_result(chip,
+					     TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+					     TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+					     dur,
+					     &priv->read_queue, false) < 0) {
 			rc = -ETIME;
 			goto out_err;
 		}
-- 
2.7.4

