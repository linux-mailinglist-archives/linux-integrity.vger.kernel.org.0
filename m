Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F30B76BC28
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Aug 2023 20:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjHASTd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Aug 2023 14:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjHASTa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Aug 2023 14:19:30 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C75AE2682
        for <linux-integrity@vger.kernel.org>; Tue,  1 Aug 2023 11:19:29 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 359E5238AEA9;
        Tue,  1 Aug 2023 11:19:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 359E5238AEA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690913969;
        bh=wudBVQFohkkzXxCbB2YMhOCNd/qTfMjxbpTBbqY9dK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PfaY43aUZRm8DwP24QcvpHl3eVWh3GmSYwFS/W0vNbyTGX5CwEmejnSwQ1M8NolHn
         KaXAqV6CkHLBVlWThL4p+EqN2M8bBxXM2n6vJFinHjJRhhMihb7do9qxe/ly7y4MN4
         VVideAkJST33sRJmHVBaLZ9/gG0MTPGTgyleEA6s=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH 6/6] kexec: measure TPM update counter in ima log at kexec load
Date:   Tue,  1 Aug 2023 11:19:17 -0700
Message-Id: <20230801181917.8535-7-tusharsu@linux.microsoft.com>
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

IMA measurements snapshot occurs at kexec 'load', but any additional
measurements between 'load' and kexec 'execute' aren't carried over
post kexec soft-reboot.[1] This may lead to TPM PCRs extending with
events that are not reflected in the new Kernel's IMA log.  By measuring
the TPM update counter at kexec 'load' and at ima_init after the kexec
soft-reboot, the remote attestation service can identify potentially
lost events by comparing the log event count with the counter difference.

Measure the TPM update counter at kexec image load.

[1] https://lore.kernel.org/all/20230703215709.1195644-1-tusharsu@linux.microsoft.com/
    ima: measure events between kexec load and execute

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 kernel/kexec_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..4b6391b02c5a 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -246,6 +246,9 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 				  image->cmdline_buf_len - 1);
 	}
 
+	/* Measures TPM update counter at kexec load. */
+	ima_measure_update_counter("kexec_load_tpm_update_counter");
+
 	/* IMA needs to pass the measurement list to the next kernel. */
 	ima_add_kexec_buffer(image);
 
-- 
2.25.1

