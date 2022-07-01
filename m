Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868C15628F0
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Jul 2022 04:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiGAC0n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jun 2022 22:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiGAC0d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jun 2022 22:26:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF175C9F4;
        Thu, 30 Jun 2022 19:26:31 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2612GU0d005414;
        Fri, 1 Jul 2022 02:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=un8OMuiPA3R1r/oDc+pBeWqvOsaQ4noOLtguMXqZ0xE=;
 b=gaTMgRZPseYoo8AP7d1lwOr09J+w7N7nvu8nI5hFIemmfnzcCWJ3La42k24bSOm1f7A0
 HdmPB1SJ53zx1ab05jvPnun9eiBpJY5iWEW38SyqZHFzDteLNsdguX9txZWKjGp4Rdjh
 l+HKKBjjLmK3+sq/azNna6HeQ1KjuFUR2Tyen3S4nsKI/Meoeswhd7Wva9tuQN1JDVOF
 qTAqDVqfwRPVsjIxubHsGuHqPUQkiwZsjWCT13gHotiDmES0wL8g7cdBJYbFaQftYQ+I
 8Jkk3lM1E47rKUcfeezpOj2yaQLKQZrITJ7dQ5AoRQbCdaYOZ+N/oXT8MNjQcA3I8dI+ 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1r06g659-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 02:26:16 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2612QF5n008014;
        Fri, 1 Jul 2022 02:26:16 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1r06g650-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 02:26:15 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2612KqqN023448;
        Fri, 1 Jul 2022 02:26:15 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 3gwt0af2ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 02:26:15 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2612QEav46203362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Jul 2022 02:26:14 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E7EB124052;
        Fri,  1 Jul 2022 02:26:14 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63181124054;
        Fri,  1 Jul 2022 02:26:14 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  1 Jul 2022 02:26:14 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v4 4/5] of: kexec: Refactor IMA buffer related functions to make them reusable
Date:   Thu, 30 Jun 2022 22:26:02 -0400
Message-Id: <20220701022603.31076-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220701022603.31076-1-stefanb@linux.ibm.com>
References: <20220701022603.31076-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 145l7ArpsFBKTCbUoOMPH_SX4JDV82wq
X-Proofpoint-GUID: K8O5Kx5Grb0LNoK6feUOvMkfdW9RPRX_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_01,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010003
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Refactor IMA buffer related functions to make them reusable for carrying
TPM logs across kexec.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>

---
v4:
 - Move debug output into setup_buffer()
---
 drivers/of/kexec.c | 131 ++++++++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 55 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index c4f9b6655a2e..0710703acfb0 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -115,48 +115,59 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
 	return 0;
 }
 
