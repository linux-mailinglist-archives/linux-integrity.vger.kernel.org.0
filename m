Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC3443DFF6
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Oct 2021 13:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhJ1L3P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Oct 2021 07:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhJ1L3P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Oct 2021 07:29:15 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F33CC061745;
        Thu, 28 Oct 2021 04:26:48 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r2so6035198pgl.10;
        Thu, 28 Oct 2021 04:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IIgzbCmJH6eDmoU6Rqe6z1SlQ1KC0noTe8OtzZG3ZXc=;
        b=UH1ojTWBIxdb2Q2DTP4cdVsYkBJ46JX4aOlqk9qcQ1dr/H5hCeSzeDTOmCWhERPTxB
         JPqJvsAAYTEfszgmTB+0XRpVrKMNu9Io+8ce94JYcp2lB/Zz9KBQ+4KYYy589VU5SmUo
         K9wrRMhbXvXK4nYR3p02u3LPcX6K4qZzhT1ALYBKZEKN9pGXYhQl2RlkDGomEJuRWFAK
         Qc7WQnkjOlTaxoRDqihUs7eZnzqDEr9HUZSVu4pzCha4ao1HutC0SlTV8IMxvCYMsGfj
         kRovxdZZ4/a+GAHk6xMtjJ8PsXkrdYX4BtgYrkt/MDdJ4X0eKBcQfzBdeTXFCcG4gsty
         sPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IIgzbCmJH6eDmoU6Rqe6z1SlQ1KC0noTe8OtzZG3ZXc=;
        b=qnIWtqoIXUrMU1srsoypTpaG9WATTr54V2F+DsNnd9nT7VSI2F1c+DF/0fFhHIbYIm
         pVYJC8fIbwdy73goMYuE3kuNb84YitmmNwnh5rRA43OMGjI+b5rDfO7wOJVMuaOi4i5b
         wqda5uHoCtmS0cA1hQV89S1jHXGSOiOtbR9jz1/Xo5cewPbJ0xFGxKdrQvVEavUjTSwK
         dbPPnWPSyH1yrbuzRP/t8yaN7pQaUc03anlJYTqzuJy5u4VlddJ7fJdAlbPeNUgi/skB
         fJGn7K+0QRkrgL9KfyHwBUaemPpVY7PhCb0WhtXaDt3F7AsWfLaymlKPp/SnrtWSMfI0
         Ed7w==
X-Gm-Message-State: AOAM5302SQGXhMY4ZXv6gjEY7k+H1KuCgTu0fAxUtAIKN4B9iGscsB7j
        i7w7QTai0ckDximzVQ0FR9Y=
X-Google-Smtp-Source: ABdhPJyQ+T3xcRBMgJmU6HlTfB8hDttP6eFuOiS3EhmLiugSYnAQ5DYxGKz0WBvGCzglOpX9nb4X4Q==
X-Received: by 2002:a62:4ed2:0:b0:47b:f2f9:8812 with SMTP id c201-20020a624ed2000000b0047bf2f98812mr3699488pfb.5.1635420407813;
        Thu, 28 Oct 2021 04:26:47 -0700 (PDT)
Received: from raspberrypi ([49.166.114.232])
        by smtp.gmail.com with ESMTPSA id m16sm3470309pfk.187.2021.10.28.04.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 04:26:47 -0700 (PDT)
Date:   Thu, 28 Oct 2021 12:26:42 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com
Subject: [PATCH] evm: mark evm_fixmode as __ro_after_init
Message-ID: <20211028112642.GA1110@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Austin Kim <austin.kim@lge.com>

The evm_fixmode is only configurable by command-line option and it is never
modified outside initcalls, so declaring it with __ro_after_init is better.

Signed-off-by: Austin Kim <austin.kim@lge.com>
---
 security/integrity/evm/evm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 1c8435dfabee..08f907382c61 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -78,7 +78,7 @@ static struct xattr_list evm_config_default_xattrnames[] = {
 
 LIST_HEAD(evm_config_xattrnames);
 
-static int evm_fixmode;
+static int evm_fixmode __ro_after_init;
 static int __init evm_set_fixmode(char *str)
 {
 	if (strncmp(str, "fix", 3) == 0)
-- 
2.20.1

