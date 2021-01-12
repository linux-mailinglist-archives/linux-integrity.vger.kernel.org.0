Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2445A2F3924
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Jan 2021 19:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406189AbhALSqy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 13:46:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726636AbhALSqy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 13:46:54 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10CIh4CD135115;
        Tue, 12 Jan 2021 13:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=8dn5n5mw4OQtpzK0N/CimN+ip41q9EcXbMAGPd2ftlk=;
 b=iExWTgecsIiGBmbNrC/PYfhGTtrXC/8EKM6P5HDKCDPQLWHvoIKiahPkjVV2EoA+jxGm
 NDgJF/LXnP80Aqngd/zz11WRrxEr3xz/lSDhyNyd80W/0sOtNw1KzMrs6zpTfLlu+0Qu
 M4POJJaw2qkJqY8Jps1A06eXPa/QGPczhovDzC6npQj88Tub9bCW4KT+BwLy/aajyvv0
 bCV9GTxEeaEnvGqde4OdBPtMLnbusdsX3CApW1RX7crA2aZmtNSqFAmtj+A8rvy+fSrb
 In5jw2rqezPJltGjvlDw924Z5szE2MkiKVqldnR9oUYivhyfKbYaU7fENWHJCMm1QJU9 Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 361h9pg1fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 13:45:21 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10CIimKQ142380;
        Tue, 12 Jan 2021 13:45:21 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 361h9pg1f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 13:45:20 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10CIb8D2011352;
        Tue, 12 Jan 2021 18:45:19 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 35y449031x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 18:45:19 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10CIjIX19175636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 18:45:18 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A900EAC062;
        Tue, 12 Jan 2021 18:45:18 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CC7BAC059;
        Tue, 12 Jan 2021 18:45:11 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.85.136.171])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Jan 2021 18:45:10 +0000 (GMT)
References: <20210104192602.10131-1-nramas@linux.microsoft.com>
 <20210112144248.GA256955@robh.at.kernel.org>
 <601825013d67584b0d2de7a973b806ec3cbc05ca.camel@linux.ibm.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au,
        james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v14 0/6] Carry forward IMA measurement log on kexec on
 ARM64
In-reply-to: <601825013d67584b0d2de7a973b806ec3cbc05ca.camel@linux.ibm.com>
Date:   Tue, 12 Jan 2021 15:45:08 -0300
Message-ID: <87eeiqro3v.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_15:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 adultscore=0 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120106
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Mimi Zohar <zohar@linux.ibm.com> writes:

> On Tue, 2021-01-12 at 08:42 -0600, Rob Herring wrote:
>> On Mon, Jan 04, 2021 at 11:25:56AM -0800, Lakshmi Ramasubramanian wrote:
>> > On kexec file load Integrity Measurement Architecture (IMA) subsystem
>> > may verify the IMA signature of the kernel and initramfs, and measure
>> > it. The command line parameters passed to the kernel in the kexec call
>> > may also be measured by IMA. A remote attestation service can verify
>> > a TPM quote based on the TPM event log, the IMA measurement list, and
>> > the TPM PCR data. This can be achieved only if the IMA measurement log
>> > is carried over from the current kernel to the next kernel across
>> > the kexec call.
>> > 
>> > powerpc already supports carrying forward the IMA measurement log on
>> > kexec. This patch set adds support for carrying forward the IMA
>> > measurement log on kexec on ARM64. 
>> > 
>> > This patch set moves the platform independent code defined for powerpc
>> > such that it can be reused for other platforms as well. A chosen node
>> > "linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
>> > the address and the size of the memory reserved to carry
>> > the IMA measurement log.
>> > 
>> > This patch set has been tested for ARM64 platform using QEMU.
>> > I would like help from the community for testing this change on powerpc.
>> > Thanks.
>> > 
>> > This patch set is based on
>> > commit a29a64445089 ("powerpc: Use common of_kexec_setup_new_fdt()")
>> > in https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
>> > "dt/kexec" branch.
>> 
>> This all looks good to me. I'd suggest you send the above patches out as 
>> part of this series because I don't plan to do so.
>> 
>> I would like to also resolve the vmalloc vs. kmalloc difference for 
>> allocating the FDT. Then we can further consolidate the DT kexec code.
>> 
>> It all needs some acks from arm64 and powerpc maintainers. As far as 
>> merging, I think via the integrity tree makes the most sense.
>
> Thanks, Rob.  Lakshmi,  please update Rob's patches to include patch
> descriptions before re-posting.

Also please update the powerpc mailing list address to
linuxppc-dev@lists.ozlabs.org

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
