Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E491DDABE
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2020 01:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgEUXGB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 May 2020 19:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbgEUXGB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 May 2020 19:06:01 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAF88207F9;
        Thu, 21 May 2020 23:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590102360;
        bh=P1jeoOmkuQys8O/5KShp1h4j+v/r/jvzvMQiBaCGXUA=;
        h=Date:From:To:Cc:Subject:From;
        b=kjPULzZ9+vdGSNsCk+ICfxYRoVBIOI+MIGmNveAC203FdJXa8MM2KqRQwPrsB5WTP
         Hd1WLCThXNMhcz0Aa7ps91f0RAECthDDyO7Q4bHQ9aOLc8gK8aYdifRf1Q3d939mHf
         1VFgtiIQkJ85EL12T+jWB/tPAznRNsrvIn2eX2io=
Date:   Thu, 21 May 2020 18:10:49 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] security: integrity: Replace zero-length array with
 flexible-array member
Message-ID: <20200521231049.GA28765@embeddedor>
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
 security/integrity/ima/ima.h   | 2 +-
 security/integrity/integrity.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 02796473238b6..3ec963ff3bc19 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -100,7 +100,7 @@ struct ima_template_entry {
 	struct tpm_digest *digests;
 	struct ima_template_desc *template_desc; /* template descriptor */
 	u32 template_data_len;
-	struct ima_field_data template_data[0];	/* template related data */
+	struct ima_field_data template_data[];	/* template related data */
 };
 
 struct ima_queue_entry {
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 298b73794d8b1..16c1894c29bb0 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -107,7 +107,7 @@ struct ima_digest_data {
 		} ng;
 		u8 data[2];
 	} xattr;
-	u8 digest[0];
+	u8 digest[];
 } __packed;
 
 /*
@@ -119,7 +119,7 @@ struct signature_v2_hdr {
 	uint8_t	hash_algo;	/* Digest algorithm [enum hash_algo] */
 	__be32 keyid;		/* IMA key identifier - not X509/PGP specific */
 	__be16 sig_size;	/* signature size */
-	uint8_t sig[0];		/* signature payload */
+	uint8_t sig[];		/* signature payload */
 } __packed;
 
 /* integrity data associated with an inode */
-- 
2.26.2

