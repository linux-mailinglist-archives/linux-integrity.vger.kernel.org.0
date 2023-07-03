Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0ED746533
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jul 2023 23:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjGCV5V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jul 2023 17:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjGCV5T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jul 2023 17:57:19 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9CCC1A1
        for <linux-integrity@vger.kernel.org>; Mon,  3 Jul 2023 14:57:18 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 17AD920C08E6;
        Mon,  3 Jul 2023 14:57:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17AD920C08E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1688421438;
        bh=QSvlPzRxeFbeULzyjZwN/RPvVC6e2A3pn0e54sScUOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBh2Sg92sT83le5olP6H2y5ygM6Vg6+PyI6OxTsBV0YLUk+L2zOPcZZdKHqlORane
         W19FFtESmi88heWz0c0dtaXJDq8J/+rg4Pwv9avmAcKEe2GqqcTXOm0fnW3tYcomhU
         edSdZsYhiTK7eiIBB3wE8dVxKHSx2FkeJOeWBWGM=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH 02/10] ima: implement function to populate buffer at kexec execute
Date:   Mon,  3 Jul 2023 14:57:01 -0700
Message-Id: <20230703215709.1195644-3-tusharsu@linux.microsoft.com>
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

There is no existing IMA functionality to just populate the buffer at
kexec execute with IMA measurements.

Implement a function to iterate over ima_measurements and populate the
ima_kexec_file buffer.  After the loop, populate ima_khdr with buffer
details (version, buffer size, number of measurements).  Copy the ima_khdr
data into ima_kexec_file.buf and update buffer_size and buffer.

The patch assumes that the ima_kexec_file.size is sufficient to hold all
the measurements.  It returns an error and does not handle scenarios where
additional space might be needed.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 52 ++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 48a683874044..858b67689701 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -62,6 +62,58 @@ static int ima_allocate_buf_at_kexec_load(void)
 	return 0;
 }
 
+static int ima_populate_buf_at_kexec_execute(unsigned long *buffer_size, void **buffer)
+{
+	struct ima_queue_entry *qe;
+	int ret = 0;
+
+	/*
+	 * Ensure the kexec buffer is large enough to hold ima_khdr
+	 */
+	if (ima_kexec_file.size < sizeof(ima_khdr)) {
+		pr_err("%s: Kexec buffer size too low to hold ima_khdr\n",
+			__func__);
+		ima_clear_kexec_file();
+		return -ENOMEM;
+	}
+
+	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+		if (ima_kexec_file.count < ima_kexec_file.size) {
+			ima_khdr.count++;
+			ima_measurements_show(&ima_kexec_file, qe);
+		} else {
+			ret = -ENOMEM;
+			pr_err("%s: Kexec ima_measurements buffer too small\n",
+				__func__);
+			break;
+		}
+	}
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * fill in reserved space with some buffer details
+	 * (eg. version, buffer size, number of measurements)
+	 */
+	ima_khdr.buffer_size = ima_kexec_file.count;
+	if (ima_canonical_fmt) {
+		ima_khdr.version = cpu_to_le16(ima_khdr.version);
+		ima_khdr.count = cpu_to_le64(ima_khdr.count);
+		ima_khdr.buffer_size = cpu_to_le64(ima_khdr.buffer_size);
+	}
+
+	memcpy(ima_kexec_file.buf, &ima_khdr, sizeof(ima_khdr));
+	*buffer_size = ima_kexec_file.count;
+	*buffer = ima_kexec_file.buf;
+
+out:
+	if (ret < 0)
+		ima_clear_kexec_file();
+
+	return ret;
+}
+
+
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
-- 
2.25.1

