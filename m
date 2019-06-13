Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D9D43C47
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 17:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfFMPfE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 11:35:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40778 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbfFMKbf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 06:31:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so7967950pla.7
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 03:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zNYSDlioe1/7qDzUymWdeZ+QFAflos+mlnY8eEGg+0o=;
        b=yGqrc+PyiSy4n5qr9NdwCtvk10NU0RuIEZpKtR38SSnXyuNE9KtNc4LOsjqZwwRHrh
         PQjFPkSB3hzxovhRjl67Bjzjq+MyaDq8caifL9XcLBUffnDo6fKiNVZJMaRJqYYrTpLD
         236tIR/c1HHyhBzC+DbYQbzknd6nXkp2yR69CfUSomWNfHZq7zDwLo6CtP6Rcz9jQoyU
         t+UUwCGOlMlfHHdRXEbat32VLMC64YiRRvC+ES6Lwz/POGU5yfdzTRVFTEJkScAUUYU3
         CLOA6wc/os0XTJLHRiURlUUYawm0WGmE6fu8bzeXwSSiF2jgcH82LXA8DmqI9CW5kKWM
         JwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zNYSDlioe1/7qDzUymWdeZ+QFAflos+mlnY8eEGg+0o=;
        b=uF5hLbt9A3i+wQlBUboXUy3aJAOKKB/Fg0CYnye+3RJ0iqDUdMYFT9YMIddtsLH8xK
         d9W4VfC8UFVdRYLF80X525jXxDb6Oe0nzKlf0wegibdwF1TyqsnJ2FsToH66ZBKi5h5V
         D0AJ7LlXSm320p/oVJXQmi8JbSXsPoEgQJQOW33BbqR+1+hoiyp602yyqLhqAaQFu2QL
         eZvR134nyAAo6GvGb0J+Rm1K5JAWbSQEg3DFMzVXgL0PSC+DOSHbem+vcW0cP6O+0+bc
         wYlsYOUUjWRAHvh97kA8O/0/697/sD33NUxo2entVJVn+zobVgo/22PHjU4UfXAp7LKp
         atzQ==
X-Gm-Message-State: APjAAAUjlQwmYwcuNJTWyTDJu68GhAafoHHBObVPyzaTBErslTVx9ZWA
        Me8I+Ksdekt4P4261aNkNoKwbg==
X-Google-Smtp-Source: APXvYqy4QNXOS9+usIQOYreRnBfssjCFTNyHTKoO86Zu6g/HvXHvK12eofupFfZNMLkwbIdNB6kb7A==
X-Received: by 2002:a17:902:1e6:: with SMTP id b93mr43575179plb.295.1560421895353;
        Thu, 13 Jun 2019 03:31:35 -0700 (PDT)
Received: from localhost.localdomain ([117.196.234.139])
        by smtp.gmail.com with ESMTPSA id a12sm2265078pgq.0.2019.06.13.03.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 03:31:34 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC 1/7] tee: optee: allow kernel pages to register as shm
Date:   Thu, 13 Jun 2019 16:00:27 +0530
Message-Id: <1560421833-27414-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Kernel pages are marked as normal type memory only so allow kernel pages
to be registered as shared memory with OP-TEE.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
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

