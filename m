Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 578E71462DB
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2020 08:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgAWHsz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Jan 2020 02:48:55 -0500
Received: from relay.sw.ru ([185.231.240.75]:37316 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgAWHsy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jan 2020 02:48:54 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iuXER-00067v-IJ; Thu, 23 Jan 2020 10:48:51 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 1/2] tpm1_bios_measurements_next should increase position
 index
To:     linux-integrity@vger.kernel.org
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Message-ID: <3b24cec6-efb9-8dd4-fa1e-19e04798b067@virtuozzo.com>
Date:   Thu, 23 Jan 2020 10:48:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

if seq_file .next fuction does not change position index,
read after non-zero llseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 drivers/char/tpm/eventlog/tpm1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index 739b1d9..2c96977 100644
--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -115,6 +115,7 @@ static void *tpm1_bios_measurements_next(struct seq_file *m, void *v,
 	u32 converted_event_size;
 	u32 converted_event_type;
 
+	(*pos)++;
 	converted_event_size = do_endian_conversion(event->event_size);
 
 	v += sizeof(struct tcpa_event) + converted_event_size;
@@ -132,7 +133,6 @@ static void *tpm1_bios_measurements_next(struct seq_file *m, void *v,
 	    ((v + sizeof(struct tcpa_event) + converted_event_size) > limit))
 		return NULL;
 
-	(*pos)++;
 	return v;
 }
 
-- 
1.8.3.1

