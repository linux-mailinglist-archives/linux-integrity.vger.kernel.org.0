Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8117E16B9B6
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2020 07:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgBYG00 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Feb 2020 01:26:26 -0500
Received: from relay.sw.ru ([185.231.240.75]:39126 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgBYG00 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Feb 2020 01:26:26 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1j6Tfi-0004j8-FN; Tue, 25 Feb 2020 09:26:22 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v3 2/2] tpm: tpm2_bios_measurements_next should increase
 position index
To:     linux-integrity@vger.kernel.org
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20200205220359.GA28111@linux.intel.com>
Message-ID: <e619d577-715f-9fe7-f43f-89e4a76de726@virtuozzo.com>
Date:   Tue, 25 Feb 2020 09:26:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205220359.GA28111@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If .next function does not change position index,
following .show function will repeat output related
to current position index.

For /sys/kernel/security/tpm0/binary_bios_measurements:
1) read after lseek beyound end of file generates whole last line.
2) read after lseek to middle of last line generates
expected end of last line and unexpected whole last line once again.

Cc: stable@vger.kernel.org
Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code ...")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 drivers/char/tpm/eventlog/tpm2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index b9aeda1..e741b11 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -94,6 +94,7 @@ static void *tpm2_bios_measurements_next(struct seq_file *m, void *v,
 	size_t event_size;
 	void *marker;
 
+	(*pos)++;
 	event_header = log->bios_event_log;
 
 	if (v == SEQ_START_TOKEN) {
@@ -118,7 +119,6 @@ static void *tpm2_bios_measurements_next(struct seq_file *m, void *v,
 	if (((v + event_size) >= limit) || (event_size == 0))
 		return NULL;
 
-	(*pos)++;
 	return v;
 }
 
-- 
1.8.3.1

