Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE7EB155EF0
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2020 20:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBGTx5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Feb 2020 14:53:57 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34358 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGTx5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Feb 2020 14:53:57 -0500
Received: from tusharsu-Ubuntu.corp.microsoft.com (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 063A820B9C02;
        Fri,  7 Feb 2020 11:53:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 063A820B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581105237;
        bh=XHJmcrml0bOhkfiWegb1wXW/R0Kk93NkGo6uSyYSInU=;
        h=From:To:Cc:Subject:Date:From;
        b=svy/L+qCddYOBiDWszf+9lBzkqheX7WtX+y0MJKKAHeTc7meqOqESv7AcgYMDL4o7
         zDbUkNJpp5YoUmiw6mvZ8AX4EG/Vhzggrcm6JAwBytUFmWNoIRueyBaCDZmncgMSwy
         +69Vgw896VF6BevTuYpdJQHPfzOxSp+kQI3Fja/8=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] IMA: Updated KBUILD_MODNAME for IMA files to ima
Date:   Fri,  7 Feb 2020 11:53:45 -0800
Message-Id: <20200207195346.4017-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Log statements from ima_mok.c, ima_asymmetric_keys.c, and
ima_queue_keys.c are prefixed with the respective file names
and not with the string "ima". 

This change fixes the log statement prefix to be consistent with the rest
of the IMA files.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 064a256f8725..67dabca670e2 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -11,6 +11,6 @@ ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
-obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
-obj-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
-obj-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
+ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
+ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
+ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
-- 
2.17.1

