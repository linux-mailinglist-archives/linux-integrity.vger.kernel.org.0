Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694F11FF38E
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 15:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgFRNp3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 09:45:29 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:50923 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730116AbgFRNos (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 09:44:48 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 05IDiRTu001778;
        Thu, 18 Jun 2020 16:44:27 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id B6335639BF; Thu, 18 Jun 2020 16:44:27 +0300 (IDT)
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
        Christophe Ricard <christophe-h.ricard@st.com>
Subject: [PATCH v11 3/8] tpm: tpm_tis: Add retry in case of protocol failure or data integrity (on I2C only) failure.
Date:   Thu, 18 Jun 2020 16:43:38 +0300
Message-Id: <20200618134344.243537-4-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200618134344.243537-1-amirmizi6@gmail.com>
References: <20200618134344.243537-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Added a retry mechanism on any protocol error. In addition, a retry is
added in case of a data integrity issue in the I2C bus protocol. The check
is performed after sending a command to the TPM and after receiving a
response from the TPM.

Data integrity is checked if a "verify_data_integrity" handle is defined in
"tpm_tis_phy_ops".
When sending a command, a loop is added in "tpm_tis_send_main()" that calls
"tpm_tis_send_data()" and then issues a retry attempt if any error occurs
(protocol or data integrity).
When receiving a response, the following new function derived from
"tpm_tis_recv()" is added: "__tpm_tis_recv()". "tpm_tis_recv()" is modified
to call "__tpm_tis_recv()" in a loop. If any error occurs (protocol or data
integrity), a retry is initiated by setting TPM_STS.responseRetry and
"__tpm_tis_recv()" is called again.
In both cases a retry is attempted "TPM_RETRY" times until reached.

Co-developed-by: Christophe Ricard <christophe-h.ricard@st.com>
Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 78 +++++++++++++++++++++++++++++------------
 drivers/char/tpm/tpm_tis_core.h |  3 ++
 2 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index d276f03..14ffee4 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -304,29 +304,24 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
 	return size;
 }
 
-static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+static int __tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int size = 0;
 	int status;
 	u32 expected;
 
-	if (count < TPM_HEADER_SIZE) {
-		size = -EIO;
-		goto out;
-	}
-
 	size = recv_data(chip, buf, TPM_HEADER_SIZE);
 	/* read first 10 bytes, including tag, paramsize, and result */
 	if (size < TPM_HEADER_SIZE) {
 		dev_err(&chip->dev, "Unable to read header\n");
-		goto out;
+		return size;
 	}
 
 	expected = be32_to_cpu(*(__be32 *) (buf + 2));
 	if (expected > count || expected < TPM_HEADER_SIZE) {
 		size = -EIO;
-		goto out;
+		return size;
 	}
 
 	size += recv_data(chip, &buf[TPM_HEADER_SIZE],
@@ -334,21 +329,51 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	if (size < expected) {
 		dev_err(&chip->dev, "Unable to read remainder of result\n");
 		size = -ETIME;
-		goto out;
+		return size;
 	}
 
 	if (wait_for_tpm_stat(chip, TPM_STS_VALID, TPM_STS_VALID,
 			      chip->timeout_c, &priv->int_queue, false) < 0) {
 		size = -ETIME;
-		goto out;
+		return size;
 	}
+
 	status = tpm_tis_status(chip);
 	if (status & TPM_STS_DATA_AVAIL) {	/* retry? */
 		dev_err(&chip->dev, "Error left over data\n");
 		size = -EIO;
+		return size;
+	}
+
+	if (priv->phy_ops->verify_data_integrity)
+		if (!priv->phy_ops->verify_data_integrity(priv, buf,
+							  size)) {
+			size = -EIO;
+			return size;
+		}
+
+	return size;
+}
+
+static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	int size;
+	int i;
+
+	if (count < TPM_HEADER_SIZE) {
+		size = -EIO;
 		goto out;
 	}
 
+	for (i = 0; i < TPM_RETRY; i++) {
+		size = __tpm_tis_recv(chip, buf, count);
+		if (size <= 0)
+			tpm_tis_write8(priv, TPM_STS(priv->locality),
+				       TPM_STS_RESPONSE_RETRY);
+		else
+			goto out;
+	}
 out:
 	tpm_tis_ready(chip);
 	return size;
@@ -358,6 +383,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
  * If interrupts are used (signaled by an irq set in the vendor structure)
  * tpm.c can skip polling for the data to be available as the interrupt is
  * waited for here
+
  */
 static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 {
@@ -372,7 +398,7 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 				      TPM_STS_COMMAND_READY, chip->timeout_b,
 				      &priv->int_queue, false) < 0) {
 			rc = -ETIME;
-			goto out_err;
+			return rc;
 		}
 	}
 
@@ -381,13 +407,13 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 		if (burstcnt < 0) {
 			dev_err(&chip->dev, "Unable to read burstcount\n");
 			rc = burstcnt;
-			goto out_err;
+			return rc;
 		}
 		burstcnt = min_t(int, burstcnt, len - count);
 		rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
 					 burstcnt, buf + count);
 		if (rc < 0)
-			goto out_err;
+			return rc;
 
 		count += burstcnt;
 	}
@@ -395,14 +421,10 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 			      TPM_STS_VALID, chip->timeout_a, &priv->int_queue,
 			      false) < 0) {
 		rc = -ETIME;
-		goto out_err;
+		return rc;
 	}
 
 	return 0;
-
-out_err:
-	tpm_tis_ready(chip);
-	return rc;
 }
 
 static void disable_interrupts(struct tpm_chip *chip)
@@ -431,13 +453,25 @@ static void disable_interrupts(struct tpm_chip *chip)
 static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-	int rc;
+	int rc, i;
 	u32 ordinal;
 	unsigned long dur;
 
-	rc = tpm_tis_send_data(chip, buf, len);
-	if (rc < 0)
-		return rc;
+	for (i = 0; i < TPM_RETRY; i++) {
+		rc = tpm_tis_send_data(chip, buf, len);
+		if (rc < 0)
+			continue;
+		if (priv->phy_ops->verify_data_integrity) {
+			if (!priv->phy_ops->verify_data_integrity(priv, buf,
+								  len)){
+				rc = -EIO;
+				continue;
+			}
+		}
+		break;
+	}
+	if (i == TPM_RETRY)
+		goto out_err;
 
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index d06c65b..cd97c01 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -34,6 +34,7 @@ enum tis_status {
 	TPM_STS_GO = 0x20,
 	TPM_STS_DATA_AVAIL = 0x10,
 	TPM_STS_DATA_EXPECT = 0x08,
+	TPM_STS_RESPONSE_RETRY = 0x02,
 };
 
 enum tis_int_flags {
@@ -106,6 +107,8 @@ struct tpm_tis_phy_ops {
 	int (*read16)(struct tpm_tis_data *data, u32 addr, u16 *result);
 	int (*read32)(struct tpm_tis_data *data, u32 addr, u32 *result);
 	int (*write32)(struct tpm_tis_data *data, u32 addr, u32 src);
+	bool (*verify_data_integrity)(struct tpm_tis_data *data, const u8 *buf,
+				      size_t len);
 };
 
 static inline int tpm_tis_read_bytes(struct tpm_tis_data *data, u32 addr,
-- 
2.7.4

