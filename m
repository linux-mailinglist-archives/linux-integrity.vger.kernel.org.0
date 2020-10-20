Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9C92943A8
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Oct 2020 22:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387394AbgJTUBp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Oct 2020 16:01:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728413AbgJTUBp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Oct 2020 16:01:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09KJXN2N094018;
        Tue, 20 Oct 2020 16:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=SFMV7OXS/VJIluGuXA0jHf5zUIehQtYguCAirxOg1gw=;
 b=i5fdpi9ZG46ddg9zJmrOUnwouPMiepEQqhGOtunjcOk/3nGCkWG4P0plGm3lMmXCdI6s
 oGAyXsI8JDvHhuDtbT8h2jsU5cVQqyMO8S7RFriSwB/K/4Np3dHgapoyrQijvTJTXFbJ
 evVHEEiQ4LxJVzTpW0XdPEJgy1tptn55bAp/hwPF5Qr2gPSzt6rQUrCclvauVkuk1pu0
 U24JuQOf9f90f2OGloSoQjGJ49MFIDcCxAw3zKpcM+e+VVxLjKbW0da3s2KpR9B4R06A
 nimitGvPEPGKFQdLJPxu5w090ZVOI8jBm09ER3dNYYUP6dSiMf4+OBAFHGLhsLg9wTrK 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34a64err3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 16:00:47 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09KJxYEq048108;
        Tue, 20 Oct 2020 16:00:46 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34a64err1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 16:00:46 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09KJud1G028967;
        Tue, 20 Oct 2020 20:00:43 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 347r881ut5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 20:00:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09KK0fOl33161594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Oct 2020 20:00:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2485411C058;
        Tue, 20 Oct 2020 20:00:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 633D811C071;
        Tue, 20 Oct 2020 20:00:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.35.199])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Oct 2020 20:00:35 +0000 (GMT)
Message-ID: <bfaadaffafa3b8c12fce7e8491ea77e22a5821a8.camel@linux.ibm.com>
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
Date:   Tue, 20 Oct 2020 16:00:34 -0400
In-Reply-To: <20200930205941.1576-2-nramas@linux.microsoft.com>
References: <20200930205941.1576-1-nramas@linux.microsoft.com>
         <20200930205941.1576-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-20_11:2020-10-20,2020-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=2
 adultscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 clxscore=1011 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010200130
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Wed, 2020-09-30 at 13:59 -0700, Lakshmi Ramasubramanian wrote:
> The functions remove_ima_buffer() and delete_fdt_mem_rsv() that handle
> carrying forward the IMA measurement logs on kexec for powerpc do not
> have architecture specific code, but they are currently defined for
> powerpc only.
> 
> remove_ima_buffer() and delete_fdt_mem_rsv() are used to remove
> the IMA log entry from the device tree and free the memory reserved
> for the log. These functions need to be defined even if the current
> kernel does not support carrying forward IMA log across kexec since
> the previous kernel could have supported that and therefore the current
> kernel needs to free the allocation.
> 
> Rename remove_ima_buffer() to remove_ima_kexec_buffer().
> Define remove_ima_kexec_buffer() and delete_fdt_mem_rsv() in kernel.
> A later patch in this series will use these functions to free
> the allocation, if any, made by the previous kernel for ARM64.
> 
> Define FDT_PROP_IMA_KEXEC_BUFFER for the chosen node, namely
> "linux,ima-kexec-buffer", that is added to the DTB to hold
> the address and the size of the memory reserved to carry
> the IMA measurement log.

> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Reported-by: kernel test robot <lkp@intel.com> error: implicit declaration of function 'delete_fdt_mem_rsv' [-Werror,-Wimplicit-function-declaration]

Much better!  This version limits unnecessarily changing the existing
code to adding a couple of debugging statements, but that looks to be
about it.

Based on Chester Lin's "ima_arch" support for arm64 discussion, the IMA generic
EFI support will be defined in ima/ima-efi.c.  Similarly, I think it would make sense to put the generic device tree support in ima/ima_kexec_fdt.c or ima/ima_fdt.c, as opposed to kernel/.  (Refer to my comments on 2/4 about the new file named ima_kexec_fdt.c.)

thanks,

Mimi

