Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD9E2A4958
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Nov 2020 16:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgKCPUi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Nov 2020 10:20:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728424AbgKCPTl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Nov 2020 10:19:41 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3F3T5T190170;
        Tue, 3 Nov 2020 10:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=iFmeiW6gOcGgHc20MGqZ838VdL0mVZvpohSyabcvc8Q=;
 b=VFmmM/+ma8B68L2sSXjoy78DBJoxz3hsSy2hBlzDDAEwBybCZbap7ZVsSx9CufToMpi2
 l5LAv7ScwPDk2CBlaDCxPvv/SZV1MuFUxO6Ly1QHJWvfHAvNulLy/HBcEVBdXB6zPcGo
 jclyxs4eN8IC1nzggNgKka5tLzqh+zzJ9B1eCncWXA8U8LKBcQ5FoOjoy+Rl5k+EsaWm
 Z6mUkQJUD8X7DpsvXSHi/ZY1Ahsa64pFaQDwZnbZq4SPknPbae7G+skVt4fHAr2suxER
 7HDIiIQNwQliypoYrqAtcPPKEIs8UO138aN8FMjUDWP3Wmn8G3BE1uX0wJRCawLxM3Wc sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34k5rx0xsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 10:18:54 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3F4aHV194071;
        Tue, 3 Nov 2020 10:18:50 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34k5rx0xqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 10:18:50 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3FHfuI001865;
        Tue, 3 Nov 2020 15:18:47 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 34hm6ham0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 15:18:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A3FIiUB57606520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Nov 2020 15:18:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAC6D4203F;
        Tue,  3 Nov 2020 15:18:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22B7742045;
        Tue,  3 Nov 2020 15:18:39 +0000 (GMT)
Received: from sig-9-65-255-16.ibm.com (unknown [9.65.255.16])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Nov 2020 15:18:38 +0000 (GMT)
Message-ID: <053cf58ae21f2e7088e22eedf8c5ee6e73a1e835.camel@linux.ibm.com>
Subject: Re: [PATCH v8 0/4] Carry forward IMA measurement log on kexec on
 ARM64
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        bauerman@linux.ibm.com, robh@kernel.org,
        gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prsriva@linux.microsoft.com,
        balajib@linux.microsoft.com
Date:   Tue, 03 Nov 2020 10:18:33 -0500
In-Reply-To: <20201030174429.29893-1-nramas@linux.microsoft.com>
References: <20201030174429.29893-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030102
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-10-30 at 10:44 -0700, Lakshmi Ramasubramanian wrote:
> On kexec file load Integrity Measurement Architecture (IMA) subsystem
> may verify the IMA signature of the kernel and initramfs, and measure
> it. The command line parameters passed to the kernel in the kexec call
> may also be measured by IMA. A remote attestation service can verify
> the measurement through the IMA log and the TPM PCR data. This can be
> achieved only if the IMA measurement log is carried over from
> the current kernel to the next kernel across the kexec call.

Nice, but you might want to tweak it a bit.  This is just a suggestion.
"A remote attestation service can verify a TPM quote based on the TPM
event log, the IMA measurement list, and the TPM PCR data".

> However in the current implementation the IMA measurement logs are not
> carried over on ARM64 platforms. Therefore a remote attestation service
> cannot verify the authenticity of the running kernel on ARM64 platforms
> when the kernel is updated through the kexec system call.

The paragraphs above and below are redundant.  The first paragraph
already explained why carrying the measurement across kexec is needed. 
Perhaps drop the above paragraph.

> This patch series adds support for carrying forward the IMA measurement
> log on kexec on ARM64. powerpc already supports carrying forward
> the IMA measurement log on kexec.

And invert these sentences, starting the paragraph with "Powerpc
already" and ending with ARM64.

> 
> This series refactors the platform independent code defined for powerpc
> such that it can be reused for ARM64 as well. A chosen node namely
> "linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
> the address and the size of the memory reserved to carry
> the IMA measurement log.

^This patch set moves ..."

Thanks,

Mimi

> 
> This patch series has been tested for ARM64 platform using QEMU.
> I would like help from the community for testing this change on powerpc.
> Thanks.
> 
> This patch series is based on
> commit 598a597636f8 ("Merge tag 'afs-fixes-20201029' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs")
> in https://github.com/torvalds/linux "master" branch.


