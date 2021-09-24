Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC294176F6
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Sep 2021 16:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346792AbhIXOoL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Sep 2021 10:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346793AbhIXOoJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Sep 2021 10:44:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA6E160F13;
        Fri, 24 Sep 2021 14:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632494556;
        bh=ILM6DAhBU5V6AX509JHxrKkU26JrZm1T05IXEYOSE+s=;
        h=From:To:Cc:Subject:Date:From;
        b=paIzPvsmsoFNnesw4gBs2eCFXmnfZd0mgDGjHPoJIR42QEezKPFYoX/9tQvgRTSPP
         FRabiXJqNaT8BYYjCk7eJxwcu7Plr0W+wCXf3zRzQ4qdZRNNPk3UxBTK6cW39mjyNT
         gVFCei6kzx2UIM0NReTKbQxTWW6cO9gLJh0hvjqxrrOLgeaJmRIRVkW5cEVVDtHw+s
         MmamDK4orZwlIsphu68d3mvnJWr5A0Ey8UwMnLBIVqlGoZNCL0JQg9Y5ASGoR+ZwyW
         PW9wYdSsvR0AFL+t7itc3NQ9FDKHmrEHzku7DhbmLFmFeHZqPQK44lONZOz22V7OuY
         Qjn83LuPBCd0A==
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Wellbrock <a.wellbrock@mailbox.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2] tpm_tis_spi: Add missing SPI ID
Date:   Fri, 24 Sep 2021 15:41:11 +0100
Message-Id: <20210924144111.15267-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; h=from:subject; bh=ILM6DAhBU5V6AX509JHxrKkU26JrZm1T05IXEYOSE+s=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhTeLyH6J2mQPcicQmI/FNzF5FZhH8QFTfVeEXUCxD B4qeAa+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYU3i8gAKCRAk1otyXVSH0EmVB/ sExhWS73+/LKAzWofGdz10rqKn4vpmI22XMLcsx9BXNTUp6Jboi1ZSCsiknKWEdgswx9tSui/RNy8B nQb+t4kDcRbzSz1xuSoLdUWdL4D67jUpx6g5MfyrNgoZ7YCFJ8CuiA9yEJTdtnLuyjQa/swW6VD9wI 0wzXbbBuaqHnMf4JrKEP7EkZ7bXS7osQMJ+JWrHIhqAKvmxnnlsZTNCcxap4hyA7pWFr+thg909M5W D/UmfvgWrUpVQm1q8i2EhR216PW2uJQfTP0XMbnC6JH+Pis0nuCEiJey+SuJhkl9P/c6zLqIZ5RBqf nIqCb4Kr6k461N6lrLArykhNzaafPi
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In commit c46ed2281bbe ("tpm_tis_spi: add missing SPI device ID entries")
we added SPI IDs for all the DT aliases to handle the fact that we always
use SPI modaliases to load modules even when probed via DT however the
mentioned commit missed that the SPI and OF device ID entries did not
match and were different and so DT nodes with compatible
"tcg,tpm_tis-spi" will not match.  Add an extra ID for tpm_tis-spi
rather than just fix the existing one since what's currently there is
going to be better for anyone actually using SPI IDs to instantiate.

Fixes: c46ed2281bbe ("tpm_tis_spi: add missing SPI device ID entries")
Fixes: 96c8395e2166 ("spi: Revert modalias changes")
Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---

v2:
 - Tweak commit message with suggestion from Javier.

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