-/**
- * ima_get_kexec_buffer - get IMA buffer from the previous kernel
- * @addr:	On successful return, set to point to the buffer contents.
- * @size:	On successful return, set to the buffer size.
- *
- * Return: 0 on success, negative errno on error.
- */
-int ima_get_kexec_buffer(void **addr, size_t *size)
+static int get_kexec_buffer(const char *name, unsigned long *addr, size_t *size)
 {
 	int ret, len;
-	unsigned long tmp_addr;
 	unsigned long start_pfn, end_pfn;
-	size_t tmp_size;
 	const void *prop;
 
-	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
-		return -ENOTSUPP;
-
-	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
+	prop = of_get_property(of_chosen, name, &len);
 	if (!prop)
 		return -ENOENT;
 
-	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
+	ret = do_get_kexec_buffer(prop, len, addr, size);
 	if (ret)
 		return ret;
 
-	/* Do some sanity on the returned size for the ima-kexec buffer */
-	if (!tmp_size)
+	/* Do some sanity on the returned size for the kexec buffer */
+	if (!*size)
 		return -ENOENT;
 
 	/*
 	 * Calculate the PFNs for the buffer and ensure
 	 * they are with in addressable memory.
 	 */
-	start_pfn = PHYS_PFN(tmp_addr);
-	end_pfn = PHYS_PFN(tmp_addr + tmp_size - 1);
+	start_pfn = PHYS_PFN(*addr);
+	end_pfn = PHYS_PFN(*addr + *size - 1);
 	if (!page_is_ram(start_pfn) || !page_is_ram(end_pfn)) {
-		pr_warn("IMA buffer at 0x%lx, size = 0x%zx beyond memory\n",
-			tmp_addr, tmp_size);
+		pr_warn("%s buffer at 0x%lx, size = 0x%zx beyond memory\n",
+			name, *addr, *size);
 		return -EINVAL;
 	}
 
+	return 0;
+}
+
+/**
+ * ima_get_kexec_buffer - get IMA buffer from the previous kernel
+ * @addr:	On successful return, set to point to the buffer contents.
+ * @size:	On successful return, set to the buffer size.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int ima_get_kexec_buffer(void **addr, size_t *size)
+{
+	int ret;
+	unsigned long tmp_addr;
+	size_t tmp_size;
+
+	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
+		return -ENOTSUPP;
+
+	ret = get_kexec_buffer("linux,ima-kexec-buffer", &tmp_addr, &tmp_size);
+	if (ret)
+		return ret;
+
 	*addr = __va(tmp_addr);
 	*size = tmp_size;
 
@@ -191,72 +202,82 @@ int ima_free_kexec_buffer(void)
 	return memblock_phys_free(addr, size);
 }
 
-/**
- * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
- *
- * @fdt: Flattened Device Tree to update
- * @chosen_node: Offset to the chosen node in the device tree
- *
- * The IMA measurement buffer is of no use to a subsequent kernel, so we always
- * remove it from the device tree.
- */
-static void remove_ima_buffer(void *fdt, int chosen_node)
+static int remove_buffer(void *fdt, int chosen_node, const char *name)
 {
 	int ret, len;
 	unsigned long addr;
 	size_t size;
 	const void *prop;
 
-	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
-		return;
-
-	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
+	prop = fdt_getprop(fdt, chosen_node, name, &len);
 	if (!prop)
-		return;
+		return -ENOENT;
 
 	ret = do_get_kexec_buffer(prop, len, &addr, &size);
-	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
+	fdt_delprop(fdt, chosen_node, name);
 	if (ret)
-		return;
+		return ret;
 
 	ret = fdt_find_and_del_mem_rsv(fdt, addr, size);
 	if (!ret)
-		pr_debug("Removed old IMA buffer reservation.\n");
+		pr_debug("Remove old %s buffer reserveration", name);
+	return ret;
 }
 
-#ifdef CONFIG_IMA_KEXEC
 /**
- * setup_ima_buffer - add IMA buffer information to the fdt
- * @image:		kexec image being loaded.
- * @fdt:		Flattened device tree for the next kernel.
- * @chosen_node:	Offset to the chosen node.
+ * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
  *
- * Return: 0 on success, or negative errno on error.
+ * @fdt: Flattened Device Tree to update
+ * @chosen_node: Offset to the chosen node in the device tree
+ *
+ * The IMA measurement buffer is of no use to a subsequent kernel, so we always
+ * remove it from the device tree.
  */
-static int setup_ima_buffer(const struct kimage *image, void *fdt,
-			    int chosen_node)
+static void remove_ima_buffer(void *fdt, int chosen_node)
+{
+	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
+		return;
+
+	remove_buffer(fdt, chosen_node, "linux,ima-kexec-buffer");
+}
+
+#ifdef CONFIG_IMA_KEXEC
+static int setup_buffer(void *fdt, int chosen_node, const char *name,
+			phys_addr_t addr, size_t size)
 {
 	int ret;
 
-	if (!image->ima_buffer_size)
+	if (!size)
 		return 0;
 
 	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
-				       "linux,ima-kexec-buffer",
-				       image->ima_buffer_addr,
-				       image->ima_buffer_size);
+				       name, addr, size);
 	if (ret < 0)
 		return -EINVAL;
 
-	ret = fdt_add_mem_rsv(fdt, image->ima_buffer_addr,
-			      image->ima_buffer_size);
+	ret = fdt_add_mem_rsv(fdt, addr, size);
 	if (ret)
 		return -EINVAL;
 
-	pr_debug("IMA buffer at 0x%pa, size = 0x%zx\n",
-		 &image->ima_buffer_addr, image->ima_buffer_size);
+	pr_debug("%s at 0x%pa, size = 0x%zx\n", name, &addr, size);
 
 	return 0;
+
+}
+
+/**
+ * setup_ima_buffer - add IMA buffer information to the fdt
+ * @image:		kexec image being loaded.
+ * @fdt:		Flattened device tree for the next kernel.
+ * @chosen_node:	Offset to the chosen node.
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+static int setup_ima_buffer(const struct kimage *image, void *fdt,
+			    int chosen_node)
+{
+	return setup_buffer(fdt, chosen_node, "linux,ima-kexec-buffer",
+			    image->ima_buffer_addr, image->ima_buffer_size);
 }
 #else /* CONFIG_IMA_KEXEC */
 static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
-- 
2.35.1

