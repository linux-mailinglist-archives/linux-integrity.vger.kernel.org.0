Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1497827CCE
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2019 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfEWM0a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 May 2019 08:26:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40863 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbfEWM03 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 May 2019 08:26:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id f10so6071086wre.7
        for <linux-integrity@vger.kernel.org>; Thu, 23 May 2019 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0lnI7olnWLTJI406nqwOkxPmMeIoPRysDaC8oF4GBZs=;
        b=M1mzSJdQUCnNpbcBiXfzoeWyEnlLoudQ7CvsO6nmpa5RsgqNXI2w2m+tPfkNcbsJdt
         u7FycqCXHrdg3iS3+hzYuvIgcDZLYtQLq3pI5ScdSx3mA/bPsfMTJVq8eUmty/ekOoB1
         lt1X0KBKksZd/U+S/uqvhMLHEZjlOzXdLgJolZNgGgkUSuHFCV/9G3PtEfI8+ptXR9PG
         a83IWLrBhdm8C43YF2vTFJhYb7ZCe+PXSXKAXI1dLC5xeeZu7ciXSRXJHzC3zaR+zY26
         xqluormcnfpF3zBELcJLG2P/X/Y+9xtnB0ksiFhwlyg9eGyd3wvon2relMJF9ALJu980
         p6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lnI7olnWLTJI406nqwOkxPmMeIoPRysDaC8oF4GBZs=;
        b=B0AmNZTrSQfd2Nnl9T5ZEw3/TvqN2SztLZNYBZbdkGO/DIG1ws0H6IbUbRQnipRAbR
         zDyjORV9kvrAU7L+vf1TuSR7wJOYbefPp6IBn5yXWeDQUORNMhsBpIOiH9Dpn1oFTWcj
         B/8k6iMY+5G8IziVMxBpnCtA7b2MjfTiKsdM/dw9ocDsgKlULrb+2UGsNdpRbwnTqlYX
         fYzIDF3WhkhP4DYH8uQfNnssZm95cKHefL7i7V9QI78WRZSgt3iHSqC+NK+8vdGOluJf
         0+UfM8aafCeBh2TNoCg1LPobJMR6/ZyrvZTaXKhLehkEVFyqOcr/5mS9QM3YWyNhfdbA
         001Q==
X-Gm-Message-State: APjAAAX6GCKiiR/QJeS8K19NQHFS+2i49V8bwN1MgCaBmH+/a324p3+H
        2oe4kDQf/vznvJs4x2+0x2FDI+D9
X-Google-Smtp-Source: APXvYqx+BIq95D84NObJoHwjdq4B+l/qZBYs9du9y/PUtzZyeAfseHvkg1LNGkr9aZguMw7alC3oOw==
X-Received: by 2002:adf:e3c4:: with SMTP id k4mr5253061wrm.186.1558614387741;
        Thu, 23 May 2019 05:26:27 -0700 (PDT)
Received: from lothlann.rup.mentorg.com (nat-min.mentorg.com. [139.181.32.34])
        by smtp.gmail.com with ESMTPSA id x187sm11101360wmg.11.2019.05.23.05.26.26
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:26:26 -0700 (PDT)
From:   Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To:     linux-integrity@vger.kernel.org
Subject: [PATCH 3/4] ima-evm-utils: include hash-info.gen into distribution
Date:   Thu, 23 May 2019 15:26:22 +0300
Message-Id: <20190523122623.25684-3-dbaryshkov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523122623.25684-1-dbaryshkov@gmail.com>
References: <20190523122623.25684-1-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Include hash-info.gen into tarball and call it from the sourcedir to fix
out-of-tree build (and thus 'make distcheck').

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 src/Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index 164e7e4af020..9c037e21dc4f 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -11,8 +11,9 @@ include_HEADERS = imaevm.h
 
 nodist_libimaevm_la_SOURCES = hash_info.h
 BUILT_SOURCES = hash_info.h
+EXTRA_DIST = hash_info.gen
 hash_info.h: Makefile
-	./hash_info.gen $(KERNEL_HEADERS) >$@
+	$(srcdir)/hash_info.gen $(KERNEL_HEADERS) >$@
 
 bin_PROGRAMS = evmctl
 
-- 
2.20.1

