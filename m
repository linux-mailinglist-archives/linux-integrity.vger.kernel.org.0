Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405F8559186
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jun 2022 07:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiFXEuf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jun 2022 00:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiFXEsc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jun 2022 00:48:32 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE14469985
        for <linux-integrity@vger.kernel.org>; Thu, 23 Jun 2022 21:48:30 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 23so1348000pgc.8
        for <linux-integrity@vger.kernel.org>; Thu, 23 Jun 2022 21:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=4THMhvS8M5ZnFTHvTFejhkWhYsuAvg/ZgzsYmQOutl8=;
        b=jZ+UoLM3M7Aw8FzFUs4vfV0xGVF+Z1rgG06Q0g6ddvpteFSUct4m0aAnWG/UHlIHcy
         xDIWATlB0GGjs/hfRkxe6UQ1V4kDs2Fm3V/6fxpXi023MU/ojZBBXm7JW8wCFWafwRbY
         ZPHpdFFCz4HQaws9xVkBWt/pnD6GgEBKfUCt/XZPKwwH8Eji0UWJl8bjjLOYO2Km/VcU
         riLaGCyFAc2cIrl3N/VncOYPKf8urgmhHUYRlJWR81bCqV+fn5a5+P3hY9dVVfzj35qZ
         3V3zmkqcGPJtvORY1fF7FSMecx1wrSvXDD/7UYn08WWFqdnoryi8KMch/00RWyQK0gLR
         DpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=4THMhvS8M5ZnFTHvTFejhkWhYsuAvg/ZgzsYmQOutl8=;
        b=i4ultIkyqY6hknvl9Pxw3IUr5MmCRRFf9aTGP9DGz1xNFgGrlYReeU4e/TJaEOXLbO
         M4XlY469Lj626vLz0MT53LbEtbgbV0/CItElqVTdqB5epvXykoX5aAXWN/OsJDR/3mMD
         ShTrLskLAW+m6fi0SXdD1f72n/hvLoDN0qwLdwdH87jdZeS6xdyvuvFoWX6v5OxzfY0h
         Q02DYr3N/u8U947Tsk8p3Qod2FqBl+F6WYBI6tU32IgqKntlSgDYTSTA8PVD8OuRnXQX
         WdGne7VDdMnU5hO3ZFCpjGGREjhiYBMHRuMCRUztn71ZwSbh/aRBj+EUMfxd4xbINlP5
         JWQQ==
X-Gm-Message-State: AJIora+VRLLC0CGMhjQ+dgvMo4AkMN4hmhnVHIuVJZI2SShHH1O8Nt3n
        8ZBNmfj3ycjiVlFpRKQpsEm9/g==
X-Google-Smtp-Source: AGRyM1tjG9XTGQzrvxKP1b0oJm9GIdXwYRdfAbtw1YGd6ry6SLMEHPonI2hZnL7q9k/q2Z13VDkRjA==
X-Received: by 2002:aa7:9206:0:b0:525:1068:c026 with SMTP id 6-20020aa79206000000b005251068c026mr31366064pfo.52.1656046110313;
        Thu, 23 Jun 2022 21:48:30 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7821a000000b0052517150777sm555865pfi.41.2022.06.23.21.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 21:48:29 -0700 (PDT)
Subject: [PATCH v2 5/5] RISC-V: Allow kexec_file() on 32-bit platforms
Date:   Thu, 23 Jun 2022 21:48:11 -0700
Message-Id: <20220624044811.9682-6-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624044811.9682-1-palmer@rivosinc.com>
References: <20220624044811.9682-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
            linux-security-module@vger.kernel.org,
            Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the build issues now sorted out we can enable kexec_file() on
32-bit platforms as well.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 898052ff743e..a246f2fe60c2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -388,7 +388,6 @@ config KEXEC_FILE
 	select KEXEC_CORE
 	select KEXEC_ELF
 	select HAVE_IMA_KEXEC if IMA
-	depends on 64BIT
 	help
 	  This is new version of kexec system call. This system call is
 	  file based and takes file descriptors as system call argument
-- 
2.34.1

