Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF22665202A
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Dec 2022 13:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiLTMHv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Dec 2022 07:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiLTMHu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Dec 2022 07:07:50 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C34101D0
        for <linux-integrity@vger.kernel.org>; Tue, 20 Dec 2022 04:07:47 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p36so18233529lfa.12
        for <linux-integrity@vger.kernel.org>; Tue, 20 Dec 2022 04:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BH7tOpcGTtWUgy2JD4wY9mCcgWvSuGX9tdTL4dNMiM0=;
        b=NKfDmVHUR6JpzNkaKHuMcOkrnhS7hIl5tPg4NvM+CHVSYcH2tKIIz1SOX7rwXro4//
         tc5TU2mXCWZsLCE/orqPqiOT4uCVAJIX5IM3u9+lkXKitaG1HjtLthUGsFtT/CUejd4s
         Yx01eVOcf61TJ3KujaMpuvz+CMTCzmycoGDA5dgPCC+9rZaWYozGVGRCR5ILdtIBY4XJ
         wT2vhVKIwGhUeRs/CyT6WitKPYza40I5VUvBFIG0F+ANh0iUPao5ixBgBJ/IY3fJyofI
         7no/OYQEFA5u+0BXlNKxppbTiVLvi0BU46iUkOMB5HuQHR0hN0URZLMyIW5CPGABxl/m
         t9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BH7tOpcGTtWUgy2JD4wY9mCcgWvSuGX9tdTL4dNMiM0=;
        b=CXO2hdPmveipKjTr8oxjEV0qzan5C0EMQLMFVFFFaSWHN4osYYEQKOAUFH81QYq29B
         IwTm7j418yxxgSuE6U9etrnKf/M7eBgsWtsXS8SUEPBj1+N+tys8TBEPsrFl/fKDKDMj
         ffrSLJ6TB7GdzTIKgdfheiJWF0Pi60sM9ZJ/UnMlsgn6ZSt9PJ4BL61Ia06wNf3dJEHX
         YmfuLaEW9Su/SMUxHb6Hmex8km8vLFazdrs+2CFsavQbmPgmyt/LVCco8J5iaimn5PaM
         FABWtq0Vkb14juilgrJ3BTzYRqYPGpZgUFIh+ea7ZPs+ni0+AS/485wp6nXvsh7+svtq
         4bww==
X-Gm-Message-State: ANoB5pkDgq8+9Jzq0inGA09BQdTOcK5ss29AAxhaYbSTslcgv8ySJLEs
        4mIxErQxaSja4XsGZYj4Xfc//SkAQtQ=
X-Google-Smtp-Source: AA0mqf4xjecaM/ZxCC+SThs1pEKliOZE4j9xT0iOKbnLWI3gCXO5KFanC71SVltJYUB7iSeD/X47aA==
X-Received: by 2002:a05:6512:6d2:b0:4b5:b7c3:8053 with SMTP id u18-20020a05651206d200b004b5b7c38053mr15495593lff.42.1671538065082;
        Tue, 20 Dec 2022 04:07:45 -0800 (PST)
Received: from putinotto.luxoft.com ([77.239.233.50])
        by smtp.gmail.com with ESMTPSA id b8-20020a056512070800b004acbfa4a18bsm1443372lfs.173.2022.12.20.04.07.44
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:07:44 -0800 (PST)
Sender: Alberto Mardegan <mardy.tardi@gmail.com>
From:   Alberto Mardegan <photo@mardy.it>
X-Google-Original-From: Alberto Mardegan <a.mardegan@omp.ru>
To:     linux-integrity@vger.kernel.org
Subject: [PATCH] libimaevm: do not crash if the certificate cannot be read
Date:   Tue, 20 Dec 2022 15:07:41 +0300
Message-Id: <20221220120741.150456-1-a.mardegan@omp.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This code path can be triggered if someone inadvertedly swaps the key
with the certificate in the evmctl command line. Our `x` variable would
be NULL, and we need to abort further processing of the certificate.

Signed-off-by: Alberto Mardegan <a.mardegan@omp.ru>
---
 src/libimaevm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index c09ed98..5b22462 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -923,6 +923,7 @@ static int read_keyid_from_cert(uint32_t *keyid_be, const char *certfile, int tr
 		ERR_print_errors_fp(stderr);
 		log_err("read keyid: %s: Error reading x509 certificate\n",
 			certfile);
+		return -1;
 	}
 
 	if (!(skid = x509_get_skid(x, &skid_len))) {
-- 
2.34.1

