Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47E73171C8
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Feb 2021 21:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhBJU5d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 15:57:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232742AbhBJU5a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 15:57:30 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11AKYr2N082478;
        Wed, 10 Feb 2021 15:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=RHSB88zCVporwbG0VaKSPTHELg9OpgAX2aNaBHi0qoQ=;
 b=gzX+FK7+trWaZ3nl0yC4KclhOZ/lcvf04EQuo9GFn7okUBNqTOiyrUVzOSwPn5LbP+09
 gJNhkBhjmAEF2Lbsi1Pb4K2W0fKN60Ep/Ux1oQYl2Ps7zDDOLkG/cULByq+4zJ1iGgno
 79d3OVdNj/nevdhZPOla+UJDJy+Wy6a8aAy06LCh4cbdPr2/FpQUkz7XXj4QeoKhPxjT
 TvCMgJkHjjrKeUa+nAz3OBddF4tUYNXQiF2M+TKEcLrJWi97IpNgCALvBwVqaXGjS0k4
 JC90mEdocoJLwAshKfVGnYveTayKcRDD/TKO13a8WFa0xAE/3+1noUF102u+85ygOlsD cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36mpaws3xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 15:56:05 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11AKs6Kv027969;
        Wed, 10 Feb 2021 15:56:04 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36mpaws3w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 15:56:04 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11AKm9KM027377;
        Wed, 10 Feb 2021 20:56:00 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 36hjr8ap8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 20:56:00 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11AKtmfc35586342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 20:55:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8180B42045;
        Wed, 10 Feb 2021 20:55:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F0804204B;
        Wed, 10 Feb 2021 20:55:53 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.111.148])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Feb 2021 20:55:53 +0000 (GMT)
Message-ID: <cf7930239b93044a1be353556b7dc730e024f658.camel@linux.ibm.com>
Subject: Re: [PATCH v17 00/10] Carry forward IMA measurement log on kexec on
 ARM64
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Rob Herring <robh@kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Joe Perches <joe@perches.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        James Morse <james.morse@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>,
        vincenzo.frascino@arm.com, Mark Rutland <mark.rutland@arm.com>,
        dmitry.kasatkin@gmail.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allison Randal <allison@lohutok.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, tao.li@vivo.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Wed, 10 Feb 2021 15:55:52 -0500
In-Reply-To: <CAL_JsqLmdqfFF8u=dE+dQz+6ngv=moWkQF8tpZjUCX-vHuvU_w@mail.gmail.com>
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
         <20210210171500.GA2328209@robh.at.kernel.org>
         <5c002c32-bc49-acda-c641-7b1494ea292d@linux.microsoft.com>
         <CAL_JsqLmdqfFF8u=dE+dQz+6ngv=moWkQF8tpZjUCX-vHuvU_w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_10:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100178
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-02-10 at 14:42 -0600, Rob Herring wrote:
> On Wed, Feb 10, 2021 at 11:33 AM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
> >
> > On 2/10/21 9:15 AM, Rob Herring wrote:
> > > On Tue, Feb 09, 2021 at 10:21:50AM -0800, Lakshmi Ramasubramanian wrote:
> > >> On kexec file load Integrity Measurement Architecture (IMA) subsystem
> > >> may verify the IMA signature of the kernel and initramfs, and measure
> > >> it.  The command line parameters passed to the kernel in the kexec call
> > >> may also be measured by IMA.  A remote attestation service can verify
> > >> a TPM quote based on the TPM event log, the IMA measurement list, and
> > >> the TPM PCR data.  This can be achieved only if the IMA measurement log
> > >> is carried over from the current kernel to the next kernel across
> > >> the kexec call.
> > >>
> > >> powerpc already supports carrying forward the IMA measurement log on
> > >> kexec.  This patch set adds support for carrying forward the IMA
> > >> measurement log on kexec on ARM64.
> > >>
> > >> This patch set moves the platform independent code defined for powerpc
> > >> such that it can be reused for other platforms as well.  A chosen node
> > >> "linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
> > >> the address and the size of the memory reserved to carry
> > >> the IMA measurement log.
> > >>
> > >> This patch set has been tested for ARM64 platform using QEMU.
> > >> I would like help from the community for testing this change on powerpc.
> > >> Thanks.
> > >>
> > >> This patch set is based on
> > >> commit 96acc833dec8 ("ima: Free IMA measurement buffer after kexec syscall")
> > >> in https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> > >> "next-integrity" branch.
> > >
> > > Is that a hard dependency still? Given this is now almost entirely
> > > deleting arch code and adding drivers/of/ code, I was going to apply it.
> > >
> >
> > I tried applying the patches in Linus' mainline branch -
> > PATCH #5 0005-powerpc-Move-ima-buffer-fields-to-struct-kimage.patch
> > doesn't apply.
> >
> > But if I apply the dependent patch set (link given below), all the
> > patches in this patch set apply fine.
> >
> > https://patchwork.kernel.org/project/linux-integrity/patch/20210204174951.25771-2-nramas@linux.microsoft.com/
> 
> Ideally, we don't apply the same patch in 2 branches. It looks like
> there's a conflict but no real dependence on the above patch (the
> ima_buffer part). The conflict seems trivial enough that Linus can
> resolve it in the merge window.
> 
> Or Mimi can take the whole thing if preferred?

How about I create a topic branch with just the two patches, allowing
both of us to merge it?   There shouldn't be a problem with re-writing
next-integrity history.

Mimi


