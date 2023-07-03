Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4EB745BB8
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jul 2023 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjGCLzn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jul 2023 07:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjGCLzm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jul 2023 07:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AD4E8
        for <linux-integrity@vger.kernel.org>; Mon,  3 Jul 2023 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688385289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=f7Blmz01KkhnjG3CkQuHSrHa/R3BAwypyrKjulduXVA=;
        b=OoKrZaoKyDJKFcILN+8V+n4r6YpcKyqHLsYn8cRgslnYUQUHmDz1U6wyxC/MVJ8GAZg3wZ
        +5tNAdeqeIRYG94T9Aw8miwtcENjHQAeFUKzp/ufiLq1pmldCX9X8vCt1kQwCQ0tjrbKHa
        BXcLS6DuknPYcMVloadVZJ/KGfa5WKA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-ynir5PD_MV-BSxQw8rsIEw-1; Mon, 03 Jul 2023 07:54:48 -0400
X-MC-Unique: ynir5PD_MV-BSxQw8rsIEw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b885d53a09so3756872a34.2
        for <linux-integrity@vger.kernel.org>; Mon, 03 Jul 2023 04:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688385287; x=1690977287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7Blmz01KkhnjG3CkQuHSrHa/R3BAwypyrKjulduXVA=;
        b=dOKyP1fAHgPkktpVCAbk8dMEw4EwFeIH4ES62GGgZBtrocT4TUt/QJTWGXD+d1s4fR
         ENKkNzYRmdYvuPO0GYauIBtksA/qHqagPsg4hc5n8YxpbGTWfphMD+muvGRTUJfR+H7F
         Ri/LNuGDVvp1v+GIvUY1+O7HglVGs6DbOkuZ5rgJo1kobyXqUTFe5yxa1llubsMPVSQI
         iHlfiENQlDTcy0o/l0LhyVBGIFgayRZWd6pRPxXEl0B0yVEgujbNOgDWc2K63f8Bi6C/
         gcHNLHD5ttQbCnQHfqpwc41Si9zBNanPAFIc/hvHgsat0pgRNRi7T4XP/BHmnHc57JgX
         3DMw==
X-Gm-Message-State: AC+VfDyENM9Z0hyT6HzFjTPRXPA8huGK/YOllqMGyaqy3jLauNm20CyU
        tR+kLuk6YOoR4ssxwnTr1dv6dXz4gdr5q9chl10rEjStiBc5+/WP+AKi9q4ulQQNSE0q3/Od3Ch
        7HE0q+QbDg1gjOUVbb9oBTnHWsXEfmjlrr5aZEbUL28LEfVthab7E5AOMiIwtPr8MOT6gOHn7ID
        aNsZV4WhkJXn0A
X-Received: by 2002:a05:6830:139a:b0:6b7:20f6:1242 with SMTP id d26-20020a056830139a00b006b720f61242mr9877373otq.20.1688385287164;
        Mon, 03 Jul 2023 04:54:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7FVEteqImZ56jG0cTISB6k7WjoEl4kHlZ2OzvXOgqdAXDOGMsCexyRBXODj/JojKMnZ6RaGw==
X-Received: by 2002:a05:6830:139a:b0:6b7:20f6:1242 with SMTP id d26-20020a056830139a00b006b720f61242mr9877348otq.20.1688385286830;
        Mon, 03 Jul 2023 04:54:46 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s68-20020a635e47000000b005533f154df1sm14907784pgb.2.2023.07.03.04.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 04:54:46 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ima: require signed IMA policy when UEFI secure boot is enabled
Date:   Mon,  3 Jul 2023 19:54:41 +0800
Message-ID: <20230703115442.129725-1-coxu@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the introduction of the .machine keyring for UEFI-based systems,
users are able to add custom CAs keys via MOK. This allow users to sign
their own IMA polices. For the sake of security, mandate signed IMA
policy when UEFI secure boot is enabled.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 security/integrity/ima/ima_efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index 9db66fe310d4..bb2881759505 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -58,6 +58,9 @@ static const char * const sb_arch_rules[] = {
 #if !IS_ENABLED(CONFIG_MODULE_SIG)
 	"appraise func=MODULE_CHECK appraise_type=imasig",
 #endif
+#if IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && IS_ENABLED(CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY)
+	"appraise func=POLICY_CHECK appraise_type=imasig",
+#endif /* CONFIG_INTEGRITY_MACHINE_KEYRING && IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY */
 	"measure func=MODULE_CHECK",
 	NULL
 };
-- 
2.41.0

