Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1D063E760
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Dec 2022 02:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiLAB56 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Nov 2022 20:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLAB55 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Nov 2022 20:57:57 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE92C2AC64;
        Wed, 30 Nov 2022 17:57:55 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NMzjt3DR8z8RV65;
        Thu,  1 Dec 2022 09:57:54 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B11vmaI032400;
        Thu, 1 Dec 2022 09:57:48 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 1 Dec 2022 09:57:49 +0800 (CST)
Date:   Thu, 1 Dec 2022 09:57:49 +0800 (CST)
X-Zmail-TransId: 2af963880a1dfffffffff1d971cf
X-Mailer: Zmail v1.0
Message-ID: <202212010957494197139@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jarkko@kernel.org>
Cc:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB0cG0vcHBpOiB1c2Ugc3lzZnNfZW1pdCgpIHRvIGluc3RlYWQgb2Ygc2NucHJpbnRmKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B11vmaI032400
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63880A22.000 by FangMail milter!
X-FangMail-Envelope: 1669859874/4NMzjt3DR8z8RV65/63880A22.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63880A22.000/4NMzjt3DR8z8RV65
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/char/tpm/tpm_ppi.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index bc7b1b4501b3..aa86a6f25120 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -52,7 +52,7 @@ static ssize_t tpm_show_ppi_version(struct device *dev,
 {
 	struct tpm_chip *chip = to_tpm_chip(dev);

-	return scnprintf(buf, PAGE_SIZE, "%s\n", chip->ppi_version);
+	return sysfs_emit(buf, "%s\n", chip->ppi_version);
 }

 static ssize_t tpm_show_ppi_request(struct device *dev,
@@ -87,11 +87,11 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
 		else {
 			req = obj->package.elements[1].integer.value;
 			if (tpm_ppi_req_has_parameter(req))
-				size = scnprintf(buf, PAGE_SIZE,
+				size = sysfs_emit(buf,
 				    "%llu %llu\n", req,
 				    obj->package.elements[2].integer.value);
 			else
-				size = scnprintf(buf, PAGE_SIZE,
+				size = sysfs_emit(buf,
 						"%llu\n", req);
 		}
 	} else if (obj->package.count == 2 &&
@@ -100,7 +100,7 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
 		if (obj->package.elements[0].integer.value)
 			size = -EFAULT;
 		else
-			size = scnprintf(buf, PAGE_SIZE, "%llu\n",
+			size = sysfs_emit(buf, "%llu\n",
 				 obj->package.elements[1].integer.value);
 	}

@@ -211,9 +211,9 @@ static ssize_t tpm_show_ppi_transition_action(struct device *dev,
 	}

 	if (ret < ARRAY_SIZE(info) - 1)
-		status = scnprintf(buf, PAGE_SIZE, "%d: %s\n", ret, info[ret]);
+		status = sysfs_emit(buf, "%d: %s\n", ret, info[ret]);
 	else
-		status = scnprintf(buf, PAGE_SIZE, "%d: %s\n", ret,
+		status = sysfs_emit(buf, "%d: %s\n", ret,
 				   info[ARRAY_SIZE(info)-1]);
 	return status;
 }
@@ -255,22 +255,22 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
 	res = ret_obj[2].integer.value;
 	if (req) {
 		if (res == 0)
-			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
+			status = sysfs_emit(buf, "%llu %s\n", req,
 					   "0: Success");
 		else if (res == 0xFFFFFFF0)
-			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
+			status = sysfs_emit(buf, "%llu %s\n", req,
 					   "0xFFFFFFF0: User Abort");
 		else if (res == 0xFFFFFFF1)
-			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
+			status = sysfs_emit(buf, "%llu %s\n", req,
 					   "0xFFFFFFF1: BIOS Failure");
 		else if (res >= 1 && res <= 0x00000FFF)
-			status = scnprintf(buf, PAGE_SIZE, "%llu %llu: %s\n",
+			status = sysfs_emit(buf, "%llu %llu: %s\n",
 					   req, res, "Corresponding TPM error");
 		else
-			status = scnprintf(buf, PAGE_SIZE, "%llu %llu: %s\n",
+			status = sysfs_emit(buf, "%llu %llu: %s\n",
 					   req, res, "Error");
 	} else {
-		status = scnprintf(buf, PAGE_SIZE, "%llu: %s\n",
+		status = sysfs_emit(buf, "%llu: %s\n",
 				   req, "No Recent Request");
 	}

@@ -314,7 +314,7 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
 		}

 		if (ret > 0 && ret < ARRAY_SIZE(info))
-			str += scnprintf(str, PAGE_SIZE, "%d %d: %s\n",
+			str += sysfs_emit(str, "%d %d: %s\n",
 					 i, ret, info[ret]);
 	}

-- 
2.25.1
