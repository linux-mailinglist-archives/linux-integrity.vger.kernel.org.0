Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A277A2DD663
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Dec 2020 18:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgLQRh4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Dec 2020 12:37:56 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51978 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbgLQRhz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Dec 2020 12:37:55 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9312420B7187;
        Thu, 17 Dec 2020 09:37:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9312420B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608226635;
        bh=DsqR7vzIXHoUsAEq7hzDyWxUD/vBBswSPRJLWzRzPQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJH2aSQNSInOgMEo4bL3Yv5XZOhN3bSPOGA5I77aNRNuW2shc02HSFkfa+sx1oP1G
         3wBcXmRoH4tzfjfguRQBusg3rzfKhWXeUyNDITCdpLMciocgYO/Rj8jIUOZTn7Gt0r
         feqkSRQ5ovai8bAPb/G/oNbPOcGv5AunEiMjgXhI=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     =james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v12 3/4] arm64: Free DTB buffer if fdt_open_into() fails
Date:   Thu, 17 Dec 2020 09:37:07 -0800
Message-Id: <20201217173708.6940-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217173708.6940-1-nramas@linux.microsoft.com>
References: <20201217173708.6940-1-nramas@linux.microsoft.com>
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

