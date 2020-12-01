Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573512CAB9D
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Dec 2020 20:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389789AbgLATRH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Dec 2020 14:17:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727375AbgLATRG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Dec 2020 14:17:06 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1J21hA176659;
        Tue, 1 Dec 2020 14:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=n0NxD7lrbqckDQQ/ZLO3t41mjgVN/FduFORCHpjZTXw=;
 b=WolUiGa+BdtX8n15X50oF5SbIs3fAd5+jjy/EEJaLh4pPwMo1ILvQ4ZqpV2ja/ClESeZ
 KDodunVe3NLp0lkIb1lWKm0D/jpvq6Y85YqpqD57tFtyPWcO55NQ8D+QqekkhuJ81eKh
 MwhJZu8+ouvTGKewb8u3Tih9MT/WKO9uV5A8DGDs5UDmMzFO9ccyPF2M/Px/arz03y9b
 wXPqC7t/mVMa25BBx84S9jtmYxxrCxv/HickEKEy4wkCdvIXaVTN8BhJ1GdJQEtPRiTP
 NQMN2icKOwpKudDS6dRBOmSf76UgU7qDpBXoODlq/ZK1ELft/dkhKGsOMQt3N8w1WadK xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 355k52js71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 14:15:45 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B1J3GB4184172;
        Tue, 1 Dec 2020 14:15:44 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 355k52js6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 14:15:44 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1JFgC0026687;
        Tue, 1 Dec 2020 19:15:42 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 353e689sq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 19:15:42 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1JFehI64094576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 19:15:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED5C5A4064;
        Tue,  1 Dec 2020 19:15:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42123A4054;
        Tue,  1 Dec 2020 19:15:34 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.54.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Dec 2020 19:15:34 +0000 (GMT)
Message-ID: <f25df5ba1cda54f3b7c555367f58f43caf3a3c7d.camel@linux.ibm.com>
Subject: Re: [PATCH v9 0/8] Carry forward IMA measurement log on kexec on
 ARM64
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Rob Herring <robh@kernel.org>
Cc:     bauerman@linux.ibm.com, gregkh@linuxfoundation.org,
        james.morse@arm.com, catalin.marinas@arm.com, sashal@kernel.org,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Date:   Tue, 01 Dec 2020 14:15:33 -0500
In-Reply-To: <76a749ac-8465-1d82-0ff5-0a46e0a29f18@linux.microsoft.com>
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
         <20201121135719.GA2134870@robh.at.kernel.org>
         <415b4d0b-3d93-40ce-b74e-48fdce7fbf7f@linux.microsoft.com>
         <a73a47da53b795617758cc23991624dfca173eba.camel@linux.ibm.com>
         <76a749ac-8465-1d82-0ff5-0a46e0a29f18@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_07:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012010112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-12-01 at 11:10 -0800, Lakshmi Ramasubramanian wrote:
> On 12/1/20 3:34 AM, Mimi Zohar wrote:
> > On Sat, 2020-11-21 at 06:38 -0800, Lakshmi Ramasubramanian wrote:
> >> On 11/21/20 5:57 AM, Rob Herring wrote:
> >>> On Fri, Nov 13, 2020 at 11:22:35AM -0800, Lakshmi Ramasubramanian wrote:
> > 
> >>>>    arch/powerpc/include/asm/kexec.h       |   1 -
> >>>>    arch/powerpc/kexec/Makefile            |   7 +-
> >>>>    arch/powerpc/kexec/file_load.c         |  32 --------
> >>>>    arch/powerpc/kexec/ima.c               | 106 ++-----------------------
> >>>>    drivers/of/Makefile                    |   9 +++
> >>>
> >>>>    drivers/of/ima_kexec.c                 |  91 +++++++++++++++++++++
> >>>>    drivers/of/kexec_fdt.c                 |  55 +++++++++++++
> >>>
> >>> Does this need to be 2 files? Just kexec.c?
> >>
> >> Since the functions defined in "ima_kexec.c" and "kexec_fdt.c" are
> >> enabled on 2 different kernel CONFIGs, keeping them in 2 files enables
> >> us to avoid using "#ifdef" in C files.
> > 
> > Normally that is true, but just as all of the kexec related functions
> > are co-located in ima/ima_kexec.c, co-locating all of the kexec related
> > functions in drivers/of makes sense.
> > 
> 
> Sounds good - i'll make the change.
> Instead of "#ifdef" will use "IS_ENABLED" macro, and define the kexec 
> related functions in drivers/of/ima_kexec.c

Perhaps name the file kexec.c, as Rob suggested.

Mimi

