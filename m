Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80793285C8B
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Oct 2020 12:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgJGKJB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Oct 2020 06:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgJGKI7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Oct 2020 06:08:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A12C0613D3
        for <linux-integrity@vger.kernel.org>; Wed,  7 Oct 2020 03:08:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kk9so802869pjb.2
        for <linux-integrity@vger.kernel.org>; Wed, 07 Oct 2020 03:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4zAlyHu3ozVwhIdc8JuhpCI5T47/aq9qR52/3xNtzoE=;
        b=d1bLEP6O8l2t1teQ7OtLJS+0E8nkTe4PSCUUuOi8LhwThHSIAzScvJJxVNWwrTjFsw
         gdVnXX/RvkS5FQdDXh5QsPAU9t34495bbhsaG1Uj8fmoQXfHBDs6y7aIdCdydpdkkqHk
         3luI89zlBE5reHz/ChyEZqGsWv6eUg3Nx6wEE3meDopsZAHLDsz+licI2O9yQ5/cXmwU
         thz2o/oKpepvkGme3St/tEkOKeFGLWa/uG3rIm5gVjmLlyjW4ucCKDYGtZI4mIkp7tf1
         T7mGJUmx6TWOZowJk7qtg3IyZS2RqICYvcduRI71MXqhsQHwEQnITTZD5XEP1kg6i2ql
         KwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4zAlyHu3ozVwhIdc8JuhpCI5T47/aq9qR52/3xNtzoE=;
        b=GHefp8U3bhCYJai/Sn5m/P3Aulr5bGB08YS7wV5fDXEQn61Sh7qaNDouw2f+vA4cDP
         znSY0ow6MB0nlrvQdVMxhO6Y30xzOIszXEbaW+jmTItDGalnZS57q7giiDoyi9DNQ2DV
         aZnshxDHlqq3EqxS1xNsnKNXeZvWSll1VJHYsL2STgRigbei0qz1roGc02qgmViALzd3
         MDcWbBG14SLrd+AUnF7usROqaqLpgOc5WtamODdyZHv3YJNkIYGc+Its7XOpJudG52+J
         b7rSuhj5gcyYWggKfTyRzUQl2ITB+utTRqRyQsSkZLbDPCsMyTWw/PTKl/JAH5bXgIIz
         GGvQ==
X-Gm-Message-State: AOAM532V2uCXGCgCd9L8ptBiS9J0hP9hlpbwnSL7YvsH/iQ+//lFvndc
        YdhHzc7savHK7biscZNeslB39w==
X-Google-Smtp-Source: ABdhPJwG4XN+q49MZ9O4RWqa8DonZxPxMTXdW7QbCKNxEz+y6bUBf5dxXAl3AwAwgmIowjHCWTfLTQ==
X-Received: by 2002:a17:90a:6787:: with SMTP id o7mr2224342pjj.125.1602065339238;
        Wed, 07 Oct 2020 03:08:59 -0700 (PDT)
Received: from localhost.localdomain ([117.252.65.235])
        by smtp.gmail.com with ESMTPSA id m4sm2322174pgv.87.2020.10.07.03.08.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2020 03:08:58 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v7 4/4] MAINTAINERS: Add entry for TEE based Trusted Keys
Date:   Wed,  7 Oct 2020 15:37:48 +0530
Message-Id: <1602065268-26017-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
References: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add MAINTAINERS entry for TEE based Trusted Keys framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48aff80..eb3d889 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9663,6 +9663,14 @@ F:	include/keys/trusted-type.h
 F:	include/keys/trusted_tpm.h
 F:	security/keys/trusted-keys/
 
+KEYS-TRUSTED-TEE
+M:	Sumit Garg <sumit.garg@linaro.org>
+L:	linux-integrity@vger.kernel.org
+L:	keyrings@vger.kernel.org
+S:	Supported
+F:	include/keys/trusted_tee.h
+F:	security/keys/trusted-keys/trusted_tee.c
+
 KEYS/KEYRINGS
 M:	David Howells <dhowells@redhat.com>
 M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
-- 
2.7.4

