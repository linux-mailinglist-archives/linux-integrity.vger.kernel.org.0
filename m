Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1C134E100
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Mar 2021 08:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhC3GJM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Mar 2021 02:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhC3GIs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Mar 2021 02:08:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86385C061764
        for <linux-integrity@vger.kernel.org>; Mon, 29 Mar 2021 23:08:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id e14so22936118ejz.11
        for <linux-integrity@vger.kernel.org>; Mon, 29 Mar 2021 23:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNbJX303TKj0bY08nTN0li+FCpaX3fkQH86qG6Fy4cY=;
        b=kCXfj4yojsaTUg2WjkiwZOb0nApyobIksGmDw2gUIj7sgOR1YC8VqnkPJrDYTzanUM
         owmndn0GmxBRPp3RUghzkdOdAZa/hI1Rn7vMTc5Df3Rbm1g9bHS3/mXN0NoVhcPnie7z
         sKysoVqz4CUGvQr2mUyVj041BzGXb5cQrV2gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNbJX303TKj0bY08nTN0li+FCpaX3fkQH86qG6Fy4cY=;
        b=BmUxRxj9/qBRJ4i0DPXmV2N6iUtvlA0QieNzXDkoWXjFZ2oxKj5bohsHw6RoR5lG1k
         l8WfO5GCF4xOm4ggFKd9HPzLk9jwePZM/ak4VJ7eSOvdFx/gomxyB7PWVv0Qjh58RzOK
         SpzLobJG9JrfGssJsm52NZ6462uviXOshxtPP5tgyJ+zct46xftfS6qrSiIWP2NYKgON
         En+3G51IaF1aZdG/3IHHs+VHnuCmjLjZ9R6MWu9GbtMSbCF0Tf1H8a6VsgtPOE75avog
         zOtBZu8fAQ0/TomoZ+k/+8Xa7PuzwWycZTCFobTQNrdgocffKHrD9SujsWgYVG8mNDA0
         0bNA==
X-Gm-Message-State: AOAM532KnEu60/5WyytOCRR/x43bjO577++q0t5ojaXb1EdaqdFywx6w
        NxcZk0A+f7qfMcp6s//630pZjvoXFgersw==
X-Google-Smtp-Source: ABdhPJxPQkHvFGwfmywaOTjQGaqLP8ZMq7LqqNUAJw1ZOTUagdIh8c31YduWn7v0Ti0IzPcqoX9yzw==
X-Received: by 2002:a17:906:4407:: with SMTP id x7mr31570991ejo.546.1617084526916;
        Mon, 29 Mar 2021 23:08:46 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id d1sm9449679eje.26.2021.03.29.23.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 23:08:46 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH] IMA: Fix error in comment
Date:   Tue, 30 Mar 2021 08:08:45 +0200
Message-Id: <20210330060845.18422-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ima_file_mprotect does not return EACCES but EPERM.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 security/integrity/ima/ima_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9ef748ea829f..716ea29cf897 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -409,7 +409,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
  * this point.  Eliminate this integrity gap by denying the mprotect
  * PROT_EXECUTE change, if an mmap appraise policy rule exists.
  *
- * On mprotect change success, return 0.  On failure, return -EACESS.
+ * On mprotect change success, return 0.  On failure, return -EPERM.
  */
 int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 {
-- 
2.31.0.291.g576ba9dcdaf-goog

