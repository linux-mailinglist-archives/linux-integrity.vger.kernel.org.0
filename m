Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F25ED105855
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Nov 2019 18:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfKUROt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Nov 2019 12:14:49 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33618 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKUROt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Nov 2019 12:14:49 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2E0FA20B7185;
        Thu, 21 Nov 2019 09:14:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E0FA20B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574356488;
        bh=ZxVEr4uFBXMRO2Hmj7wYKpQquAuGeS6v3eiWUkYsy5s=;
        h=From:To:Subject:Date:From;
        b=eDFE+bS71Ax1RsH5sgy7TdV1cQGZAg93ws+U3a6Ak5jkHFH5e4/5G8pW7pen2N6N3
         WfsJUogB9nUKMQeC3ZdSP09ZX0rwUASzI26pfTgGDYaq8Tt5aC3gs2R93UM6zsgTdd
         kO+b9GM81HhoZH3oRNT0J/sHfoG/tn+5s0/s5yJA=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, eric.snowberg@oracle.com,
        linux-integrity@vger.kernel.org
Subject: [PATCH v0] IMA: Check IMA policy flag
Date:   Thu, 21 Nov 2019 09:14:44 -0800
Message-Id: <20191121171444.2797-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

process_buffer_measurement() needs to check if ima_policy_flag
is set to measure and\or appraise. Not doing this check can
result in kernel panic (such as when process_buffer_measurement()
is called before IMA is initialized).

Please see one instance reported by Eric Snowberg
(eric.snowberg@oracle.com) when testing key measurement:
https://lore.kernel.org/linux-integrity/20191118223818.3353-1-nramas@linux.microsoft.com/T/#mc243b065659d43a7f5070a2383979542f10d58d1

This change adds the check in process_buffer_measurement()
to return immediately if ima_policy_flag is set to 0.

[    1.185105] Loading compiled-in X.509 certificates
[    1.190240] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    1.191835] #PF: supervisor read access in kernel mode
[    1.193041] #PF: error_code(0x0000) - not-present page
[    1.222749] Call Trace:
[    1.223344]  ? crypto_destroy_tfm+0x5f/0xb0
[    1.224315]  ima_get_action+0x2c/0x30
[    1.225148]  process_buffer_measurement+0x1da/0x230
[    1.226306]  ima_post_key_create_or_update+0x3b/0x40
[    1.227459]  key_create_or_update+0x371/0x5c0
[    1.228494]  load_system_certificate_list+0x99/0xfa
[    1.229588]  ? system_trusted_keyring_init+0xfb/0xfb
[    1.230705]  ? do_early_param+0x95/0x95
[    1.231574]  do_one_initcall+0x4a/0x1fa
[    1.232444]  ? do_early_param+0x95/0x95
[    1.233313]  kernel_init_freeable+0x1c2/0x267
[    1.234300]  ? rest_init+0xb0/0xb0
[    1.235075]  kernel_init+0xe/0x110
[    1.235842]  ret_from_fork+0x24/0x50

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 60027c643ecd..c9374430bb72 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -651,6 +651,9 @@ static void process_buffer_measurement(const void *buf, int size,
 	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
 	int action = 0;
 
+	if (!ima_policy_flag)
+		return;
+
 	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
 				&template_desc);
 	if (!(action & IMA_MEASURE))
-- 
2.17.1

