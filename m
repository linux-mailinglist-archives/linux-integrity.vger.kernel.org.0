Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681606591A
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 16:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfGKOdd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 10:33:33 -0400
Received: from mx0b-00176a03.pphosted.com ([67.231.157.48]:39512 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728529AbfGKOdd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 10:33:33 -0400
X-Greylist: delayed 7432 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jul 2019 10:33:32 EDT
Received: from pps.filterd (m0048206.ppops.net [127.0.0.1])
        by m0048206.ppops.net-00176a03. (8.16.0.27/8.16.0.27) with SMTP id x6BCTJFI002315
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jul 2019 08:29:40 -0400
From:   "Safford, David (GE Global Research, US)" <david.safford@ge.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>
Subject: [PATCH] tpm_crb - workaround broken ACPI tables
Thread-Topic: [PATCH] tpm_crb - workaround broken ACPI tables
Thread-Index: AdU34krwvcnCVlC5RnKeY3i0fswIjw==
Date:   Thu, 11 Jul 2019 12:29:30 +0000
Message-ID: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcMjEyNDczOTUwXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctODY4NmZlYzAtYTNkNy0xMWU5LThkZmQtYTRjM2YwYjU5OGE2XGFtZS10ZXN0XDg2ODZmZWMxLWEzZDctMTFlOS04ZGZkLWE0YzNmMGI1OThhNmJvZHkudHh0IiBzej0iMjc4OSIgdD0iMTMyMDczMjE3NjkyNzUxMzU3IiBoPSJtMTNCS1BvR1pjSTM1NDEvWUdmZTllY1J6ajA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-originating-ip: [3.159.19.191]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-11_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907110143
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Most x86 desktops and laptops have firmware TPMs which support the
CRB interface. Unfortunately, the linux tpm_crb driver depends on
perfectly correct ACPI tables, and there are a *lot* of systems out
there with broken tpm_crb entries. (Not one of my five tpm_crb
systems works with the existing driver.) While it is good to
encourage vendors to fix their firmware, many refuse ("It works on
Windows"), leaving users in the lurch.

This patch adds a kernel parameter "tpm_crb.force=1" that works
around the problem in every case I have tested so far. Basically
it does two things:
	- it trusts the cmd and resp addresses in the CRB registers
	- it ignores all alleged IO resource conflicts

Both workarounds make sense. If there really were an address conflict,
or if the register values really were wrong, the device would not be
working at all. And testing with this patch has shown that in every
case (so far), the problem has been bogus ACPI entries.

This patch is against the upstream 5.2 kernel.

Signed-off-by: David Safford <david.safford@ge.com>

--- a/drivers/char/tpm/tpm_crb.c	2019-07-07 18:41:56.000000000 -0400
+++ b/drivers/char/tpm/tpm_crb.c	2019-07-10 11:12:37.269766833 -0400
@@ -108,6 +108,12 @@
 	u32 smc_func_id;
 };
 
+static bool force;
+#ifdef CONFIG_X86
+module_param(force, bool, 0444);
+MODULE_PARM_DESC(force, "Force register provided mappings to overcome broken acpi tables");
+#endif
+
 static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
 				unsigned long timeout)
 {
@@ -460,9 +466,12 @@
 	if (start != new_res.start)
 		return (void __iomem *) ERR_PTR(-EINVAL);
 
-	if (!resource_contains(io_res, &new_res))
-		return devm_ioremap_resource(dev, &new_res);
-
+	if (!resource_contains(io_res, &new_res)){
+		if (force)
+			return ioremap(start, size);
+		else
+			return devm_ioremap_resource(dev, &new_res);
+	}
 	return priv->iobase + (new_res.start - io_res->start);
 }
 
@@ -480,6 +489,11 @@
 	if (start + size - 1 <= io_res->end)
 		return size;
 
+	if (force) {
+		dev_err(dev, FW_BUG "ACPI cmd size broken. Using %llX\n", size);
+		return size;
+	}
+
 	dev_err(dev,
 		FW_BUG "ACPI region does not cover the entire command/response buffer. %pr vs %llx %llx\n",
 		io_res, start, size);
@@ -512,8 +526,11 @@
 		dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resource\n");
 		return -EINVAL;
 	}
+	if (force)
+		priv->iobase = ioremap(io_res.start, io_res.end - io_res.start + 1);
+	else
+		priv->iobase = devm_ioremap_resource(dev, &io_res);
 
-	priv->iobase = devm_ioremap_resource(dev, &io_res);
 	if (IS_ERR(priv->iobase))
 		return PTR_ERR(priv->iobase);

