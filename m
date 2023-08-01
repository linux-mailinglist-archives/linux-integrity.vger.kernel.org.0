Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EFC76BC29
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Aug 2023 20:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjHASTd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Aug 2023 14:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjHASTa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Aug 2023 14:19:30 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81E8C2130
        for <linux-integrity@vger.kernel.org>; Tue,  1 Aug 2023 11:19:29 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id A88C7238AEA6;
        Tue,  1 Aug 2023 11:19:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A88C7238AEA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690913969;
        bh=UMsa/6D6amNcXhqqKgULTQeVgWNbTSj6Vc9o3LqSmOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egYnxmFXUmAUrYzaMvhqMd5SZj4sz+H5N9yFX1xKDQkZxON3lo0KA07sHiGzJXMUM
         xJaFYoGEKAw36wRXfIQnm3yIIuNViqGHzFkt0DWFWpq0ZI6fJd+3jXCb4ubf/lUyma
         vAEhPC0vytGW551wjUAsccwqN44SHlAvINfeKrtc=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH 5/6] ima: measure TPM update counter at ima_init
Date:   Tue,  1 Aug 2023 11:19:16 -0700
Message-Id: <20230801181917.8535-6-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA log entries can be lost due to a variety of causes, such as code bugs
or error conditions, leading to a mismatch between TPM PCRs and
the IMA log.  Measuring TPM PCR update counter during ima_init would
provide a baseline counter for the number of times the TPM PCRs are
updated.  The remote attestation service can compare this baseline
counter with a subsequent measured one (e.g., post-kexec soft-boot) to
identify if there are any lost IMA log events.

Measure the TPM update counter at ima init.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_init.c | 3 +++
 security/integrity/ima/ima_main.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 63979aefc95f..9bb18d6c2fd6 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -154,5 +154,8 @@ int __init ima_init(void)
 				  UTS_RELEASE, strlen(UTS_RELEASE), false,
 				  NULL, 0);
 
+	/* Measures TPM update counter at ima_init */
+	ima_measure_update_counter("ima_init_tpm_update_counter");
+
 	return rc;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1bcd45cc5a6a..93357c245e82 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1035,6 +1035,7 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 				   buf, size, "kexec-cmdline", KEXEC_CMDLINE, 0,
 				   NULL, false, NULL, 0);
 	fdput(f);
+
 }
 
 /**
-- 
2.25.1

