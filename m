Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C0A52EF97
	for <lists+linux-integrity@lfdr.de>; Fri, 20 May 2022 17:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351078AbiETPpt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 11:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351067AbiETPpl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 11:45:41 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16A5179976
        for <linux-integrity@vger.kernel.org>; Fri, 20 May 2022 08:45:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so11828005pjb.2
        for <linux-integrity@vger.kernel.org>; Fri, 20 May 2022 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=U/MW6rSbN5zBgusIBhKQzePh9cnp8uaNotWlLIHTUsY=;
        b=JQyzbPvORX1IKsTlWc0qkUHSKntueefkGU8dfB3thfUfkSYRjG91vooo6vChrw9Bf7
         9Z5XY/rjVuwzsrlkQA5pcgEYx+QnJKtt5nmCn9DhLAdeLEqucw8pOG8J12o96ngdNp5g
         itgIArPjfmV3PmE0JpQd4a+cAR95KxK2BRwn0m7OypbO/75j+MGw0tQDgXO551FebRyN
         04wS/DqNscTUoNHtWgoitV/Yu0wzpeaqdS7LdRbwE65wXveDL69cHyxRiC2N2xewmWjM
         UTbLdEVcVlOT/o6zIiNUwcdDEW8akpNDod5tvoD9ZEXINE7/RJScDiChs8rEREGK9MC4
         rYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=U/MW6rSbN5zBgusIBhKQzePh9cnp8uaNotWlLIHTUsY=;
        b=oX5CmX742aq97Z+J5hTNl84xBxr0bl+RE2EDexJeSnqOM4FJjfkOtd644O4kocTLvU
         2oETjSOjURyC7WZIWxSiSiR/Ub7BQtUe9uR6uJPXba0FQCkzpA4o0O2jVLD+2FUJQSxb
         UprpqkELou2LKoHMGDEhpk6ZAqDQBrMKxk1ZYoaidfhIKpds1G3a1u7N0sjEK9Yjagve
         0YLeR3wOdG/UvPCSZ8NFshlD24qSlRt5ZXofGlR3FMV7jK7zIDMGVRyaaRalR2Ft5anQ
         mVHH6+xIaRw0DpEMfTHIS4MR3ygr12jZ02+W9S4QgDzdHtsOfXYyfUaf19oQ33GzwjUs
         V9EA==
X-Gm-Message-State: AOAM532W8w8LaWkEqFEUFadhU6FIiCFquwq6vzQJq5Y18VJNuJtx85iq
        ZzUibtSVPKEL4mSK9+1nwCDhdQ==
X-Google-Smtp-Source: ABdhPJxcVY/NCwkycro4XerYgWAVjh079yzImy34/DKN8DSXqYHS1KYB9wqnCW7AFPycA9lFB2mEsg==
X-Received: by 2002:a17:902:7788:b0:15e:ec55:2cfd with SMTP id o8-20020a170902778800b0015eec552cfdmr10405450pll.113.1653061527803;
        Fri, 20 May 2022 08:45:27 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090a4f0b00b001df78f27c10sm2091006pjh.42.2022.05.20.08.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:45:27 -0700 (PDT)
Subject: [PATCH v1 4/5] RISC-V: purgatory: Use XLEN-length loads to support rv32
Date:   Fri, 20 May 2022 08:44:30 -0700
Message-Id: <20220520154430.18593-5-palmer@rivosinc.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

This uses an explicit "ld" to load up target address, which dosn't work
on rv32.  Convert it to a REG_L macro, like everywhere else.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/purgatory/entry.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/purgatory/entry.S b/arch/riscv/purgatory/entry.S
index 0194f4554130..71c50fef051c 100644
--- a/arch/riscv/purgatory/entry.S
+++ b/arch/riscv/purgatory/entry.S
@@ -8,6 +8,8 @@
  *
  */
 
+#include <asm/asm.h>
+
 .macro	size, sym:req
 	.size \sym, . - \sym
 .endm
@@ -26,7 +28,7 @@ purgatory_start:
 	/* Start new image. */
 	mv	a0, s0
 	mv	a1, s1
-	ld	a2, riscv_kernel_entry
+	REG_L	a2, riscv_kernel_entry
 	jr	a2
 
 size purgatory_start
@@ -41,7 +43,7 @@ size purgatory_start
 
 .globl riscv_kernel_entry
 riscv_kernel_entry:
-	.quad	0
+	REG_ASM	0
 size riscv_kernel_entry
 
 .end
-- 
2.34.1

