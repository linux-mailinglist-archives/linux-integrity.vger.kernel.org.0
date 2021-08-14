Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423023EC157
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Aug 2021 10:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbhHNIPq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 14 Aug 2021 04:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbhHNIPp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Aug 2021 04:15:45 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF450C06175F;
        Sat, 14 Aug 2021 01:15:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so8838348pjb.2;
        Sat, 14 Aug 2021 01:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6noX9uXKVk5hFoN1uQIQSjPuZZZ+OHBTtkbl22yeANc=;
        b=Oa2A9hv2Elf+HkRmqTAMYljW8O5HRS0gt+/6U83sNhr/OQaidzcfkxwlCGSy434lnZ
         ARkEkZtzLwN/5tyrbd6tQsHqVJ7UwYWTD6S8pz94b6D3Dwf5ATu+MlbSkc1zYh4cID8r
         r6NQJse1nXLBPfdMIW292/u87fRGzRSAMX4M9N5/p1iWCRy98Ibcsf8CvJ0zzql4befY
         1Jh1NKCPqryFvZwlY6Q/AK1B0rZregUaS6ZejXGAGdPg4yJN3QfpXvg7kv8AxNCs/63W
         hB0BRJ+Fz+q+cI7ItQg55AbXA2Y5YiwGpNEOOrEOhj6PYqcPMDd/hx6kySNqgNtAIrcW
         qNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6noX9uXKVk5hFoN1uQIQSjPuZZZ+OHBTtkbl22yeANc=;
        b=V40pF79lzqXI16hARuk7Q6EBEh9cceLLovWYW29idUiYbheOtG5VBjmNj7KNksM1PQ
         8AWRSsTvUzuFRAXIbkUT64hFU93m/r4tOBnPNa8mHkjssAXwwoS/YEYeDBsWFeLNCVts
         9t5hyWCtgi7EHcx4QvH8SiOVuq2SCH8LIA0szuaRXV1pnnhabDEG/lGrVFBtLZlOl5SZ
         yWCq6nWq7pldc61pYnkt2Npakfhoa1kJSu/YdSY05CbN0PmoLMUqO5k5zY26kza2inWy
         C9tVJc6UsdRfRMzFy2YKMwQmWwjskKySl7RM1OtSFmxkSItBW0L10Oi2zsOTaY1p9LNR
         HTcA==
X-Gm-Message-State: AOAM5307uCZWVNwt111LmdFewxzciX9D8totJWhfxX/hpHMytcMkU54B
        fvaI6382DIxb7+sMv2a8RP6kyroNEj/tTGkrU/k=
X-Google-Smtp-Source: ABdhPJxRP51q25RwecxucYner1gqcbt7VbEth/W3X/c+f6GDp1pu20gfBcJIRn1+/U9PmgaWHdTYWg==
X-Received: by 2002:a17:902:a710:b029:12b:9b9f:c461 with SMTP id w16-20020a170902a710b029012b9b9fc461mr5059043plq.59.1628928917259;
        Sat, 14 Aug 2021 01:15:17 -0700 (PDT)
Received: from localhost ([119.3.119.21])
        by smtp.gmail.com with ESMTPSA id ca7sm3838142pjb.11.2021.08.14.01.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 01:15:16 -0700 (PDT)
From:   Tianxing Zhang <anakinzhang96@gmail.com>
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tianxing Zhang <anakinzhang96@gmail.com>
Subject: [PATCH 0/1] ima: check control characters in policy path
Date:   Sat, 14 Aug 2021 16:13:55 +0800
Message-Id: <20210814081356.293-1-anakinzhang96@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

IMA policy can be updated with /sys/kernel/security/ima/policy interface when
CONFIG_IMA_WRITE_POLICY is set. However, kernel does not check the file path
carefully. It only checks if the path has '/' prefix.

When a policy file path contains control characters like '\r' or '\b',
invalid error messages can be printed to overwrite system messages.

For example:

$ echo -e "/\rtest invalid path: ddddddddddddddddddddd" > /sys/kernel/security/ima/policy
$ dmesg
test invalid path: ddddddddddddddddddddd (-2) 

After adding this patch, we'll be able to throw out error message:

$ echo -e "/\rtest invalid path: ddddddddddddddddddddd" > /sys/kernel/security/ima/policy
-bash: echo: write error: Invalid argument
$ dmesg
[   11.684004] ima: invalid path (control characters are not allowed)
[   11.684071] ima: policy update failed

Any suggestions would be appreciated, thank you.

Tianxing Zhang (1):
  ima: check control characters in policy file path

 security/integrity/ima/ima_fs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.25.1

