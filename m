Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AFA1BA3F5
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2020 14:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgD0MwR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Apr 2020 08:52:17 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:47789 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727823AbgD0MwN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Apr 2020 08:52:13 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 03RCpiGa024058;
        Mon, 27 Apr 2020 15:51:44 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id A1E3E639B1; Mon, 27 Apr 2020 15:51:44 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        benoit.houyere@st.com, eajames@linux.ibm.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v7 4/7] tpm: tpm_tis: Fix expected bit handling and send all bytes in one shot without last byte in exception
Date:   Mon, 27 Apr 2020 15:49:28 +0300
Message-Id: <20200427124931.115697-5-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200427124931.115697-1-amirmizi6@gmail.com>
References: <20200427124931.115697-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Incorrect implementation of send message was detected. We polled only
TPM_STS.stsValid bit and then we single-checked the TPM_STS.expect bit
value.
TPM_STS.expected bit should be checked at the same time as
TPM_STS.stsValid bit, and this should be repeated until timeout_A.

To detect a TPM_STS.expected bit reset, the "wait_for_tpm_stat" function is
modified to "wait_for_tpm_stat_result". This function regularly reads the
status register and check the bits defined by "mask" to reach the value
defined in "mask_result".

This correct implementation is required for using the new CRC calculation
on I2C TPM command bytes or I2C TPM answer bytes. TPM_STS.expected bit is
reset after all bytes are acquired and the CRC result is inserted in the
dedicated register. It introduces a normal latency for TPM_STS.expected
bit reset.

Respectively, to send a message, as defined in
TCG_DesignPrinciples_TPM2p0Driver_vp24_pubrev.pdf, all bytes should be
sent in one shot instead of sending the last byte separately.

Suggested-by: Benoit Houyere <benoit.houyere@st.com>
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 74 +++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 44 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 682f950..f71ecd8 100644
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
@@ -292,10 +293,13 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
 	int size = 0, burstcnt, rc;
 
 	while (size < count) {
-		rc = wait_for_tpm_stat(chip,
-				 TPM_STS_DATA_AVAIL | TPM_STS_VALID,
-				 chip->timeout_c,
-				 &priv->read_queue, true);
+		rc = wait_for_tpm_stat_result(chip,
+					      TPM_STS_DATA_AVAIL |
+					      TPM_STS_VALID,
+					      TPM_STS_DATA_AVAIL |
+					      TPM_STS_VALID,
+					      chip->timeout_c,
+					      &priv->read_queue, true);
 		if (rc < 0)
 			return rc;
 		burstcnt = get_burstcount(chip);
@@ -350,8 +354,9 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
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
@@ -387,61 +392,40 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
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
 
@@ -498,9 +482,11 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
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

