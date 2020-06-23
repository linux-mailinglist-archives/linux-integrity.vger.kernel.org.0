Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83ED0206428
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 23:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391144AbgFWVQ4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jun 2020 17:16:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56190 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389259AbgFWU1L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jun 2020 16:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592944029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWgiqK629K1J6FFA3OHGCtK+IArht+OUbON7PWvIrTY=;
        b=KO987pjcJLN4ugQqemc3F60O38eq/a6ptbIUwCgPG4RW+E1i3x7DD6ZO4WAxfQugphJ4qa
        sd/ZY+s4gs+MNvRNtbF8yofYX9p/xNmbXZ8TDCKOOJeCvsE2Lo/iyxgQttR66ZXhCPhvDp
        J0WHBEkXnQxgwP1v3irVQgE49SDLOtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-qjWdDP3IPCikL0nDxWQPaQ-1; Tue, 23 Jun 2020 16:27:06 -0400
X-MC-Unique: qjWdDP3IPCikL0nDxWQPaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A4E2806BAA;
        Tue, 23 Jun 2020 20:26:55 +0000 (UTC)
Received: from localhost (ovpn-116-10.gru2.redhat.com [10.97.116.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C34962B6D4;
        Tue, 23 Jun 2020 20:26:49 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, erichte@linux.ibm.com, nayna@linux.ibm.com,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v3 2/2] ima: move APPRAISE_BOOTPARAM dependency on ARCH_POLICY to runtime
Date:   Tue, 23 Jun 2020 17:26:40 -0300
Message-Id: <20200623202640.4936-3-bmeneg@redhat.com>
In-Reply-To: <20200623202640.4936-1-bmeneg@redhat.com>
References: <20200623202640.4936-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA_APPRAISE_BOOTPARAM has been marked as dependent on !IMA_ARCH_POLICY in
compile time, enforcing the appraisal whenever the kernel had the arch
policy option enabled.

However it breaks systems where the option is actually set but the system
wasn't booted in a "secure boot" platform. In this scenario, anytime an
appraisal policy (i.e. ima_policy=appraisal_tcb) is used it will be forced,
giving no chance to the user set the 'fix' state (ima_appraise=fix) to
actually measure system's files.

This patch remove this compile time dependency and move it to a runtime
decision: all architecture that supports it so far (powerpc, x86 and s390)
only enable such specific policies if the secure/trusted boot is actually
enabled in the platform, thus the IMA_APPRAISE_ENFORCE flag is set whenever
the secure/trusted boot state is met, otherwise the kernel paramenter value
passed is used.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 arch/x86/kernel/ima_arch.c          |  3 +--
 security/integrity/ima/Kconfig      |  2 +-
 security/integrity/ima/ima_policy.c | 20 ++++++++++++++------
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index 168393d399ba..78fb61b2e480 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -85,8 +85,7 @@ static const char * const sb_arch_rules[] = {
 
 const char * const *arch_get_ima_policy(void)
 {
-	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) &&
-	    arch_ima_secure_or_tusted_boot()) {
+	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY)) {
 		if (IS_ENABLED(CONFIG_MODULE_SIG))
 			set_module_sig_enforced();
 		return sb_arch_rules;
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index edde88dbe576..62dc11a5af01 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -232,7 +232,7 @@ config IMA_APPRAISE_REQUIRE_POLICY_SIGS
 
 config IMA_APPRAISE_BOOTPARAM
 	bool "ima_appraise boot parameter"
-	depends on IMA_APPRAISE && !IMA_ARCH_POLICY
+	depends on IMA_APPRAISE
 	default y
 	help
 	  This option enables the different "ima_appraise=" modes
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e493063a3c34..6742f86b6c60 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -732,12 +732,20 @@ void __init ima_init_policy(void)
 	 * and custom policies, prior to other appraise rules.
 	 * (Highest priority)
 	 */
-	arch_entries = ima_init_arch_policy();
-	if (!arch_entries)
-		pr_info("No architecture policies found\n");
-	else
-		add_rules(arch_policy_entry, arch_entries,
-			  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
+	if (arch_ima_secure_or_trusted_boot()) {
+		/* In secure and/or trusted boot the appraisal must be
+		 * enforced, regardless kernel parameters, preventing
+		 * runtime changes */
+		pr_info("setting IMA appraisal to enforced\n");
+		ima_appraise |= IMA_APPRAISE_ENFORCE;
+
+		arch_entries = ima_init_arch_policy();
+		if (!arch_entries)
+			pr_info("No architecture policies found\n");
+		else
+			add_rules(arch_policy_entry, arch_entries,
+				  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
+	}
 
 	/*
 	 * Insert the builtin "secure_boot" policy rules requiring file
-- 
2.26.2

