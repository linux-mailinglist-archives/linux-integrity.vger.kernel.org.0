Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A720431ACDD
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Feb 2021 17:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBMQLk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 13 Feb 2021 11:11:40 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35532 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhBMQLg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 13 Feb 2021 11:11:36 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id CA34520B57A0;
        Sat, 13 Feb 2021 08:10:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA34520B57A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613232656;
        bh=W4nfk42A7xcjjuWVwXZ5p95MM79jT4rO0IEgmmAlhU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BGczkjJC/2YMNuqpzttE2Qqwl+1QakY0vI1+r9FBaAJOFWRUBDn5k9bHUrYsDW1+b
         EXJpL/izfEKvAlG5p1BKsdy8/GtrviadcVSSZKVdv7QLM0+Iq3iUIALWWzJLBvI58d
         ebaoNgfVPlTxppC2ESNeMWJP6c9iocgx32dBAR9s=
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
Subject: [PATCH v18 02/11] arm64: Rename kexec elf_headers_mem to elf_load_addr
Date:   Sat, 13 Feb 2021 08:10:40 -0800
Message-Id: <20210213161049.6190-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210213161049.6190-1-nramas@linux.microsoft.com>
References: <20210213161049.6190-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The architecture specific field, elf_headers_mem in struct kimage_arch,
that holds the address of the buffer in memory for ELF core header for
arm64 has a different name than the one used for powerpc.  This makes
it hard to have a common code for setting up the device tree for
kexec system call.

Rename elf_headers_mem to elf_load_addr to align with powerpc name so
common code can use it.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/arm64/include/asm/kexec.h         | 2 +-
 arch/arm64/kernel/machine_kexec_file.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index d24b527e8c00..e6a99dfdffb8 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -98,7 +98,7 @@ struct kimage_arch {
 	unsigned long dtb_mem;
 	/* Core ELF header buffer */
 	void *elf_headers;
-	unsigned long elf_headers_mem;
+	unsigned long elf_load_addr;
 	unsigned long elf_headers_sz;
 };
 
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 03210f644790..d98bacec9426 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -73,7 +73,7 @@ static int setup_dtb(struct kimage *image,
 		/* add linux,elfcorehdr */
 		ret = fdt_appendprop_addrrange(dtb, 0, off,
 				FDT_PROP_KEXEC_ELFHDR,
-				image->arch.elf_headers_mem,
+				image->arch.elf_load_addr,
 				image->arch.elf_headers_sz);
 		if (ret)
 			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
@@ -283,11 +283,11 @@ int load_other_segments(struct kimage *image,
 			goto out_err;
 		}
 		image->arch.elf_headers = headers;
-		image->arch.elf_headers_mem = kbuf.mem;
+		image->arch.elf_load_addr = kbuf.mem;
 		image->arch.elf_headers_sz = headers_sz;
 
 		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-			 image->arch.elf_headers_mem, kbuf.bufsz, kbuf.memsz);
+			 image->arch.elf_load_addr, kbuf.bufsz, kbuf.memsz);
 	}
 
 	/* load initrd */
-- 
2.30.0

