Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE3B408ADD
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 14:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbhIMMSA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 08:18:00 -0400
Received: from mxout70.expurgate.net ([91.198.224.70]:43251 "EHLO
        mxout70.expurgate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbhIMMR5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 08:17:57 -0400
X-Greylist: delayed 688 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Sep 2021 08:17:56 EDT
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1mPkiG-000XrG-49; Mon, 13 Sep 2021 14:05:28 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1mPkiF-00026b-HE; Mon, 13 Sep 2021 14:05:27 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 329D9240042;
        Mon, 13 Sep 2021 14:05:27 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id B4150240041;
        Mon, 13 Sep 2021 14:05:26 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 4BFAF20110;
        Mon, 13 Sep 2021 14:05:26 +0200 (CEST)
From:   Florian Eckert <fe@dev.tdt.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        Eckert.Florian@googlemail.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] tpm/tpm_i2c_infineon: Fix init endian vendor check
Date:   Mon, 13 Sep 2021 14:05:21 +0200
Message-ID: <20210913120521.18572-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1631534728-00009D1C-E8CFFB6C/0/0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On my embedded system I use this tpm infineon chip via i2c bus.
The system is a MIPS architecture and therefore works in big endian mode.

The problem is, that the chip type is not correctly recognized,
because the vendor ID is wrongly aligned in the memory.

By declaring the vendor ID variable as a `__le32` type, the TPM chip is
then correctly recognized by the driver and feels then responsible.

The device works than as expected.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
v2:
* use variable type instead of le32_to_cpus function call
 drivers/char/tpm/tpm_i2c_infineon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i=
2c_infineon.c
index a19d32cb4e94..30c320ea57fd 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -611,7 +611,7 @@ static const struct tpm_class_ops tpm_tis_i2c =3D {
=20
 static int tpm_tis_i2c_init(struct device *dev)
 {
-	u32 vendor;
+	__le32 vendor;
 	int rc =3D 0;
 	struct tpm_chip *chip;
=20
--=20
2.20.1

