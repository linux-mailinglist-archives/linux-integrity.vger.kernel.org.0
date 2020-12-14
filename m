Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC232DA042
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Dec 2020 20:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440779AbgLNTUd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Dec 2020 14:20:33 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58450 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440658AbgLNTU3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Dec 2020 14:20:29 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5918420B718C;
        Mon, 14 Dec 2020 11:19:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5918420B718C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607973551;
        bh=DsqR7vzIXHoUsAEq7hzDyWxUD/vBBswSPRJLWzRzPQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OlZCck7KXDpFmFF206z6b5aoRsssJYga0eFCHXG2uJ8Wv1l4hKobTq8XToagJfKkV
         d/e6HnvvGJMJul2lWCU40ne4pXxn0qThZKC5D32/TsUeiz63vRuh+EbbLoTVD3tf9Z
         dntyIENoK3nejHi6taDDE9X+bbwwcemp16NDPjBY=
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
Subject: [PATCH v11 7/8] arm64: Free DTB buffer if fdt_open_into() fails
Date:   Mon, 14 Dec 2020 11:18:53 -0800
Message-Id: <20201214191854.9050-8-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201214191854.9050-1-nramas@linux.microsoft.com>
References: <20201214191854.9050-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

create_dtb() function allocates memory for the device tree blob (DTB)
and calls fdt_open_into(). If this call fails the memory allocated
for the DTB is not freed before returning from create_dtb() thereby
leaking memory.

Call vfree() to free the memory allocated for the DTB if fdt_open_into()
fails.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 7de9c47dee7c..3e045cd62451 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -65,8 +65,10 @@ static int create_dtb(struct kimage *image,
 
 		/* duplicate a device tree blob */
 		ret = fdt_open_into(initial_boot_params, buf, buf_size);
-		if (ret)
+		if (ret) {
+			vfree(buf);
 			return -EINVAL;
+		}
 
 		ret = of_kexec_setup_new_fdt(image, buf, initrd_load_addr,
 					     initrd_len, cmdline);
-- 
2.29.2

