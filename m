Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9876F416518
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Sep 2021 20:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhIWSRq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Sep 2021 14:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230474AbhIWSRq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Sep 2021 14:17:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DCB9610C8;
        Thu, 23 Sep 2021 18:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632420974;
        bh=Jjum8dD2jyB0jumFhHDg/89BHQQUykCQ01qdRsUvSig=;
        h=From:To:Cc:Subject:Date:From;
        b=pGn774gtchQAkmAUxsd2VER4HO/rPVwwRTZEQ6nTYhWQ+873lH0Jb7CtPFKJp7bEY
         pm9WQfzmlaMZWB3nLil+uUr4v8ioukgGtOufbeJP+cJwrXzRZ4Oi0tNM8XlrwnMhXu
         qeEW4bIBtCJ2i8waU3KKH6ghN2vt4kI3/+3NahwNly2heoBUErbyykYaUe+twnAGNr
         ap5kBr8HyuV+i6BTIATRMoJV2Xi57C0OEWzGGRms4gKBDJubPTrPo6mIvBtFhQ0Ssm
         OxuLRSkhKaexcho+mJKMX5rf12RuiGgEh49JqM3FHGH3nRc/Dd0GmB7EnUVGYBaiyp
         pybk16TYk+u8g==
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Wellbrock <a.wellbrock@mailbox.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] tpm_tis_spi: Add missing SPI ID
Date:   Thu, 23 Sep 2021 19:15:20 +0100
Message-Id: <20210923181520.8680-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; h=from:subject; bh=Jjum8dD2jyB0jumFhHDg/89BHQQUykCQ01qdRsUvSig=; b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBhTMP6tNnCvq3YyWMInujrOJK6jIwm37bFvj0HLRCS 2IGQ/KSJATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUzD+gAKCRAk1otyXVSH0J/5B/ itYom3Zxu3jXea+GzXyj+jjYPRoaJSXEq+SfEm7YPsGi7f2w2SzJDozh+h9sbl47J25wriReIFn5D0 xlKygFqHMk6OrRyU75DCYsh45cWPBQEd95HLIxafBUdkVCrRha0nsq8trEVwSr/YFNFBHKIGduAS0p LCVpMGIVz6H/pkdqxUtJQzIqnRA6pR0M00LhonCDsVXkkGZYxTwnePVjOYK1HPj4/C4AUZx+M9BGSe 4R9lFlM0NUTT8An9j0HeEu40OkDvqAQKfwp3fYdRroirySi1hsMxo92p7qnQKLPxidnQ9WmqLCkTp3 oAbBVkQe35it1xQ08Bl5SZ6ztpGNk=
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In commit c46ed2281bbe ("tpm_tis_spi: add missing SPI device ID entries")
we added SPI IDs for all the DT aliases to handle the fact that we always
use SPI modaliases to load modules even when probed via DT however this
added an alias for the non-idiomatic tpm_tis-spi compatible as tpm_tis_spi
which doesn't actually match. Add an extra ID for tpm_tis-spi rather than
just fix the existing one since what's currently there is going to be
better for anyone actually using SPI IDs to instantiate.

Fixes: c46ed2281bbe ("tpm_tis_spi: add missing SPI device ID entries")
Fixes: 96c8395e2166 ("spi: Revert modalias changes")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index 54584b4b00d1..aaa59a00eeae 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -267,6 +267,7 @@ static const struct spi_device_id tpm_tis_spi_id[] = {
 	{ "st33htpm-spi", (unsigned long)tpm_tis_spi_probe },
 	{ "slb9670", (unsigned long)tpm_tis_spi_probe },
 	{ "tpm_tis_spi", (unsigned long)tpm_tis_spi_probe },
+	{ "tpm_tis-spi", (unsigned long)tpm_tis_spi_probe },
 	{ "cr50", (unsigned long)cr50_spi_probe },
 	{}
 };
-- 
2.20.1

