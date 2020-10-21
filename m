Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E412946E6
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Oct 2020 05:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411625AbgJUDSu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Oct 2020 23:18:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2411623AbgJUDSt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Oct 2020 23:18:49 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09L33nfU045756;
        Tue, 20 Oct 2020 23:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=gonw/JPabK1O5CBM/w49nAQDDIVuQ2fR2sFvrrqg9ps=;
 b=qssSlyKfQvsdtRkV2Q3eCs447/UbyQfN7chlL7HO3wARQ8BR9lxDKaUDV7RsNfAm3akI
 pL9W50AI8d4TRJvoLoQtudYdrfzYztZXaLAiq9ca5tm8Oq0AvFZX6CyM6oUz9OfQyTrd
 gWAzDhXOsVqoCSvypvF/eIxX/ROK78EuNnhp+6qAyHqmCdJ6r9ztrhn+BWyhpk1iPbGN
 siZQuV6sApIf+LkwGXVLOgd84wq0njyhUKJu8ynQzFJmzDWDlN6TMZF+tsUTz4FISw7G
 rHYOW0Y1jIigQ+YMmXFjZZHHiEDVyf6MeC1Oy3YffNBvrygzmZ9khYlTzyvf3CQaX2Ef nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ac1ahg8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 23:18:12 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09L33jBc045218;
        Tue, 20 Oct 2020 23:18:11 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ac1ahg7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 23:18:11 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09L3BkXV027261;
        Wed, 21 Oct 2020 03:18:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 347r8820ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 03:18:08 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09L3I6mk31261036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Oct 2020 03:18:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53AE34C059;
        Wed, 21 Oct 2020 03:18:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16A904C040;
        Wed, 21 Oct 2020 03:18:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.35.199])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Oct 2020 03:17:59 +0000 (GMT)
Message-ID: <a6c3e3ecb5c1c6f35b747f1ea4d8261667f9a376.camel@linux.ibm.com>
Subject: Re: [PATCH v7 1/4] powerpc: Refactor kexec functions to move arch
 independent code to kernel
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
Date:   Tue, 20 Oct 2020 23:17:59 -0400
In-Reply-To: <81c4a9ce-c363-a87a-06de-4a8729702b97@linux.microsoft.com>
References: <20200930205941.1576-1-nramas@linux.microsoft.com>
         <20200930205941.1576-2-nramas@linux.microsoft.com>
         <bfaadaffafa3b8c12fce7e8491ea77e22a5821a8.camel@linux.ibm.com>
         <81c4a9ce-c363-a87a-06de-4a8729702b97@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-21_02:2020-10-20,2020-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 suspectscore=2 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010210025
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-10-20 at 19:25 -0700, Lakshmi Ramasubramanian wrote:
> On 10/20/20 1:00 PM, Mimi Zohar wrote:
> > Hi Lakshmi,
> > 
> > On Wed, 2020-09-30 at 13:59 -0700, Lakshmi Ramasubramanian wrote:
> >> The functions remove_ima_buffer() and delete_fdt_mem_rsv() that handle
> >> carrying forward the IMA measurement logs on kexec for powerpc do not
> >> have architecture specific code, but they are currently defined for
> >> powerpc only.
> >>
> >> remove_ima_buffer() and delete_fdt_mem_rsv() are used to remove
> >> the IMA log entry from the device tree and free the memory reserved
> >> for the log. These functions need to be defined even if the current
> >> kernel does not support carrying forward IMA log across kexec since
> >> the previous kernel could have supported that and therefore the current
> >> kernel needs to free the allocation.
> >>
> >> Rename remove_ima_buffer() to remove_ima_kexec_buffer().
> >> Define remove_ima_kexec_buffer() and delete_fdt_mem_rsv() in kernel.
> >> A later patch in this series will use these functions to free
> >> the allocation, if any, made by the previous kernel for ARM64.
> >>
> >> Define FDT_PROP_IMA_KEXEC_BUFFER for the chosen node, namely
> >> "linux,ima-kexec-buffer", that is added to the DTB to hold
> >> the address and the size of the memory reserved to carry
> >> the IMA measurement log.
> > 
> >> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> >> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> >> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> >> Reported-by: kernel test robot <lkp@intel.com> error: implicit declaration of function 'delete_fdt_mem_rsv' [-Werror,-Wimplicit-function-declaration]
> > 
> > Much better!  This version limits unnecessarily changing the existing
> > code to adding a couple of debugging statements, but that looks to be
> > about it.
> Yes Mimi - that's correct.
> 
> > 
> > Based on Chester Lin's "ima_arch" support for arm64 discussion, the IMA generic
> > EFI support will be defined in ima/ima-efi.c.  Similarly, I think it would make sense to put the generic device tree support in ima/ima_kexec_fdt.c or ima/ima_fdt.c, as opposed to kernel/.  (Refer to my comments on 2/4 about the new file named ima_kexec_fdt.c.)
> 
> The functions remove_ima_kexec_buffer() and delete_fdt_mem_rsv(), which 
> are defined in kernel/ima_kexec.c and kernel/kexec_file_fdt.c 
> respectively, are needed even when CONFIG_IMA is not defined. These 
> functions need to be called by the current kernel to free the ima kexec 
> buffer resources allocated by the previous kernel. This is the reason, 
> these functions are defined under "kernel" instead of 
> "security/integrity/ima".
> 
> If there is a better location to move the above C files, please let me 
> know. I'll move them.

Freeing the previous kernel measurement list is currently called from
ima_load_kexec_buffer(), only after the measurement list has been
restored.  The only other time the memory is freed is when the
allocated memory size isn't sufficient to hold the measurement list,
which could happen if there is a delay between loading and executing
the kexec.

thanks,

Mimi

