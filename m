Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF6331ACF4
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Feb 2021 17:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBMQMz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 13 Feb 2021 11:12:55 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35996 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhBMQMX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 13 Feb 2021 11:12:23 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4F92620B57A4;
        Sat, 13 Feb 2021 08:10:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F92620B57A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613232659;
        bh=2G7Gtn5ImDaEyx2Dh/8M1DXo+eKUkTMejxWi5JSu2+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JSfFiHMVPLxXQJ8y74s7/OdblkbpajJeA5zJoEWyy8Sn9KAn6Ts2R3Cz15k+G08ck
         ePyYtg5C2sm1vHCqxWXFKkYhQ7u6W0eI/Zw+MYLyZA6aE4K2HotolvYWyR5gUd8iq3
         RMzdRLT/9mX14cL1wdP+cy6+WEsKCIkDVuGJmpNQ=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v18 07/11] powerpc: Enable passing IMA log to next kernel on kexec
Date:   Sat, 13 Feb 2021 08:10:45 -0800
Message-Id: <20210213161049.6190-8-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210213161049.6190-1-nramas@linux.microsoft.com>
References: <20210213161049.6190-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

CONFIG_HAVE_IMA_KEXEC is enabled to indicate that the IMA measurement
log information is present in the device tree. This should be selected
only if CONFIG_IMA is enabled.

Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC, if CONFIG_IMA
is enabled, to indicate that the IMA measurement log information is
present in the device tree for powerpc.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 107bb4319e0e..d6e593ad270e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -554,7 +554,7 @@ config KEXEC
 config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
-	select HAVE_IMA_KEXEC
+	select HAVE_IMA_KEXEC if IMA
 	select BUILD_BIN2C
 	select KEXEC_ELF
 	depends on PPC64
-- 
2.30.0

