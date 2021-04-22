Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6D6368174
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Apr 2021 15:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhDVNay (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Apr 2021 09:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhDVNau (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Apr 2021 09:30:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 440136143B;
        Thu, 22 Apr 2021 13:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619098215;
        bh=C/N43WVFiAate8dTxtGVLCNXK5ejQ6QClZ0OGp0igFg=;
        h=From:To:Cc:Subject:Date:From;
        b=QpYHQy8SOy0EUYU1mSRuGwKtDDDNtQf01s4lNuwJt/PqFZFodPERnsq6qp3RHqy4p
         gc8fShSOZEtlpcKGmuFkET8LIvqmlgWf4ijvUPKoLTtiNfo4UCszQciSMc2orwKcOF
         D6EbaHlCn97Tah2INl5MzNA70i/UBCPdWzCngKJPF6Zr/Uki97uwyjr7/IiUC4zhh6
         jRzkGkdVKRLMktkXPrRjBtf5/PwKm8I7Aqy9NmiIy6ko7dxAAdSY0aVjNEkXa2X/z3
         eWMngcN7ZLzuHwc6bzAovzC03bAWCPElKD5m4CJFe4Cy6voUPYICnr+kG7p2aHz2b6
         SMSEqAqvwaa/g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        John Johansen <john.johansen@canonical.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Bruno Meneguele <bmeneg@redhat.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ima: require CONFIG_MODULES for IMA_APPRAISE_MODSIG
Date:   Thu, 22 Apr 2021 15:29:48 +0200
Message-Id: <20210422132956.1628059-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When module support is disabled, CONFIG_MODULE_SIG_HASH cannot
be set either, so the build process fails with an error

certs/Makefile:52: *** Could not determine digest type to use from kernel config.  Stop.

when IMA_APPRAISE_MODSIG is set but modules are not.

Add a Kconfig dependency to prevent this configuration.

Fixes: 0165f4ca223b ("ima: enable signing of modules with build time generated key")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/integrity/ima/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 12e9250c1bec..2c36144cdd24 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -242,6 +242,7 @@ config IMA_APPRAISE_MODSIG
 	bool "Support module-style signatures for appraisal"
 	depends on IMA_APPRAISE
 	depends on INTEGRITY_ASYMMETRIC_KEYS
+	depends on MODULES
 	select PKCS7_MESSAGE_PARSER
 	select MODULE_SIG_FORMAT
 	default n
-- 
2.29.2

