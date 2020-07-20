Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BB3226335
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgGTPYF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 11:24:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47810 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgGTPX6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 11:23:58 -0400
Received: from prsriva-linux.hsd1.wa.comcast.net (c-24-19-135-168.hsd1.wa.comcast.net [24.19.135.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id D88C120B490F;
        Mon, 20 Jul 2020 08:23:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D88C120B490F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595258637;
        bh=EUcMyDqZ4Fg5vK3Ykz1aXcAoaHK493NaidtUiuM+e7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMW2EuY1o3kAJxX6Axmp3yf3M7hyFoQfwCACaf2Sc7vraeB/4JXNvwg2vq9R1uLAb
         wB53eEshn/+Y6fZSBOS6qVenBPAak+cFvK+Yz6kGw7N/s5UqbL6l/ZL2GLDciftHxu
         TiJKUGFGk0QtTVjO9aleSEPcMpoqjvBzJit2EFaA=
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, robh+dt@kernel.org,
        frowand.list@gmail.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, masahiroy@kernel.org, james.morse@arm.com,
        bhsharma@redhat.com, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        gregkh@linuxfoundation.org, nramas@linux.microsoft.com,
        prsriva@linux.microsoft.com, tusharsu@linux.microsoft.com,
        balajib@linux.microsoft.com, bauerman@linux.ibm.com,
        robh@kernel.org
Subject: [PATCH V3 5/6] Update the Kconfig to support carrying forward the IMA Measurement log and and update the setup_dtb call to add the linux,ima-kexec-buffer property to the DTB.
Date:   Mon, 20 Jul 2020 08:23:41 -0700
Message-Id: <20200720152342.337990-6-prsriva@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720152342.337990-1-prsriva@linux.microsoft.com>
References: <20200720152342.337990-1-prsriva@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
---
 arch/arm64/Kconfig                     |  1 +
 arch/arm64/kernel/machine_kexec_file.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 66dc41fd49f2..ece34b8ca648 100644
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
index 4c54723e7a04..066670c43626 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -153,6 +153,17 @@ static int setup_dtb(struct kimage *image,
 				FDT_PROP_KASLR_SEED);
 	}
 
+	/* add ima-kexec-buffer */
+	if (image->arch.ima_buffer_size > 0) {
+
+		ret = fdt_appendprop_addrrange(dtb, 0, off,
+				"linux,ima-kexec-buffer",
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
2.25.1

