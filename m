Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE7D27CCF
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2019 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfEWM0b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 May 2019 08:26:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53306 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730763AbfEWM0b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 May 2019 08:26:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id 198so5625473wme.3
        for <linux-integrity@vger.kernel.org>; Thu, 23 May 2019 05:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wJhOC6XYSvC72mjtdo2m14FIys0tmRE1yj3cbqZcm2o=;
        b=anVpX8+6zLyJ8XF6AyoLWxhFMgN2tuoI7cpLtM3nDVWSdSrRJ+4kBhIgcxxsC1x2eQ
         +4YjPXyJhvjG6bxylOJ8cLLqitxeD668cZnpwgJSjkJ/01cQOIzZ+Cdr/fOCeveQHs4h
         F3Qb5cm1yKJCGTaOha4k76rGbXPwav7bFgWynqIZse1V/2hPGLmDeGiAU3XynfFQyEvo
         sB717S8LT+szorNc0/wPbjJi/Ls9BhP7NZzpoJYaRK6xCCWiGR7sRESwQlgQhchtIRu0
         aQF/KN1NEsUH3DgDLhoODoqcl2sFfREC011skQa3TLQ8bwGtYXt0IGFbe/M9JU3FRtWc
         tTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wJhOC6XYSvC72mjtdo2m14FIys0tmRE1yj3cbqZcm2o=;
        b=BYyehGR9eXbsZekT3SHDxPvwfyO9eHw/HJYqWbtYoiic5Znw5aKFkAd9D1NOnRfnvm
         m94VF6lJWLctWPNXKAPQBNuofRm3+QZ31zkplbLrsWrATRQQ36/OVAu94z7Wq3joTg67
         cOKilangWUzRa7CaknE9JIHTIrubPeI2vj42Wg9TD7qewzqsyKSsl5KzX3lJeiRslyKq
         X3buzSEDERj9cempACg2hut5WeUbZ6FabT7Rja/KhznGPYAeBPmcAXvQ2HuG672KZB3X
         TRZm/A4uk5ulkmgxtwf5PtcqAPdIHcT9VXlU5rb/RzTLuNJhWQyBm2cGBVhqU1VnuByI
         HqvQ==
X-Gm-Message-State: APjAAAVw1m1G6Hf8NNUbQU6dLc2p7v9SAqtnpLItXNktyPY+LxfhIV4s
        pIfo7NzwnUESGELXEj2FP+bSwYWJ
X-Google-Smtp-Source: APXvYqxJTOmmURGX6MOTGHtb2HgiaQFOVwjbyrQzkVvA363314p3VlJd14KO1Nl7BoItQU2x4B/Jog==
X-Received: by 2002:a1c:2889:: with SMTP id o131mr11290787wmo.101.1558614388813;
        Thu, 23 May 2019 05:26:28 -0700 (PDT)
Received: from lothlann.rup.mentorg.com (nat-min.mentorg.com. [139.181.32.34])
        by smtp.gmail.com with ESMTPSA id x187sm11101360wmg.11.2019.05.23.05.26.27
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:26:28 -0700 (PDT)
From:   Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To:     linux-integrity@vger.kernel.org
Subject: [PATCH 4/4] ima-evm-utils: update .gitignore files
Date:   Thu, 23 May 2019 15:26:23 +0300
Message-Id: <20190523122623.25684-4-dbaryshkov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523122623.25684-1-dbaryshkov@gmail.com>
References: <20190523122623.25684-1-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 .gitignore     | 1 +
 src/.gitignore | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 src/.gitignore

diff --git a/.gitignore b/.gitignore
index ca7a06ea94ff..cb82166fe13f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -45,6 +45,7 @@ cscope.*
 ncscope.*
 
 # Generated documentation
+*.1
 *.8
 *.5
 manpage.links
diff --git a/src/.gitignore b/src/.gitignore
new file mode 100644
index 000000000000..38e8e3ca60fb
--- /dev/null
+++ b/src/.gitignore
@@ -0,0 +1 @@
+hash_info.h
-- 
2.20.1

