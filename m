Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8E51FA091
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2020 21:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbgFOTmf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jun 2020 15:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731063AbgFOTmc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 15:42:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A266C08C5C9
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jun 2020 12:42:26 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 23so8249096pfw.10
        for <linux-integrity@vger.kernel.org>; Mon, 15 Jun 2020 12:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EN1IhuHOwzgoOcWyZIy9cQLF20jppiOEN2CrFnDInH8=;
        b=U9lxy3jE22JUx9l9TV8z9qLuPgIwP3ylxQU8Oumrvr9oyBQsLce9TnB7+K5bfye5Rt
         uSfK6xnQ0iLu3hF2G/vBHdDn/bbuiTEXKjRZhRPX4Oe5f9f7l4y/eKqXwqR0BaJFJ6Kg
         yVYKCNCf6yBQoC4Q5z7/kPeFqVPc4lPPSW40Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EN1IhuHOwzgoOcWyZIy9cQLF20jppiOEN2CrFnDInH8=;
        b=GQ2nHVjyToXWK74eNUL+kdyVrSAe7uCj9q5HeUNdlYwrASXwaVjMzz2pMHiA1hjmGS
         A1sDbVDmgy/AnUKB7qDu7MCHkavxYpq1oMAC6kCwZM3ZP/JohTPwfmqQKkw6zfbL2MYN
         JfYfponwn4hIhUXqo0Ec8DXlMX/HmGzTg2D5iuNdSyMTzV0UU527Aj+WyH4BdR4Fb2iu
         YZaoY4f8KoJZrmhBoytV6+kDuDHCgOc8jxuyLIZGHr5Ji+FnQb2EAQo2pNwoC62uHktI
         JaOn6y69NbjZs03Uu++gNeEyMgdeUeddJkuHD0jlpQXZ9eZi5wdShbUjuSRewjxEHSnQ
         /k5g==
X-Gm-Message-State: AOAM531SeD38rWeJhUTd8Iw+RiqbUd5mN9eGyM5gdTypNyQsYaflrZy6
        BAhg8bG5PfjmV8dJ87GG67hK+w==
X-Google-Smtp-Source: ABdhPJyBz/jS9zEuqkK2ql9UA5VzjypmIVHnFoC/77SXnpjE2nUSYBpVs6rkRwL2bVBYYLvYR9xePA==
X-Received: by 2002:a63:214d:: with SMTP id s13mr21585779pgm.277.1592250145955;
        Mon, 15 Jun 2020 12:42:25 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id gq8sm293663pjb.14.2020.06.15.12.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 12:42:25 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
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
Subject: [PATCH v9 7/8] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Mon, 15 Jun 2020 12:41:50 -0700
Message-Id: <20200615194151.7011-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200615194151.7011-1-scott.branden@broadcom.com>
References: <20200615194151.7011-1-scott.branden@broadcom.com>
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
index 83078661cd2b..ce29c7d0b228 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3657,6 +3657,13 @@ L:	netdev@vger.kernel.org
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

