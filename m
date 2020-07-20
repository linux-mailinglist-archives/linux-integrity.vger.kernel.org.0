Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217A222633E
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 17:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgGTPYL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 11:24:11 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47730 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgGTPX4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 11:23:56 -0400
Received: from prsriva-linux.hsd1.wa.comcast.net (c-24-19-135-168.hsd1.wa.comcast.net [24.19.135.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id 524B820B490D;
        Mon, 20 Jul 2020 08:23:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 524B820B490D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595258636;
        bh=asT4nGwMz6U6W8sA54vi23OF8OW0nPD++mURmO//m58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+GC1srpp/bzQrPV6KZeX3cvi3EjvRF00t6uql8sVg912lahoL13TXLYg/tilKPsb
         aBT84XHH8KEERZti7nygmSPGpqNAW6I20bhnN+ktzemgnF4rpD44tfgBR3AxyTDH2F
         X/VzPq7d1l9PGyZTK/ytjtCMO0OGxXXPJZrYjP3Y=
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, robh+dt@kernel.org,
        frowand.list@gmail.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, masahiroy@kernel.org, james.morse@arm.com,
        bhsharma@redhat.com, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        gregkh@linuxfoundation.org, nramas@linux.microsoft.com,
        prsriva@linux.microsoft.com, tusharsu@linux.microsoft.com,
        balajib@linux.microsoft.com, bauerman@linux.ibm.com,
        robh@kernel.org
Subject: [PATCH V3 3/6] Update function do_get_kexec_buffer to use of_* functions, and reducing wrapper functions.
Date:   Mon, 20 Jul 2020 08:23:39 -0700
Message-Id: <20200720152342.337990-4-prsriva@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720152342.337990-1-prsriva@linux.microsoft.com>
References: <20200720152342.337990-1-prsriva@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 2fe2d3bf7bda..e47982e9bb67 100644
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
2.25.1

