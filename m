Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C974555909D
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jun 2022 07:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiFXEtz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jun 2022 00:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiFXEs2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jun 2022 00:48:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFDB68096
        for <linux-integrity@vger.kernel.org>; Thu, 23 Jun 2022 21:48:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so1685951pjj.5
        for <linux-integrity@vger.kernel.org>; Thu, 23 Jun 2022 21:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=vBU/QhGWkV1K4rpRU6iuVI+/0UvyZtTiMv0XrxYPMnY=;
        b=KBTXLVQ9Myy+5fRcw18yS0lVJWlJWOdd7MztywK2mmLs41m1QyL9u71UUmRkZsVufO
         WBGDCzLQmzxvYVvsyvL43mR/VUG7XnIdk39+oF8XwhmacjrZkaSZcXbdPN9I5HafTNer
         xr82vLEO3N2V2NbYCHw86NmaenfnQTgypXQywZ3rOFxQ8Ry2BA3Q6/1czAnoeM+amgXI
         PXNiI40EmhGP/RqKwo10U5bHYT3e2eMwbnXUA42H/MeYjCJBsRUSv0ePUpNifVLgVv1h
         EOnTPql0DKaJ4Wn1LDQyp0D911OQtivur+xe4+XmZBEwj8WkviY0CU/CFaC8mcdEguoD
         tZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=vBU/QhGWkV1K4rpRU6iuVI+/0UvyZtTiMv0XrxYPMnY=;
        b=kTEHpW4vLegNd0S8rYvv8GemGIuU5QJdEE3uZqavaNMhtXBs5fRt69UxUmtrtrRvo/
         jImushUb9GcG2yavHT/b3lFE3sTRLCVqrNaEcCT+v5ypBkFxIP4tLHeXuLMUD3s2+Fpi
         F3V6jzfFxuIaopqmTIU8MqJ7tmvPOC0Ilqsyg42H69fJqxdzQkrXkO3vCdnomZRan/Ba
         WvIFSZemreHfhaorEgNXlrGBkCKmA9OxW2HaJcb5v7YbYUrRijNcsiBDWPCT681krUFT
         UV9NbmRmAvQlCguUAxUzWYopvnr1NldxBIHMDAglXTvvRRxWrUlLnD+D1tZFpuMN96n4
         go/w==
X-Gm-Message-State: AJIora92unKEsWTUkKjFc+6eQ2bAkkL89lAe/bd53iraQjQWiGA4vynl
        e1uxMbT0g4Ca/Eq7+EJ7nbuIAKuyD5nzrA==
X-Google-Smtp-Source: AGRyM1voXMrdQb1DI39mijMlt8wYaDCo2EZoNrpq8QsrSaFoZs/0+hNfar1BHQvqZ1cGC/I8u7r8Ug==
X-Received: by 2002:a17:902:7202:b0:167:6548:3f3e with SMTP id ba2-20020a170902720200b0016765483f3emr41641064plb.98.1656046105816;
        Thu, 23 Jun 2022 21:48:25 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id x13-20020a056a000bcd00b005206d4fd636sm559062pfu.2.2022.06.23.21.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 21:48:24 -0700 (PDT)
Subject: [PATCH v2 1/5] drivers: of: kexec ima: Support 32-bit platforms
Date:   Thu, 23 Jun 2022 21:48:07 -0700
Message-Id: <20220624044811.9682-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624044811.9682-1-palmer@rivosinc.com>
References: <20220624044811.9682-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
            linux-security-module@vger.kernel.org,
            Palmer Dabbelt <palmer@rivosinc.com>,
            Rob Herring <robh@kernel.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RISC-V recently added kexec_file() support, which uses enables kexec
IMA.  We're the first 32-bit platform to support this, so we found a
build bug.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/of/kexec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index b9bd1cff1793..ed3451ec2b24 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -236,8 +236,8 @@ static int setup_ima_buffer(const struct kimage *image, void *fdt,
 	if (ret)
 		return -EINVAL;
 
-	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
-		 image->ima_buffer_addr, image->ima_buffer_size);
+	pr_debug("IMA buffer at 0x%pa, size = 0x%zx\n",
+		 &image->ima_buffer_addr, image->ima_buffer_size);
 
 	return 0;
 }
-- 
2.34.1

