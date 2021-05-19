Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BF9388FB8
	for <lists+linux-integrity@lfdr.de>; Wed, 19 May 2021 16:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346757AbhESOCr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 May 2021 10:02:47 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:59772 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240179AbhESOCp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 May 2021 10:02:45 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 14JE154Y031398;
        Wed, 19 May 2021 17:01:05 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id C615D63A19; Wed, 19 May 2021 17:01:11 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v2] add longer timeout for verify signature command
Date:   Wed, 19 May 2021 17:00:58 +0300
Message-Id: <20210519140059.85919-1-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

while testing TPM2_CC_VERIFY_SIGNATURE with usage of RSA 3070-bit keys i
encountered a timeout error. it seems current values do not support this case
as described in ptp 1.05 6.5.1.3:
https://trustedcomputinggroup.org/wp-content/uploads/PC_Client_Specific-Platform_TPM_Profile_for-PTP_2p0-v1p05p_r14_pub.pdf

The patch was tested on Raspberry-Pie 3, using Nuvoton NPCT75X TPM.

Changes since version 1:
-"tpm2: add longer timout for verify signature command"
                - Fixed and extended commit description.
Addressed comments from:
 - Jarkko Sakkinen: https://lore.kernel.org/patchwork/patch/1424664/

Amir Mizinski (1):
  tpm2: add longer timeout for verify signature command

 drivers/char/tpm/tpm2-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4

