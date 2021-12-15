Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5150B476089
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Dec 2021 19:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343659AbhLOSSi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Dec 2021 13:18:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343657AbhLOSSh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Dec 2021 13:18:37 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFGfalM010534;
        Wed, 15 Dec 2021 18:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=nGeh01gluSDS5Phrfv8zqwtLok0osbCDT8oPiLUPPzE=;
 b=terwJV7vYvZX0u/VOXHTLlrm6Q83zUL6zy8LsU6hWtIZ9AaclEvmGxeKcONlaAaXsH7M
 Kc09vv9lRs4n3Og/JArS9K78e14O2WtJhJMNu9OGov9kQxyUtzrEZN3B22mSIhuf5Tqg
 4kqwPqqr7verH086vtpYXZpqCPtFfI1y0dT1XpfO9v+pgpA6ddtUkueDY8koedsmwPkG
 U6a6dLjgPjrBzVHiPECZyvbblhbrLssqBQyYxR2yVYZCPxoGmyFZgcQnVjr3T3HCtgTi
 ouv7KaEpIsQjJuhmhBNUzz8uVQVCpoW1LJMgC9wwapjn8FK/f61dvSB7ZDW7h2iH/v8u 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cye72udnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 18:18:20 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BFHTMgI020453;
        Wed, 15 Dec 2021 18:18:20 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cye72udn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 18:18:20 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BFHrMUT031529;
        Wed, 15 Dec 2021 18:18:17 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3cy7qw01jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 18:18:12 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BFI8qpv36176136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 18:08:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3C06A406D;
        Wed, 15 Dec 2021 18:16:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B1EFA4065;
        Wed, 15 Dec 2021 18:16:49 +0000 (GMT)
Received: from sig-9-65-74-182.ibm.com (unknown [9.65.74.182])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Dec 2021 18:16:49 +0000 (GMT)
Message-ID: <a54f7de463853f9c3b7404739793d2f690aa317e.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fix undefined arch_ima_get_secureboot() and co
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Date:   Wed, 15 Dec 2021 13:16:48 -0500
In-Reply-To: <20211215160345.GF3786@linux-l9pv.suse>
References: <20211213161145.3447-1-tiwai@suse.de>
         <d99fc78005d8a245449dd6ca0158cf9e2a897465.camel@linux.ibm.com>
         <s5hpmpz9o08.wl-tiwai@suse.de> <20211215160345.GF3786@linux-l9pv.suse>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cWeiEobYK4OcGQ67NnbTt9ZU2poW88AT
X-Proofpoint-ORIG-GUID: h_FTy4B6l_kq_dUwjQzq88COT9afY_-g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_10,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150101
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Eric Snowberg, Jarkko]

Hi Joey,

On Thu, 2021-12-16 at 00:03 +0800, joeyli wrote:
> Hi Takashi, Mimi,
> 
> On Tue, Dec 14, 2021 at 04:58:47PM +0100, Takashi Iwai wrote:
> > On Tue, 14 Dec 2021 16:31:21 +0100,
> > Mimi Zohar wrote:
> > > 
> > > Hi Takashi,
> > > 
> > > On Mon, 2021-12-13 at 17:11 +0100, Takashi Iwai wrote:
> > > > Currently arch_ima_get_secureboot() and arch_get_ima_policy() are
> > > > defined only when CONFIG_IMA is set, and this makes the code calling
> > > > those functions without CONFIG_IMA failing.  Although there is no such
> > > > in-tree users, but the out-of-tree users already hit it.
> > > > 
> > > > Move the declaration and the dummy definition of those functions
> > > > outside ifdef-CONFIG_IMA block for fixing the undefined symbols.
> > > > 
> > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > 
> > > Before lockdown was upstreamed, we made sure that IMA and lockdown
> > > could co-exist.  This patch makes the stub functions available even
> > > when IMA is not configured.  Do the remaining downstream patches
> > > require IMA to be disabled or can IMA co-exist?
> > 
> > I guess Joey (Cc'ed) can explain this better.  AFAIK, currently it's
> > used in a part of MODSIGN stuff in SUSE kernels, and it's calling
> > unconditionally this function for checking whether the system is with
> > the Secure Boot or not.
> >
> 
> Actually in downstream code, I used arch_ima_get_secureboot() in
> load_uefi_certs() to prevent the mok be loaded when secure boot is
> disabled. Because the security of MOK relies on secure boot.
> 
> The downstream code likes this:
> 
> /* the MOK and MOKx can not be trusted when secure boot is disabled */
> -      if (!efi_enabled(EFI_SECURE_BOOT))
> +      if (!arch_ima_get_secureboot())
> 		return 0;
> 
> The old EFI_SECURE_BOOT bit can only be available on x86_64, so I switch
> the code to to arch_ima_get_secureboot() for cross-architectures and sync
> with upstream api.
> 
> The load_uefi.c depends on CONFIG_INTEGRITY but not CONFIG_IMA. So
> load_uefi.c still be built when CONFIG_INTEGRITY=y and CONFIG_IMA=n.
> Then "implicit declaration of function 'arch_ima_get_secureboot'" is
> happened.

The existing upstream code doesn't require secureboot to load the
MOK/MOKx keys.  Why is your change being made downstream?

Are you aware of Eric Snowberg's "Enroll kernel keys thru MOK" patch
set?  When INTEGRITY_MACHINE_KEYRING is enabled and new UEFI variables
are enabled,  instead of loading the MOK keys onto the .platform
keyring, they're loaded onto a new keyring name ".machine", which is
linked to the secondary keyring.

Eric's patchset doesn't add a new check either to make sure secure boot
is enabled before loading the MOK/MOKx keys.

thanks,

Mimi

