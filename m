Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F761C80B2
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2020 06:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgEGEEr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 00:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgEGEEr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 00:04:47 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87BA207DD;
        Thu,  7 May 2020 04:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588824286;
        bh=GnLUxgmdXtnzY66D3hGDvqn+bBMebpp1lc+6hwlGfAo=;
        h=Date:From:To:Cc:Subject:From;
        b=ARhYmz2v+xSNYnTjr+O0bRqASsMPYHF68/hkeORs0hdYuJpIGt6+5S+XBbMJxInm0
         fXVi6sK25p7Q7O9Me3ZaGCcKlv+MHDwpZ/cxELS/ewgC+/pcIENDfv/ukf9rw90M8B
         ux2C56xh1pcJrsZxCW+7lg8KF2cXVlyicH+HBn1U=
Date:   Wed, 6 May 2020 23:09:12 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH RESEND] tpm: eventlog: Replace zero-length array with
 flexible-array member
Message-ID: <20200507040912.GA31382@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

Also, the following issue shows up due to the flexible-array member
having incomplete type[4]:

drivers/char/tpm/eventlog/tpm2.c: In function ‘tpm2_bios_measurements_start’:
drivers/char/tpm/eventlog/tpm2.c:54:46: error: invalid application of ‘sizeof’ to incomplete type ‘u8[]’ {aka ‘unsigned char[]’}
   54 |  size = sizeof(struct tcg_pcr_event) - sizeof(event_header->event)
      |                                              ^
drivers/char/tpm/eventlog/tpm2.c: In function ‘tpm2_bios_measurements_next’:
drivers/char/tpm/eventlog/tpm2.c:102:10: error: invalid application of ‘sizeof’ to incomplete type ‘u8[]’ {aka ‘unsigned char[]’}
  102 |    sizeof(event_header->event) + event_header->event_size;
      |          ^
drivers/char/tpm/eventlog/tpm2.c: In function ‘tpm2_binary_bios_measurements_show’:
drivers/char/tpm/eventlog/tpm2.c:140:10: error: invalid application of ‘sizeof’ to incomplete type ‘u8[]’ {aka ‘unsigned char[]’}
  140 |    sizeof(event_header->event) + event_header->event_size;
      |          ^
scripts/Makefile.build:266: recipe for target 'drivers/char/tpm/eventlog/tpm2.o' failed
make[3]: *** [drivers/char/tpm/eventlog/tpm2.o] Error 1

As mentioned above: "Flexible array members have incomplete type, and
so the sizeof operator may not be applied. As a quirk of the original
implementation of zero-length arrays, sizeof evaluates to zero."[1] So,
the sizeof(flexible-array) can be safely removed to fix the error above.

Lastly, prefer sizeof(*ptr) over sizeof(struct foo).

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
[4] https://github.com/KSPP/linux/issues/43

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Hi,

I'm resending this because LKML is eating some messages, recently.
Sorry for the noise in case you've already received this patch.

Thanks

 drivers/char/tpm/eventlog/tpm2.c | 10 +++-------
 include/linux/tpm_eventlog.h     |  2 +-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index e741b1157525..351a2989b3c6 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -51,8 +51,7 @@ static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
 	int i;
 
 	event_header = addr;
-	size = sizeof(struct tcg_pcr_event) - sizeof(event_header->event)
-		+ event_header->event_size;
+	size = sizeof(*event_header) + event_header->event_size;
 
 	if (*pos == 0) {
 		if (addr + size < limit) {
@@ -98,8 +97,7 @@ static void *tpm2_bios_measurements_next(struct seq_file *m, void *v,
 	event_header = log->bios_event_log;
 
 	if (v == SEQ_START_TOKEN) {
-		event_size = sizeof(struct tcg_pcr_event) -
-			sizeof(event_header->event) + event_header->event_size;
+		event_size = sizeof(*event_header) + event_header->event_size;
 		marker = event_header;
 	} else {
 		event = v;
@@ -136,9 +134,7 @@ static int tpm2_binary_bios_measurements_show(struct seq_file *m, void *v)
 	size_t size;
 
 	if (v == SEQ_START_TOKEN) {
-		size = sizeof(struct tcg_pcr_event) -
-			sizeof(event_header->event) + event_header->event_size;
-
+		size = sizeof(*event_header) + event_header->event_size;
 		temp_ptr = event_header;
 
 		if (size > 0)
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index c253461b1c4e..4f8c90c93c29 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -97,7 +97,7 @@ struct tcg_pcr_event {
 	u32 event_type;
 	u8 digest[20];
 	u32 event_size;
-	u8 event[0];
+	u8 event[];
 } __packed;
 
 struct tcg_event_field {
-- 
2.26.2

