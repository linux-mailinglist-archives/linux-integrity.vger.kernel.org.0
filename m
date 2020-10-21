Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7F229470F
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Oct 2020 05:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411848AbgJUDvc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Oct 2020 23:51:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2411845AbgJUDvc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Oct 2020 23:51:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09L3W61E088844;
        Tue, 20 Oct 2020 23:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=XunGNr7TC/a8oWd2ej3RpOLe0vAA4LGrrynGFgzx0Hg=;
 b=jvRHxPnw23ZHTlVMdpVVEqIJSFzvsy2btw+U8zJjlXC7LeGh4zMIq49zEr3Uk/lyc29F
 90mKd1tNQ9JhCapsNFRhQ1VtOBEbJg+m5YGp28Rs5FkOzTU3PDitl1TyWpG37Nojoj7+
 ocnNwM6BnBNLajSVN8xWCxqiGj2TphFxnSSi0oi7wSxLrMqKrhnpJmrVJPu5y/VuSsVm
 8tiU94U74OG67FWhESCfqVHz188K7J+1kgX8/W8JY/zjhaKpP4wNBWvG4SDD6wWQQD+y
 rbkyJBO5uHcxwLklvR6xTMMQoa8vnDcP7lHzfFcJbjVyojGQVXYMZiF4sFdS4E7srbzP Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34aah6v666-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 23:50:54 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09L3W9RI089115;
        Tue, 20 Oct 2020 23:50:53 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34aah6v65f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 23:50:53 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09L3m4ce010646;
        Wed, 21 Oct 2020 03:50:51 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 347r87t0wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 03:50:51 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09L3on8I30867722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Oct 2020 03:50:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7606A4040;
        Wed, 21 Oct 2020 03:50:48 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DA79A4053;
        Wed, 21 Oct 2020 03:50:42 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.35.199])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Oct 2020 03:50:41 +0000 (GMT)
Message-ID: <b8e04f61016b558ad62c4ac0aba183bab521664c.camel@linux.ibm.com>
Subject: Re: [PATCH v7 2/4] powerpc: Refactor kexec functions to move arch
 independent code to ima
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
Date:   Tue, 20 Oct 2020 23:50:41 -0400
In-Reply-To: <9a44d8aa-515d-fc97-74bd-7ae976dea35b@linux.microsoft.com>
References: <20200930205941.1576-1-nramas@linux.microsoft.com>
         <20200930205941.1576-3-nramas@linux.microsoft.com>
         <ecc13356983d5cff536c53c4da98a839ea9a0f19.camel@linux.ibm.com>
         <9a44d8aa-515d-fc97-74bd-7ae976dea35b@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-21_02:2020-10-20,2020-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 suspectscore=2 impostorscore=0 malwarescore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010210025
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Tue, 2020-10-20 at 19:38 -0700, Lakshmi Ramasubramanian wrote:
> On 10/20/20 1:01 PM, Mimi Zohar wrote:
> > On Wed, 2020-09-30 at 13:59 -0700, Lakshmi Ramasubramanian wrote:
> >> The functions ima_get_kexec_buffer() and ima_free_kexec_buffer(),
> >> that handle carrying forward the IMA measurement logs on kexec for
> >> powerpc do not have architecture specific code, but they are currently
> >> defined for powerpc only.
> >>
> >> Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to IMA
> >> subsystem. A later patch in this series will use these functions for
> >> carrying forward the IMA measurement log for ARM64.
> >>
> >> With the above refactoring arch/powerpc/kexec/ima.c contains only
> >> functions used when CONFIG_IMA_KEXEC is enabled. Update Makefile
> >> in arch/powerpc/kexec to include arch/powerpc/kexec/ima.c only
> >> when CONFIG_IMA_KEXEC is enabled.
> >>
> >> Move ima_dump_measurement_list() and ima_add_kexec_buffer() to
> >> a new file namely ima_kexec_fdt.c in IMA. Update
> >> security/integrity/ima/Makefile to include ima_kexec_fdt.c only
> >> when CONFIG_IMA_KEXEC is enabled.
> >>
> >> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> >> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> >> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > 
> > The existing support for carrying the IMA measurement list across kexec
> > is limited to powerpc.  This patch set is adding similar support for
> > arm64, making as much of the existing code as generic as possible.
> > However ima_dump_measurement_list() is already generic, but for some
> > reason this patch moves it to ima_kexec_fdt.c.  ima_kexec_fdt.c should
> > be limited to device tree specific code.
> 
> I wanted to split the functions defined under CONFIG_HAVE_IMA_KEXEC and 
> CONFIG_IMA_KEXEC to separate files so that we can get rid of #ifdef in C 
> file and instead conditionally compile the C files (using Makefile).
> 
> ima_dump_measurement_list() need to be defined only when 
> CONFIG_IMA_KEXEC is defined. I moved it to ima_kexec_fdt.c

In this case, everything in ima_kexec.c relates to carrying or
restoring the measurement list.  It's a logical unit.  Separating them
doesn't make sense.

> 
> Instead of ima_kexec_fdt.c, where ima_dump_measurement_list() and 
> ima_add_kexec_buffer() are defined, perhaps I can change the file name 
> to "ima_kexec_buffer.c". Would that be better?

I don't understand why adding support for carrying the IMA measurement
across kexec on ARM64, should require any changes in the IMA loading
and restoring the measurement list code itself.  Please minimize the
changes.

thanks,

Mimi

