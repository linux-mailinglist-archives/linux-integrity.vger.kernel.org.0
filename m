Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980C4574F67
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jul 2022 15:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbiGNNlA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jul 2022 09:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239219AbiGNNk7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jul 2022 09:40:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24DFF61108
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jul 2022 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657806058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPEtVWmsQSkTQzDvP4m8a65flxiE/Nesl9xf3cgMNG8=;
        b=iMrdUxYj3ko9ZXPUNryovgtCIdbIYdT6qXZVYg8tlw+A7SR948Ag5JkOcR/0D0AoqCDyq0
        m2xNxYr6CuVXKvCmxzwYSTdkuMZzHoHr6JcrVm0ffHYKR79duFmGDMX8x3AzO0AsLbb4DU
        s5jxStIOn+98ZMWc1JHN+ohbkyi4R5s=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-x3GBnA2iMRq-6Mcj7SZm-g-1; Thu, 14 Jul 2022 09:40:57 -0400
X-MC-Unique: x3GBnA2iMRq-6Mcj7SZm-g-1
Received: by mail-pg1-f197.google.com with SMTP id g67-20020a636b46000000b0040e64eee874so1268025pgc.4
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jul 2022 06:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gPEtVWmsQSkTQzDvP4m8a65flxiE/Nesl9xf3cgMNG8=;
        b=XEwiaaQHX+nHmwPfqwiGw+GprKa6JOyHHuY979vHiGTQjT2JiHiyxUfz+UWKWfde8y
         Yn5Z3ShciCTwCtHNGRFqALRQFvIGiA5q1vTCFmao8JVx/wOXcAK2tz2kXTIfXgwIxV+u
         2ziKOCJxbKIyAg6UjwcI6ziIQbhR8xKKxmMnjoOOeH10EY+83nsx70FcpF4FJSrOR/wQ
         tplTdaJ40dpusox3fapguuU7v1NbrtHsJOFiQ7S28YO5m5gymbclxa3UwzPQir0qAv1n
         IT9fjo3jJ2GS1ZbJoSZHTzktvBnjG+o+0WK/PjRaVE0Q0vPpdJQyypsWts85hxx1Eneq
         OyeQ==
X-Gm-Message-State: AJIora/MYO5jp4OkBOnMtNd3TF5SjixEDBvaYcJcMDg2JzJYvrqawUBw
        HfdQQMXxBjeGGJrrwUjfVdIn00lCn3GlRH5+eDqQySPhZQV6PxoYZJCE15Nhxeot9NMPxj/0lyp
        D8Gchq7I57x78709OMIWNAOkeczoD
X-Received: by 2002:a05:6a00:228e:b0:52b:13d2:2627 with SMTP id f14-20020a056a00228e00b0052b13d22627mr6669616pfe.42.1657806055740;
        Thu, 14 Jul 2022 06:40:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1usVuR3eLQo75Dg0fkD9sxT+ABvKFZxKK5KiUodEx1pCPVlWbqKhxgcrRbiImMlDhzyfN0trw==
X-Received: by 2002:a05:6a00:228e:b0:52b:13d2:2627 with SMTP id f14-20020a056a00228e00b0052b13d22627mr6669586pfe.42.1657806055485;
        Thu, 14 Jul 2022 06:40:55 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z15-20020aa79f8f000000b00518a473265csm1651851pfr.217.2022.07.14.06.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:40:53 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v10 2/4] kexec, KEYS: make the code in bzImage64_verify_sig generic
Date:   Thu, 14 Jul 2022 21:40:25 +0800
Message-Id: <20220714134027.394370-3-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220714134027.394370-1-coxu@redhat.com>
References: <20220714134027.394370-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

commit 278311e417be ("kexec, KEYS: Make use of platform keyring for
signature verify") adds platform keyring support on x86 kexec but not
arm64.

The code in bzImage64_verify_sig uses the keys on the
.builtin_trusted_keys, .machine, if configured and enabled,
.secondary_trusted_keys, also if configured, and .platform keyrings
to verify the signed kernel image as PE file.

Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Reviewed-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 20 +-------------------
 include/linux/kexec.h             |  7 +++++++
 kernel/kexec_file.c               | 17 +++++++++++++++++
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 170d0fd68b1f..f299b48f9c9f 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/efi.h>
-#include <linux/verification.h>
 
 #include <asm/bootparam.h>
 #include <asm/setup.h>
@@ -528,28 +527,11 @@ static int bzImage64_cleanup(void *loader_data)
 	return 0;
 }
 
-#ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
-static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
-{
-	int ret;
-
-	ret = verify_pefile_signature(kernel, kernel_len,
-				      VERIFY_USE_SECONDARY_KEYRING,
-				      VERIFYING_KEXEC_PE_SIGNATURE);
-	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
-		ret = verify_pefile_signature(kernel, kernel_len,
-					      VERIFY_USE_PLATFORM_KEYRING,
-					      VERIFYING_KEXEC_PE_SIGNATURE);
-	}
-	return ret;
-}
-#endif
-
 const struct kexec_file_ops kexec_bzImage64_ops = {
 	.probe = bzImage64_probe,
 	.load = bzImage64_load,
 	.cleanup = bzImage64_cleanup,
 #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
-	.verify_sig = bzImage64_verify_sig,
+	.verify_sig = kexec_kernel_verify_pe_sig,
 #endif
 };
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6e7510f39368..bf24e7fce1fc 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 
 #include <uapi/linux/kexec.h>
+#include <linux/verification.h>
 
 /* Location of a reserved region to hold the crash kernel.
  */
@@ -212,6 +213,12 @@ static inline void *arch_kexec_kernel_image_load(struct kimage *image)
 }
 #endif
 
+#ifdef CONFIG_KEXEC_SIG
+#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
+int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
+#endif
+#endif
+
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 6dc1294c90fc..a7b411c22f19 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -123,6 +123,23 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_KEXEC_SIG
+#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
+int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
+{
+	int ret;
+
+	ret = verify_pefile_signature(kernel, kernel_len,
+				      VERIFY_USE_SECONDARY_KEYRING,
+				      VERIFYING_KEXEC_PE_SIGNATURE);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
+		ret = verify_pefile_signature(kernel, kernel_len,
+					      VERIFY_USE_PLATFORM_KEYRING,
+					      VERIFYING_KEXEC_PE_SIGNATURE);
+	}
+	return ret;
+}
+#endif
+
 static int kexec_image_verify_sig(struct kimage *image, void *buf,
 				  unsigned long buf_len)
 {
-- 
2.35.3

