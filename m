Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3FD52EF93
	for <lists+linux-integrity@lfdr.de>; Fri, 20 May 2022 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351060AbiETPpo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 11:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351072AbiETPpl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 11:45:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE3F179961
        for <linux-integrity@vger.kernel.org>; Fri, 20 May 2022 08:45:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fw21-20020a17090b129500b001df9f62edd6so6649750pjb.0
        for <linux-integrity@vger.kernel.org>; Fri, 20 May 2022 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=vc6UzMZJ99rPT/oGbTC9rWGA9q53ZOjUpC79nvKqcAU=;
        b=xn7tGQsd1Ammyb30tKhGhYaTasZDR6D+KopoaEElpoNqc6cGf0hpG8c/xcaW+oBpAb
         NQDMz08xYT3+AcMmulQAk6hqyDWTp+nOeQiNtJHz9aUl3GAakkxCzJCkqmNuICNj6ku9
         Vl5uzJywr8dENe3WususOJPHvvwQ2N9Zb7UXl2j98MpGfkZKlVUup3aNUYpiWXSSsMnF
         HepGggexSW9DzDTaB5r53P4KdrOWLX4hD7rWWZIHZzryaJzlILIHBDAqaXM69uvA+q0+
         HTb8rFfgcXIiymlN8fTxxIcV4a/06ryRKb3FCuQF+PfCqhJ1VLcOJ4sJZ6Wafv1dnUgs
         vWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=vc6UzMZJ99rPT/oGbTC9rWGA9q53ZOjUpC79nvKqcAU=;
        b=jPBeVfFFFPN7juWmndS/l0i35XJzyxCfuYYtJLbSnO2URTVff4wor7dWSqluM3sSC5
         6gwvpKTbYOxex6lTfPODMj8RYKv6PSQU+x3gBLWwD9h4GJfrSo8HpXcTQ1HvIEpCCIez
         hrJ55pq5ks+ZBJIev9UwuWKkNzA+LDrdWWCIiHql/9sJ0n3NpHZtoxKpeVGHB5MzIA03
         IH3b3BVUEIeJu5v+TSy5lNJbhom7UU2wRUkYderUwrvJ87WNnweWxnsPfO3HLTw4BTt4
         QLEzhrYOwy5wOCto96EaU49m/STVh2/enMUvOINzQBUQE05zPyDHip+csNEDVM2CshvW
         tFOg==
X-Gm-Message-State: AOAM530uePhJzXIsvABKUJ6fD6pWW+27k8v4mDYFljvlQlBVJkyhxFHr
        UtnfCFYp8Us46tHmv8+ZIl5TsA==
X-Google-Smtp-Source: ABdhPJztQKNxzDANcIjGDZLNAGCofYLcLEa+w82rs1Ze6iiV8t755M1LTaCfj73BRJaCli8PyHWtOQ==
X-Received: by 2002:a17:902:8c98:b0:15f:3e78:dc43 with SMTP id t24-20020a1709028c9800b0015f3e78dc43mr10194800plo.120.1653061528884;
        Fri, 20 May 2022 08:45:28 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id hi4-20020a17090b30c400b001cda0b69a30sm1987977pjb.52.2022.05.20.08.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:45:28 -0700 (PDT)
Subject: [PATCH v1 5/5] RISC-V: Allow kexec_file() on 32-bit platforms
Date:   Fri, 20 May 2022 08:44:31 -0700
Message-Id: <20220520154430.18593-6-palmer@rivosinc.com>
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

