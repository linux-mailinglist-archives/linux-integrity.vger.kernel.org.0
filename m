Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EB454E637
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jun 2022 17:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbiFPPll (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jun 2022 11:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiFPPlk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jun 2022 11:41:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E783B37030;
        Thu, 16 Jun 2022 08:41:39 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GFeMNR028468;
        Thu, 16 Jun 2022 15:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8s+zvtwiO1CS+cnTENaFYIn0D6GAMQ3InBKiqizdwks=;
 b=QSUK8Ph/Cwu9VCwdXoT5VYZaLpycnfmn92q1shdKZs3r8EEuq1s6/2ls+XroxODtO5Ts
 yzALtYxmLt/VckqphHskSVfhiHmr2M0V1VhsQnGNS3XKlBL6txImNNkqNC1oaPlnQ857
 2Nzgcz7SiVWEw0YMI7dYqXKAbwLobQvRYsg+fIAzUtZmBkWyLkQYzt/3W9lNEaLU7Qfv
 BBxYi3DTPTbz7dtbsuZ26RLMprNkdLuQhD63iWQgkZXB0y+ftmrJ4beS0kb+Q1Ffxg2k
 aT8ubA5U/TIfTwx3LsTbNOA9g3dZY/3XI/MqztConXTP22zx11iIuLUyLkJq/m7dT2wz Kg== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gqj4j0c4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 15:41:35 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25GFZOPK012977;
        Thu, 16 Jun 2022 15:41:35 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 3gmjpaba18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 15:41:35 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25GFfXHo45154768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 15:41:33 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20F07AC05B;
        Thu, 16 Jun 2022 15:41:33 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A23BAC05F;
        Thu, 16 Jun 2022 15:41:33 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jun 2022 15:41:32 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     nayna@linux.ibm.com, nasastry@in.ibm.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/3] tpm: Preserve TPM measurement log across kexec
Date:   Thu, 16 Jun 2022 11:41:27 -0400
Message-Id: <20220616154130.2052541-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LSo2FsPlZKT44LYR16aNGIJ6kqQkuQj9
X-Proofpoint-ORIG-GUID: LSo2FsPlZKT44LYR16aNGIJ6kqQkuQj9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-16_12,2022-06-16_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=693 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206160064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The of-tree driver does not currently preserve the IBM vTPM 1.2 and
vTPM 2.0 measurement logs across a kexec. This series fixes this for the
kexec_file_load() syscall using the flattened device tree (fdt) to
carry the measurement log's buffer across kexec.

   Stefan

v2:
 - rearranged patches
 - fixed compilation issues for x86

Stefan Berger (3):
  tpm: of: Move of-tree specific code from tpm driver into of driver
  of: kexec: Refactor IMA buffer related functions to make them reusable
  tpm/kexec: Duplicate TPM measurement log in of-tree for kexec

 drivers/char/tpm/eventlog/of.c |  31 +---
 drivers/of/Makefile            |   2 +-
 drivers/of/device_node.c       |  27 +++
 drivers/of/kexec.c             | 293 +++++++++++++++++++++++++++++----
 include/linux/kexec.h          |   6 +
 include/linux/of.h             |   8 +-
 include/linux/of_device_node.h |   9 +
 kernel/kexec_file.c            |   6 +
 8 files changed, 318 insertions(+), 64 deletions(-)
 create mode 100644 drivers/of/device_node.c
 create mode 100644 include/linux/of_device_node.h

-- 
2.35.1

