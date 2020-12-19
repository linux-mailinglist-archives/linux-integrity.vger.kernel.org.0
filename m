Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09202DF0E8
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Dec 2020 19:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgLSR7D (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 19 Dec 2020 12:59:03 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51390 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgLSR7A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 19 Dec 2020 12:59:00 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id E04F920B8760;
        Sat, 19 Dec 2020 09:57:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E04F920B8760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608400661;
        bh=OVwA4inNau2hmijx/oPmAOP24IyIW5ZqUgc87HT/n4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYvY8oFR77uNrtNi8uvYFk928ERQQrPMySXkp4MZRHkdjUzOGddbLY4oHuZoCVJzE
         gXMYZ60NeqQYjkqg/235ZIxhe5No/45Hqigzgdxev0OAvkJTk/gwfSfptVDTxHwabq
         Wo+Kf6RvfNRCdJaiUV1f17GXtyok9+IY0uucsfmY=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v13 6/6] arm64: Add IMA log information in kimage used for kexec
Date:   Sat, 19 Dec 2020 09:57:13 -0800
Message-Id: <20201219175713.18888-7-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201219175713.18888-1-nramas@linux.microsoft.com>
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Address and size of the buffer containing the IMA measurement log need
to be passed from the current kernel to the next kernel on kexec.

Any existing "linux,ima-kexec-buffer" property in the device tree
needs to be removed and its corresponding memory reservation in
the currently running kernel needs to be freed. The address and
size of the current kernel's IMA measurement log need to be added
to the device tree's IMA kexec buffer node and memory for the buffer
needs to be reserved for the log to be carried over to the next kernel
on the kexec call.

Add address and size fields to "struct kimage_arch" for ARM64 platform
to hold the address and size of the IMA measurement log buffer. Remove
any existing "linux,ima-kexec-buffer" property in the device tree and
free the corresponding memory reservation in the currently running
kernel. Add "linux,ima-kexec-buffer" property to the device tree and
reserve the memory for storing the IMA log that needs to be passed from
the current kernel to the next one.

Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC to indicate
that the IMA measurement log information is present in the device tree
for ARM64.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/arm64/Kconfig             | 1 +
 arch/arm64/include/asm/kexec.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1d466addb078..c85d18b1f2fd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1094,6 +1094,7 @@ config KEXEC
 config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
+	select HAVE_IMA_KEXEC
 	help
 	  This is new version of kexec system call. This system call is
 	  file based and takes file descriptors as system call argument
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index d24b527e8c00..2bd19ccb6c43 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -100,6 +100,11 @@ struct kimage_arch {
 	void *elf_headers;
 	unsigned long elf_headers_mem;
 	unsigned long elf_headers_sz;
+
+#ifdef CONFIG_IMA_KEXEC
+	phys_addr_t ima_buffer_addr;
+	size_t ima_buffer_size;
+#endif
 };
 
 extern const struct kexec_file_ops kexec_image_ops;
-- 
2.29.2

