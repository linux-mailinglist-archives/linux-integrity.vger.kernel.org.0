Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAB2163801
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2020 01:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBSAGX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Feb 2020 19:06:23 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44408 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBSAGW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Feb 2020 19:06:22 -0500
Received: from tusharsu-Ubuntu.corp.microsoft.com (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 98B7620B9C2F;
        Tue, 18 Feb 2020 16:06:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98B7620B9C2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1582070781;
        bh=E4LoSYA568Wrc2tNWvgWgtnR26JPp2YG+l1HQwQL3ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jM6NQnCVHaxk6KIszZgE4oomQx91hCeqcxQdcne1QUMhK4LIKPfYfbifa4+mk9t3s
         ZpkmTRtQqKJMwBU2YP2Ny8E0WYW3epdqRar+rfbDMqlcQi6RQVrp7RcInUHCQHfDy0
         ZpUhLANVH8LBVUZ/+DBdrj2uyt4ohSyHzC9EhIgE=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, joe@perches.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] IMA: Update KBUILD_MODNAME for IMA files to ima
Date:   Tue, 18 Feb 2020 16:06:09 -0800
Message-Id: <20200219000611.28141-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219000611.28141-1-tusharsu@linux.microsoft.com>
References: <20200219000611.28141-1-tusharsu@linux.microsoft.com>
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
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
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

