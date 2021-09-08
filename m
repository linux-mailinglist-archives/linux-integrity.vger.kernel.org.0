Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8A8403ADE
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Sep 2021 15:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhIHNoY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Sep 2021 09:44:24 -0400
Received: from mxout70.expurgate.net ([194.37.255.70]:47707 "EHLO
        mxout70.expurgate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbhIHNoX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Sep 2021 09:44:23 -0400
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Sep 2021 09:44:23 EDT
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1mNxii-0006AB-Gy; Wed, 08 Sep 2021 15:34:32 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1mNxih-000Bkh-Ed; Wed, 08 Sep 2021 15:34:31 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id E9F42240041;
        Wed,  8 Sep 2021 15:34:30 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 77837240040;
        Wed,  8 Sep 2021 15:34:30 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id ABC032029C;
        Wed,  8 Sep 2021 15:34:29 +0200 (CEST)
From:   Florian Eckert <fe@dev.tdt.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        Eckert.Florian@googlemail.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm/tpm_i2c_infineon: Fix init endian vendor check
Date:   Wed,  8 Sep 2021 15:34:16 +0200
Message-ID: <20210908133416.12408-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1631108072-00000D29-D0C1529F/0/0
X-purgate: clean
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On my embedded system I use this tpm infineon chip via I2C.
My system is a MIPS architecture and therefore works in big endian mode.

The problem is that the chip type is not recognised, because the vendor I=
D
is incorrectly stored in memory.

By converting the vendor ID with ie32_to_cpus() to the correct format,
the TPM chip is recognised by the driver and works as expected.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/char/tpm/tpm_i2c_infineon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i=
2c_infineon.c
index a19d32cb4e94..111a8c34329a 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -638,6 +638,8 @@ static int tpm_tis_i2c_init(struct device *dev)
 		goto out_release;
 	}
=20
+	le32_to_cpus(&vendor);
+
 	if (vendor =3D=3D TPM_TIS_I2C_DID_VID_9645) {
 		tpm_dev.chip_type =3D SLB9645;
 	} else if (vendor =3D=3D TPM_TIS_I2C_DID_VID_9635) {
--=20
2.20.1

