Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283DE3B6E55
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 08:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhF2GlP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 02:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhF2GlO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 02:41:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FD8C061574
        for <linux-integrity@vger.kernel.org>; Mon, 28 Jun 2021 23:38:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id j24so2345771pfi.12
        for <linux-integrity@vger.kernel.org>; Mon, 28 Jun 2021 23:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kuAh7tjcAJQbNWRi/NTbYroUtb7AuHjSTaF27s3ttE4=;
        b=m3niJWEoHDT87k5Kpf/QUTY/z0ceoujBJ5vIc40XAYP5ARVjSP7XfS6G/obtVhsg+v
         0UJZMEQUflC+Byyw1zsoP/FTsA1oZoGWyGZ4gcd7VhbdNXcbXeo/HISqL2oHt3FXxlie
         3FKAiLqzixy4FCjWfKAUHb2WgpYdqRlJwr9ngJCc6rCGHjpv+7tdVEyLDlEiyU5pRxnz
         JVWrvxPIWqRvyOetjIpD5myHDdn4sfZe2IvsiCiuQHfABsSBEyk6Z7tcWoVGnIkQAhAc
         a2XYTnRDtSUOliwCS63/OqxZndL+eMaBxGntCjEgbdUv0huehoHZC0R7jsH0jjhBPwUb
         x4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kuAh7tjcAJQbNWRi/NTbYroUtb7AuHjSTaF27s3ttE4=;
        b=U1ixT49DrXDpeEAyNGER+nea2kcrSSLc8v74w6S1tFpCX/kHipfbMddq/D97mF464x
         hlkejZVP2eU07+DLEYVsKoNQQ9qu9FuLUL62OwhPWkhTkZF5kHtfoPEn8Re6IJfVG+i7
         ojjI0Vcgmz2mKqmlcJrs6oPtPFgBZCewwqQBrJK2rgHhi9ohqBbglprr2rQ8r9Wg/qSI
         VZli+QF0/7tZYJEBHsB8jh8pIS3EoZegx4hE4IoLl99QXhDVd9qh9BDW1umsgnlqzAW5
         NrjbdXZ3EPU8tQX25tLNeJCq6ZtvnEplEElCPBmt8dLYe8KVEFVCfSegydqADC6DRKZq
         h2QA==
X-Gm-Message-State: AOAM530XVGzDlckba96RDx0/UGT6SL/agyrFMFUkO4SIqKESr/fEcvUw
        f7o5oUqqTGEtrozAm/FXDn8=
X-Google-Smtp-Source: ABdhPJyiykdlCs80FfUHdOCXnbUJ9KKBwZwqrhYmyCl8D88RWXt1NN6s+x8NMkManDCDJru2o7RSVw==
X-Received: by 2002:a63:e245:: with SMTP id y5mr26667782pgj.171.1624948727653;
        Mon, 28 Jun 2021 23:38:47 -0700 (PDT)
Received: from localhost ([124.160.217.101])
        by smtp.gmail.com with ESMTPSA id g38sm17085755pgg.63.2021.06.28.23.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 23:38:47 -0700 (PDT)
From:   Tianxing Zhang <anakinzhang96@gmail.com>
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org
Subject: [RFC] ima: check ima-policy's path
Date:   Tue, 29 Jun 2021 14:38:43 +0800
Message-Id: <20210629063843.18499-1-anakinzhang96@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi, I was reading the function ima_write_policy in ima/ima_fs.c when I find the issue:

> static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>                                              size_t datalen, loff_t *ppos)
> {
>         ...
>
>         if (data[0] == '/') {
>                 result = ima_read_policy(data);
>         } else if (ima_appraise & IMA_APPRAISE_POLICY) {
>                 pr_err("signed policy file (specified as an absolute pathname) required\n");
>                 integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
>                                              "policy_update", "signed policy required",
>                                              1, 0);
>         ...
>         return result;
> }

For the absolute path written by the user, we only check the prefix "/". Actually, we can echo an illegal path to the /sys/kernel/security/ima/policy, e.g. "/\rtest: ddddddddddddddddddd" to inject some logs into dmesg.

Then ima_read_policy is called to return error:

> static ssize_t ima_read_policy(char *path)
> {
>         ...
>         rc = kernel_read_file_from_path(path, 0, &data, INT_MAX, NULL,
>                                                       READING_POLICY);
>         if (rc < 0) {
>                 pr_err("Unable to open file: %s (%d)", path, rc);
>                 return rc;
>         }
>         ...
> }

In ima_read_policy, the illegal path would be logged into dmesg like this:

> ...
> test: ddddddddddddddddddd (-2)/
> test: ddddddddddddddddddd (-2)/
> test: ddddddddddddddddddd (-2)/
> test: ddddddddddddddddddd (-2)/

I suggest that we should check the path in ima_write_policy to make sure it's a valid one, at least literally.

thanks,

Tianxing
