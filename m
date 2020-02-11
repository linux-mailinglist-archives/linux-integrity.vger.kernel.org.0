Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCF4D159D03
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2020 00:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgBKXO1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Feb 2020 18:14:27 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36378 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgBKXO1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Feb 2020 18:14:27 -0500
Received: from tusharsu-Ubuntu.corp.microsoft.com (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7EC7520B9C2F;
        Tue, 11 Feb 2020 15:14:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7EC7520B9C2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581462866;
        bh=XHJmcrml0bOhkfiWegb1wXW/R0Kk93NkGo6uSyYSInU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3U7GEBUoYB072zwIWuSQI7AJc+KMY3wpadX8KcrfXNCKs8rredIEsKgDKg4EpeDS
         tVM9RQv8Rm4PbHCC8djMwiSZuI4vFKmI3TkD6Wy25TfOH/RDAU7e+GzR9OBMEBfJzZ
         hRMxyjbknl2IMAzl04N61PUBAPZ46z0OOxp5Asc8=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, joe@perches.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] IMA: Update KBUILD_MODNAME for IMA files to ima
Date:   Tue, 11 Feb 2020 15:14:12 -0800
Message-Id: <20200211231414.6640-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
References: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
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

