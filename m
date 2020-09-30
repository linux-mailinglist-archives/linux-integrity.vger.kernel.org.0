Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E22E27F3C7
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 23:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgI3VAD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 17:00:03 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52912 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3U7y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 16:59:54 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2EE2A20BBF7F;
        Wed, 30 Sep 2020 13:59:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2EE2A20BBF7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601499593;
        bh=GY0zcMb9riPZWPjUXcZO2QO/IujwSqKax40jmESu6yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EL5M6ofW4to5So+D80BbLAJkvUtpuuoJqGLKRbGOA0rlXo8C2H/IufQ0V8oo/Jadw
         9KwKVcpITSQoySDxzFjslf06QLXn4/6RlATgoJj/XoQNUsQv7ahnAl544I0dWMMAS7
         Swg6vGew1ZbNJGQpmGBgjrSgHPsMRsgZf8pTFz7I=
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
Subject: [PATCH v7 4/4] arm64: Add IMA kexec buffer to DTB
Date:   Wed, 30 Sep 2020 13:59:41 -0700
Message-Id: <20200930205941.1576-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930205941.1576-1-nramas@linux.microsoft.com>
References: <20200930205941.1576-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Any existing FDT_PROP_IMA_KEXEC_BUFFER property in the device tree
needs to be removed and its corresponding memory reservation in
the currently running kernel needs to be freed.

The address and size of the current kernel's IMA measurement log need
to be added to the device tree's IMA kexec buffer node and memory for
the buffer needs to be reserved for the log to be carried over to
the next kernel on the kexec call.

Remove any existing FDT_PROP_IMA_KEXEC_BUFFER property in the device
tree and free the corresponding memory reservation in the currently
running kernel. Add FDT_PROP_IMA_KEXEC_BUFFER property to the device
tree and reserve the memory for storing the IMA log that needs to be
passed from the current kernel to the next one.

Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC to indicate
that the IMA measurement log information is present in the device tree
for ARM64.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/arm64/Kconfig                     |  1 +
 arch/arm64/kernel/machine_kexec_file.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

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
index 361a1143e09e..e9a02e551bca 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -21,6 +21,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/vmalloc.h>
+#include <linux/ima.h>
 #include <asm/byteorder.h>
 
 /* relevant device tree properties */
@@ -62,6 +63,8 @@ static int setup_dtb(struct kimage *image,
 
 	off = ret;
 
+	remove_ima_kexec_buffer(dtb, ret);
+
 	ret = fdt_delprop(dtb, off, FDT_PROP_KEXEC_ELFHDR);
 	if (ret && ret != -FDT_ERR_NOTFOUND)
 		goto out;
@@ -136,6 +139,21 @@ static int setup_dtb(struct kimage *image,
 				FDT_PROP_KASLR_SEED);
 	}
 
+	/* add ima-kexec-buffer */
+	if (image->arch.ima_buffer_size > 0) {
+		ret = fdt_appendprop_addrrange(dtb, 0, off,
+				FDT_PROP_IMA_KEXEC_BUFFER,
+				image->arch.ima_buffer_addr,
+				image->arch.ima_buffer_size);
+		if (ret)
+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
+
+		ret = fdt_add_mem_rsv(dtb, image->arch.ima_buffer_addr,
+				      image->arch.ima_buffer_size);
+		if (ret)
+			goto out;
+	}
+
 	/* add rng-seed */
 	if (rng_is_initialized()) {
 		void *rng_seed;
-- 
2.28.0

