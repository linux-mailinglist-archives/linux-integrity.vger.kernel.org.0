Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626DF47730B
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 14:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbhLPNXO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 08:23:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232110AbhLPNXO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 08:23:14 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGAhMrY038697;
        Thu, 16 Dec 2021 13:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=C60u5fgQwrqkI/S3ecNj2qnPkL6oMzGVTZ1CXYGQmPI=;
 b=ZBdT6uo+fQzyRgBxCIn/XrtnphSlI71kwQhBEYN5FF/qSMWcxRp1M3w2uEM3teaOhVKI
 RMHLfuRQEMb+iouObqxucsYlNerjOdNZDX9lzgfX4KEf1Ltf8NM0F/eIjOHRJaTDpz0A
 hF6/I4sEFQZdGT5cwPYSHROtnfArVWw6BXXDHDKCxvQwXh0UAxFiMDr5WmklX9oiAbEm
 Z520QrEti5YSX9tlylNicWzkPnlivo97tzx3zb/9lauLc64ndcg30EZRrkfEb0Hj+WQj
 eRZenyLsWYb4AcFO2yjJp2o3SbwySXOcUOJQUKehZEZ3DrsfMA772gtcEwT+J5tjtpkM lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cymkw5xb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 13:23:04 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BGDN4jV020625;
        Thu, 16 Dec 2021 13:23:04 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cymkw5xa8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 13:23:03 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BGDIU21029147;
        Thu, 16 Dec 2021 13:23:01 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3cy7k9ekkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 13:23:01 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BGDMwWi14877060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 13:22:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8669AE053;
        Thu, 16 Dec 2021 13:22:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9E19AE04D;
        Thu, 16 Dec 2021 13:22:57 +0000 (GMT)
Received: from sig-9-65-93-34.ibm.com (unknown [9.65.93.34])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 13:22:57 +0000 (GMT)
Message-ID: <72b57e7f22a593ea7fe38e340ba11de944658554.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fix undefined arch_ima_get_secureboot() and co
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     joeyli <jlee@suse.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Date:   Thu, 16 Dec 2021 08:22:56 -0500
In-Reply-To: <20211216043212.GG3786@linux-l9pv.suse>
References: <20211213161145.3447-1-tiwai@suse.de>
         <d99fc78005d8a245449dd6ca0158cf9e2a897465.camel@linux.ibm.com>
         <s5hpmpz9o08.wl-tiwai@suse.de> <20211215160345.GF3786@linux-l9pv.suse>
         <a54f7de463853f9c3b7404739793d2f690aa317e.camel@linux.ibm.com>
         <20211216043212.GG3786@linux-l9pv.suse>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AWs_xyAFMNpQnf6ETQvsFhZgLU4prfqw
X-Proofpoint-ORIG-GUID: sUnBR6dCTZ_YliRkNsmqGLItsiUglCtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_04,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160073
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-12-16 at 12:32 +0800, joeyli wrote:
> On Wed, Dec 15, 2021 at 01:16:48PM -0500, Mimi Zohar wrote:
> > [Cc'ing Eric Snowberg, Jarkko]
> > 
> > Hi Joey,
> > 
> > On Thu, 2021-12-16 at 00:03 +0800, joeyli wrote:
> > > Hi Takashi, Mimi,
> > > 
> > > On Tue, Dec 14, 2021 at 04:58:47PM +0100, Takashi Iwai wrote:
> > > > On Tue, 14 Dec 2021 16:31:21 +0100,
> > > > Mimi Zohar wrote:
> > > > > 
> > > > > Hi Takashi,
> > > > > 
> > > > > On Mon, 2021-12-13 at 17:11 +0100, Takashi Iwai wrote:
> > > > > > Currently arch_ima_get_secureboot() and arch_get_ima_policy() are
> > > > > > defined only when CONFIG_IMA is set, and this makes the code calling
> > > > > > those functions without CONFIG_IMA failing.  Although there is no such
> > > > > > in-tree users, but the out-of-tree users already hit it.
> > > > > > 
> > > > > > Move the declaration and the dummy definition of those functions
> > > > > > outside ifdef-CONFIG_IMA block for fixing the undefined symbols.
> > > > > > 
> > > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > > 
> > > > > Before lockdown was upstreamed, we made sure that IMA and lockdown
> > > > > could co-exist.  This patch makes the stub functions available even
> > > > > when IMA is not configured.  Do the remaining downstream patches
> > > > > require IMA to be disabled or can IMA co-exist?
> > > > 
> > > > I guess Joey (Cc'ed) can explain this better.  AFAIK, currently it's
> > > > used in a part of MODSIGN stuff in SUSE kernels, and it's calling
> > > > unconditionally this function for checking whether the system is with
> > > > the Secure Boot or not.
> > > >
> > > 
> > > Actually in downstream code, I used arch_ima_get_secureboot() in
> > > load_uefi_certs() to prevent the mok be loaded when secure boot is
> > > disabled. Because the security of MOK relies on secure boot.
> > > 
> > > The downstream code likes this:
> > > 
> > > /* the MOK and MOKx can not be trusted when secure boot is disabled */
> > > -      if (!efi_enabled(EFI_SECURE_BOOT))
> > > +      if (!arch_ima_get_secureboot())
> > > 		return 0;
> > > 
> > > The old EFI_SECURE_BOOT bit can only be available on x86_64, so I switch
> > > the code to to arch_ima_get_secureboot() for cross-architectures and sync
> > > with upstream api.
> > > 
> > > The load_uefi.c depends on CONFIG_INTEGRITY but not CONFIG_IMA. So
> > > load_uefi.c still be built when CONFIG_INTEGRITY=y and CONFIG_IMA=n.
> > > Then "implicit declaration of function 'arch_ima_get_secureboot'" is
> > > happened.
> > 
> > The existing upstream code doesn't require secureboot to load the
> > MOK/MOKx keys.  Why is your change being made downstream?
> >
> Because the security of MOK relies on secure boot. When secure boot is
> disabled, EFI firmware will not verify binary code. So arbitrary efi
> binary code can modify MOK when rebooting.
> 
> When user disabled secure boot, a hacker can just replace shim.efi then
> reboot for enrolling new MOK without any interactive. Or hacker can just
> replace shim.efi and wait user to reboot their machine. A hacker's MOK can
> also be enrolled by hacked shim. User can't perceive. 
>  
> > Are you aware of Eric Snowberg's "Enroll kernel keys thru MOK" patch
> > set?  When INTEGRITY_MACHINE_KEYRING is enabled and new UEFI variables
> > are enabled,  instead of loading the MOK keys onto the .platform
> > keyring, they're loaded onto a new keyring name ".machine", which is
> > linked to the secondary keyring.
> > 
> > Eric's patchset doesn't add a new check either to make sure secure boot
> > is enabled before loading the MOK/MOKx keys.
> >
> 
> Kernel doesn't know how was a MOK enrolled. Kernel can only detect the
> state of secure boot. If kernel doesn't want to check the state of secure
> boot before loading MOK, then user should understands that they can not disable
> secure boot when using MOK. 

Thanks, Joey, for the detailed explained.  I was agreeing with you that
MOK/MOKx keys should only be loaded when secure boot is enabled.  A
better way for me to have phrased the questions would have been, why
are you making this change downstream and not upstream?

thanks,

Mimi

