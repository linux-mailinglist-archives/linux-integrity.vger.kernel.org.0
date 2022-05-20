Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9972352EF91
	for <lists+linux-integrity@lfdr.de>; Fri, 20 May 2022 17:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351039AbiETPpo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 11:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350840AbiETPpk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 11:45:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146B317995A
        for <linux-integrity@vger.kernel.org>; Fri, 20 May 2022 08:45:26 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b5so646071plx.10
        for <linux-integrity@vger.kernel.org>; Fri, 20 May 2022 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=5TWBcQL6wNB9LxLHrCP8/TqxtjURhSYJy0/t361wYQU=;
        b=c4yOuQVg7fx9koZWMZRlxpoboAwjwiDzPiwKBiWegfHXXsuU2piqdAdZvKOlVL3wY3
         UyMVdqIEVjbV1MmgqqqPhWFWRYk+bwhWi3TkpDv7o5K0YMkwc2c02fWRsbHrFdFzgmc/
         DLCeupy+iNJUpjyqYR4JeQBFPDjmxJXZ6WuV96Z/KK2rf4fz8KRM7VUPEfZqSILfpstt
         Q93Pbbx+e/CkwcfH5kHA9LYQWUOunWsskcKvraNycowPS7MwBNFLKoTqCaCh2XphgH0+
         vJzeQDisWHO7I9qWBsQtNc8D/rVzeLhSaBVt5S0CGzQ2juEt6+b5bBLTQFftgGxZVBOb
         xF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=5TWBcQL6wNB9LxLHrCP8/TqxtjURhSYJy0/t361wYQU=;
        b=mXDizH+Zzos/miFuh1w+0Di6FeTJlGYm1GS5iWyvsKFB4RToHuMVUDg2ePCVyKQc2w
         bm/N/8KSXzQ5JkyBw8Ij4Ub4vYo2ZsEH4jnRbYhtSV557UNh7zQ2QaA20UVLgJnBOtHq
         VCxhIzVfGYViqJBwNc9+HXssKSs8c1bGxPu8rXGpHYkT4p40AUJlO18b465gcoiZJs7X
         CNEF6JumZU09+CGt1O/YbaxbVMkalcK4NGQkskSRtIJKcNiSRU7qT8lxqgmvU3ptdKj2
         tlQhf4jA1Nk21QZxxduXfQmi8DrDQ2rUtvY5cPZFMwZcI7OrVAc/Km5Le6jzzQSWWLrj
         HP6w==
X-Gm-Message-State: AOAM530PCnAnN9JHscAB7k5TAImgveuxJyJoJr1JwV0/0WvaftTwAaVb
        9m+OQeGV2vZP7PbGtY1bR79rAg==
X-Google-Smtp-Source: ABdhPJyPOaFhKw7lv1sn4i4AHPP0QtokVuzUJUfKGEWZJSnPqbVu1QCImrf5yMwt/D4DDEzAf6OhTw==
X-Received: by 2002:a17:903:108c:b0:161:e5a5:e387 with SMTP id u12-20020a170903108c00b00161e5a5e387mr6866867pld.108.1653061525601;
        Fri, 20 May 2022 08:45:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b0015e8d4eb239sm5936919plb.131.2022.05.20.08.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:45:25 -0700 (PDT)
Subject: [PATCH v1 2/5] ima: Fix a build issue on 32-bit platforms
Date:   Fri, 20 May 2022 08:44:28 -0700
Message-Id: <20220520154430.18593-3-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220520154430.18593-1-palmer@rivosinc.com>
References: <20220520154430.18593-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        robh+dt@kernel.org, frowand.list@gmail.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        liaochang1@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     lizhengyu3@huawei.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

ima_dump_measurement_list() took an "unsigned long *", but was passed a
size_t.  This triggers build warnings on 32-bit RISC-V.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 security/integrity/ima/ima_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 13753136f03f..f2a94ec3002a 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,7 +15,7 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
-static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
+static int ima_dump_measurement_list(size_t *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
 	struct ima_queue_entry *qe;
-- 
2.34.1

