Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FDC2CF88E
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Dec 2020 02:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgLEBWP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 20:22:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgLEBWP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 20:22:15 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B50XVas000872;
        Fri, 4 Dec 2020 20:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=xNnZ/ZkntbjED8A3awgVAApqgSCj5zVZ3LoHd65+kEA=;
 b=dlx58ryIncl/0bicYIpwkY7DRs1Uzoy5EGOn1XQtEigrPlfG5vFICpnicIRhQPoYKNro
 LFueyisOnXsD6g2KYYCyi5YLyzenpCHWkqYFej5SGYfPCLApriMoaSCcgesARkWdeGn9
 WY8QckvLz+ZhZOgq0futsGVj5R4Y0MCN2dnnfaUENY25xTDEzObqC7yVrG6TYg2T3Y7l
 bIkjyB0tL4AZDnXjS3zqrSUKkSx3xGdumZE82Z1VcXL7PkuakcVGLE1IFFrndbjIjiJn
 eQau1ec/Wmci2x27P1IHKLWeWbzWffHRAQbd9ALpPkq8UTDEiTPSFhXCVVtFYzNOHzLn Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 357yjc914v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 20:20:40 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B50oe75061768;
        Fri, 4 Dec 2020 20:20:40 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 357yjc914a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 20:20:39 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B51Fa1Q030816;
        Sat, 5 Dec 2020 01:20:38 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02wdc.us.ibm.com with ESMTP id 356cbf44j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 01:20:38 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B51Kb7C18547190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Dec 2020 01:20:37 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A675BE054;
        Sat,  5 Dec 2020 01:20:37 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4125BE04F;
        Sat,  5 Dec 2020 01:20:27 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.203.141])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Sat,  5 Dec 2020 01:20:27 +0000 (GMT)
References: <20201204195149.611-1-nramas@linux.microsoft.com>
 <20201204195149.611-2-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v10 1/8] powerpc: fix compiler warnings and errors
In-reply-to: <20201204195149.611-2-nramas@linux.microsoft.com>
Date:   Fri, 04 Dec 2020 22:20:24 -0300
Message-ID: <87mtytoxpj.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_13:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 mlxscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=776 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012050000
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> The function prototype for the functions defined in ima.c for powerpc
> are given in the header file ima.h. But this header file is not
> included in ima.c resulting in compilation errors such as given below.
>
> arch/powerpc/kexec/ima.c:56:5: error: no previous prototype for 'ima_get_kexec_buffer' [-Werror=missing-prototypes]
>    56 | int ima_get_kexec_buffer(void **addr, size_t *size)
>       |     ^~~~~~~~~~~~~~~~~~~~
>
> The function parameters for remove_ima_buffer() and
> arch_ima_add_kexec_buffer() are not described in the function header
> resulting in warnings such as given below.
>
> arch/powerpc/kexec/ima.c:111: warning: Function parameter or member 'fdt' not described in 'remove_ima_buffer'
>
> Include ima.h in ima.c for powerpc. Describe the function parameters for
> remove_ima_buffer() and arch_ima_add_kexec_buffer().
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

These warnings showed up when using `make W=1`, and this patch fixes
them. Thanks!

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>


-- 
Thiago Jung Bauermann
IBM Linux Technology Center
