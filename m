Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAD211FA61
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Dec 2019 19:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfLOSXU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 15 Dec 2019 13:23:20 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:35792 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfLOSXU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 15 Dec 2019 13:23:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47bXpH4HhTz9vKSn
        for <linux-integrity@vger.kernel.org>; Sun, 15 Dec 2019 18:23:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HhBSGzYLfS0z for <linux-integrity@vger.kernel.org>;
        Sun, 15 Dec 2019 12:23:19 -0600 (CST)
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com [209.85.161.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47bXpH32yjz9vs7Y
        for <linux-integrity@vger.kernel.org>; Sun, 15 Dec 2019 12:23:19 -0600 (CST)
Received: by mail-yw1-f72.google.com with SMTP id 199so3615872ywe.20
        for <linux-integrity@vger.kernel.org>; Sun, 15 Dec 2019 10:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=llCgKqj4oj+SBI/9u2Qj4pLrOEShlhQ/Pb7xPdsk9S0=;
        b=JLdccgyJMvUFH10z5CGdaUBC2QyJT9+FF/JUVJsEkP++worO7bLakHUfCSF7rK6oFc
         3mjwgpGUuxk6Om/+DeieGP5xm82Rag8ZQpl+AqIRzf9jGf+7/cA0j2Ra4POBDsYw+p8x
         nNxuG1p88kqIErbFUFGJAtQgnsGzEKxLOs/+x9I9KAXMZL905eHOIJHa5q6x6oiXS9BM
         r4wUaA76g6tZQIg8Ont8s1TA6dxmHrhOJ600Y5VwjPGNMI4HKlAb27wJ35B5Y5pgsac3
         9zT5RlEx+zcGz9iDsQwkhAZth+n30Vu7+SN4ww+yigcz4CWjogdFMFr7lCA/LFxCGBrK
         LXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=llCgKqj4oj+SBI/9u2Qj4pLrOEShlhQ/Pb7xPdsk9S0=;
        b=Z7rZt8NtM5hQZcqWMsQKnPXKvMoaDyR2IRY1T8h/dNudw1+EH2TkCbyb8N9oUE9Vp3
         wfwIUcKbC2D9ZzdpiJnWZZOytUBlv7iUKgsJq5UBN3zxAg71V6S9pe+Evgo3lj5qjn1u
         EBr0oy9OGvcAnkYZdPQTmzP/cw5TNJvCA7A9HotaMlprjbkysFi29Zmzz3aMGAugje5Q
         mC2M2OJ0t4EcKrrV85RHPXdKC4kz4lkiCE6TM8bh5+jSHNvu75TO0lEEdrUIL8kz7yRN
         BdfzEqhDHvR0SCcA1tyl7gB5D5mqsceawnk0JN+VgdX+5t0fUZExoScEXBoo81QegcnI
         OKBQ==
X-Gm-Message-State: APjAAAVpKZUR3fsaUC/V2mxKeSF6+GE5PtnzKGPabZZskAq011rKEICk
        Pwa8hSABqnKTAon/3uAahaQd5SKUVyvXVWYcZqAfZhQsR3CRR1WaA+ZmbrEqX+u3JzfKzK1ha5j
        9/Wl/Se/nC+lMnWEJf8k6trc0jqmtoerV
X-Received: by 2002:a81:84c6:: with SMTP id u189mr17064870ywf.439.1576434198948;
        Sun, 15 Dec 2019 10:23:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzQGMrX+PEkSD/x5YBWtEuXfdwPOSYkyvf2XkwMhs4RTNPkXIJTpbHfnGzZcSMgz4+G9424rw==
X-Received: by 2002:a81:84c6:: with SMTP id u189mr17064859ywf.439.1576434198671;
        Sun, 15 Dec 2019 10:23:18 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id o84sm962165ywb.92.2019.12.15.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 10:23:18 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm/ppi: replace assertion code with recovery in tpm_eval_dsm
Date:   Sun, 15 Dec 2019 12:23:14 -0600
Message-Id: <20191215182314.32208-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In tpm_eval_dsm, BUG_ON on ppi_handle is used as an assertion.
By returning NULL to the callers, instead of crashing, the error
can be better handled.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/char/tpm/tpm_ppi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index b2dab941cb7f..4b6f6a9c0b48 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -42,7 +42,9 @@ static inline union acpi_object *
 tpm_eval_dsm(acpi_handle ppi_handle, int func, acpi_object_type type,
 	     union acpi_object *argv4, u64 rev)
 {
-	BUG_ON(!ppi_handle);
+	if (!ppi_handle)
+		return NULL;
+
 	return acpi_evaluate_dsm_typed(ppi_handle, &tpm_ppi_guid,
 				       rev, func, argv4, type);
 }
-- 
2.20.1

