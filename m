Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72AF24A4CE
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 19:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHSRVs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 13:21:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44498 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgHSRVn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 13:21:43 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 910BD20B4916;
        Wed, 19 Aug 2020 10:21:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 910BD20B4916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597857703;
        bh=fljryF0I/Ht+D5c1kVdiKKq9Z25pMaEkJlo1mGLnMrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fW6jb+tRnM1hq1xsXmMTfPba27XXydZeALzfXHrm2Yz77iPq3ats5hQmzDXrxWO2e
         r+PawBNHgN14OiyzJ7bawFPgtgIWlX63fYJ9wqZKvDryzQOK0rDLdC4+zWfTw3dsZo
         cO8OoxPlyUwFBS9Sjwo77ccDk1BWbC8PL5sh7s+c=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prsriva@linux.microsoft.com,
        balajib@linux.microsoft.com
Subject: [PATCH v4 5/5] arm64: Add IMA kexec buffer to DTB
Date:   Wed, 19 Aug 2020 10:21:34 -0700
Message-Id: <20200819172134.11243-6-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819172134.11243-1-nramas@linux.microsoft.com>
References: <20200819172134.11243-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The address and size of the current kernel's IMA measurement log
need to be added to the device tree's IMA kexec buffer node for
the log to be carried over to the next kernel on the kexec call.

Add the IMA measurement log buffer properties to the device tree for
ARM64. Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC to
indicate that the IMA measurement log information is present in
the device tree.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/arm64/Kconfig                     |  1 +
 arch/arm64/kernel/machine_kexec_file.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..9f03c8245e5b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1077,6 +1077,7 @@ config KEXEC
 config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
+	select HAVE_IMA_KEXEC
 	help
 	  This is new version of kexec system call. This system call is
 	  file based and takes file descriptors as system call argument
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 4c54723e7a04..8488f8e87d1a 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -153,6 +153,17 @@ static int setup_dtb(struct kimage *image,
 				FDT_PROP_KASLR_SEED);
 	}
 
+	/* add ima-kexec-buffer */
+	if (image->arch.ima_buffer_size > 0) {
+
+		ret = fdt_appendprop_addrrange(dtb, 0, off,
+				FDT_PROP_IMA_KEXEC_BUFFER,
+				image->arch.ima_buffer_addr,
+				image->arch.ima_buffer_size);
+		if (ret)
+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
+	}
+
 	/* add rng-seed */
 	if (rng_is_initialized()) {
 		void *rng_seed;
-- 
2.28.0

