Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0811A3B737D
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 15:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhF2NxW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 09:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhF2NxW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 09:53:22 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA2FC061760;
        Tue, 29 Jun 2021 06:50:55 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e33so18559784pgm.3;
        Tue, 29 Jun 2021 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=NVE/yWmG13Srx+k1GcLPqraZFRtg51oSQRZanYNNkUA=;
        b=VIFvQyHPYh23zuWVsCyyFUcNrJ/3dFcxDbFMj2Fn0Om7lzOlVqk4qQ/dSZAW8Xm0Hq
         Oee5pq6NoIX0+OsyydHRUqfsy4SFZ33hCg/+eyx3Ja9A0Zl9LYQ/poqLnfqpt1JVhBt+
         /8ZZ1+LvFHv94StQNO6Y1vO8CmTsb58RL2r9MNwmSm8ho7m6yx6LDXhX1nrrsC4jtX1/
         5iw/tC5NHYWGMRAMf4V8a6p2mnTht23DoAeDWTVabp5Bm+9LCeo7zrwfVd4FMw0dD1/D
         r8LEXFtCZ+8DATirZy4A9YgJcePV+rfwVIfVAT8u6ni71Dgyub6Ad85T1JewkCXUsR8C
         dQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=NVE/yWmG13Srx+k1GcLPqraZFRtg51oSQRZanYNNkUA=;
        b=R3HNJt3BQ6Q33WS4tTBVM0RyUF9rWdYE0Ow9Kh7WhnISr76bsTMnfzs3DbHDQFphzV
         Gb9JecTe9BkOKMvS50PlkJylc0yMY/fEnojO8tUiL6hAWfDMXIh6Mpg5DRZUKh4VBtmV
         rJZ8z3PkYesmm5AE3tWJTqgs6FU8u0S/XeCTTUq+D9qd40uhZ2C0dlJuQi/o7GU5EFb7
         8AgHermbhDaO+dAMJC72V2919ppPsW7q91Nxpyg4rr5bxRhuS2AfjdzOBPbz77r0DLVY
         wYoTc0KXuBAcDtIx20gmucPrrHmwxys8y6w/clP3SauCKN8t7XLLciZp0nmd28E9MdzM
         AuHg==
X-Gm-Message-State: AOAM5308Dp4NTDojWW36kH4S5FQRoofAvzFaoBbXuZrmG0zWNh4bQXUc
        0yBqH87b/DKvC/gpvKlmkI0=
X-Google-Smtp-Source: ABdhPJwspCAT3P99G3AiRVnyDOfH56x5L7uz7zqufnDraLp7J8M5RmBzZn7hn0awoFBJ6zhjBnJHcw==
X-Received: by 2002:aa7:900f:0:b029:306:24ca:108f with SMTP id m15-20020aa7900f0000b029030624ca108fmr30110894pfo.77.1624974655153;
        Tue, 29 Jun 2021 06:50:55 -0700 (PDT)
Received: from raspberrypi ([125.141.84.155])
        by smtp.gmail.com with ESMTPSA id b9sm16774593pfm.124.2021.06.29.06.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:50:54 -0700 (PDT)
Date:   Tue, 29 Jun 2021 14:50:50 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com,
        austindh.kim@gmail.com
Subject: [PATCH] IMA: remove -Wmissing-prototypes warning
Message-ID: <20210629135050.GA1373@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Austin Kim <austin.kim@lge.com>

With W=1 build, the compiler throws warning message as below:

   security/integrity/ima/ima_mok.c:24:12: warning:
   no previous prototype for ‘ima_mok_init’ [-Wmissing-prototypes]
       __init int ima_mok_init(void)

Silence the warning by adding static keyword to ima_mok_init().

Signed-off-by: Austin Kim <austin.kim@lge.com>
---
 security/integrity/ima/ima_mok.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_mok.c b/security/integrity/ima/ima_mok.c
index 1e5c01916173..95cc31525c57 100644
--- a/security/integrity/ima/ima_mok.c
+++ b/security/integrity/ima/ima_mok.c
@@ -21,7 +21,7 @@ struct key *ima_blacklist_keyring;
 /*
  * Allocate the IMA blacklist keyring
  */
-__init int ima_mok_init(void)
+static __init int ima_mok_init(void)
 {
 	struct key_restriction *restriction;
 
-- 
2.20.1

