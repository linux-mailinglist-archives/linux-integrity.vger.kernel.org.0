Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126C524A4D1
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 19:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHSRVs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 13:21:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44410 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgHSRVm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 13:21:42 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2F96920B490F;
        Wed, 19 Aug 2020 10:21:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F96920B490F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597857701;
        bh=dyVJPjIPeKuDvPutEebyYsHKnrEeEtP1po8wjqtmprQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=exTof0A5i2tmM9Z/hvphRiahvZ8BQ7eipXw3KtWZDbjQdRNFREyjfke3waK+W0bLy
         qpcUVEqTIx/o9rTGqL9vwXaqIiPyUwx7M4WxoOGtKuGegnzm/tsM5eyTfcdZyJldWr
         EWC53cc8RF4bvONZbEF1EIR9+YJmGnat9FTWN9xI=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prsriva@linux.microsoft.com,
        balajib@linux.microsoft.com
Subject: [PATCH v4 3/5] IMA: Refactor do_get_kexec_buffer() to call of_ functions directly
Date:   Wed, 19 Aug 2020 10:21:32 -0700
Message-Id: <20200819172134.11243-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819172134.11243-1-nramas@linux.microsoft.com>
References: <20200819172134.11243-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

do_get_kexec_buffer() calls another local function get_addr_size_cells()
to get the address and size of the IMA measurement log buffer stored in
the device tree. get_addr_size_cells() is small enough that it can be
merged into do_get_kexec_buffer() and a function call can be avoided.

Refactor do_get_kexec_buffer() to call of_ functions directly instead
of calling get_addr_size_cells() and remove get_addr_size_cells().

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 25d79d521597..283631098b48 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,31 +15,21 @@
 #include <linux/libfdt.h>
 #include "ima.h"
 
-static int get_addr_size_cells(int *addr_cells, int *size_cells)
+static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
+			       size_t *size)
 {
+	int addr_cells, size_cells;
 	struct device_node *root;
 
 	root = of_find_node_by_path("/");
 	if (!root)
 		return -EINVAL;
 
-	*addr_cells = of_n_addr_cells(root);
-	*size_cells = of_n_size_cells(root);
+	addr_cells = of_n_addr_cells(root);
+	size_cells = of_n_size_cells(root);
 
 	of_node_put(root);
 
-	return 0;
-}
-
-static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
-			       size_t *size)
-{
-	int ret, addr_cells, size_cells;
-
-	ret = get_addr_size_cells(&addr_cells, &size_cells);
-	if (ret)
-		return ret;
-
 	if (len < 4 * (addr_cells + size_cells))
 		return -ENOENT;
 
-- 
2.28.0

