Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D962E0F11
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Dec 2020 20:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgLVTqd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 14:46:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbgLVTqd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 14:46:33 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BMJVni1083551;
        Tue, 22 Dec 2020 14:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=WjWJp3AIQDryqKRLNFaJp2pECH69G2IqGHqR79KvEbc=;
 b=FTzBjeQfUBVJlL0tLCUMdFNUkKef5XjZrUcQatIb/gXq4l1UEeEUDr+6P+09+GzLtR+B
 7dDdkpAj+rGI19o+ojyccouiH6aX8rhERWxJqwB2awEWUQw3NxwVEG/etjeaZmMYWyrI
 YY2fV8su9X9CvL4WtE+JY+DOWeYG4S18loWP4F1Mviwn9eUOPuOZ7SoQxdOe6ltIx6rP
 FBbSMYjs75OEgJbCt6D4UCaGqiWP4XXtt1aQPsfl4bk7+ydo9EpYg/m5cmGqgewf2Io7
 YMr1tkU8HwqwqV6GiGKU0RxcpCQRWLHbxjLD7rjZqgeVk0/7I79sY+mSjF7PltfRt1gF kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35kq008bv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 14:45:18 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BMJYrsg094719;
        Tue, 22 Dec 2020 14:45:18 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35kq008bub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 14:45:17 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BMJjFmn032299;
        Tue, 22 Dec 2020 19:45:15 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 35kefjg7hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 19:45:15 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BMJjCL625952760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Dec 2020 19:45:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 948BDA4067;
        Tue, 22 Dec 2020 19:45:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F0C3A4060;
        Tue, 22 Dec 2020 19:45:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.81.142])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Dec 2020 19:45:06 +0000 (GMT)
Message-ID: <7a347c8f2a76fc80551a3dfcb66b0eec9b024a90.camel@linux.ibm.com>
Subject: Re: [PATCH v13 2/6] powerpc: Move arch independent ima kexec
 functions to drivers/of/kexec.c
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        bauerman@linux.ibm.com, robh@kernel.org,
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
Date:   Tue, 22 Dec 2020 14:45:05 -0500
In-Reply-To: <e0d9398b-1b46-8115-7bf0-28e9826fcd6b@linux.microsoft.com>
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
         <20201219175713.18888-3-nramas@linux.microsoft.com>
         <a1a4526c0759eb3b5d70fb8edc89360718376def.camel@linux.ibm.com>
         <e0d9398b-1b46-8115-7bf0-28e9826fcd6b@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_09:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012220138
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-12-22 at 10:53 -0800, Lakshmi Ramasubramanian wrote:
> On 12/22/20 6:26 AM, Mimi Zohar wrote:
> 
> Hi Mimi,
> 
> > 
> > On Sat, 2020-12-19 at 09:57 -0800, Lakshmi Ramasubramanian wrote:
> >>
> >> diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
> >> index 4aff6846c772..b6c52608cb49 100644
> >> --- a/arch/powerpc/kexec/Makefile
> >> +++ b/arch/powerpc/kexec/Makefile
> >> @@ -9,13 +9,6 @@ obj-$(CONFIG_PPC32)		+= relocate_32.o
> >>   
> >>   obj-$(CONFIG_KEXEC_FILE)	+= file_load.o ranges.o file_load_$(BITS).o elf_$(BITS).o
> >>   
> >> -ifdef CONFIG_HAVE_IMA_KEXEC
> >> -ifdef CONFIG_IMA
> >> -obj-y				+= ima.o
> >> -endif
> >> -endif
> > 
> > Notice how "kexec/ima.o" is only included if the architecture supports
> > it and IMA is configured.  In addition only if CONFIG_IMA_KEXEC is
> > configured, is the IMA measurement list carried across kexec.  After
> > moving the rest of ima.c to drivers/of/kexec.c, this changes.   Notice
> > how drivers/of/Kconfig includes kexec.o:
> > 
> > obj-$(CONFIG_KEXEC_FILE) += kexec.o
> > 
> > It is not dependent on CONFIG_HAVE_IMA_KEXEC.  Shouldn't all of the
> > functions defined in ima.c being moved to kexec.o be defined within a
> > CONFIG_HAVE_IMA_KEXEC ifdef?
> > 
> 
> Thanks for reviewing the changes.
> 
> In "drivers/of/kexec.c" the function remove_ima_buffer() is defined 
> under "#ifdef CONFIG_HAVE_IMA_KEXEC"
> 
> setup_ima_buffer() is defined under "#ifdef CONFIG_IMA_KEXEC" - the same 
> way it was defined in "arch/powerpc/kexec/ima.c".
> 
> As you know, CONFIG_IMA_KEXEC depends on CONFIG_HAVE_IMA_KEXEC (as 
> defined in "security/integrity/ima/Kconfig").
> 
> ima_get_kexec_buffer() and ima_free_kexec_buffer() are unconditionally 
> defined in "drivers/of/kexec.c" even though they are called only when 
> CONFIG_HAVE_IMA_KEXEC is enabled. I will update these two functions to 
> be moved under "#ifdef CONFIG_HAVE_IMA_KEXEC"

The issue is the reverse.  CONFIG_HAVE_IMA_KEXEC may be enabled without
CONFIG_IMA_KEXEC being enabled.  This allows the architecture to
support carrying the measurement list across kexec, but requires
enabling it at build time.

Only if CONFIG_HAVE_IMA_KEXEC is enabled should any of these functions
be compiled at build.  This allows restoring the previous IMA
measurement list, even if CONFIG_IMA_KEXEC is not enabled.

Only if CONFIG_IMA_KEXEC is enabled, should carrying the measurement
list across kexec be enabled.  See how arch_ima_add_kexec_buffer,
write_number, setup_ima_buffer are ifdef'ed in
arch/powerpc/kexec/ima.c.

Mimi

