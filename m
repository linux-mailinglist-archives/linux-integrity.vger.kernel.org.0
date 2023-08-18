Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA75781287
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Aug 2023 20:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379333AbjHRSCB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Aug 2023 14:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379331AbjHRSBc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Aug 2023 14:01:32 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100DB2D67
        for <linux-integrity@vger.kernel.org>; Fri, 18 Aug 2023 11:01:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-688731c6331so992750b3a.3
        for <linux-integrity@vger.kernel.org>; Fri, 18 Aug 2023 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692381690; x=1692986490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYBhb547ncMi3wuUeN47Qu32Xgp7Mgncg35363KdjMY=;
        b=e8Q1lB1q/5WpShrGBZOlVAiH4jHMVpOUuaOqIgAkBvaujIY8uzpya5ESLBaG3ix8nb
         FHUNTjwbqpghd11R4Q+G2sU0BtL4HRvOe1svnqwdTQzKOSgMk3Jyhq+iNgCDAYct9ETm
         lToX6VZMeh+e1RqjKH4Tk4VV24davAJq54e9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692381690; x=1692986490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYBhb547ncMi3wuUeN47Qu32Xgp7Mgncg35363KdjMY=;
        b=CEWMszTlvhnad1W80ey3EjBEkge4qIMTzKWK5w9QD8OLcK5+mG6C7Vk5wyiRshVX+l
         9npmsWsYC5PRTrA+lBDYH4r4XqTMkfVVRSl1P0+m62aciwT8MJNJOMzwdOouG9J1smvX
         8t8zzOwYgreet+s7BMCZxtdYw4XfBqcnFyh87fcqGIt5ZnLNQIR/2t4aR96NTlQSekXk
         Ua0Qbw6e4SedXShXaL6j1NtmZwpltwQtkgbnAKaCGRQgpmkqnxgf9xhqsZPBpC/Wf4er
         G/5JNL2/PHuW5vpVQg+DcMaGm7VEnt0ghY1uqTnTIcTxKR/uNjA8hGxgnbvBLQN9q9X1
         oyeQ==
X-Gm-Message-State: AOJu0YzaK60nYVX3dnwmTBKJ2wNp0gchA36eZ84GqhMS+1XibazP3mw+
        lciP9PN6elD8t8FNwPMk0KutRg==
X-Google-Smtp-Source: AGHT+IHK7p11ROoF/GBRTRYvtIRFeZ79ofBB2FpFJ+GKVFcVF+S6Zy6V00Y0yvuoDiCNKNnDjwtw1A==
X-Received: by 2002:a05:6a21:3984:b0:135:10fd:31b0 with SMTP id ad4-20020a056a21398400b0013510fd31b0mr3565014pzc.15.1692381690480;
        Fri, 18 Aug 2023 11:01:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v21-20020aa78095000000b00687087d8bc3sm1883813pff.141.2023.08.18.11.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 11:01:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, Kees Cook <keescook@chromium.org>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] integrity: Annotate struct ima_rule_opt_list with __counted_by
Date:   Fri, 18 Aug 2023 11:01:15 -0700
Message-Id: <169238167326.1457886.12849640803727382145.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817210327.never.598-kees@kernel.org>
References: <20230817210327.never.598-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 17 Aug 2023 14:03:28 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ima_rule_opt_list.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] integrity: Annotate struct ima_rule_opt_list with __counted_by
      https://git.kernel.org/kees/c/a4b35d4d05b9

Take care,

-- 
Kees Cook

