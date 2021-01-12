Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E302F37EE
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Jan 2021 19:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391917AbhALSH1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 13:07:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63830 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726259AbhALSH1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 13:07:27 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10CI4Jpv107375;
        Tue, 12 Jan 2021 13:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=y92jepHkYu/5Ng7z5kVoqsbqJOO5aCJiOzGONr6fphM=;
 b=bCctGOy1rW9Z91ya/ym0rFmSTXboq1imdt2miIPI05dBM8xzi2EAevkz3ICEXUEkjcyJ
 Xw5DDDUC5b2KC8rKODzAYibBtTYc8XrgOuaplM5fHUhHaewSVDWFolBKhSLXCQJuYSPM
 5ZuDwUeTVlVsjhFUqRKF2hC3Q0XLaCj4PSIlPR9qcu8zzavXaYKDd9fqlfKHxRA4ud7S
 xVm/rVeugbyKDemrqe391x50UIsNuUJPHKwb4lvavq3Q+5dK2qqG8k/jgjnZU6FMqPX1
 /RqiS9Cfh69H5QxoxpJmbveJC3az3Zc9ju3efLM+3CDw9W21X7ZvPK7V35Tmeue3IFNV qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 361b5f3utc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 13:06:01 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10CI4OdI107673;
        Tue, 12 Jan 2021 13:05:59 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 361b5f3uqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 13:05:59 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10CI3ElC016501;
        Tue, 12 Jan 2021 18:05:57 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 35y448a1nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 18:05:56 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10CI5se928246474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 18:05:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95D14AE04D;
        Tue, 12 Jan 2021 18:05:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BF62AE053;
        Tue, 12 Jan 2021 18:05:47 +0000 (GMT)
Received: from sig-9-65-221-171.ibm.com (unknown [9.65.221.171])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jan 2021 18:05:47 +0000 (GMT)
Message-ID: <601825013d67584b0d2de7a973b806ec3cbc05ca.camel@linux.ibm.com>
Subject: Re: [PATCH v14 0/6] Carry forward IMA measurement log on kexec on
 ARM64
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Rob Herring <robh@kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     bauerman@linux.ibm.com, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, will@kernel.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au, james.morse@arm.com,
        sashal@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        frowand.list@gmail.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@vger.kernel.org
Date:   Tue, 12 Jan 2021 13:05:46 -0500
In-Reply-To: <20210112144248.GA256955@robh.at.kernel.org>
References: <20210104192602.10131-1-nramas@linux.microsoft.com>
         <20210112144248.GA256955@robh.at.kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_12:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 clxscore=1011 phishscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120103
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-01-12 at 08:42 -0600, Rob Herring wrote:
> On Mon, Jan 04, 2021 at 11:25:56AM -0800, Lakshmi Ramasubramanian wrote:
> > On kexec file load Integrity Measurement Architecture (IMA) subsystem
> > may verify the IMA signature of the kernel and initramfs, and measure
> > it. The command line parameters passed to the kernel in the kexec call
> > may also be measured by IMA. A remote attestation service can verify
> > a TPM quote based on the TPM event log, the IMA measurement list, and
> > the TPM PCR data. This can be achieved only if the IMA measurement log
> > is carried over from the current kernel to the next kernel across
> > the kexec call.
> > 
> > powerpc already supports carrying forward the IMA measurement log on
> > kexec. This patch set adds support for carrying forward the IMA
> > measurement log on kexec on ARM64. 
> > 
> > This patch set moves the platform independent code defined for powerpc
> > such that it can be reused for other platforms as well. A chosen node
> > "linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
> > the address and the size of the memory reserved to carry
> > the IMA measurement log.
> > 
> > This patch set has been tested for ARM64 platform using QEMU.
> > I would like help from the community for testing this change on powerpc.
> > Thanks.
> > 
> > This patch set is based on
> > commit a29a64445089 ("powerpc: Use common of_kexec_setup_new_fdt()")
> > in https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> > "dt/kexec" branch.
> 
> This all looks good to me. I'd suggest you send the above patches out as 
> part of this series because I don't plan to do so.
> 
> I would like to also resolve the vmalloc vs. kmalloc difference for 
> allocating the FDT. Then we can further consolidate the DT kexec code.
> 
> It all needs some acks from arm64 and powerpc maintainers. As far as 
> merging, I think via the integrity tree makes the most sense.

Thanks, Rob.  Lakshmi,  please update Rob's patches to include patch
descriptions before re-posting.

Mimi

