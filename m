Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19035746538
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jul 2023 23:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGCV5X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jul 2023 17:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjGCV5V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jul 2023 17:57:21 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C6321A1
        for <linux-integrity@vger.kernel.org>; Mon,  3 Jul 2023 14:57:20 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id D099320C08FE;
        Mon,  3 Jul 2023 14:57:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D099320C08FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1688421440;
        bh=qcx5Aa65d/0M8PqhuBesEv2N4gHSQORRxOZKyGZ74F8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r5u2DuzGdZuk9Iw/VerUCmS8YLz6jLTt7JRHgqgwVLYLILLT6VB/MUzKb5f+tNL/o
         gaVYhG6pyaoUi/Puv79U/15cRH6AWLj6sATN4hVZxSdgboEezHP2xRMLb8zfceyZvH
         NxyMyU//JHEwsjnGRh8KbT7jEkt1bhpCcffqM6OA=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH 07/10] ima: remove function ima_dump_measurement_list
Date:   Mon,  3 Jul 2023 14:57:06 -0700
Message-Id: <20230703215709.1195644-8-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
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

The ima_dump_measurement_list function was designed to iterate over the
IMA measurement list and store each entry into a buffer.  The buffer,
along with its size, would be returned to the caller.  However, the
function is no longer required in the IMA subsystem.  It previously served
to dump the measurement list during the kexec 'load' operation, but this
functionality has been replaced by an alternative approach in this patch
series.

Remove the unused ima_dump_measurement_list function from the IMA
subsystem, to ensure a cleaner and more maintainable code.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 58 ------------------------------
 1 file changed, 58 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 224d88ccfe85..424930085c18 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -115,64 +115,6 @@ static int ima_populate_buf_at_kexec_execute(unsigned long *buffer_size, void **
 }
 
 
-static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
-				     unsigned long segment_size)
-{
-	struct ima_queue_entry *qe;
-	struct seq_file file;
-	struct ima_kexec_hdr khdr;
-	int ret = 0;
-
-	/* segment size can't change between kexec load and execute */
-	file.buf = vmalloc(segment_size);
-	if (!file.buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	file.size = segment_size;
-	file.read_pos = 0;
-	file.count = sizeof(khdr);	/* reserved space */
-
-	memset(&khdr, 0, sizeof(khdr));
-	khdr.version = 1;
-	list_for_each_entry_rcu(qe, &ima_measurements, later) {
-		if (file.count < file.size) {
-			khdr.count++;
-			ima_measurements_show(&file, qe);
-		} else {
-			ret = -EINVAL;
-			break;
-		}
-	}
-
-	if (ret < 0)
-		goto out;
-
-	/*
-	 * fill in reserved space with some buffer details
-	 * (eg. version, buffer size, number of measurements)
-	 */
-	khdr.buffer_size = file.count;
-	if (ima_canonical_fmt) {
-		khdr.version = cpu_to_le16(khdr.version);
-		khdr.count = cpu_to_le64(khdr.count);
-		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
-	}
-	memcpy(file.buf, &khdr, sizeof(khdr));
-
-	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
-			     file.buf, file.count < 100 ? file.count : 100,
-			     true);
-
-	*buffer_size = file.count;
-	*buffer = file.buf;
-out:
-	if (ret == -EINVAL)
-		vfree(file.buf);
-	return ret;
-}
-
 /*
  * Called during kexec_file_load so that IMA can add a segment to the kexec
  * image for the measurement list for the next kernel.
-- 
2.25.1

