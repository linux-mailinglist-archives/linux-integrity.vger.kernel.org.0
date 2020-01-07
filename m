Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF087133571
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2020 23:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgAGWEl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jan 2020 17:04:41 -0500
Received: from mga11.intel.com ([192.55.52.93]:40523 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbgAGWEk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jan 2020 17:04:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 14:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,407,1571727600"; 
   d="scan'208";a="217317989"
Received: from tstruk-mobl1.jf.intel.com (HELO [127.0.1.1]) ([10.7.196.67])
  by fmsmga007.fm.intel.com with ESMTP; 07 Jan 2020 14:04:39 -0800
Subject: [PATCH] tpm: handle negative priv->response_len in tpm_common_read
From:   Tadeusz Struk <tadeusz.struk@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     keescook@chromium.org, tadeusz.struk@intel.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-integrity@vger.kernel.org, labbott@redhat.com
Date:   Tue, 07 Jan 2020 14:04:48 -0800
Message-ID: <157843468820.24718.10808226634364669421.stgit@tstruk-mobl1>
In-Reply-To: <b85fa669-d3aa-f6c9-9631-988ae47e392c@redhat.com>
References: <b85fa669-d3aa-f6c9-9631-988ae47e392c@redhat.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The priv->responce_length can hold the size of an response or
an negative error code, and the tpm_common_read() needs to handle
both cases correctly. Changed the type of responce_length to
signed and accounted for negative value in tpm_common_read()

Cc: stable@vger.kernel.org
Fixes: d23d12484307 ("tpm: fix invalid locking in NONBLOCKING mode")
Reported-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
---
 drivers/char/tpm/tpm-dev-common.c |    2 +-
 drivers/char/tpm/tpm-dev.h        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index b23b0b999232..87f449340202 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -130,7 +130,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 		priv->response_read = true;
 
 		ret_size = min_t(ssize_t, size, priv->response_length);
-		if (!ret_size) {
+		if (ret_size <= 0) {
 			priv->response_length = 0;
 			goto out;
 		}
diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
index 1089fc0bb290..f3742bcc73e3 100644
--- a/drivers/char/tpm/tpm-dev.h
+++ b/drivers/char/tpm/tpm-dev.h
@@ -14,7 +14,7 @@ struct file_priv {
 	struct work_struct timeout_work;
 	struct work_struct async_work;
 	wait_queue_head_t async_wait;
-	size_t response_length;
+	ssize_t response_length;
 	bool response_read;
 	bool command_enqueued;
 

