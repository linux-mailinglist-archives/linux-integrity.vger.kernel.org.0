Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B567D2195
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Oct 2023 08:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjJVGp3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 Oct 2023 02:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVGp2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 Oct 2023 02:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA45E7
        for <linux-integrity@vger.kernel.org>; Sat, 21 Oct 2023 23:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697957079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zQ885VK8hA3luVnGofcqtgJM5PIhIHcBmWMnsznzXeQ=;
        b=YweO1+iXVFgQmjIlnXCm+8cKu2738i4OficpOXsC2XC8+VUSOJZo6e1J3y9Y8NA401Sxdn
        qQUsY9CqrxHaHRn96vLGk2Qax/DARtSQUd26KxiDfUZRmrSB/aNsbXXT7MOVnSgDz5Bpfo
        WR47E+lwixKHvgGNIpvr97VeRF3J6T8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-iimQPeTNMI6dlKsYxsrH9w-1; Sun, 22 Oct 2023 02:44:36 -0400
X-MC-Unique: iimQPeTNMI6dlKsYxsrH9w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E502F3805DBD;
        Sun, 22 Oct 2023 06:44:35 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.67.24.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 522DF1121320;
        Sun, 22 Oct 2023 06:44:34 +0000 (UTC)
From:   Prasad Pandit <ppandit@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH] integrity: fix indentation of config attributes
Date:   Sun, 22 Oct 2023 12:17:23 +0530
Message-ID: <20231022064723.167042-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Prasad Pandit <pjp@fedoraproject.org>

Fix indentation of config attributes. Attributes are generally
indented with a leading tab(\t) character.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 security/integrity/Kconfig | 44 +++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 232191ee09e3..1e151e6a5d3f 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -34,10 +34,10 @@ config INTEGRITY_ASYMMETRIC_KEYS
 	bool "Enable asymmetric keys support"
 	depends on INTEGRITY_SIGNATURE
 	default n
-        select ASYMMETRIC_KEY_TYPE
-        select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
-        select CRYPTO_RSA
-        select X509_CERTIFICATE_PARSER
+	select ASYMMETRIC_KEY_TYPE
+	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select CRYPTO_RSA
+	select X509_CERTIFICATE_PARSER
 	help
 	  This option enables digital signature verification using
 	  asymmetric keys.
@@ -53,14 +53,14 @@ config INTEGRITY_TRUSTED_KEYRING
 	   keyring.
 
 config INTEGRITY_PLATFORM_KEYRING
-        bool "Provide keyring for platform/firmware trusted keys"
-        depends on INTEGRITY_ASYMMETRIC_KEYS
-        depends on SYSTEM_BLACKLIST_KEYRING
-        help
-         Provide a separate, distinct keyring for platform trusted keys, which
-         the kernel automatically populates during initialization from values
-         provided by the platform for verifying the kexec'ed kerned image
-         and, possibly, the initramfs signature.
+	bool "Provide keyring for platform/firmware trusted keys"
+	depends on INTEGRITY_ASYMMETRIC_KEYS
+	depends on SYSTEM_BLACKLIST_KEYRING
+	help
+	  Provide a separate, distinct keyring for platform trusted keys, which
+	  the kernel automatically populates during initialization from values
+	  provided by the platform for verifying the kexec'ed kerned image
+	  and, possibly, the initramfs signature.
 
 config INTEGRITY_MACHINE_KEYRING
 	bool "Provide a keyring to which Machine Owner Keys may be added"
@@ -71,10 +71,10 @@ config INTEGRITY_MACHINE_KEYRING
 	select INTEGRITY_CA_MACHINE_KEYRING if LOAD_PPC_KEYS
 	select INTEGRITY_CA_MACHINE_KEYRING_MAX if LOAD_PPC_KEYS
 	help
-	 If set, provide a keyring to which Machine Owner Keys (MOK) may
-	 be added. This keyring shall contain just MOK keys.  Unlike keys
-	 in the platform keyring, keys contained in the .machine keyring will
-	 be trusted within the kernel.
+	  If set, provide a keyring to which Machine Owner Keys (MOK) may
+	  be added. This keyring shall contain just MOK keys.  Unlike keys
+	  in the platform keyring, keys contained in the .machine keyring will
+	  be trusted within the kernel.
 
 config INTEGRITY_CA_MACHINE_KEYRING
 	bool "Enforce Machine Keyring CA Restrictions"
@@ -99,14 +99,14 @@ config INTEGRITY_CA_MACHINE_KEYRING_MAX
 	  .platform keyring.
 
 config LOAD_UEFI_KEYS
-       depends on INTEGRITY_PLATFORM_KEYRING
-       depends on EFI
-       def_bool y
+	depends on INTEGRITY_PLATFORM_KEYRING
+	depends on EFI
+	def_bool y
 
 config LOAD_IPL_KEYS
-       depends on INTEGRITY_PLATFORM_KEYRING
-       depends on S390
-       def_bool y
+	depends on INTEGRITY_PLATFORM_KEYRING
+	depends on S390
+	def_bool y
 
 config LOAD_PPC_KEYS
 	bool "Enable loading of platform and blacklisted keys for POWER"
-- 
2.41.0

