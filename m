Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 975CB199589
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 13:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgCaLq0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 07:46:26 -0400
Received: from maillog.nuvoton.com ([202.39.227.15]:40908 "EHLO
        maillog.nuvoton.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbgCaLq0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 07:46:26 -0400
Received: from NTHCCAS02.nuvoton.com (nthccas02.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 1E4EE1C80E4B;
        Tue, 31 Mar 2020 19:34:57 +0800 (CST)
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTHCCAS02.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Tue, 31 Mar 2020
 19:34:56 +0800
Received: from NTILML02.nuvoton.com (10.190.1.47) by NTILML02.nuvoton.com
 (10.190.1.47) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Tue, 31 Mar
 2020 14:34:54 +0300
Received: from taln70.nuvoton.co.il (10.191.1.70) by NTILML02.nuvoton.com
 (10.190.1.46) with Microsoft SMTP Server id 15.0.1130.7 via Frontend
 Transport; Tue, 31 Mar 2020 14:34:54 +0300
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln70.nuvoton.co.il (Postfix) with ESMTP id 3A7EA250;
        Tue, 31 Mar 2020 14:34:54 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 2CA4C639B0; Tue, 31 Mar 2020 14:34:24 +0300 (IDT)
From:   <amirmizi6@gmail.com>
To:     <Eyal.Cohen@nuvoton.com>, <jarkko.sakkinen@linux.intel.com>,
        <oshrialkoby85@gmail.com>, <alexander.steffen@infineon.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <oshri.alkoby@nuvoton.com>,
        <tmaimon77@gmail.com>, <gcwilson@us.ibm.com>,
        <kgoldman@us.ibm.com>, <Dan.Morav@nuvoton.com>,
        <oren.tanami@nuvoton.com>, <shmulik.hager@nuvoton.com>,
        <amir.mizinski@nuvoton.com>, Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v4 3/7] tpm: tpm_tis: rewrite "tpm_tis_req_canceled()"
Date:   Tue, 31 Mar 2020 14:32:03 +0300
Message-ID: <20200331113207.107080-4-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200331113207.107080-1-amirmizi6@gmail.com>
References: <20200331113207.107080-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Using this function while read/write data resulted in aborted operation.
After investigating according to TCG TPM Profile (PTP) Specifications,
i found cancel should happen only if TPM_STS.commandReady bit is lit and
couldn't find a case when the current condition is valid.
Also only cmdReady bit need to be compared instead of the full lower status
register byte.

Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 6c4f232..18b9dc4 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -710,17 +710,7 @@ static int probe_itpm(struct tpm_chip *chip)

 static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
 {
-       struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-
-       switch (priv->manufacturer_id) {
-       case TPM_VID_WINBOND:
-               return ((status == TPM_STS_VALID) ||
-                       (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
-       case TPM_VID_STM:
-               return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
-       default:
-               return (status == TPM_STS_COMMAND_READY);
-       }
+       return ((status & TPM_STS_COMMAND_READY) == TPM_STS_COMMAND_READY);
 }

 static irqreturn_t tis_int_handler(int dummy, void *dev_id)
--
2.7.4



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
