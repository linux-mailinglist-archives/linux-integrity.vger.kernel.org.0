Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D501E2A1C
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2020 20:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgEZSck (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 May 2020 14:32:40 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:59250 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728113AbgEZScj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 May 2020 14:32:39 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QIHLl9015082;
        Tue, 26 May 2020 14:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=Te1mkX2H/rmHg2h5LVQwpFbnaZ6Tap4l+WBfe+VOlyA=;
 b=LzYeHHKN0Mf1v4FQvfLjOtOm4bDmU0+teOYFx80of3tQF84Gh572LLiuLSHRdiLhhUOs
 io5GY0JnsmHxhPpoB7z0ourkFahDrSpPnUeSSl7K5RzknPwRUAC8wCC7AFIF7i7CAlC8
 2wcQ4/JPX+anBjJnNLyRhovZDOU/4lSMMMw587Ij6NsmSLEdGzLYS3UnmlQarWtKQXWp
 InxRPpxbFvsCN/onJMo2K3OSPU3S6vlMc2ylAFAq2q+92McsRjOcVPOoS26KY/kIwBbX
 axcrpdKOslFn7WHOG4TllDq2rGbKc75agIOdhvaX2Wts0+LKBrVjbUMaumydJ+U0p5pB fQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 316vwurke8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 14:32:38 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QIEXuZ016883;
        Tue, 26 May 2020 14:32:38 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0b-00154901.pphosted.com with ESMTP id 3194yekm4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 May 2020 14:32:38 -0400
X-LoopCount0: from 10.173.37.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="552834903"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Alex Guzman <alex@guzman.io>
Subject: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING mode"
Date:   Tue, 26 May 2020 13:32:13 -0500
Message-Id: <20200526183213.20720-1-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 cotscore=-2147483648 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 clxscore=1011 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260142
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260142
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This reverts commit d23d12484307b40eea549b8a858f5fffad913897.

This commit has caused regressions for the XPS 9560 containing
a Nuvoton TPM.

As mentioned by the reporter all TPM2 commands are failing with:
  ERROR:tcti:src/tss2-tcti/tcti-device.c:290:tcti_device_receive()
  Failed to read response from fd 3, got errno 1: Operation not permitted

The reporter bisected this issue back to this commit which was
backported to stable as commit 4d6ebc4.

Cc: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206275
Fixes: d23d124 ("tpm: fix invalid locking in NONBLOCKING mode")
Reported-by: Alex Guzman <alex@guzman.io>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/char/tpm/tpm-dev-common.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 87f449340202..bc9d7c7ddc01 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -61,12 +61,6 @@ static void tpm_dev_async_work(struct work_struct *work)
 
 	mutex_lock(&priv->buffer_mutex);
 	priv->command_enqueued = false;
-	ret = tpm_try_get_ops(priv->chip);
-	if (ret) {
-		priv->response_length = ret;
-		goto out;
-	}
-
 	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
 			       sizeof(priv->data_buffer));
 	tpm_put_ops(priv->chip);
@@ -74,7 +68,6 @@ static void tpm_dev_async_work(struct work_struct *work)
 		priv->response_length = ret;
 		mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
 	}
-out:
 	mutex_unlock(&priv->buffer_mutex);
 	wake_up_interruptible(&priv->async_wait);
 }
@@ -211,7 +204,6 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	if (file->f_flags & O_NONBLOCK) {
 		priv->command_enqueued = true;
 		queue_work(tpm_dev_wq, &priv->async_work);
-		tpm_put_ops(priv->chip);
 		mutex_unlock(&priv->buffer_mutex);
 		return size;
 	}
-- 
2.25.1

