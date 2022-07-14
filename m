Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A377574F70
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jul 2022 15:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbiGNNlQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jul 2022 09:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239845AbiGNNlP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jul 2022 09:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41CFE6170D
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jul 2022 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657806073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
        b=BtW5PPKAfhTJm0YL6anRbNB4Y3Wy27fKoHc3eglkYhW4un5ySaGdQ3nbHAWAPqlcuE8fyd
        MYjF6781jPaFghQVkv1YNcQsiw48z2+PQOXOW3TmjrnBOtu+eZPKHqLMePkpUaVpZbSMae
        FdfvXUhu5Bv53S/qPDN04TqC/igkPQI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-Uy0FExvQNIa6tEq_t7XJlQ-1; Thu, 14 Jul 2022 09:41:12 -0400
X-MC-Unique: Uy0FExvQNIa6tEq_t7XJlQ-1
Received: by mail-pl1-f199.google.com with SMTP id h11-20020a170902f54b00b0016bfdca124fso239322plf.9
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jul 2022 06:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
        b=WshRtVzdyY/6CqlXhEQwCzY5NpjugQH6h6yNKlEuJhfPObtJ9M4xM9pgmX3vXEnYOT
         p1enSzU/sNAzzW/RB3Y7Gp6cZ+5+52IAwtu3L63C0lwXAQXrVQ91hG/KWtPxySO1JcS3
         6ThmUaNItmugXLJ48o0KEd1FznjOqLW1gba2AiImDFvX2iLZEYn0H4tO6F1X+N2TQi0s
         +rxSY7rwsyY3G/jbCJKv0fi8tVEO7AUiBmvMp0RUZ4FWzEsngCzaodaRMjZtSv90aqaW
         MsFERiC09+dATv7A4ha9DhinPMA90/38dRSBwM+qJXiFfFpLo8vxDqmffcuqfVyhEQ0H
         Ildw==
X-Gm-Message-State: AJIora/Ty5+1IUHe+eCF8/oFcm8rYe3hKdn+yTZI6Cs1kELo4pteG1Bn
        cg2pzkveeSryL9cAbe0+SMUoM5hN51lKIq5CfPNBH+vpizlhAdqEHKdOM7ua6cU3J6lJQqv1PWE
        Q2abNth3hylB1cTsgbqTiC9NHbjZe
X-Received: by 2002:a17:90b:4b82:b0:1f0:196d:4204 with SMTP id lr2-20020a17090b4b8200b001f0196d4204mr16396514pjb.194.1657806070928;
        Thu, 14 Jul 2022 06:41:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v6W73kkND0lzdShUq0XCk7I59w6K6H/HhxbM9LJ4h4Bhv+gs6tfqbnzg5qbuZf1Ex6YUHUFA==
X-Received: by 2002:a17:90b:4b82:b0:1f0:196d:4204 with SMTP id lr2-20020a17090b4b8200b001f0196d4204mr16396483pjb.194.1657806070591;
        Thu, 14 Jul 2022 06:41:10 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h10-20020aa79f4a000000b00528d880a32fsm1663006pfr.78.2022.07.14.06.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:41:10 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>, stable@vger.kernel.org,
        Philipp Rudo <prudo@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org (open list:S390),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 4/4] kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification
Date:   Thu, 14 Jul 2022 21:40:27 +0800
Message-Id: <20220714134027.394370-5-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220714134027.394370-1-coxu@redhat.com>
References: <20220714134027.394370-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Michal Suchanek <msuchanek@suse.de>

commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
adds support for KEXEC_SIG verification with keys from platform keyring
but the built-in keys and secondary keyring are not used.

Add support for the built-in keys and secondary keyring as x86 does.

Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
Cc: stable@vger.kernel.org
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 8f43575a4dd3..fc6d5f58debe 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -31,6 +31,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
 	struct module_signature *ms;
 	unsigned long sig_len;
+	int ret;
 
 	/* Skip signature verification when not secure IPLed. */
 	if (!ipl_secure_flag)
@@ -65,11 +66,18 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 		return -EBADMSG;
 	}
 
-	return verify_pkcs7_signature(kernel, kernel_len,
-				      kernel + kernel_len, sig_len,
-				      VERIFY_USE_PLATFORM_KEYRING,
-				      VERIFYING_MODULE_SIGNATURE,
-				      NULL, NULL);
+	ret = verify_pkcs7_signature(kernel, kernel_len,
+				     kernel + kernel_len, sig_len,
+				     VERIFY_USE_SECONDARY_KEYRING,
+				     VERIFYING_MODULE_SIGNATURE,
+				     NULL, NULL);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
+		ret = verify_pkcs7_signature(kernel, kernel_len,
+					     kernel + kernel_len, sig_len,
+					     VERIFY_USE_PLATFORM_KEYRING,
+					     VERIFYING_MODULE_SIGNATURE,
+					     NULL, NULL);
+	return ret;
 }
 #endif /* CONFIG_KEXEC_SIG */
 
-- 
2.35.3

