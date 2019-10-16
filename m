Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D6FD8592
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 03:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfJPBoa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Oct 2019 21:44:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726786AbfJPBoa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Oct 2019 21:44:30 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G1ffSw053390
        for <linux-integrity@vger.kernel.org>; Tue, 15 Oct 2019 21:44:29 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vnn837034-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 15 Oct 2019 21:44:28 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 16 Oct 2019 02:44:26 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 02:44:21 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9G1iK7p60162280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 01:44:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64D9A11C052;
        Wed, 16 Oct 2019 01:44:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC1D911C04C;
        Wed, 16 Oct 2019 01:44:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.156.20])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Oct 2019 01:44:17 +0000 (GMT)
Subject: Re: [PATCH V4 0/2] Add support for arm64 to carry ima measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Morse <james.morse@arm.com>,
        prsriva <prsriva@linux.microsoft.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de,
        takahiro.akashi@linaro.org, sboyd@kernel.org,
        catalin.marinas@arm.com, yamada.masahiro@socionext.com,
        duwe@lst.de, bauerman@linux.ibm.com, tglx@linutronix.de,
        allison@lohutok.net, ard.biesheuvel@linaro.org
Date:   Tue, 15 Oct 2019 21:44:16 -0400
In-Reply-To: <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
References: <20191011003600.22090-1-prsriva@linux.microsoft.com>
         <87d92514-e5e4-a79f-467f-f24a4ed279b6@arm.com>
         <b35b239c-990c-0d5b-0298-8f9e35064e2b@linux.microsoft.com>
         <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101601-4275-0000-0000-000003726CDA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101601-4276-0000-0000-00003885806B
Message-Id: <1571190256.5250.200.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160013
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

On Tue, 2019-10-15 at 18:39 +0100, James Morse wrote:
> If SecureBoot isn't relevant, I'm confused as to why kexec_file_load() is.
> 
> I thought kexec_file_load() only existed because SecureBoot systems need to validate the
> new OS images's signature before loading it, and we can't trust user-space calling Kexec
> to do this.
> 
> If there is no secure boot, why does this thing only work with kexec_file_load()?
> (good news! With the UEFI memreseve table, it should work transparently with regular kexec
> too)

I'm so sorry for the confusion.  IMA was originally limited to
extending trusted boot concepts to the OS.  As of Linux 3.10, IMA
added support for extending secure boot concepts and auditing file
hashes (commit e7c568e0fd0cf).

True, kexec_file_load is required for verifying the kexec kernel
image, but it is also required for measuring the kexec kernel image as
well.

After reading the kernel image into memory (kernel_read_file_from_fd),
the hash is calculated and then added to the IMA measurement list and
used to extend the TPM.  All of this is based on the IMA policy,
including the TPM PCR.

> 
> > I am not sure if i addressed all your concerns, please let me know
> > if i missed anything. To me most concerns look to be towards the kexec case and dependency
> > on hardware(ACPI/TPM) during boot and early boot services, where as carrying the logs is
> > only during the kexec_file_load sys call and does not interfere with that code path.
> > IMA documentation: https://sourceforge.net/p/linux-ima/wiki/Home/
> 
> Supporting ACPI in the same way is something we need to do from day one. kexec_file_load()
> already does this. I'm not sure "only kexec_file_load()" is a justifiable restriction...

The TPM PCRs are not reset on a soft reboot.  As a result, in order to
validate the IMA measurement list against the TPM PCRs, the IMA
measurement list is saved on kexec load, restored on boot, and then
the memory allocated for carrying the measurement list across kexec is
freed.

Where/how to save the IMA measurement list is architecture dependent.
 Thiago Bauermann implemented allocating and freeing the measurement
list memory for Power.

Mimi

