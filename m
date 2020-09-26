Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91531279A7B
	for <lists+linux-integrity@lfdr.de>; Sat, 26 Sep 2020 17:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbgIZPwZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 26 Sep 2020 11:52:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54138 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729788AbgIZPwZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 26 Sep 2020 11:52:25 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id CE5EF20B36E7;
        Sat, 26 Sep 2020 08:52:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CE5EF20B36E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601135544;
        bh=KvKjiotn6mL3Yq1J6tbnb0Rp+ek+KOhged/9ZAOBywQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QiyQ8+doYi2h3hPwO0sInlDj3K+B/vA6C58SvFJMI1NsxcQrPc1/S6LKZkl+qZ66c
         SXwcOsU3Qf852O2LLJaCWh8PMaRV12m5D1r3ePtrHziUw+0KEae2x7GibtxRETR5el
         z9AsLzlqbs+r1HsZlquAYnIUJhsvfMywLzZVqaBo=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] IMA: Support early boot measurement of critical data
Date:   Sat, 26 Sep 2020 08:52:19 -0700
Message-Id: <20200926155219.5561-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926155219.5561-1-nramas@linux.microsoft.com>
References: <20200926155219.5561-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IMA hook ima_measure_critical_data() requires a custom IMA policy
to be loaded to determine what data should be measured by IMA.
If a custom policy is not loaded by the time ima_measure_critical_data()
is called, then IMA needs to queue the data until a policy is loaded.

Update ima_measure_critical_data() to utilize early boot measurement
support to defer processing data if a custom IMA policy is not yet
loaded.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 438199e43f5e..5162917e6bf2 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -898,6 +898,8 @@ void ima_measure_critical_data(const char *event_name,
 			       const void *buf, int buf_len,
 			       bool measure_buf_hash)
 {
+	bool queued = false;
+
 	if (!event_name || !event_data_source || !buf || !buf_len) {
 		pr_err("Invalid arguments passed to %s().\n", __func__);
 		return;
@@ -909,6 +911,14 @@ void ima_measure_critical_data(const char *event_name,
 		return;
 	}
 
+	if (ima_should_queue_data())
+		queued = ima_queue_data(event_name, buf, buf_len,
+					event_data_source, CRITICAL_DATA,
+					measure_buf_hash);
+
+	if (queued)
+		return;
+
 	process_buffer_measurement(NULL, buf, buf_len, event_name,
 				   CRITICAL_DATA, 0, event_data_source,
 				   measure_buf_hash);
-- 
2.28.0

