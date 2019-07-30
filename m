Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1E087A831
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 14:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfG3MYe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 08:24:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32978 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfG3MYe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 08:24:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id f20so20756104pgj.0
        for <linux-integrity@vger.kernel.org>; Tue, 30 Jul 2019 05:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ub4kuUSnrD2CiYyKKwaDCU7WlCc+MjZGT8+i8BhCGSM=;
        b=MfQvx2dhjGV4/bSe60l+LebksrED1y3ZIlrOHn7KEst3uYq0lbZGY0vsMCXlHdvqTW
         Ye8auI8LrPtuk1JjxXNnkdo+hZ+99keG4VGsdhwKAsEXIsOsIUECaXlU8hbVHLFk9cLT
         HO8nBnDu0xGtOjVBUUGFJzgjgr3leWNo194UxYVJeI2Y+0v/K+qeQpXyF0PGeONbMN+i
         gW62oUUDBfxqW/m3zRut5eraL0BhFNM47K2DQzNbSup/f6DVATK2umRIZlAbmj5eTK+g
         Ie2+FR2iyP4pVV9kGjOO0QK2a+lbpVtyMzeY+CEhSSw2QwFdLdH8EHmR5UmLIl/CCH4Z
         mvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ub4kuUSnrD2CiYyKKwaDCU7WlCc+MjZGT8+i8BhCGSM=;
        b=tGj64NW4j3v1Qtn/ERO2IwIuA7H6NAAgMAf9iCbh7dkGdhofcBagiUUiAXms0cTMrT
         LFoQMMZSh7yXTf3NMlWb7tNH8haMJRteuvfa6QhSVQt4pUtuC/4zamnzdJPdPKtOs2l6
         76RpIN7Ec4tLSOmSL8uMrYybbCIwHo7cGnJ2x5HSxj46DdDP0IoyURh/3ELBu4k0pH2h
         ZXGxVbMrFPYDncJYocyKGWlE00hRuVip+KqvDTtYyAyv1myiJ/LtRrMlI8M6nPKwyUuz
         e2zrGRMcD0FetQlPBikfij/Dnbqp69lyhAcHqqOAgeXAGCvFCYpCy5ULkE2JeWYbjTBZ
         /8UA==
X-Gm-Message-State: APjAAAWdMYlq6CPPC9SsJkihMupNNKvGrIw2ZLIWN1r0psCsawEgDG1V
        Cb29EthAoqIpBnY+F4VGTFYtrA==
X-Google-Smtp-Source: APXvYqy9AOsI/bgpSrYC4bB6dRW/RMjRTTrIQ53nsJNjfy9Y+arPAlgz9XGruaRKwy6MTunT2Iwvvg==
X-Received: by 2002:a63:125c:: with SMTP id 28mr55618644pgs.255.1564489473744;
        Tue, 30 Jul 2019 05:24:33 -0700 (PDT)
Received: from localhost.localdomain ([45.114.72.197])
        by smtp.gmail.com with ESMTPSA id v8sm54895462pgs.82.2019.07.30.05.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jul 2019 05:24:33 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, ard.biesheuvel@linaro.org,
        daniel.thompson@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC v2 1/6] tee: optee: allow kernel pages to register as shm
Date:   Tue, 30 Jul 2019 17:53:35 +0530
Message-Id: <1564489420-677-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
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
index aa94270..bce45b1 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -553,6 +553,13 @@ static int check_mem_type(unsigned long start, size_t num_pages)
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

