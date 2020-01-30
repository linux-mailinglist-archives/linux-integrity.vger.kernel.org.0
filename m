Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 799F014D8E1
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jan 2020 11:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgA3KXY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jan 2020 05:23:24 -0500
Received: from relay.sw.ru ([185.231.240.75]:49630 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgA3KXY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jan 2020 05:23:24 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1ix6yj-0003u1-Mp; Thu, 30 Jan 2020 13:23:17 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 1/2] tpm: tpm1_bios_measurements_next should increase
 position index
To:     linux-integrity@vger.kernel.org
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <e72b6fda6c4ff0d54af37d064d66b883d7ea48e7.camel@linux.intel.com>
Message-ID: <3f4f2483-66cf-8693-986d-bf2821cdd879@virtuozzo.com>
Date:   Thu, 30 Jan 2020 13:23:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e72b6fda6c4ff0d54af37d064d66b883d7ea48e7.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If seq_file .next function does not change position index,
read after non-zero lseek can generate unexpected output.
In case of /sys/kernel/security/tpm0/ascii_bios_measurements
and binary_bios_measurements:
1) read after lseek beyond end of file generates whole last line.
2) read after lseek to middle of last line generates
expected end of last line and unexpected whole last line once again.

Cc: stable@vger.kernel.org
Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code ...")
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

