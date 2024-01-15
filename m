Return-Path: <linux-integrity+bounces-810-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF6B82E199
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jan 2024 21:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE9D2839A3
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jan 2024 20:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7665119BAD;
	Mon, 15 Jan 2024 20:21:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AC219BB1
	for <linux-integrity@vger.kernel.org>; Mon, 15 Jan 2024 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSI-0004x7-TL; Mon, 15 Jan 2024 21:21:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSI-0005hd-GU; Mon, 15 Jan 2024 21:21:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSI-000N8x-1N;
	Mon, 15 Jan 2024 21:21:10 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Subject: [PATCH 27/33] tpm_tis_spi: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:13:13 +0100
Message-ID:  <31f11901f6329a1de0299903d43c16439948bd46.1705348270.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=V8N9aIl0ONqba2eF61XStTUsd5p79z7jiynDO2E7c50=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHf8WD6GjV5qY8OxXbChFsTFEdFqH06f0kdB 8L0fxuPVIaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWR3wAKCRCPgPtYfRL+ TpQaB/9uCFV1sRbzNXWST/s0pnW+ymomv0WmvdVwR2vybREGIBOqzoGVnX2ZaPx+vF3lDs0BlBE M7U9EcCJSM6DnvYWGhooX6vuPldYuFccaNLDhLB1hcBrVQWyLNsmFdnfN/7L/Sv4hwdajsJkmLj PP+nRgn9ViKd+D1nZBe9T5EAhf7Ai0PZcOY4RHF5ZwAgvF13/V5/ktqP2egPFyBgj9tXPLsBlRx YSUeSfYDGG7l+zCyR+Oa5zAFMN7qnwBMPPnEfJ6YEJSXMtpTMbRtl8suKQxukS0kbxaT1xxLRli 4HZjr5XH/MtnvRpkbO0GNij0urODsAt3xcfqZdTUpGqcGHK9
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. To not break all drivers
compatibility macros were provided.

To be able to remove these compatibility macros push the renaming into
this driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index c5c3197ee29f..c647de7b3709 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -146,7 +146,7 @@ static int tpm_tis_spi_transfer_full(struct tpm_tis_data *data, u32 addr,
 	struct spi_transfer spi_xfer;
 	u8 transfer_len;
 
-	spi_bus_lock(phy->spi_device->master);
+	spi_bus_lock(phy->spi_device->controller);
 
 	while (len) {
 		transfer_len = min_t(u16, len, MAX_SPI_FRAMESIZE);
@@ -210,7 +210,7 @@ static int tpm_tis_spi_transfer_full(struct tpm_tis_data *data, u32 addr,
 		spi_sync_locked(phy->spi_device, &m);
 	}
 
-	spi_bus_unlock(phy->spi_device->master);
+	spi_bus_unlock(phy->spi_device->controller);
 	return ret;
 }
 
-- 
2.43.0


