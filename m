Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B4B22A02A
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jul 2020 21:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgGVTc4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jul 2020 15:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgGVTc4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 15:32:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06682C0619DC
        for <linux-integrity@vger.kernel.org>; Wed, 22 Jul 2020 12:32:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p14so2544367wmg.1
        for <linux-integrity@vger.kernel.org>; Wed, 22 Jul 2020 12:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NyxUSj63c6Kh46mnriFnWbO/YaDGvF4n5kBgVRHKNAg=;
        b=jjA8p40C5uyeenz7U+XJuc/4uTWk7tI5SNNx0AOnxqT3sDSK/ShsZOlAm1SWbApzbZ
         taaGuSJpYyAoy7FSDgahEw5sxOR24M6T+vcEb3YppOus7E7XSSd0D0lAHb1TZ2bvZeMz
         0+0uoShaIdxoxt+i2q1GDLi0zHDPNe7dTslgDw4QbtVSmvFshOTnEUecxEYxeOYQKt2a
         xxny5Uuk4DFaCdGlK/IS0uViasAa4Yo1uldSN0+JQ2fZ8DqpxJIr4fpkYP+p5xXexD9e
         8X6C8RR1ccfzkz3WyV/ywNfnXUPzTxqfGccpMHYaC8CI9kFW0b9GE4Q7N+51b2Ef3oZ7
         +MWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NyxUSj63c6Kh46mnriFnWbO/YaDGvF4n5kBgVRHKNAg=;
        b=iEA2Try3VIcYaaDbs0E8wS93260BHekj4UyoCO8vMBR2vgc0+5Yt5NJHTVCwsdvCOA
         mlYfEv5ZkoyQdvgTt2jCHSUAqnnbNUoyT5t1E7p1kSG2zaBrPUV60Sr5Q+cuWAg9WULW
         wRZrJmXg7JdM5rmTzvU3eue+0c/0F4qsn1SDUs0+LKyCik9vndg+6YBprGXFyBUyOErs
         dHGAXE4AJ6rqa0OHZhbdM3UADwUjEI+unEw9bu2iKsXTaZsDRZGh+WTh3HFSuVBVv5Qh
         n+hBQVIb1x+TK7h9ISBQi4mvuRXZ9BTDTN7QW9hgCTJTIetOhb1E7NSWs4u3TJitxzVM
         wKnA==
X-Gm-Message-State: AOAM532vjUEHMatu5LbyfPrUb5YtU3RZfn2ZdkYKNFP4uUCyXpX70+qk
        9ng420Ckz7lWjFa527ZGuIvA6/DIrTw=
X-Google-Smtp-Source: ABdhPJxm7OqJJf/0uaGXgtD9Dy2IW6mM61h8UQ9LjW0809hZEB+VF46sMlhjOJxJzdG7pJAzKwm4ew==
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr930556wme.159.1595446374476;
        Wed, 22 Jul 2020 12:32:54 -0700 (PDT)
Received: from dell5510.arch.suse.de ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id k131sm763993wmb.36.2020.07.22.12.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 12:32:54 -0700 (PDT)
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH ima-evm-utils] Fix missing {u,g}id_t typedef on musl
Date:   Wed, 22 Jul 2020 21:32:46 +0200
Message-Id: <20200722193246.13140-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fixes: 273701a ("evmctl - IMA/EVM control tool")

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Hi Mimi,

one more fix, musl related this time.

Kind regards,
Petr

 src/imaevm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index 30e9730..3f1db97 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -46,7 +46,7 @@
 #include <syslog.h>
 #include <stdbool.h>
 #include <errno.h>
-
+#include <sys/types.h>
 #include <openssl/rsa.h>
 
 #ifdef USE_FPRINTF
-- 
2.27.0

