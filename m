Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA45A11D47B
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 18:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfLLRsq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 12:48:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:42295 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbfLLRsp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 12:48:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 09:48:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="414006006"
Received: from tstruk-mobl1.jf.intel.com (HELO [127.0.1.1]) ([10.7.196.67])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2019 09:48:44 -0800
Subject: [PATCH =v2 1/3] tpm: fix invalid locking in NONBLOCKING mode
From:   Tadeusz Struk <tadeusz.struk@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     tadeusz.struk@intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, jgg@ziepe.ca, mingo@redhat.com,
        jeffrin@rajagiritech.edu.in, linux-integrity@vger.kernel.org,
        will@kernel.org, peterhuewe@gmx.de
Date:   Thu, 12 Dec 2019 09:48:47 -0800
Message-ID: <157617292787.8172.9586296287013438621.stgit@tstruk-mobl1>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When an application sends TPM commands in NONBLOCKING mode
the driver holds chip->tpm_mutex returning from write(),
which triggers: "WARNING: lock held when returning to user space".
To fix this issue the driver needs to release the mutex before
returning and acquire it again in tpm_dev_async_work() before
sending the command.

Cc: stable@vger.kernel.org
Fixes: 9e1b74a63f776 (tpm: add support for nonblocking operation)
Reported-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
Changes in v2:
- Updated commit message as requested
- Add the fix and test updates to the same series
---
 drivers/char/tpm/tpm-dev-common.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 2ec47a69a2a6..b23b0b999232 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -61,6 +61,12 @@ static void tpm_dev_async_work(struct work_struct *work)
 
 	mutex_lock(&priv->buffer_mutex);
 	priv->command_enqueued = false;
+	ret = tpm_try_get_ops(priv->chip);
+	if (ret) {
+		priv->response_length = ret;
+		goto out;
+	}
+
 	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
 			       sizeof(priv->data_buffer));
 	tpm_put_ops(priv->chip);
@@ -68,6 +74,7 @@ static void tpm_dev_async_work(struct work_struct *work)
 		priv->response_length = ret;
 		mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
 	}
+out:
 	mutex_unlock(&priv->buffer_mutex);
 	wake_up_interruptible(&priv->async_wait);
 }
@@ -204,6 +211,7 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	if (file->f_flags & O_NONBLOCK) {
 		priv->command_enqueued = true;
 		queue_work(tpm_dev_wq, &priv->async_work);
+		tpm_put_ops(priv->chip);
 		mutex_unlock(&priv->buffer_mutex);
 		return size;
 	}

