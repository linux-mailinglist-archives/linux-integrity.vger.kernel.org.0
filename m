Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317FB1E6919
	for <lists+linux-integrity@lfdr.de>; Thu, 28 May 2020 20:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405716AbgE1SLm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 May 2020 14:11:42 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38720 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405670AbgE1SLB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 May 2020 14:11:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B35758EE10F;
        Thu, 28 May 2020 11:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1590689459;
        bh=DeRSgg7D0rBwpdN4/Gc8/QVVAyN6anYXIb3+cXQ7RKk=;
        h=Subject:From:To:Cc:Date:From;
        b=e55gR+Aq4ywanWk9+djnF6EYDJ89374p4Xqz2ailj1STX80jQYOSpKmIBoVvueoki
         IEynOAu9qn+V0TwNDe9h2h38kQbmCL8fLdMZjrKWr1FDm0XJZKpw8jrbc4DydPnGyN
         lzeUf6NhcI7CGc2cnGumjseZwvW95nMTjBGEeX2A=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d8eMtATCBdww; Thu, 28 May 2020 11:10:59 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4948C8EE0F8;
        Thu, 28 May 2020 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1590689458;
        bh=DeRSgg7D0rBwpdN4/Gc8/QVVAyN6anYXIb3+cXQ7RKk=;
        h=Subject:From:To:Cc:Date:From;
        b=Bg8U9DBmD4aASySEFSyMtJIUQTJn2XuNRLxmZhZMIfmWbgqNhEsQbl54CIFxG9J8C
         F6GsICG+FFBsFs99awuUI66Ctw1XnfoI72ubJVCK66Er4jPWa9bAqYlKs8Zv1+0dAz
         yoiQy5YBLjnWmGgrfxqQtkxm0N8m5yHcQ6ppWaAQ=
Message-ID: <1590689457.3449.7.camel@HansenPartnership.com>
Subject: [PATCH v2] tpm: fix TIS locality timeout problems
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Alex Guzman <alex@guzman.io>
Date:   Thu, 28 May 2020 11:10:57 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

It has been reported that some TIS based TPMs are giving unexpected
errors when using the O_NONBLOCK path of the TPM device. The problem
is that some TPMs don't like it when you get and then relinquish a
locality (as the tpm_try_get_ops()/tpm_put_ops() pair does) without
sending a command.  This currently happens all the time in the
O_NONBLOCK write path. Fix this by moving the tpm_try_get_ops()
further down the code to after the O_NONBLOCK determination is made.
This is safe because the priv->buffer_mutex still protects the priv
state being modified.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206275
Fixes: d23d12484307 ("tpm: fix invalid locking in NONBLOCKING mode")
Reported-by: Mario Limonciello <Mario.Limonciello@dell.com>
Tested-by: Alex Guzman <alex@guzman.io>
Cc: stable@vger.kernel.org
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-dev-common.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 87f449340202..1784530b8387 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -189,15 +189,6 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 		goto out;
 	}
 
-	/* atomic tpm command send and result receive. We only hold the ops
-	 * lock during this period so that the tpm can be unregistered even if
-	 * the char dev is held open.
-	 */
-	if (tpm_try_get_ops(priv->chip)) {
-		ret = -EPIPE;
-		goto out;
-	}
-
 	priv->response_length = 0;
 	priv->response_read = false;
 	*off = 0;
@@ -211,11 +202,19 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	if (file->f_flags & O_NONBLOCK) {
 		priv->command_enqueued = true;
 		queue_work(tpm_dev_wq, &priv->async_work);
-		tpm_put_ops(priv->chip);
 		mutex_unlock(&priv->buffer_mutex);
 		return size;
 	}
 
+	/* atomic tpm command send and result receive. We only hold the ops
+	 * lock during this period so that the tpm can be unregistered even if
+	 * the char dev is held open.
+	 */
+	if (tpm_try_get_ops(priv->chip)) {
+		ret = -EPIPE;
+		goto out;
+	}
+
 	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
 			       sizeof(priv->data_buffer));
 	tpm_put_ops(priv->chip);
-- 
2.26.2

