Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90977216834
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 10:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgGGIT5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jul 2020 04:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgGGITc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jul 2020 04:19:32 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D07C061755
        for <linux-integrity@vger.kernel.org>; Tue,  7 Jul 2020 01:19:32 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k27so3577793pgm.2
        for <linux-integrity@vger.kernel.org>; Tue, 07 Jul 2020 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0pw/almlOM0nvvqI+5nYmAdy2Yj1U7UMDcdD61C+qaQ=;
        b=LGKeNNtTd/zC9lyBS5S1OkdT3sNaE+OZVMRG3YUkLIM//s1udvtMwGfcRKkICTDfwX
         ciRh8xDXHRSFwSI2d++7iFZs2KTVOZj83GEv3CXcpx2PnvTMoeW3qj/VyUi3VUXCJMRk
         BZDk4YDxdLaSu4NokEYhbyiGlmhzlQzseg27I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0pw/almlOM0nvvqI+5nYmAdy2Yj1U7UMDcdD61C+qaQ=;
        b=Oe02uYdfmVIAQzef1pZyybV14aPosHLugrZSNqYaIHZSwPZDRMf6tsl8QRPFx2c770
         nlwYm/TOLo9VKvs5owbeYo1WymC4j1ZFFThD/W+MgM1wzekVbG3Iesss0faVoePPgqhA
         ChSi6qYnMHc1Vy21+4uRBLQtHuuJqySLPqAkyDc+cg6rh9lDetMp96Mj5wG2eEp0NG6I
         ZEazNj4tu/JNhvO4rUCmhKiiuM36XXqAkrWT822yXO2opXMI0ul+CCF6ZWyKlpP+ZTrL
         5oNmmsLM3V20cqS2kisdNgK7pLtKm4rqS61Pir78CYLVnoPKCOeFGe3qqpFh3To2bYd8
         HBwQ==
X-Gm-Message-State: AOAM5305x48a12eDTxR5B3mtkCA/YBCyerhVoKkBvy5h/JIUr7TKnYDQ
        zrh4pOWsEyaPbi/uZ0auJNlXAw==
X-Google-Smtp-Source: ABdhPJxa9aMEUJ/Mjzn5aqtaRqYpVKuj1envkrNds6yTMeT1CX3sElLVK5gBWNoqrM4QS8Ru/kca3w==
X-Received: by 2002:a63:2d44:: with SMTP id t65mr33902187pgt.257.1594109971610;
        Tue, 07 Jul 2020 01:19:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 186sm15400415pfe.1.2020.07.07.01.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 01:19:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 0/4] Fix misused kernel_read_file() enums
Date:   Tue,  7 Jul 2020 01:19:22 -0700
Message-Id: <20200707081926.3688096-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

In looking for closely at the additions that got made to the
kernel_read_file() enums, I noticed that FIRMWARE_PREALLOC_BUFFER
and FIRMWARE_EFI_EMBEDDED were added, but they are not appropriate
*kinds* of files for the LSM to reason about. They are a "how" and
"where", respectively. Remove these improper aliases and refactor the
code to adapt to the changes.

Additionally adds in missing calls to security_kernel_post_read_file()
in the platform firmware fallback path (to match the sysfs firmware
fallback path) and in module loading. I considered entirely removing
security_kernel_post_read_file() hook since it is technically unused,
but IMA probably wants to be able to measure EFI-stored firmware images,
so I wired it up and matched it for modules, in case anyone wants to
move the module signature checks out of the module core and into an LSM
to avoid the current layering violations.

This touches several trees, and I suspect it would be best to go through
James's LSM tree.

Thanks!

-Kees

Kees Cook (4):
  firmware_loader: EFI firmware loader must handle pre-allocated buffer
  fs: Remove FIRMWARE_PREALLOC_BUFFER from kernel_read_file() enums
  fs: Remove FIRMWARE_EFI_EMBEDDED from kernel_read_file() enums
  module: Add hook for security_kernel_post_read_file()

 drivers/base/firmware_loader/fallback_platform.c | 12 ++++++++++--
 drivers/base/firmware_loader/main.c              |  5 ++---
 fs/exec.c                                        |  7 ++++---
 include/linux/fs.h                               |  3 +--
 include/linux/lsm_hooks.h                        |  6 +++++-
 kernel/module.c                                  |  7 ++++++-
 security/integrity/ima/ima_main.c                |  6 ++----
 7 files changed, 30 insertions(+), 16 deletions(-)

-- 
2.25.1

