Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6403D405A
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jul 2021 20:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhGWSB0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jul 2021 14:01:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55528 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWSBZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jul 2021 14:01:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id B110B1F44C5C
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 1/2] char: tpm: Kconfig: remove bad i2c cr50 select
Date:   Fri, 23 Jul 2021 21:41:49 +0300
Message-Id: <20210723184150.2596604-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This fixes a minor bug which went unnoticed during the initial
driver upstreaming review: TCG_CR50 does not exist in mainline
kernels, so remove it.

Fixes: 3a253caaad11 ("char: tpm: add i2c driver for cr50")
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 drivers/char/tpm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 4308f9ca7a43..d6ba644f6b00 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -89,7 +89,6 @@ config TCG_TIS_SYNQUACER
 config TCG_TIS_I2C_CR50
 	tristate "TPM Interface Specification 2.0 Interface (I2C - CR50)"
 	depends on I2C
-	select TCG_CR50
 	help
 	  This is a driver for the Google cr50 I2C TPM interface which is a
 	  custom microcontroller and requires a custom i2c protocol interface
-- 
2.32.0

