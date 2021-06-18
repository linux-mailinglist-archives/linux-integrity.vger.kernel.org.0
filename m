Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB70F3AD004
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Jun 2021 18:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhFRQKP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Jun 2021 12:10:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36294 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231819AbhFRQJ5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Jun 2021 12:09:57 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IG1mCN009524;
        Fri, 18 Jun 2021 16:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=wyUKR7Lqo8drNw7N54c7scR0toi7I+kwormUWMDRqXU=;
 b=pSXamAG94Vr17ixcxluY+kVr+1Wqc6fJ0HzZmOwlj3o060lLIPqqddrvz9IG6yFf1wFb
 3mQV1cv7htDTD+87NgfcUvO4TXCsCbM/ewbgdYlE7CCdRBiBkfQBUIqhy6N++hhjd7md
 qpqx8vI/18embXsWfZXUdz+WhapHSZL8D0bMHW+P8Ovx6WZDueBBH7ulq+y+woIKJEVw
 nLyiJlacaR1ytCv8zX+9AgxmmFs77NmYRqD4K9x18LMTlVgk222sXhVfTrhNLvOE5PI4
 8Y3ntBI8N+0JMa+GZDzzK1yKbJb/GhiO085XncWlSRd2P3i4Tg4xqlY1GVO8Cj9Pc63m 4Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 397w1y3k8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15IG1QcE108832;
        Fri, 18 Jun 2021 16:06:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 396wawv2na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:54 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15IG6sQr123130;
        Fri, 18 Jun 2021 16:06:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 396wawv2mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 16:06:54 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15IG6oUG018490;
        Fri, 18 Jun 2021 16:06:50 GMT
