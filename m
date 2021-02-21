Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E24320C31
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Feb 2021 18:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhBURuU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Feb 2021 12:50:20 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45082 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhBURuT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Feb 2021 12:50:19 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 316B2209FACE;
        Sun, 21 Feb 2021 09:49:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 316B2209FACE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613929777;
        bh=MgAdoofhEsBi9ijWTsxP8/GBNa/+wmI9q0RKTL7qSb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxRmZxdlfJ/ULDZwTxFlrrVVojo60qJw4/YRlOTsSL/PVPMbrCtAGGTniL6WFwHX3
         Ag8qdgt19bC+IQkxpaimLQcaMDu+bA8hAcONiBXRF7FgTDCyiJaqm8sKBjhNAimVS/
         U+GXo79K8iPkqg84fJ31YOs1ec2T1gI90Fi6A10A=
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
Subject: [PATCH v19 02/13] arm64: Use ELF fields defined in 'struct kimage'
Date:   Sun, 21 Feb 2021 09:49:19 -0800
Message-Id: <20210221174930.27324-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221174930.27324-1-nramas@linux.microsoft.com>
References: <20210221174930.27324-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ELF related fields elf_headers, elf_headers_sz, and elf_headers_mem
have been moved from 'struct kimage_arch' to 'struct kimage' as
elf_headers, elf_headers_sz, and elf_load_addr respectively.

Use the ELF fields defined in 'struct kimage'.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Rob Herring <robh@kernel.org>
Fixes: 33488dc4d61f ("of: Add a common kexec FDT setup function")
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/arm64/include/asm/kexec.h         |  4 ----
 arch/arm64/kernel/machine_kexec_file.c | 18 +++++++++---------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index d24b527e8c00..12a561a54128 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -96,10 +96,6 @@ static inline void crash_post_resume(void) {}
 struct kimage_arch {
 	void *dtb;
 	unsigned long dtb_mem;
-	/* Core ELF header buffer */
-	void *elf_headers;
-	unsigned long elf_headers_mem;
-	unsigned long elf_headers_sz;
 };
 
 extern const struct kexec_file_ops kexec_image_ops;
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 03210f644790..5553de3d401a 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -43,9 +43,9 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	vfree(image->arch.dtb);
 	image->arch.dtb = NULL;
 
-	vfree(image->arch.elf_headers);
-	image->arch.elf_headers = NULL;
-	image->arch.elf_headers_sz = 0;
+	vfree(image->elf_headers);
+	image->elf_headers = NULL;
+	image->elf_headers_sz = 0;
 
 	return kexec_image_post_load_cleanup_default(image);
 }
@@ -73,8 +73,8 @@ static int setup_dtb(struct kimage *image,
 		/* add linux,elfcorehdr */
 		ret = fdt_appendprop_addrrange(dtb, 0, off,
 				FDT_PROP_KEXEC_ELFHDR,
-				image->arch.elf_headers_mem,
-				image->arch.elf_headers_sz);
+				image->elf_load_addr,
+				image->elf_headers_sz);
 		if (ret)
 			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
 
@@ -282,12 +282,12 @@ int load_other_segments(struct kimage *image,
 			vfree(headers);
 			goto out_err;
 		}
-		image->arch.elf_headers = headers;
-		image->arch.elf_headers_mem = kbuf.mem;
-		image->arch.elf_headers_sz = headers_sz;
+		image->elf_headers = headers;
+		image->elf_load_addr = kbuf.mem;
+		image->elf_headers_sz = headers_sz;
 
 		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			 image->arch.elf_headers_mem, kbuf.bufsz, kbuf.memsz);
+			 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 	}
 
 	/* load initrd */
-- 
2.30.0

