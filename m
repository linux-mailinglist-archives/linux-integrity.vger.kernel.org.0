Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3821759148F
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Aug 2022 19:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbiHLRCh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Aug 2022 13:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbiHLRC1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Aug 2022 13:02:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8AAB14EB;
        Fri, 12 Aug 2022 10:02:27 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27CGltZW000624;
        Fri, 12 Aug 2022 17:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=MksrG9shS4R9ubTDGiwGpUBYzkdN1PukPM7LKFfZp/A=;
 b=A+ph0WXrOjpmgoVhdTRIOZNrJs6R9r0UgvBxkp2+4X+dQdrR2nJscxx3AdvsF7nsWlpf
 tRSO8UVBG3mzc916UEvb5YIggklt0eBroEglW2uDhDDSdPE4BwMKQr56Sb3T5OJN5WwK
 CLQrWrhIJsSXDkTbasBTnp8kCJ2oT+3DHreGKQIEF0XhW5Dc31o1eKWbygRQwXe+mnHs
 DouBd/BFP2oGQhaNf6pq4RNSAEw2O0GxB7jl6Q6mPzlRFX15Bj/OW3I/mx3ec1jV46Np
 77KrttRQRShYzU+eqzmLJ4bNsvIlwWn1x8LVHs7bq6Va2JTjkEJDyJI2LBG4DTrs6bEj ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hwtpmgams-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 17:02:11 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27CGnPEZ004751;
        Fri, 12 Aug 2022 17:02:10 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hwtpmg9u5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 17:02:10 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27CGavLH006463;
        Fri, 12 Aug 2022 16:43:12 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 3hvcmrnst2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 16:43:12 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27CGhBOB9634480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 16:43:11 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43E2428059;
        Fri, 12 Aug 2022 16:43:11 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28A962805C;
        Fri, 12 Aug 2022 16:43:11 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 12 Aug 2022 16:43:11 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Rob Herring <robh@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v7 1/6] of: check previous kernel's ima-kexec-buffer against memory bounds
Date:   Fri, 12 Aug 2022 12:43:00 -0400
Message-Id: <20220812164305.2056641-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812164305.2056641-1-stefanb@linux.ibm.com>
References: <20220812164305.2056641-1-stefanb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PP7Srjidomn2goeqfts35Ce6ki0zJQmT
X-Proofpoint-GUID: 8TwUC-nTXIAh3XwJ0_DlM6lWKMTiKwqS
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_10,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 impostorscore=0 suspectscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Vaibhav Jain <vaibhav@linux.ibm.com>

Presently ima_get_kexec_buffer() doesn't check if the previous kernel's
ima-kexec-buffer lies outside the addressable memory range. This can result
in a kernel panic if the new kernel is booted with 'mem=X' arg and the
ima-kexec-buffer was allocated beyond that range by the previous kernel.
The panic is usually of the form below:

$ sudo kexec --initrd initrd vmlinux --append='mem=16G'

<snip>
 BUG: Unable to handle kernel data access on read at 0xc000c01fff7f0000
 Faulting instruction address: 0xc000000000837974
 Oops: Kernel access of bad area, sig: 11 [#1]
<snip>
 NIP [c000000000837974] ima_restore_measurement_list+0x94/0x6c0
 LR [c00000000083b55c] ima_load_kexec_buffer+0xac/0x160
 Call Trace:
 [c00000000371fa80] [c00000000083b55c] ima_load_kexec_buffer+0xac/0x160
 [c00000000371fb00] [c0000000020512c4] ima_init+0x80/0x108
 [c00000000371fb70] [c0000000020514dc] init_ima+0x4c/0x120
 [c00000000371fbf0] [c000000000012240] do_one_initcall+0x60/0x2c0
 [c00000000371fcc0] [c000000002004ad0] kernel_init_freeable+0x344/0x3ec
 [c00000000371fda0] [c0000000000128a4] kernel_init+0x34/0x1b0
 [c00000000371fe10] [c00000000000ce64] ret_from_kernel_thread+0x5c/0x64
 Instruction dump:
 f92100b8 f92100c0 90e10090 910100a0 4182050c 282a0017 3bc00000 40810330
 7c0802a6 fb610198 7c9b2378 f80101d0 <a1240000> 2c090001 40820614 e9240010
 ---[ end trace 0000000000000000 ]---

Fix this issue by checking returned PFN range of previous kernel's
ima-kexec-buffer with page_is_ram() to ensure correct memory bounds.

Fixes: 467d27824920 ("powerpc: ima: get the kexec buffer passed by the previous kernel")
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Prakhar Srivastava <prsriva@linux.microsoft.com>
Cc: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220531041446.3334259-1-vaibhav@linux.ibm.com
---
 drivers/of/kexec.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 8d374cc552be..91b04b04eec4 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -126,6 +126,7 @@ int ima_get_kexec_buffer(void **addr, size_t *size)
 {
 	int ret, len;
 	unsigned long tmp_addr;
+	unsigned long start_pfn, end_pfn;
 	size_t tmp_size;
 	const void *prop;
 
@@ -140,6 +141,22 @@ int ima_get_kexec_buffer(void **addr, size_t *size)
 	if (ret)
 		return ret;
 
+	/* Do some sanity on the returned size for the ima-kexec buffer */
+	if (!tmp_size)
+		return -ENOENT;
+
+	/*
+	 * Calculate the PFNs for the buffer and ensure
+	 * they are with in addressable memory.
+	 */
+	start_pfn = PHYS_PFN(tmp_addr);
+	end_pfn = PHYS_PFN(tmp_addr + tmp_size - 1);
+	if (!page_is_ram(start_pfn) || !page_is_ram(end_pfn)) {
+		pr_warn("IMA buffer at 0x%lx, size = 0x%zx beyond memory\n",
+			tmp_addr, tmp_size);
+		return -EINVAL;
+	}
+
 	*addr = __va(tmp_addr);
 	*size = tmp_size;
 
-- 
2.35.1

