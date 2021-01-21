Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C312FF1F9
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 18:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388618AbhAURbJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Jan 2021 12:31:09 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57656 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388593AbhAURat (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jan 2021 12:30:49 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0502320B6C40;
        Thu, 21 Jan 2021 09:30:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0502320B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1611250209;
        bh=n1S4TbdTz/yn+EbNkKnNYjNg0Ij/jNTpwezyFWx+1Wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAsCtlFB0Ga2tjsVs2efUQkBP05ADsVa3PFbpGHO6NxCZ9d+aeud6uOEVSBOeM0yy
         wlgMATBedMKfgED6W2A9Hn2fuFadHgOjsAdLQqdOQsLGx7l4nAUhK7+tSUsXFhyfUV
         Lqd/AjcKAYmtv/LX0PWPrEw3WUq+ulrfRj7UrN8w=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, sashal@kernel.org,
        tyhicks@linux.microsoft.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] ima: Free IMA measurement buffer after kexec syscall
Date:   Thu, 21 Jan 2021 09:30:03 -0800
Message-Id: <20210121173003.18324-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121173003.18324-1-nramas@linux.microsoft.com>
References: <20210121173003.18324-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA allocates kernel virtual memory to carry forward the measurement
list, from the current kernel to the next kernel on kexec system call,
in ima_add_kexec_buffer() function.  This buffer is not freed before
completing the kexec system call resulting in memory leak.

Add ima_buffer field in "struct kimage" to store the virtual address
of the buffer allocated for the IMA measurement list.
Free the memory allocated for the IMA measurement list in
kimage_file_post_load_cleanup() function.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")
---
 include/linux/kexec.h              | 5 +++++
 kernel/kexec_file.c                | 5 +++++
 security/integrity/ima/ima_kexec.c | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9e93bef52968..5f61389f5f36 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -300,6 +300,11 @@ struct kimage {
 	/* Information for loading purgatory */
 	struct purgatory_info purgatory_info;
 #endif
+
+#ifdef CONFIG_IMA_KEXEC
+	/* Virtual address of IMA measurement buffer for kexec syscall */
+	void *ima_buffer;
+#endif
 };
 
 /* kexec interface functions */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b02086d70492..5c3447cf7ad5 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -166,6 +166,11 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	vfree(pi->sechdrs);
 	pi->sechdrs = NULL;
 
+#ifdef CONFIG_IMA_KEXEC
+	vfree(image->ima_buffer);
+	image->ima_buffer = NULL;
+#endif /* CONFIG_IMA_KEXEC */
+
 	/* See if architecture has anything to cleanup post load */
 	arch_kimage_file_post_load_cleanup(image);
 
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 212145008a01..8eadd0674629 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -130,6 +130,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
+	image->ima_buffer = kexec_buffer;
+
 	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		 kbuf.mem);
 }
-- 
2.30.0

