Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B9654E639
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jun 2022 17:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiFPPlr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jun 2022 11:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiFPPlr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jun 2022 11:41:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56135377E0;
        Thu, 16 Jun 2022 08:41:46 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GDuODD015233;
        Thu, 16 Jun 2022 15:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jJLW91B7wzmiIM8pkoGBYzEOtxCKb/elmWaiVT1q+2Y=;
 b=E9IszRUG/dA20bvrAg9hbzeg2mpgG3E6qwsXSTo1MlW506slhdeNDqj7Yfqke4uZY/Z0
 PZNP8vEPaD8L+EMaUgg/1MYRRmvnpfYlLfBbGsREfKXPEOj0jmtBKjrfoSq9v8ElHFTt
 G6bPt4vhIGgDtF4dyVfRcX7w0CEKr3ij0IMHbhEHDUjghomofHw6sqJAhx4Bcobqgka8
 /rgwZ1dLdg/9fHatBByv/HmlgOr5OzT7JpAokPCLodoanFykKz6yy1bJkUfAXyYFsc2s
 b071Co0NinWUfGvKO+MMEt5hzLAenZpzkTQBkM/+gAPJ3gNcjRo8ogG7czxecVvrGe+K uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gqhbdjf3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 15:41:36 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25GDCnLR000983;
        Thu, 16 Jun 2022 15:41:36 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gqhbdjf2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 15:41:35 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25GFYwwT031602;
        Thu, 16 Jun 2022 15:41:34 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 3gmjpajsse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 15:41:34 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25GFfXKN44826944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 15:41:33 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56A3AAC05E;
        Thu, 16 Jun 2022 15:41:33 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DDC1AC05F;
        Thu, 16 Jun 2022 15:41:33 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jun 2022 15:41:33 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     nayna@linux.ibm.com, nasastry@in.ibm.com,
        Stefan Berger <stefanb@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v2 2/3] of: kexec: Refactor IMA buffer related functions to make them reusable
Date:   Thu, 16 Jun 2022 11:41:29 -0400
Message-Id: <20220616154130.2052541-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220616154130.2052541-1-stefanb@linux.ibm.com>
References: <20220616154130.2052541-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y7l_IuG22tKqsHKvt61GH9kNX7sPFFI5
X-Proofpoint-GUID: -EZyjqWYBAoc-yVIl_P2Bc8d3utE9WiC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-16_12,2022-06-16_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206160064
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
 drivers/of/kexec.c | 99 +++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 37 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index b9bd1cff1793..601ea9727b0e 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -115,6 +115,18 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
 	return 0;
 }
 
+static int get_kexec_buffer(const char *name, unsigned long *addr, size_t *size)
+{
+	const void *prop;
+	int len;
+
+	prop = of_get_property(of_chosen, name, &len);
+	if (!prop)
+		return -ENOENT;
+
+	return do_get_kexec_buffer(prop, len, addr, size);
+}
+
 /**
  * ima_get_kexec_buffer - get IMA buffer from the previous kernel
  * @addr:	On successful return, set to point to the buffer contents.
@@ -124,19 +136,14 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
  */
 int ima_get_kexec_buffer(void **addr, size_t *size)
 {
-	int ret, len;
+	int ret;
 	unsigned long tmp_addr;
 	size_t tmp_size;
-	const void *prop;
 
 	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
 		return -ENOTSUPP;
 
-	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
-	if (!prop)
-		return -ENOENT;
-
-	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
+	ret = get_kexec_buffer("linux,ima-kexec-buffer", &tmp_addr, &tmp_size);
 	if (ret)
 		return ret;
 
@@ -174,6 +181,28 @@ int ima_free_kexec_buffer(void)
 	return memblock_phys_free(addr, size);
 }
 
+static int remove_buffer(void *fdt, int chosen_node, const char *name)
+{
+	int ret, len;
+	unsigned long addr;
+	size_t size;
+	const void *prop;
+
+	prop = fdt_getprop(fdt, chosen_node, name, &len);
+	if (!prop)
+		return -ENOENT;
+
+	ret = do_get_kexec_buffer(prop, len, &addr, &size);
+	fdt_delprop(fdt, chosen_node, name);
+	if (ret)
+		return ret;
+
+	ret = fdt_find_and_del_mem_rsv(fdt, addr, size);
+	if (!ret)
+		pr_debug("Remove old %s buffer reserveration", name);
+	return ret;
+}
+
 /**
  * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
  *
@@ -185,29 +214,34 @@ int ima_free_kexec_buffer(void)
  */
 static void remove_ima_buffer(void *fdt, int chosen_node)
 {
-	int ret, len;
-	unsigned long addr;
-	size_t size;
-	const void *prop;
-
 	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
 		return;
 
-	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
-	if (!prop)
-		return;
+	remove_buffer(fdt, chosen_node, "linux,ima-kexec-buffer");
+}
 
-	ret = do_get_kexec_buffer(prop, len, &addr, &size);
-	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
+#ifdef CONFIG_IMA_KEXEC
+static int setup_buffer(void *fdt, int chosen_node, const char *name,
+			uint64_t addr, uint64_t size)
+{
+	int ret;
+
+	if (!size)
+		return 0;
+
+	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
+				       name, addr, size);
+	if (ret < 0)
+		return -EINVAL;
+
+	ret = fdt_add_mem_rsv(fdt, addr, size);
 	if (ret)
-		return;
+		return -EINVAL;
+
+	return 0;
 
-	ret = fdt_find_and_del_mem_rsv(fdt, addr, size);
-	if (!ret)
-		pr_debug("Removed old IMA buffer reservation.\n");
 }
 
-#ifdef CONFIG_IMA_KEXEC
 /**
  * setup_ima_buffer - add IMA buffer information to the fdt
  * @image:		kexec image being loaded.
@@ -221,23 +255,14 @@ static int setup_ima_buffer(const struct kimage *image, void *fdt,
 {
 	int ret;
 
-	if (!image->ima_buffer_size)
-		return 0;
-
-	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
-				       "linux,ima-kexec-buffer",
-				       image->ima_buffer_addr,
-				       image->ima_buffer_size);
-	if (ret < 0)
-		return -EINVAL;
-
-	ret = fdt_add_mem_rsv(fdt, image->ima_buffer_addr,
-			      image->ima_buffer_size);
+	ret = setup_buffer(fdt, chosen_node, "linux,ima-kexec-buffer",
+			   image->ima_buffer_addr, image->ima_buffer_size);
 	if (ret)
-		return -EINVAL;
+		return ret;
 
-	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
-		 image->ima_buffer_addr, image->ima_buffer_size);
+	if (image->ima_buffer_addr)
+		pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
+			 image->ima_buffer_addr, image->ima_buffer_size);
 
 	return 0;
 }
-- 
2.35.1

