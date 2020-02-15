Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 162B715FC32
	for <lists+linux-integrity@lfdr.de>; Sat, 15 Feb 2020 02:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgBOBrv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Feb 2020 20:47:51 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57476 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbgBOBru (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Feb 2020 20:47:50 -0500
Received: from tusharsu-Ubuntu.corp.microsoft.com (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 239C520B9C2F;
        Fri, 14 Feb 2020 17:47:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 239C520B9C2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581731269;
        bh=5ranJUL04vD+5slQ9vrmfq8MrUASpsHtOsEdQGeqY3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDx7aawfACObXsSfv+eKPrhQb9mpX9Df06ciHNc5PHDtRZVr7JVG+RnG006mjOJcF
         GpML2gFIGTohL23yMNiyHrZYm92dU3qMIoaSdLcSnNqv+OLLguzq7w25etThicnCxh
         da8bPsOs8Q1RZngxW6UlIHpyy0XPt4CMzvZYqJeQ=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, joe@perches.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] IMA: Update KBUILD_MODNAME for IMA files to ima
Date:   Fri, 14 Feb 2020 17:47:07 -0800
Message-Id: <20200215014709.3006-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200215014709.3006-1-tusharsu@linux.microsoft.com>
References: <20200215014709.3006-1-tusharsu@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kbuild Makefile specifies object files for vmlinux in the $(obj-y)
lists. These lists depend on the kernel configuration[1].

The kbuild Makefile for IMA combines the object files for IMA into a
single object file namely ima.o. All the object files for IMA should be
combined into ima.o. But certain object files are being added to their
own $(obj-y). This results in the log messages from those modules getting
prefixed with their respective base file name, instead of "ima". This is
inconsistent with the log messages from the IMA modules that are combined
into ima.o.

This change fixes the above issue.

[1] Documentation\kbuild\makefiles.rst 

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

