Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35CC25CCBD
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Sep 2020 23:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgICVur (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Sep 2020 17:50:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbgICVur (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Sep 2020 17:50:47 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 083LWoJv082071;
        Thu, 3 Sep 2020 17:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=cjkaZttb2w3H/rGwt9YR9Ok/v2RDmTY8uBKhTtcgvf8=;
 b=BFnnjKPkWcf0MwUvuY69O4iOrHafazQ5JEnpGXXxrampiGmP8661HO4reWhgbVhi+sbN
 rHyRTctCr9yp4CRAEcoyuMTfnUu1CFo+Dh2m+PC1sB5kcsbl2Uc/CwT3Whc/H951cyBV
 BGKigKA8NMAb+GHxO3I0l7a1Io38vi3FwXVOIdqX7kWVMgDMRBDZziUn6e3WLL6EExkq
 PSzEIdl+7ip10LMwWQGaRfLQ3J/N28msekZnJ63LzPx1063J91+HpKf74AbJPCRzo8Ds
 6z+FPdc7SW7Pk2FvQKAbNAL2MnRX2YZ1rrEnoTG7Jk/OO+LdOPce/rZoUOEwH79Pd/zl +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33b7cft33c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 17:50:16 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 083LZR35086960;
        Thu, 3 Sep 2020 17:50:15 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33b7cft32n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 17:50:14 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 083Llwvc002343;
        Thu, 3 Sep 2020 21:50:13 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 339tmvdfft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 21:50:13 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 083LoCDm38142216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Sep 2020 21:50:12 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28C5FC6055;
        Thu,  3 Sep 2020 21:50:12 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48AD6C6057;
        Thu,  3 Sep 2020 21:50:05 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.155.22])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Sep 2020 21:50:04 +0000 (GMT)
References: <20200901195029.30039-1-nramas@linux.microsoft.com>
 <20200901195029.30039-3-nramas@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, gregkh@linuxfoundation.org,
        james.morse@arm.com, catalin.marinas@arm.com, sashal@kernel.org,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Subject: Re: [PATCH v5 2/3] arm64: Store IMA log information in kimage used
 for kexec
In-reply-to: <20200901195029.30039-3-nramas@linux.microsoft.com>
Date:   Thu, 03 Sep 2020 18:50:02 -0300
Message-ID: <87v9guy1h1.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_14:2020-09-03,2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=781 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030189
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> Address and size of the buffer containing the IMA measurement log need
> to be passed from the current kernel to the next kernel on kexec.
>
> Add address and size fields to "struct kimage_arch" for ARM64 platform
> to hold the address and size of the IMA measurement log buffer.
> Define an architecture specific function for ARM64 namely
> arch_ima_add_kexec_buffer() that will set the address and size of
> the current kernel's IMA buffer to be passed to the next kernel on kexec.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Reported-by: kernel test robot <lkp@intel.com> warning: no previous prototype for 'arch_ima_add_kexec_buffer' [-Wmissing-prototypes]

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
