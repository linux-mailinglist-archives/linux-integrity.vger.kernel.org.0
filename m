Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202B550FF8D
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Apr 2022 15:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347550AbiDZNxj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Apr 2022 09:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245649AbiDZNxi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Apr 2022 09:53:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68D512620;
        Tue, 26 Apr 2022 06:50:29 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QCMoCN007323;
        Tue, 26 Apr 2022 13:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Q0jaz1HrIi744S+qWz0aV7c81C4Syn+bjw3DDBg+xBg=;
 b=YOURaXCX/WgSEuJNYsnCGvTxnCBZDeJN2Z7y0vgfQi9mfndCbDtRrFyppMYPDQHth3bK
 kKPQAXp3MESMOoR7Wv+Dz5CM4MEuF+b7N5ucZviQT9Sk6645VGoQ3IrhfZqODJTkAdld
 bw5bIfdMw/lNXch+IfFJGY7E4N/flK5HbWx/Ol2Vq3bhoxr3OfkMQ8iSPRgLO1V/bM1P
 6KQPTbgu4wxRM/NaMXbLSjMjrixuCZQT6aNqPPZSHSVUuYtmFkbjLVwF+adpIJXAUSlv
 8fhNrWF/s4dQl6imxtMAei//PpDmveLsXhsaqlfQsgLt9q3fAkOYS3+pQsFCgtTzhcXf Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpbyh84wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 13:50:00 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23QDjJEV018452;
        Tue, 26 Apr 2022 13:49:59 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpbyh84w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 13:49:59 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QDcaNE017139;
        Tue, 26 Apr 2022 13:49:57 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm938vftu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 13:49:57 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QDar8P53281270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 13:36:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77E9A11C050;
        Tue, 26 Apr 2022 13:49:55 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0617E11C04C;
        Tue, 26 Apr 2022 13:49:54 +0000 (GMT)
Received: from sig-9-65-95-142.ibm.com (unknown [9.65.95.142])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 13:49:53 +0000 (GMT)
Message-ID: <41f9d261a7750e576460360c512a8e4c1492efa3.camel@linux.ibm.com>
Subject: Re: [PATCH] Carry forward IMA measurement log on kexec on x86_64
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jonathan McDowell <noodles@fb.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Tue, 26 Apr 2022 09:49:53 -0400
In-Reply-To: <YmfgyyUs6TgM/Czx@noodles-fedora-PC23Y6EG>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
         <12108732c287a85a417927de37cb027cefae6e06.camel@linux.ibm.com>
         <YmfgyyUs6TgM/Czx@noodles-fedora-PC23Y6EG>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OUIcOi4QcBjdBfgMowm32ozP-RUVxJur
X-Proofpoint-GUID: VRi_EdctptlzSEnzmfoupoLW-Qzb43nn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-04-26 at 12:08 +0000, Jonathan McDowell wrote:
> On Mon, Apr 25, 2022 at 12:29:17PM -0400, Mimi Zohar wrote:
> > Hi Jonathan,
> > 
> > On Fri, 2022-04-22 at 13:50 +0000, Jonathan McDowell wrote:
> > > On kexec file load Integrity Measurement Architecture (IMA) subsystem
> > > may verify the IMA signature of the kernel and initramfs, and measure
> > > it. The command line parameters passed to the kernel in the kexec call
> > > may also be measured by IMA. A remote attestation service can verify
> > > a TPM quote based on the TPM event log, the IMA measurement list, and
> > > the TPM PCR data. This can be achieved only if the IMA measurement log
> > > is carried over from the current kernel to the next kernel across
> > > the kexec call.
> > > 
> > > powerpc and ARM64 both achieve this using device tree with a
> > > "linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
> > > device tree, so the IMA infrastructure is extended to allow non device
> > > tree platforms to provide a log buffer. x86 then passes the IMA buffer
> > > to the new kernel via the setup_data mechanism.
> > > 
> > > Signed-off-by: Jonathan McDowell <noodles@fb.com>
> > 
> > FYI, after applying, building, and booting a kernel with this patch,
> > "kexec -s -l /boot/vmlinuz-5.18.0-rc4+ --reuse-cmdline --
> > initrd=/boot/initramfs-5.18.0-rc4+.img" properly loads the kernel, but
> > "kexec -s -e" fails to reboot, at least on a test laptop even with only
> > the "boot_aggregate" measurement record.
> > 
> > Without enabling CONFIG_IMA_KEXEC, kexec boots properly.
> 
> Thanks for giving it a try. At a guess your laptop is booting with
> EFI, whereas for my testing I was using qemu with legacy BIOS. I've
> managed to reproduce the issue with qemu+OVMF and isolated the mistake
> in the setup data calculation I made when EFI is involved. If you have
> time can you try with the below on top of the original patch?

Thank you!  With the change, as expected there are two "boot_aggregate"
records in the measurement list.  With a custom policy, the measurement
list verifies.

# grep boot_aggregate
/sys/kernel/security/ima/ascii_runtime_measurements 
10 fe0b821290b1bd229e0d34c5571f48eeff403119 ima-sig
sha1:a87d47e560d148cd1f4c8da677a84ddbe27f12f8 boot_aggregate 
10 fe0b821290b1bd229e0d34c5571f48eeff403119 ima-sig
sha1:a87d47e560d148cd1f4c8da677a84ddbe27f12f8 boot_aggregate 

# cat /sys/kernel/security/ima/runtime_measurements_count
5597

# evmctl ima_measurement
/sys/kernel/security/ima/binary_runtime_measurements
Matched per TPM
bank calculated digest(s).

FYI, the builtin "ima_policy=tcb" results in measurement violations.  
Normally, the measurement list can still be verified using the evmctl
"--ignore-violations" option.   For some reason with the "tcb" policy, 
the measurement list doesn't verify even with the "--ignore-violations" 
option after kexec.  I assume this is a result of additional
measurements being added after the kexec load, which aren't being
carried across kexec.

thanks,

Mimi

> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 07625da33075..cdc73e081585 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -277,7 +277,9 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
>  #ifdef CONFIG_IMA_KEXEC
>  	/* Setup IMA log buffer state */
>  	setup_ima_state(image, params, params_load_addr,
> -			efi_setup_data_offset + ALIGN(efi_map_sz, 16) + sizeof(struct setup_data));
> +			efi_setup_data_offset +
> +			sizeof(struct setup_data) +
> +			sizeof(struct efi_setup_data));
>  #endif
>  
>  	/* Setup EDD info */


