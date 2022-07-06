Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC0568C97
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Jul 2022 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiGFPXv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Jul 2022 11:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiGFPXu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Jul 2022 11:23:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F4317E03;
        Wed,  6 Jul 2022 08:23:49 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266EkiWG037165;
        Wed, 6 Jul 2022 15:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=k4rfDl5sjXMkFxZKUuEqZdOSLHex7NUKzrZWhtsr1fw=;
 b=VzvQkGB38EF8YoX6X/BVeRx5RwDJ68FHMJnLYVZluWOE881JZ0wskRRB4HxH+pFsuMyK
 CoRBR6wa0wiYKvIoVd3OeUSi45KRrlJJP4r5klK67LdLVuHFUkzT0jS8L3+Jb0MX0nYz
 Y7vYcjdxgHz/UmX3bSIrLaq9zngkpGlW+LQ/59OMOIvwtC75CG3V8Soitt2ydjW+eIjI
 fntD0DEXGLCKAugOhmydjjuqXmo9kKHTfnQKOLFvZj15aRVSLj/ZhbI8kB6GI0Pd45Uv
 Z3/JT0wfwCWPC8rA1XL8jAnKLSlq0OMVAIY7R9Knh1SC4EOzF4cRGhpfdhcthTSzRSTc rA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5cf3s3bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 15:23:40 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 266FL6Je020776;
        Wed, 6 Jul 2022 15:23:39 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02wdc.us.ibm.com with ESMTP id 3h4ucxn8a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 15:23:39 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 266FNc6x31785430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jul 2022 15:23:38 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F372112062;
        Wed,  6 Jul 2022 15:23:38 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66476112065;
        Wed,  6 Jul 2022 15:23:38 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  6 Jul 2022 15:23:38 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Rob Herring <robh@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v5 2/6] drivers: of: kexec ima: Support 32-bit platforms
Date:   Wed,  6 Jul 2022 11:23:25 -0400
Message-Id: <20220706152329.665636-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220706152329.665636-1-stefanb@linux.ibm.com>
References: <20220706152329.665636-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VSz_nYx-t_FEe69XdWOfMqK7WC093iBg
X-Proofpoint-ORIG-GUID: VSz_nYx-t_FEe69XdWOfMqK7WC093iBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207060060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

RISC-V recently added kexec_file() support, which uses enables kexec
IMA.  We're the first 32-bit platform to support this, so we found a
build bug.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 drivers/of/kexec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 91b04b04eec4..c4f9b6655a2e 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -253,8 +253,8 @@ static int setup_ima_buffer(const struct kimage *image, void *fdt,
 	if (ret)
 		return -EINVAL;
 
-	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
-		 image->ima_buffer_addr, image->ima_buffer_size);
+	pr_debug("IMA buffer at 0x%pa, size = 0x%zx\n",
+		 &image->ima_buffer_addr, image->ima_buffer_size);
 
 	return 0;
 }
-- 
2.35.1

