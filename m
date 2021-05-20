Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C1038AF23
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 14:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhETMvv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 08:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242860AbhETMvM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 08:51:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6192CC05BD07
        for <linux-integrity@vger.kernel.org>; Thu, 20 May 2021 05:14:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j14so15689013wrq.5
        for <linux-integrity@vger.kernel.org>; Thu, 20 May 2021 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9y0gA0fQbXJNYgnBVvxDNn1I72crBojCN5pP1eoOBYo=;
        b=Dwjglu8dczKMPgon22oVb+PqpR5pfGiatS1J8lHv3Tm2d5IFGvKPpgDv/4ZMkOwPVC
         ZTaUDNJ0J+iL2lu+ytEGrHhNIoOGn/XJsKydfIy4ubJiGpc0FtKzCansYm/9za14wffG
         NcYRb4JImwkI4pwyBSu3qznpjTxSRX4StIAoslnQ46kBzQaUtJj6UOJ5NPcGtKOHjGq+
         0CgTssMzSA9521Q7OVGuKVlH2ogq9iSFRGYXHph8KNwU3gMZW4DCLZPB1MMIDvTm+v7p
         kEIMSQPM7sC8KoM+bPPRc5YEkeaIfzN4TGHTiqFxIcdJXl5Fy0X+Jf1ewskE8UmxvRYc
         339g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9y0gA0fQbXJNYgnBVvxDNn1I72crBojCN5pP1eoOBYo=;
        b=uSzNCmmcXnDZvyDEhPwqUMYvf3qpu1e4atIkDzTs4zrLlgtR7k/MWJ4cXDh50UFzJR
         I6OhA6oQ6wM7hlLxAZ3dQwy+qLzryUEaqNhKzSRncjjSddwe+HtQ7KFChCBVN40goNmh
         sTjfi0QeAbvLL8+FAeOnXCfPtg4eRyhtMzjc5ZUsP8bbYGe7IxcYOsq6xTKtTEhTDI4X
         o3PBPh/l0g6LlB3zauLON4kaBFyzq05vKBZfA8VEuS2lOWCAZRM8oGDlx5VHwK1vrCxB
         xqc0R3N9cHXurzglz4mZIksPF3o3Hq+fmR0+MRFNlwEb+XdA6DcxM3EqIWPzDzH0NDA/
         5mlA==
X-Gm-Message-State: AOAM530f97nlIX2sHkcW26efzaVHCV1hKwjxnPj+iJQXarDRi3cQFppT
        P/oszShYEVFvbCRywrX8NDBl8A==
X-Google-Smtp-Source: ABdhPJwaNdYgAYB+0XLU/rHo3whTXtJZreRhrDbouJQj0lUenFGdNCKjcXPpYdI64az4oL5s3RQdNQ==
X-Received: by 2002:adf:faca:: with SMTP id a10mr4047923wrs.9.1621512844027;
        Thu, 20 May 2021 05:14:04 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:14:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 08/16] char: tpm: tpm_ftpm_tee: Fix a couple of kernel-doc misdemeanours
Date:   Thu, 20 May 2021 13:13:39 +0100
Message-Id: <20210520121347.3467794-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/char/tpm/tpm_ftpm_tee.c:218: warning: Function parameter or member 'dev' not described in 'ftpm_tee_probe'
 drivers/char/tpm/tpm_ftpm_tee.c:218: warning: Excess function parameter 'pdev' description in 'ftpm_tee_probe'
 drivers/char/tpm/tpm_ftpm_tee.c:314: warning: Function parameter or member 'dev' not described in 'ftpm_tee_remove'
 drivers/char/tpm/tpm_ftpm_tee.c:314: warning: Excess function parameter 'pdev' description in 'ftpm_tee_remove'
 drivers/char/tpm/tpm_ftpm_tee.c:349: warning: expecting prototype for ftpm_tee_shutdown(). Prototype was for ftpm_plat_tee_shutdown() instead

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Thirupathaiah Annapureddy <thiruan@microsoft.com>
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 2ccdf8ac69948..2d9c0ecd43f0a 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -209,7 +209,7 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
 
 /**
  * ftpm_tee_probe() - initialize the fTPM
- * @pdev: the platform_device description.
+ * @dev: the platform_device description.
  *
  * Return:
  *	On success, 0. On failure, -errno.
@@ -305,7 +305,7 @@ static int ftpm_plat_tee_probe(struct platform_device *pdev)
 
 /**
  * ftpm_tee_remove() - remove the TPM device
- * @pdev: the platform_device description.
+ * @dev: the platform_device description.
  *
  * Return:
  *	0 always.
@@ -342,7 +342,7 @@ static int ftpm_plat_tee_remove(struct platform_device *pdev)
 }
 
 /**
- * ftpm_tee_shutdown() - shutdown the TPM device
+ * ftpm_plat_tee_shutdown() - shutdown the TPM device
  * @pdev: the platform_device description.
  */
 static void ftpm_plat_tee_shutdown(struct platform_device *pdev)
-- 
2.31.1

