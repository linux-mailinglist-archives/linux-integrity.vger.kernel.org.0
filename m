Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D6C2D81A7
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 23:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406587AbgLKWLa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 17:11:30 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40487 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394262AbgLKWKz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 17:10:55 -0500
Received: by mail-ot1-f65.google.com with SMTP id j12so9665184ota.7;
        Fri, 11 Dec 2020 14:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5DOUAwNBZTpsAGtj8/sa2DV++d3Am3UoJ46lgHI5NXw=;
        b=QoWSMnbppJSUUFb2H8QEY3uQskYL6C1V4t+yuxVo0PwvPZzl+WXljFchfg4U2l1bb1
         QkZtqQnZxLWfrMGQP2mG6lvX/N32VNTzZMkx02Nwy3/yekUJN79e112wxf3+kCh8GXsC
         LWcZiGbeSvFYWeBrFa2WzzYpt/nJhZoRbD7auscNtM++BelSvjfrbLHKwEpDPD4KeWd+
         RLz+yl6IpBam5aAsnQVh3zkyWT7l4yEaT0aCqsARcxfU0RYn+lYUAuGGe8ZFR8DYdy5M
         SScUsKBdY3TeHz4zHNYkErINx9KWQ3aJ9luNo4tcUI7WYKmSjfT4p9TPXDBqELs9Qq5a
         9p8Q==
X-Gm-Message-State: AOAM533MDVCvk6Z2gafqAviN/IhmzebBdYMMQGB6MsiAJ/Tg1oC722g7
        3BrN3ksj4lHnDBG7gtFflQ==
X-Google-Smtp-Source: ABdhPJxgyfaoDh+m5zmI8+VyVda4yZOf75Uysw6WxEnATVYka7mAtOv01ywSDzDwYlxDFX56wS+ecA==
X-Received: by 2002:a9d:37c4:: with SMTP id x62mr10493712otb.87.1607724614033;
        Fri, 11 Dec 2020 14:10:14 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id p3sm2137383otf.3.2020.12.11.14.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 14:10:11 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        takahiro.akashi@linaro.org, will@kernel.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        zohar@linux.ibm.com, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Subject: [RFC PATCH 1/4] powerpc: Rename kexec elfcorehdr_addr to elf_headers_mem
Date:   Fri, 11 Dec 2020 16:10:03 -0600
Message-Id: <20201211221006.1052453-2-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201211221006.1052453-1-robh@kernel.org>
References: <20201211221006.1052453-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Align with arm64 name so common code can use it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/include/asm/kexec.h  | 2 +-
 arch/powerpc/kexec/file_load.c    | 4 ++--
 arch/powerpc/kexec/file_load_64.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 55d6ede30c19..dbf09d2f36d0 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -108,7 +108,7 @@ struct kimage_arch {
 	unsigned long backup_start;
 	void *backup_buf;
 
-	unsigned long elfcorehdr_addr;
+	unsigned long elf_headers_mem;
 	unsigned long elf_headers_sz;
 	void *elf_headers;
 
diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
index 9a232bc36c8f..e452b11df631 100644
--- a/arch/powerpc/kexec/file_load.c
+++ b/arch/powerpc/kexec/file_load.c
@@ -45,7 +45,7 @@ char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
 		return NULL;
 
 	elfcorehdr_strlen = sprintf(cmdline_ptr, "elfcorehdr=0x%lx ",
-				    image->arch.elfcorehdr_addr);
+				    image->arch.elf_headers_mem);
 
 	if (elfcorehdr_strlen + cmdline_len > COMMAND_LINE_SIZE) {
 		pr_err("Appending elfcorehdr=<addr> exceeds cmdline size\n");
@@ -263,7 +263,7 @@ int setup_new_fdt(const struct kimage *image, void *fdt,
 		 * Avoid elfcorehdr from being stomped on in kdump kernel by
 		 * setting up memory reserve map.
 		 */
-		ret = fdt_add_mem_rsv(fdt, image->arch.elfcorehdr_addr,
+		ret = fdt_add_mem_rsv(fdt, image->arch.elf_headers_mem,
 				      image->arch.elf_headers_sz);
 		if (ret) {
 			pr_err("Error reserving elfcorehdr memory: %s\n",
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index c69bcf9b547a..a05c19b3cc60 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -815,7 +815,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 		goto out;
 	}
 
-	image->arch.elfcorehdr_addr = kbuf->mem;
+	image->arch.elf_headers_mem = kbuf->mem;
 	image->arch.elf_headers_sz = headers_sz;
 	image->arch.elf_headers = headers;
 out:
@@ -851,7 +851,7 @@ int load_crashdump_segments_ppc64(struct kimage *image,
 		return ret;
 	}
 	pr_debug("Loaded elf core header at 0x%lx, bufsz=0x%lx memsz=0x%lx\n",
-		 image->arch.elfcorehdr_addr, kbuf->bufsz, kbuf->memsz);
+		 image->arch.elf_headers_mem, kbuf->bufsz, kbuf->memsz);
 
 	return 0;
 }
-- 
2.25.1

