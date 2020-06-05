Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38E1F034A
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Jun 2020 01:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgFEXAu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jun 2020 19:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgFEXAe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jun 2020 19:00:34 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2484EC08C5CB
        for <linux-integrity@vger.kernel.org>; Fri,  5 Jun 2020 16:00:34 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y18so4267812plr.4
        for <linux-integrity@vger.kernel.org>; Fri, 05 Jun 2020 16:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5lbYp8Ah5PsaIVi4QJJDeodrUyhJmdB2XhNayDLcqg4=;
        b=X9Xd39sMlyaFaDsKVcJ8nmOkzZyJ3sF0+ia3NlMgbiPN/DjckV6mw691tNQX5Eh/fX
         iFU9jT5lWR8S6FCQkBWpOKGw3n3aIiukA2UCdHfPC1IPwPji8KyaIlFMbkFNEJG0ek+/
         r2rW2WvDkIaQFixit5DMC0B8gT0N/0roYnqzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5lbYp8Ah5PsaIVi4QJJDeodrUyhJmdB2XhNayDLcqg4=;
        b=jTCdh9yDjzBDLE0kFrt+stKToqa+6DHAWLc+eKtQS+gFm2uaOgIKHwdte9lKgxUheM
         ZI98/eR7k2u23TYwuQjR0mIiUL8BnlNwrTFVPYXBAC1ar69jPy94llD6ivfGBrcifENf
         Fj0ZhWkQ8oYUfyE5RppK4QiWqmThNrNrMK0O9YIj4A+frYvdFVZU3320hEc4VhQlUbxe
         98fUEJktX7KLiqfsNRwl7RSC4VRU/DQ5gi33qEiVvnjeF34eivKxmQMGTkd834F2D0Lr
         BD6xfujEGY3nCnpKv9DXHp7sHHO15wo6tf9dIwr+tUz6p220bzBLw1OKQm3uGFGFbHi9
         oyQg==
X-Gm-Message-State: AOAM530VIZ1PG9q/8Ef84X2LoAv4QhSRnpY4iC2Yr0FHhLDnp7sMkrWw
        3HPY5kQQkRhFAeSelSbNWc5GbA==
X-Google-Smtp-Source: ABdhPJzgVYLQyOZxOcb7SX3uvv2pqjz1hQwvUTTdKJpGNev9cMW+7bhSDkMdJrOjyWI0ETUi+YJusA==
X-Received: by 2002:a17:90a:d3d7:: with SMTP id d23mr5266002pjw.233.1591398033613;
        Fri, 05 Jun 2020 16:00:33 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b140sm568974pfb.119.2020.06.05.16.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 16:00:32 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v6 7/8] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Fri,  5 Jun 2020 15:59:58 -0700
Message-Id: <20200605225959.12424-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605225959.12424-1-scott.branden@broadcom.com>
References: <20200605225959.12424-1-scott.branden@broadcom.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b045b70e54df..9fbf255fe093 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3656,6 +3656,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VK DRIVER
+M:	Scott Branden <scott.branden@broadcom.com>
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Supported
+F:	drivers/misc/bcm-vk/
+F:	include/uapi/linux/misc/bcm_vk.h
+
 BROCADE BFA FC SCSI DRIVER
 M:	Anil Gurumurthy <anil.gurumurthy@qlogic.com>
 M:	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
-- 
2.17.1

