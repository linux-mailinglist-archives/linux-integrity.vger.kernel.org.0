Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58EB5E5275
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502902AbfJYRjz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 13:39:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505866AbfJYRjz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 13:39:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PHapsi051284
        for <linux-integrity@vger.kernel.org>; Fri, 25 Oct 2019 13:39:54 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vv3ck525w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 25 Oct 2019 13:39:53 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 25 Oct 2019 18:39:51 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Oct 2019 18:39:46 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9PHdj5W21102994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 17:39:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B407AE045;
        Fri, 25 Oct 2019 17:39:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8A1AAE053;
        Fri, 25 Oct 2019 17:39:43 +0000 (GMT)
Received: from dhcp-9-31-103-196.watson.ibm.com (unknown [9.31.103.196])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Oct 2019 17:39:43 +0000 (GMT)
Subject: Re: [PATCH V4 0/2] Add support for arm64 to carry ima measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Morse <james.morse@arm.com>
Cc:     prsriva <prsriva@linux.microsoft.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de,
        takahiro.akashi@linaro.org, sboyd@kernel.org,
        catalin.marinas@arm.com, yamada.masahiro@socionext.com,
        duwe@lst.de, tglx@linutronix.de, allison@lohutok.net,
        ard.biesheuvel@linaro.org
Date:   Fri, 25 Oct 2019 13:39:43 -0400
In-Reply-To: <3879883b-8c27-df25-ce20-97ed7274dc80@arm.com>
References: <20191011003600.22090-1-prsriva@linux.microsoft.com>
         <87d92514-e5e4-a79f-467f-f24a4ed279b6@arm.com>
         <b35b239c-990c-0d5b-0298-8f9e35064e2b@linux.microsoft.com>
         <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
         <1571190256.5250.200.camel@linux.ibm.com>
         <3879883b-8c27-df25-ce20-97ed7274dc80@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102517-0020-0000-0000-0000037EA105
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102517-0021-0000-0000-000021D4EF22
Message-Id: <1572025183.4532.34.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250161
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-10-25 at 18:07 +0100, James Morse wrote:
> Hi Mimi,
> 
> On 16/10/2019 02:44, Mimi Zohar wrote:
> > On Tue, 2019-10-15 at 18:39 +0100, James Morse wrote:
> >> If SecureBoot isn't relevant, I'm confused as to why kexec_file_load() is.
> >>
> >> I thought kexec_file_load() only existed because SecureBoot systems need to validate the
> >> new OS images's signature before loading it, and we can't trust user-space calling Kexec
> >> to do this.
> >>
> >> If there is no secure boot, why does this thing only work with kexec_file_load()?
> >> (good news! With the UEFI memreseve table, it should work transparently with regular kexec
> >> too)
> 
> > I'm so sorry for the confusion.  IMA was originally limited to
> > extending trusted boot concepts to the OS.  As of Linux 3.10, IMA
> > added support for extending secure boot concepts and auditing file
> > hashes (commit e7c568e0fd0cf).
> > 
> > True, kexec_file_load is required for verifying the kexec kernel
> > image, but it is also required for measuring the kexec kernel image as
> > well.
> > 
> > After reading the kernel image into memory (kernel_read_file_from_fd),
> > the hash is calculated and then added to the IMA measurement list and
> > used to extend the TPM.  All of this is based on the IMA policy,
> > including the TPM PCR.
> 
> Don't we get a set of segments with the regular kexec syscall? These could equally be
> hashed and measured, and logged via IMA and/or extending the TPMs measurements.

IMA works at the file level.  I'm not sure what it would mean to
measure "segments".

Originally, kexec_file_load read the KEXEC kernel image twice, once to
calculate the file hash, and again to verify the signature.  Now
kexec_file_load calls kernel_read_file_from_fd, which reads the file
into memory, before IMA calculates the file buffer hash.

> 
> (obviously this would include the command-line and maybe purgatory, which makes it less
> predictable, but these are still the binary blobs that were given privileged access to the
> system).
> 
> 
> >>> I am not sure if i addressed all your concerns, please let me know
> >>> if i missed anything. To me most concerns look to be towards the kexec case and dependency
> >>> on hardware(ACPI/TPM) during boot and early boot services, where as carrying the logs is
> >>> only during the kexec_file_load sys call and does not interfere with that code path.
> >>> IMA documentation: https://sourceforge.net/p/linux-ima/wiki/Home/
> >>
> >> Supporting ACPI in the same way is something we need to do from day one. kexec_file_load()
> >> already does this. I'm not sure "only kexec_file_load()" is a justifiable restriction...
> 
> > The TPM PCRs are not reset on a soft reboot.  As a result, in order to
> > validate the IMA measurement list against the TPM PCRs, the IMA
> > measurement list is saved on kexec load, restored on boot, and then
> > the memory allocated for carrying the measurement list across kexec is
> > freed.
> 
> Hmm, this is why the reserved memory gets freed.

Yes
> 
> What happens to stuff that happens between kexec-load and boot?
> There is a comment:
> | /* segment size can't change between kexec load and execute */

Right, the original version addressed this, but was nixed by Eric,
saying it was unnecessary.  The current version allocates more memory
than needed to hopefully compensate. 

> 
> But I can't see anywhere that enforces that. I guess those measurements will go missing,
> and the TPM value will not match after kexec.

No, the kexec load will succeed, but if there isn't enough memory to
store the measurement list, the exec should fail.

Mimi

