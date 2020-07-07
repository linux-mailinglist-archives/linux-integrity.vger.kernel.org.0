Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3250216821
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 10:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGGITc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jul 2020 04:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgGGITc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jul 2020 04:19:32 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E871EC08C5DB
        for <linux-integrity@vger.kernel.org>; Tue,  7 Jul 2020 01:19:31 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x72so8680550pfc.6
        for <linux-integrity@vger.kernel.org>; Tue, 07 Jul 2020 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3/TGGX2kn2NKL/BgEqb75l7336ZUov57vqrEk8SkHU4=;
        b=bTBN7lfilcJGYJdlbwQDX/rqp45HFb8HgJGAGBOBV9CKgL4pKePubhej06HA9A/RP4
         GYmlJTS16HrfkuEjFWhk2UBxLPGgXCrjCJm0sfYpW7tUAiCXQijLn14wMx50qyTlAyIa
         KcmWeWhBMi7HFssd/6ma4MzBpKX5m9i8fZazg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3/TGGX2kn2NKL/BgEqb75l7336ZUov57vqrEk8SkHU4=;
        b=Zaj34adKbyCEdk18DpDgBkvpsynnQyrelm49sCkSAznduYkn/Hg57EUxZjpPrCho9L
         TEQag/ZzCLAfE1OZxJLnW3fmRO+Y34F4LSUHsSgY6kdfdEYhkL7x5Lsxw1iqxoLlf7g5
         dUouia8yfJt5dztGESsP41AO6cidKbjaWAVyk0Bx6540sYClagV4R1kTmn7NNGtFetjS
         tjav5wbZM0B7oyKXK728rdkNVYlQGCAe0WZ90OisCOGzixjfrpYM0fzuxXoQVwDdbBNZ
         sOGmxMhBBawdwGTh24eoxYSiv6ieJogB/xQypArI+38N3EMQ+s6YeWrs68J4SSLB3QgJ
         15bw==
X-Gm-Message-State: AOAM531VEA8TVoXXD/xzbyeWpKn4OqkcaisgRIQq8p5h6m6Gk26y3vzR
        LIERDlaybWf/RyitquEU2o0fDA==
X-Google-Smtp-Source: ABdhPJziQGymUuXunuRD3Hljwo1v5DLu/Rvol9Qs1TKP88U1Ya5951qLD2hP+Du4ykBwwluuy8bk1A==
X-Received: by 2002:a63:df54:: with SMTP id h20mr42712026pgj.319.1594109971059;
        Tue, 07 Jul 2020 01:19:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r8sm20795455pfh.29.2020.07.07.01.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 01:19:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Subject: [PATCH 4/4] module: Add hook for security_kernel_post_read_file()
Date:   Tue,  7 Jul 2020 01:19:26 -0700
Message-Id: <20200707081926.3688096-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707081926.3688096-1-keescook@chromium.org>
References: <20200707081926.3688096-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Calls to security_kernel_load_data() should be paired with a call to
security_kernel_post_read_file() with a NULL file argument. Add the
missing call so the module contents are visible to the LSMs interested
in measuring the module content. (This also paves the way for moving
module signature checking out of the module core and into an LSM.)

Cc: Jessica Yu <jeyu@kernel.org>
Fixes: c77b8cdf745d ("module: replace the existing LSM hook in init_module")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/module.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index 0c6573b98c36..af9679f8e5c6 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2980,7 +2980,12 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 		return -EFAULT;
 	}
 
-	return 0;
+	err = security_kernel_post_read_file(NULL, (char *)info->hdr,
+					     info->len, READING_MODULE);
+	if (err)
+		vfree(info->hdr);
+
+	return err;
 }
 
 static void free_copy(struct load_info *info)
-- 
2.25.1

