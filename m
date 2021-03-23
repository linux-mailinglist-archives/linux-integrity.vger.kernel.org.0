Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF90345AA5
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Mar 2021 10:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCWJT3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Mar 2021 05:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhCWJTW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Mar 2021 05:19:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F87C061574;
        Tue, 23 Mar 2021 02:19:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so4617998pjb.0;
        Tue, 23 Mar 2021 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cjx0WSzuMYREzSGI95Dm8405MXA//Ic3KPFQmalnzDg=;
        b=h9O2ssAA79VelDOBwCNQ5RVKlhT+lBUASCEP4QkcSPCEL3s6tBsLsHaxSw8R9SBYB5
         ClEz3ETCCdqmYyinTRc03kyAfy9Vb1nVkFiXw/TuRg4j+2IMw1TZkA5sg2CrzLxgtp+V
         QE+G1hkngOz7KkAA1nrOFsOgZKPbYFOvsmTIwzWsZ2aBNMsoBHcvcG33qJT/OcZO3tJ2
         NHSGwCHRJwuuJR0N/yDl344iVvzRHrqP4Gypk3bbXiYMJ9DhehYk48vO4WrjarUhA8ej
         67oEz84+1KJhBiPHFLbsE4IRUuO8JPoCOuzAqRmcpSpsiRncnDQYB/+P64HcKa/Sv++X
         McGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cjx0WSzuMYREzSGI95Dm8405MXA//Ic3KPFQmalnzDg=;
        b=a7aCQQN0BGdqB+fIbUXuSbe7ArZVw2nvG0jGc81ApugWzRXUKESegUkK2z3ywZPzjp
         AGPQLZJwMv8yq4UD+ID27FDGZrGUCPB6p8VNPpd6ZsWPTP3+wKAzOoDhKfH2CvtpvSrH
         gpXmt5Jlh9m+Bpk/xvAO1AnZVWjSaK44lca+79e5SB0T9Sf9xjAeBdWKvIt+mMMhn+ul
         Y2KdbU++IkACZoXBwdInZZd4YQ/TQx3lp1FIwzvQfp1Sw+4t5B42rBHKp10S/U7PsjAE
         28cUuHvwvGrWICgjrcDW4J8z60Vbv2zb1UXtiU8BkFXkNSQ9VMUlpBHKI6/w+L1mXxab
         GEgQ==
X-Gm-Message-State: AOAM53145IoiV6vWnJSdvRpHIwmVs8NHVSUIUXCxXmlrfJcZAsfH6F8v
        sPW6QOigh5amUEHR2svL9uY=
X-Google-Smtp-Source: ABdhPJyTcotqOXqx680byQNlECxUvFWgrmiMjtIYHm4IMb6RbYqdpB/RrpU7FmHaU/y+cFndUtgy4g==
X-Received: by 2002:a17:90a:ec15:: with SMTP id l21mr3535593pjy.164.1616491161661;
        Tue, 23 Mar 2021 02:19:21 -0700 (PDT)
Received: from localhost.localdomain ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id d20sm1944165pjv.47.2021.03.23.02.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:19:21 -0700 (PDT)
From:   Jiele Zhao <unclexiaole@gmail.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jiele Zhao <unclexiaole@gmail.com>
Subject: [PATCH] ima: Fix function name error in comment.
Date:   Tue, 23 Mar 2021 09:19:05 +0000
Message-Id: <20210323091905.317885-1-unclexiaole@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Function "ima_file_check" is written as "ima_path_check" in
the comment. Fix this error to prevent misunderstanding.

Signed-off-by: Jiele Zhao <unclexiaole@gmail.com>
---
 security/integrity/ima/ima_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9ef748ea829f..03bef720ab44 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -482,7 +482,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
 }
 
 /**
- * ima_path_check - based on policy, collect/store measurement.
+ * ima_file_check - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured
  * @mask: contains MAY_READ, MAY_WRITE, MAY_EXEC or MAY_APPEND
  *
-- 
2.25.1

