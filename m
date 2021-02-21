Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E234C320C44
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Feb 2021 18:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhBURvL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Feb 2021 12:51:11 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45666 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhBURvA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Feb 2021 12:51:00 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id F1E2020B57A7;
        Sun, 21 Feb 2021 09:49:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F1E2020B57A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613929782;
        bh=2G7Gtn5ImDaEyx2Dh/8M1DXo+eKUkTMejxWi5JSu2+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hUmscgS/fRNc3Pu9F9ssrPshCPES+iJD1rxn6CUSCOHQ1nkC/CQYo1Dl7awJroEJm
         7Y6SUaJ531oKh3YyuEcrFQYraU+3uAOFCnxDUV+Qc+/dTnGKLFR3vvgS+Z3YTLlsRP
         fgn9YqieKkQSsszfXrZJbHZl/a6Q9N4wkQwV5h+4=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au, sfr@canb.auug.org.au
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
Subject: [PATCH v19 09/13] powerpc: Enable passing IMA log to next kernel on kexec
Date:   Sun, 21 Feb 2021 09:49:26 -0800
Message-Id: <20210221174930.27324-10-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221174930.27324-1-nramas@linux.microsoft.com>
References: <20210221174930.27324-1-nramas@linux.microsoft.com>
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

