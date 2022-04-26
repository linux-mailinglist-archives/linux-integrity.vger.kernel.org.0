Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D45510657
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Apr 2022 20:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350011AbiDZSOj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Apr 2022 14:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343490AbiDZSOi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Apr 2022 14:14:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386AF68983;
        Tue, 26 Apr 2022 11:11:30 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QH7MKQ032458;
        Tue, 26 Apr 2022 18:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=3s1FybCxQafy+xH7pLCDd52lXS+4Wq7/6kJL7T1SaU8=;
 b=Fztw6XKSpN1GADC5gEpWggaH2jkxgvEzyPtQUk2LBbJcuoxpHXKS2AmcgvU9iQsrGZiC
 LR7gNY248ZZMKUB1KyP40rBoXZSga0FvFv+u4/zHlFPwFB7+6t+EUfqclCi9hNT1Gj3Y
 m/KEKG/2R2uD40uSb6P37rBrvNtu7x25NQ85cr3W1je6hjs2G71p5YxtHgeAVVRsxdKd
 BZ6Z8n/97zXZvkQO5v3XdCPzf5sTEbaBv3F1zHqTgD9c/fJPrBWSM/PdneIqUt1KYGD7
 sxMlIKn20Jf39wR4pDKH/jcjxUlAKDc1PG3/boBZNXAcHQQfKr+/o/Y4Wkkxtox5iPb+ og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpg490gtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 18:11:05 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23QI1ZVZ028476;
        Tue, 26 Apr 2022 18:11:04 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpg490gt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 18:11:04 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23QI2TWZ014140;
        Tue, 26 Apr 2022 18:11:02 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm938vsfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 18:11:02 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QIBDBQ29229432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 18:11:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 760C0A4051;
        Tue, 26 Apr 2022 18:11:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA10AA4040;
        Tue, 26 Apr 2022 18:10:58 +0000 (GMT)
Received: from sig-9-65-87-209.ibm.com (unknown [9.65.87.209])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 18:10:58 +0000 (GMT)
Message-ID: <06a1242830ddb84c52cd77e548c71d40a0eb5e63.camel@linux.ibm.com>
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
Date:   Tue, 26 Apr 2022 14:10:58 -0400
In-Reply-To: <YmgiWpHWH6K1feyt@noodles-fedora-PC23Y6EG>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
         <12108732c287a85a417927de37cb027cefae6e06.camel@linux.ibm.com>
         <YmfgyyUs6TgM/Czx@noodles-fedora-PC23Y6EG>
         <41f9d261a7750e576460360c512a8e4c1492efa3.camel@linux.ibm.com>
         <YmgiWpHWH6K1feyt@noodles-fedora-PC23Y6EG>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lRuNid9m0EcvG7oZVP8qqgQph9gJskXS
X-Proofpoint-ORIG-GUID: CfqGdPCTt12tBUw8_yHt7AREDuaeSHvd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_05,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-04-26 at 16:48 +0000, Jonathan McDowell wrote:
> On Tue, Apr 26, 2022 at 09:49:53AM -0400, Mimi Zohar wrote:
> > On Tue, 2022-04-26 at 12:08 +0000, Jonathan McDowell wrote:
> > > On Mon, Apr 25, 2022 at 12:29:17PM -0400, Mimi Zohar wrote:
> > > > Hi Jonathan,
> > > > 
> > > > On Fri, 2022-04-22 at 13:50 +0000, Jonathan McDowell wrote:
> > > > > On kexec file load Integrity Measurement Architecture (IMA) subsystem
> > > > > may verify the IMA signature of the kernel and initramfs, and measure
> > > > > it. The command line parameters passed to the kernel in the kexec call
> > > > > may also be measured by IMA. A remote attestation service can verify
> > > > > a TPM quote based on the TPM event log, the IMA measurement list, and
> > > > > the TPM PCR data. This can be achieved only if the IMA measurement log
> > > > > is carried over from the current kernel to the next kernel across
> > > > > the kexec call.
> > > > > 
> > > > > powerpc and ARM64 both achieve this using device tree with a
> > > > > "linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
> > > > > device tree, so the IMA infrastructure is extended to allow non device
> > > > > tree platforms to provide a log buffer. x86 then passes the IMA buffer
> > > > > to the new kernel via the setup_data mechanism.
> > > > > 
> > > > > Signed-off-by: Jonathan McDowell <noodles@fb.com>
> > > > 
> > > > FYI, after applying, building, and booting a kernel with this patch,
> > > > "kexec -s -l /boot/vmlinuz-5.18.0-rc4+ --reuse-cmdline --
> > > > initrd=/boot/initramfs-5.18.0-rc4+.img" properly loads the kernel, but
> > > > "kexec -s -e" fails to reboot, at least on a test laptop even with only
> > > > the "boot_aggregate" measurement record.
> > > > 
> > > > Without enabling CONFIG_IMA_KEXEC, kexec boots properly.
> > > 
> > > Thanks for giving it a try. At a guess your laptop is booting with
> > > EFI, whereas for my testing I was using qemu with legacy BIOS. I've
> > > managed to reproduce the issue with qemu+OVMF and isolated the mistake
> > > in the setup data calculation I made when EFI is involved. If you have
> > > time can you try with the below on top of the original patch?
> > 
> > Thank you!  With the change, as expected there are two "boot_aggregate"
> > records in the measurement list.  With a custom policy, the measurement
> > list verifies.
> 
> Excellent, thanks for verifying. I'll get the fixed v2 out.
> 
> ...
> > FYI, the builtin "ima_policy=tcb" results in measurement violations.  
> > Normally, the measurement list can still be verified using the evmctl
> > "--ignore-violations" option.   For some reason with the "tcb" policy, 
> > the measurement list doesn't verify even with the "--ignore-violations" 
> > option after kexec.  I assume this is a result of additional
> > measurements being added after the kexec load, which aren't being
> > carried across kexec.
> 
> I believe with "tcb" things like the subsequent exec of kexec to
> actually do the reboot will end up measured, and as the kexec buffer is
> static it won't include that.
> 
> Also there's an issue about the fact that we measure the kexec pieces
> even if we don't actually do the kexec; there's no marker that confirms
> the kexec took place. It's separate to this patch (in that it affects
> the device tree kexec infrastructure too) but it's conceivable that an
> attacker could measure in the new kernel details and not actually do the
> kexec, and that's not distinguishable from the kexec happening.
> 
> One approach might be to add a marker in the kexec ima buffer such that
> if it's not present we know the kexec hasn't happened, but I need to
> think through that a bit more.

I'm not quite sure what you mean by "we measure the kexec pieces".  The
kexec file load syscall calls kernel_read_file_from_fd() to read the
kernel image into a buffer.  The measurement record included in the IMA
measurement list a hash of the buffer data, which is exactly the same
as the hash of the kernel image.

The kernel kexec self tests only do the kexec load, not the execute. 
For each kexec execute you'll see an additional "boot_aggregate" record
in the IMA measurement list.  At least for the moment I don't see a
need for additional marker.

thanks,

Mimi

