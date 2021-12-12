Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BE7471798
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Dec 2021 02:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhLLB2Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 20:28:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230038AbhLLB2P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 20:28:15 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BC0vaQe022711;
        Sun, 12 Dec 2021 01:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=YZDQ1dVmJSObr2QC5ds1YJSFNcrnTSy0Dpv1KV7by7M=;
 b=NzNAwTGfeotavIYcra89xn1xTyNs23Pyt2HBdTIgWdV7B7ao1UvZmpl+UjdiVukBfdUH
 eiAVRmA1WB9o3od30Yjx0OwY+U2wkAcBS2c/dlSt8UfDFKGq18zSoFh6D84pzVPAV1yy
 gCz0c6izzq7oUAKF2foyH+WJg5g/Gb7csoyL1RxEXm51Da83nEGYT/2tLYm5Zc/tRTV6
 BX6kQHWYeZMXbrnNjHbRFq33BWeeIumyx+qttn4OLLLF5OJdZiziXRvtEbQhHhFmg4cp
 pxaZVB8Cbe+A0qZvCLLTR+mhM7miVG2IVA6yxoW3Das3vx/+kSlYvjTFhnjj3GeDOfJ8 zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cw70f89rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Dec 2021 01:28:10 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BC1S96w018427;
        Sun, 12 Dec 2021 01:28:09 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cw70f89rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Dec 2021 01:28:09 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BC1J37h030766;
        Sun, 12 Dec 2021 01:28:08 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 3cvkm91xkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Dec 2021 01:28:08 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BC1S6qa11338076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Dec 2021 01:28:06 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0EF912405C;
        Sun, 12 Dec 2021 01:28:05 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7600124054;
        Sun, 12 Dec 2021 01:28:05 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 12 Dec 2021 01:28:05 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jarkko@kernel.org, peterhuewe@gmx.de,
        linux-integrity@vger.kernel.org
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, pavrampu@in.ibm.com,
        Korrapati.Likhitha@ibm.com, gcwilson@us.ibm.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] tpm: Fix kexec crash due to access to ops NULL pointer (powerpc)
Date:   Sat, 11 Dec 2021 20:28:04 -0500
Message-Id: <20211212012804.1555661-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GxgV9UOK6OpX3GkMwldcJNfNFy16amgT
X-Proofpoint-GUID: Wc47lRA6TO1_spWYa5gsKtc-wxTsIIDq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-11_10,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=782 clxscore=1011
 suspectscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112120004
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fix the following crash on kexec by checking chip->ops for a NULL pointer
in tpm_chip_start() and returning an error code if this is the case.

BUG: Kernel NULL pointer dereference on read at 0x00000060
Faulting instruction address: 0xc00000000099a06c
Oops: Kernel access of bad area, sig: 11 [#1]
...
NIP [c00000000099a06c] tpm_chip_start+0x2c/0x140
 LR [c00000000099a808] tpm_chip_unregister+0x108/0x170
Call Trace:
[c0000000188bfa00] [c000000002b03930] fw_devlink_strict+0x0/0x8 (unreliable)
[c0000000188bfa30] [c00000000099a808] tpm_chip_unregister+0x108/0x170
[c0000000188bfa70] [c0000000009a3874] tpm_ibmvtpm_remove+0x34/0x130
[c0000000188bfae0] [c000000000110dbc] vio_bus_remove+0x5c/0xb0
[c0000000188bfb20] [c0000000009bc154] device_shutdown+0x1d4/0x3a8
[c0000000188bfbc0] [c000000000196e14] kernel_restart_prepare+0x54/0x70

The referenced patch below introduced a function to shut down the VIO bus.
The bus shutdown now calls tpm_del_char_device (via tpm_chip_unregister)
after a call to tpm_class_shutdown, which already set chip->ops to NULL.
The crash occurrs when tpm_del_char_device calls tpm_chip_start with the
chip->ops NULL pointer.

Fixes: 39d0099f9439 ("powerpc/pseries: Add shutdown() to vio_driver and vio_bus")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/tpm-chip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index ddaeceb7e109..cca1bde296ee 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -101,6 +101,9 @@ int tpm_chip_start(struct tpm_chip *chip)
 {
 	int ret;
 
+	if (!chip->ops)
+		return -EINVAL;
+
 	tpm_clk_enable(chip);
 
 	if (chip->locality == -1) {
-- 
2.31.1

