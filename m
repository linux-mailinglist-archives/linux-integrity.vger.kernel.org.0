Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBFD320C2E
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Feb 2021 18:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhBURuW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Feb 2021 12:50:22 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45190 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhBURuU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Feb 2021 12:50:20 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 87CB820B57A1;
        Sun, 21 Feb 2021 09:49:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 87CB820B57A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613929779;
        bh=qa+NJP4aqiYfDfVBgbCgEyvzbYLV5ECOdj7x4WIL6oA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/d7RTcg/ory144srJ3zFNOHdVnpVuPjh+/Fz/2/AJljEm7AI8MwD+CZUPeLtWz/b
         6sr1vAA3A1WwA9W1r/hTAIEQUzR15aasFMemQzfHnyseqeXrdhY8MfukrJnrAZXnp4
         EcXVwjlzwkOxnjftqRPQTp6FxkBX1bs0I271mpmM=
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
Subject: [PATCH v19 04/13] x86: Use ELF fields defined in 'struct kimage'
Date:   Sun, 21 Feb 2021 09:49:21 -0800
Message-Id: <20210221174930.27324-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221174930.27324-1-nramas@linux.microsoft.com>
References: <20210221174930.27324-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ELF related fields elf_headers, elf_headers_sz, and elf_load_addr
have been moved from 'struct kimage_arch' to 'struct kimage'.

Use the ELF fields defined in 'struct kimage'.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Rob Herring <robh@kernel.org>
Fixes: 33488dc4d61f ("of: Add a common kexec FDT setup function")
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/x86/include/asm/kexec.h       |  5 -----
 arch/x86/kernel/crash.c            | 14 +++++++-------
 arch/x86/kernel/kexec-bzimage64.c  |  2 +-
 arch/x86/kernel/machine_kexec_64.c |  4 ++--
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 6802c59e8252..0a6e34b07017 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -150,11 +150,6 @@ struct kimage_arch {
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-
-	/* Core ELF header buffer */
-	void *elf_headers;
-	unsigned long elf_headers_sz;
-	unsigned long elf_load_addr;
 };
 #endif /* CONFIG_X86_32 */
 
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index a8f3af257e26..9d0722fb8842 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -323,8 +323,8 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 	cmem->nr_ranges = 1;
 
 	/* Exclude elf header region */
-	start = image->arch.elf_load_addr;
-	end = start + image->arch.elf_headers_sz - 1;
+	start = image->elf_load_addr;
+	end = start + image->elf_headers_sz - 1;
 	return crash_exclude_mem_range(cmem, start, end);
 }
 
@@ -407,20 +407,20 @@ int crash_load_segments(struct kimage *image)
 	if (ret)
 		return ret;
 
-	image->arch.elf_headers = kbuf.buffer;
-	image->arch.elf_headers_sz = kbuf.bufsz;
+	image->elf_headers = kbuf.buffer;
+	image->elf_headers_sz = kbuf.bufsz;
 
 	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
-		vfree((void *)image->arch.elf_headers);
+		vfree((void *)image->elf_headers);
 		return ret;
 	}
-	image->arch.elf_load_addr = kbuf.mem;
+	image->elf_load_addr = kbuf.mem;
 	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		 image->arch.elf_load_addr, kbuf.bufsz, kbuf.bufsz);
+		 image->elf_load_addr, kbuf.bufsz, kbuf.bufsz);
 
 	return ret;
 }
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index ce831f9448e7..170d0fd68b1f 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -75,7 +75,7 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 
 	if (image->type == KEXEC_TYPE_CRASH) {
 		len = sprintf(cmdline_ptr,
-			"elfcorehdr=0x%lx ", image->arch.elf_load_addr);
+			"elfcorehdr=0x%lx ", image->elf_load_addr);
 	}
 	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
 	cmdline_len += len;
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a29a44a98e5b..055c18a6f7bf 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -402,8 +402,8 @@ void machine_kexec(struct kimage *image)
 #ifdef CONFIG_KEXEC_FILE
 void *arch_kexec_kernel_image_load(struct kimage *image)
 {
-	vfree(image->arch.elf_headers);
-	image->arch.elf_headers = NULL;
+	vfree(image->elf_headers);
+	image->elf_headers = NULL;
 
 	if (!image->fops || !image->fops->load)
 		return ERR_PTR(-ENOEXEC);
-- 
2.30.0

