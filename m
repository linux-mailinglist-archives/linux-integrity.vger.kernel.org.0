Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D895330FA44
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Feb 2021 18:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbhBDRvn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Feb 2021 12:51:43 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33212 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238448AbhBDRug (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Feb 2021 12:50:36 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3D09C20B4909;
        Thu,  4 Feb 2021 09:49:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D09C20B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612460996;
        bh=KUCGfm0H9n8b95EVGaq5LMGcYpvnfVl5v/tIYYMwNjg=;
        h=From:To:Cc:Subject:Date:From;
        b=jz5iZmzTYbSZ/YJrRFGiPf9/9dbFZ+BL8LP+XJe2TtW1zQUWkvUzGv7npg2yBbYiZ
         kKmYv44sl1fJpCwO9niFUvE3eW0do2vFCIun9USWQJgRlCQiMKRs/TKc1fYqnNZJD3
         vioOZ5aNLB8YMY6LbUpvWbfb/yoUu6bkhYFZAvaM=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, sashal@kernel.org,
        tyhicks@linux.microsoft.com
Cc:     linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ima: Free IMA measurement buffer on error
Date:   Thu,  4 Feb 2021 09:49:50 -0800
Message-Id: <20210204174951.25771-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA allocates kernel virtual memory to carry forward the measurement
list, from the current kernel to the next kernel on kexec system call,
in ima_add_kexec_buffer() function.  In error code paths this memory
is not freed resulting in memory leak.

Free the memory allocated for the IMA measurement list in
the error code paths in ima_add_kexec_buffer() function.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")
---
 security/integrity/ima/ima_kexec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 121de3e04af2..206ddcaa5c67 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -119,6 +119,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
 		pr_err("Error passing over kexec measurement buffer.\n");
+		vfree(kexec_buffer);
 		return;
 	}
 
-- 
2.30.0

