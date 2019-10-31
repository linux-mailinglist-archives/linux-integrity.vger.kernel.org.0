Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74F5EEB1C9
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 14:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfJaN7l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Oct 2019 09:59:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36769 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbfJaN7l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Oct 2019 09:59:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id j22so4125187pgh.3
        for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2019 06:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4N2qK3I0XAixg8Gqykp67y7zePqj/gx/cyRF/j/7A/0=;
        b=Kqyg+WHaKi7N2HGDe3jjbqRjhP0iAIF7fq3SfVbK5PtQpNxwCzGGALgWry/cHUWeIB
         Ed0DVYCEJKhlq01DA5MVDfbQl0R4986RtaS1g/yVbsM7PuC4BXoM/WiZO1VPjDWUG4lm
         VSBPNH0k4olFhH5ZF9miOX0OaLKjUX74UUz2iu73j6DnLHQUK17XJRqdhFmVJYStt7hw
         8ZIQdpp1KLjv2Rg8yCBJJ5dxmRYLFONe8To/Q9lqy5eTES0B2Du52/fuKkzDaXFE0xF5
         KJuqpNPoA5AjOnlVVffpYPzho17l0zkMbMTKWwMDPgOKyrcNZxLJkPHiIl9oBiJSrz6I
         1Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4N2qK3I0XAixg8Gqykp67y7zePqj/gx/cyRF/j/7A/0=;
        b=I1EjdHgTH2/TXgMicGvQhEtE+C7a7a25R98vYaQTcU4CLPuGTHsWvwFzHKyH5pb6Du
         Is6bf+fNJdrFILzI4Q20yIjbqvP1uIIVVdJnXoeWeDeZ9jTS/OAxDS7XZhUauKHnOxx6
         5r9wfuA5vbgir5cfK6sBNBM/eFHipdmSfCf+YPRTf2gLilaQ7Nxy/VAY/9vWMcp7S3YP
         VpgsRRE1o4feu8Gi4wQGH1EsFj5pBp70urWLAKCPxehnXCEBK/sCd8QZd0IhSK5iLxLl
         cY94dBbSzVFsdtjq9Z/jnlSYu1+R05C2vU9yNcOQhtSO5MoApLl/udZwA7LsZbbguQAK
         vOTA==
X-Gm-Message-State: APjAAAWMq3X2fUTCoZjrzqS0urk6WE8J4/mz5ZI4Waqg8S+XcG55dxFQ
        DWTDl3sFIcFxAsP2Jny1zlOP3w==
X-Google-Smtp-Source: APXvYqz+zWH54kS4jRD/vTLg3fa52z3BsIVW3U6c2hQ4Fj1BhwZJZIUhAgMu0evVEV8d+Td5DsY8qw==
X-Received: by 2002:a17:90a:fa02:: with SMTP id cm2mr7816999pjb.129.1572530380071;
        Thu, 31 Oct 2019 06:59:40 -0700 (PDT)
Received: from localhost.localdomain ([117.252.69.143])
        by smtp.gmail.com with ESMTPSA id i16sm3522441pfa.184.2019.10.31.06.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 06:59:39 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org, jarkko.sakkinen@linux.intel.com,
        dhowells@redhat.com
Cc:     corbet@lwn.net, jejb@linux.ibm.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        stuart.yoder@arm.com, janne.karhunen@gmail.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [Patch v3 1/7] tee: optee: allow kernel pages to register as shm
Date:   Thu, 31 Oct 2019 19:28:37 +0530
Message-Id: <1572530323-14802-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
References: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Kernel pages are marked as normal type memory only so allow kernel pages
to be registered as shared memory with OP-TEE.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 13b0269..cf2367b 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -554,6 +554,13 @@ static int check_mem_type(unsigned long start, size_t num_pages)
 	struct mm_struct *mm = current->mm;
 	int rc;
 
+	/*
+	 * Allow kernel address to register with OP-TEE as kernel
+	 * pages are configured as normal memory only.
+	 */
+	if (virt_addr_valid(start))
+		return 0;
+
 	down_read(&mm->mmap_sem);
 	rc = __check_mem_type(find_vma(mm, start),
 			      start + num_pages * PAGE_SIZE);
-- 
2.7.4

