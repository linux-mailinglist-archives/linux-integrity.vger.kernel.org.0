Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580E66B5113
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Mar 2023 20:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjCJTmG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Mar 2023 14:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjCJTmF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Mar 2023 14:42:05 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C7CF8E72;
        Fri, 10 Mar 2023 11:42:04 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 4685460501;
        Fri, 10 Mar 2023 20:42:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1678477322; bh=cj0o+XqVTrRektdE/wKq96D66nRJDWQYPgaoiKUVv6s=;
        h=Date:From:To:Cc:Subject:From;
        b=Zj2kvUMc1VyW7LJ4lRyMTLAIstjZHWWc+/oPa0R+VK49kUMjhnV1btr0YtMuB9vDf
         wT8ghbUdsFWD4LRfaMNcHaIfaiFY+gR/U1i61yB2tHVUWoEZ/1UQ7p7rxUPOadd9aU
         Dx5fothsLInSPn1R80GnnRZDNxidJpWc3iZ6UmGZ+PFm+3pRR3i4U0pO8+YIh/6n5Q
         trTOFQSWA2b6kYDcyyCRUTQIyOOSqtMJur7AgutFhpNfUGIJ6+ZRko97TgWwukSqeL
         Za7FGpB15gtplfqQgoczbRhHSsxd9AHbjEJ190bCn+IQxHNnZs1Hd725RAeZXp6ug2
         viw08LhVVxTOg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CY3lqGu51-DQ; Fri, 10 Mar 2023 20:42:00 +0100 (CET)
Received: by domac.alu.hr (Postfix, from userid 1014)
        id 0AE5760502; Fri, 10 Mar 2023 20:42:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1678477320; bh=cj0o+XqVTrRektdE/wKq96D66nRJDWQYPgaoiKUVv6s=;
        h=Date:From:To:Cc:Subject:From;
        b=hxtoO2FizQmqBf5u2BrG0oax8xtvbo2Oj4IsjgiVnLtvfu4J5NnmxaJOpsrfaMbhu
         KqE/09n6Mec4T9ZD33BK3auxlalAxQMlWw9X42rVNkteEm+qQ18mCkdlFwnkDwB/WO
         0LVI4EmXJRTQbOH0AcUh0/QOp2PYZsVJPq3hDficL65w0PJejG0LL8Q2yKZyGAIVhu
         IsGzb6B7zAcpH6Qfgy7P/zQ1K3KSJxGN5+DFYZda3IWxShZr96VD5sORR/S94wofTH
         2qKuD0s80PSFXKLFEK9ZDC1b/HcJZ+3tUeJo2SeUhnxQNEbbWsCoI4nLFgP3ZcUJgI
         mQbC41zihRkmw==
Date:   Fri, 10 Mar 2023 20:42:00 +0100
From:   Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v1 1/2] Add release hook to LSM
Message-ID: <20230310194159.GB528@domac.alu.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.6 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Add release() hook to the definition of the LSM modules, to enable calling
destructors and deallocating allocated resources cleanly.

Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---
 include/linux/lsm_hooks.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6e156d2acffc..d5a6ab9b5eb2 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1724,6 +1724,7 @@ struct lsm_info {
 	unsigned long flags;	/* Optional: flags describing LSM */
 	int *enabled;		/* Optional: controlled by CONFIG_LSM */
 	int (*init)(void);	/* Required. */
+	int (*release)(void);	/* Release associated resources */
 	struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
 };
 

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union
