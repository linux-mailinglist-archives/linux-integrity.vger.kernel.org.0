Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90211C99C4
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2020 20:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgEGSt0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 14:49:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbgEGStZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 14:49:25 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0943124957;
        Thu,  7 May 2020 18:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877365;
        bh=pk7QrAL3NDjeA4BB8U07kjEUUtfctxSRQ394nM277v4=;
        h=Date:From:To:Cc:Subject:From;
        b=ewFUKtOokui8KqvgXxgQbs1XcpdPapWxul2Zw+SPUBSPM2TvMrwTGaDW6+kek18ka
         khLJOC525uEUctcdf8bKfyhasQTJbEx3L70DCvIEMkBkdyc+QyCzuhl45XzC9igQvQ
         VnELWJfggr5xFYGVJEg14g8TdtP6OPk9dbZ4UX2E=
Date:   Thu, 7 May 2020 13:53:51 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ima: Replace zero-length array with flexible-array
Message-ID: <20200507185351.GA14519@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 security/integrity/ima/ima.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 64317d95363e..da4246ee7e35 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -95,7 +95,7 @@ struct ima_template_entry {
 	u8 digest[TPM_DIGEST_SIZE];	/* sha1 or md5 measurement hash */
 	struct ima_template_desc *template_desc; /* template descriptor */
 	u32 template_data_len;
-	struct ima_field_data template_data[0];	/* template related data */
+	struct ima_field_data template_data[];	/* template related data */
 };
 
 struct ima_queue_entry {