Received: from lateralus.us.oracle.com (/10.149.232.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Jun 2021 16:06:50 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: [PATCH v2 07/12] x86: Secure Launch SMP bringup support
Date:   Fri, 18 Jun 2021 12:12:52 -0400
Message-Id: <1624032777-7013-8-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
References: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
X-Proofpoint-ORIG-GUID: NxRRoX2Xkv-umUCSyXndurDZyrGE3Mhi
X-Proofpoint-GUID: NxRRoX2Xkv-umUCSyXndurDZyrGE3Mhi
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Intel, the APs are left in a well documented state after TXT performs
the late launch. Specifically they cannot have #INIT asserted on them so
a standard startup via INIT/SIPI/SIPI cannot be performed. Instead the
early SL stub code parked the APs in a pause/jmp loop waiting for an NMI.
The modified SMP boot code is called for the Secure Launch case. The
jump address for the RM piggy entry point is fixed up in the jump where
the APs are waiting and an NMI IPI is sent to the AP. The AP vectors to
the Secure Launch entry point in the RM piggy which mimics what the real
mode code would do then jumps the the standard RM piggy protected mode
entry point.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/include/asm/realmode.h      |  3 ++
 arch/x86/kernel/smpboot.c            | 86 ++++++++++++++++++++++++++++++++++++
 arch/x86/realmode/rm/header.S        |  3 ++
 arch/x86/realmode/rm/trampoline_64.S | 37 ++++++++++++++++
 4 files changed, 129 insertions(+)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 5db5d08..ef37bf1 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -37,6 +37,9 @@ struct real_mode_header {
 #ifdef CONFIG_X86_64
 	u32	machine_real_restart_seg;
 #endif
+#ifdef CONFIG_SECURE_LAUNCH
+	u32	sl_trampoline_start32;
+#endif
 };
 
 /* This must match data at realmode/rm/trampoline_{32,64}.S */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 7770245..c324b04 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -57,6 +57,7 @@
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
 #include <linux/syscore_ops.h>
+#include <linux/slaunch.h>
 
 #include <asm/acpi.h>
 #include <asm/desc.h>
@@ -1023,6 +1024,83 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+#ifdef CONFIG_SECURE_LAUNCH
+
+static atomic_t first_ap_only = {1};
+
+/*
+ * Called to fix the long jump address for the waiting APs to vector to
+ * the correct startup location in the Secure Launch stub in the rmpiggy.
+ */
+static int
+slaunch_fixup_jump_vector(void)
+{
+	struct sl_ap_wake_info *ap_wake_info;
+	u32 *ap_jmp_ptr = NULL;
+
+	if (!atomic_dec_and_test(&first_ap_only))
+		return 0;
+
+	ap_wake_info = slaunch_get_ap_wake_info();
+
+	ap_jmp_ptr = (u32 *)__va(ap_wake_info->ap_wake_block +
+				 ap_wake_info->ap_jmp_offset);
+
+	*ap_jmp_ptr = real_mode_header->sl_trampoline_start32;
+
+	pr_info("TXT AP long jump address updated\n");
+
+	return 0;
+}
+
+/*
+ * TXT AP startup is quite different than normal. The APs cannot have #INIT
+ * asserted on them or receive SIPIs. The early Secure Launch code has parked
+ * the APs in a pause loop waiting to receive an NMI. This will wake the APs
+ * and have them jump to the protected mode code in the rmpiggy where the rest
+ * of the SMP boot of the AP will proceed normally.
+ */
+static int
+slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
+{
+	unsigned long send_status = 0, accept_status = 0;
+
+	/* Only done once */
+	if (slaunch_fixup_jump_vector())
+		return -1;
+
+	/* Send NMI IPI to idling AP and wake it up */
+	apic_icr_write(APIC_DM_NMI, apicid);
+
+	if (init_udelay == 0)
+		udelay(10);
+	else
+		udelay(300);
+
+	send_status = safe_apic_wait_icr_idle();
+
+	if (init_udelay == 0)
+		udelay(10);
+	else
+		udelay(300);
+
+	accept_status = (apic_read(APIC_ESR) & 0xEF);
+
+	if (send_status)
+		pr_err("Secure Launch IPI never delivered???\n");
+	if (accept_status)
+		pr_err("Secure Launch IPI delivery error (%lx)\n",
+			accept_status);
+
+	return (send_status | accept_status);
+}
+
+#else
+
+#define slaunch_wakeup_cpu_from_txt(cpu, apicid)	0
+
+#endif  /* !CONFIG_SECURE_LAUNCH */
+
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
@@ -1077,6 +1155,13 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 	cpumask_clear_cpu(cpu, cpu_initialized_mask);
 	smp_mb();
 
+	/* With Intel TXT, the AP startup is totally different */
+	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) ==
+	   (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) {
+		boot_error = slaunch_wakeup_cpu_from_txt(cpu, apicid);
+		goto txt_wake;
+	}
+
 	/*
 	 * Wake up a CPU in difference cases:
 	 * - Use the method in the APIC driver if it's defined
@@ -1089,6 +1174,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		boot_error = wakeup_cpu_via_init_nmi(cpu, start_ip, apicid,
 						     cpu0_nmi_registered);
 
+txt_wake:
 	if (!boot_error) {
 		/*
 		 * Wait 10s total for first sign of life from AP
diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index 8c1db5b..9136bd5 100644
--- a/arch/x86/realmode/rm/header.S
+++ b/arch/x86/realmode/rm/header.S
@@ -36,6 +36,9 @@ SYM_DATA_START(real_mode_header)
 #ifdef CONFIG_X86_64
 	.long	__KERNEL32_CS
 #endif
+#ifdef CONFIG_SECURE_LAUNCH
+	.long	pa_sl_trampoline_start32
+#endif
 SYM_DATA_END(real_mode_header)
 
 	/* End signature, used to verify integrity */
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index cc8391f..cdfc2c2 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -104,6 +104,43 @@ SYM_CODE_END(sev_es_trampoline_start)
 
 	.section ".text32","ax"
 	.code32
+#ifdef CONFIG_SECURE_LAUNCH
+	.balign 4
+SYM_CODE_START(sl_trampoline_start32)
+	/*
+	 * The early secure launch stub AP wakeup code has taken care of all
+	 * the vagaries of launching out of TXT. This bit just mimics what the
+	 * 16b entry code does and jumps off to the real startup_32.
+	 */
+	cli
+	wbinvd
+
+	/*
+	 * The %ebx provided is not terribly useful since it is the physical
+	 * address of tb_trampoline_start and not the base of the image.
+	 * Use pa_real_mode_base, which is fixed up, to get a run time
+	 * base register to use for offsets to location that do not have
+	 * pa_ symbols.
+	 */
+	movl    $pa_real_mode_base, %ebx
+
+	/*
+	 * This may seem a little odd but this is what %esp would have had in
+	 * it on the jmp from real mode because all real mode fixups were done
+	 * via the code segment. The base is added at the 32b entry.
+	 */
+	movl	rm_stack_end, %esp
+
+	lgdt    tr_gdt(%ebx)
+	lidt    tr_idt(%ebx)
+
+	movw	$__KERNEL_DS, %dx	# Data segment descriptor
+
+	/* Jump to where the 16b code would have jumped */
+	ljmpl	$__KERNEL32_CS, $pa_startup_32
+SYM_CODE_END(sl_trampoline_start32)
+#endif
+
 	.balign 4
 SYM_CODE_START(startup_32)
 	movl	%edx, %ss
-- 
1.8.3.1

