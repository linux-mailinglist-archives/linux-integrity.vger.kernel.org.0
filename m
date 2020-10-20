Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DED2943AB
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Oct 2020 22:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbgJTUC3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Oct 2020 16:02:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14777 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387443AbgJTUC3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Oct 2020 16:02:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09KK1Nbg016479;
        Tue, 20 Oct 2020 16:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=wENMh1cREjlI++izhVRnhITqNVHaC0QuLgepW6qgq0U=;
 b=j7bMlHyfuq1asUZ5E3uuj9QSQs+vXvLS4gJr5M0QtR5hPLTMxJbfA6/11YbLVB8NPg9P
 PR22idxIGmrhPG8uMq8oA3U0CNO8+WFNQkZXVdsADRHOfHIL+VxKJ60DtfXijYL+lCZb
 SRXcUsJwtITnkKsTXyN8aqWspEiFie7jlzMJdyAwQDmmdYsTvJ7AYbbvb7SMQWBqA+ZP
 tw+9VARMcibHCRByoJ+rlCnH+2G6KDwBHl/vM9l8+8vCqWSYBtRM9rllqHDRjh8743DX
 m/g+TzU1JSJsF98CyoA+pADDvxGoqPvTCj5mkexMjUQ0mmKcDakNaOVnToKo4ad5IrGM Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34a6jdr07u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 16:01:36 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09KK1aZO017087;
        Tue, 20 Oct 2020 16:01:36 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34a6jdr06j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 16:01:36 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09KJv71D029005;
        Tue, 20 Oct 2020 20:01:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 347r881uts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 20:01:33 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09KK1Vhv30015778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Oct 2020 20:01:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BCD74C046;
        Tue, 20 Oct 2020 20:01:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC0A14C052;
        Tue, 20 Oct 2020 20:01:24 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.35.199])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Oct 2020 20:01:24 +0000 (GMT)
Message-ID: <ecc13356983d5cff536c53c4da98a839ea9a0f19.camel@linux.ibm.com>
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
Date:   Tue, 20 Oct 2020 16:01:23 -0400
In-Reply-To: <20200930205941.1576-3-nramas@linux.microsoft.com>
References: <20200930205941.1576-1-nramas@linux.microsoft.com>
         <20200930205941.1576-3-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-20_11:2020-10-20,2020-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010200130
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-09-30 at 13:59 -0700, Lakshmi Ramasubramanian wrote:
> The functions ima_get_kexec_buffer() and ima_free_kexec_buffer(),
> that handle carrying forward the IMA measurement logs on kexec for
> powerpc do not have architecture specific code, but they are currently
> defined for powerpc only.
> 
> Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to IMA
> subsystem. A later patch in this series will use these functions for
> carrying forward the IMA measurement log for ARM64.
> 
> With the above refactoring arch/powerpc/kexec/ima.c contains only
> functions used when CONFIG_IMA_KEXEC is enabled. Update Makefile
> in arch/powerpc/kexec to include arch/powerpc/kexec/ima.c only
> when CONFIG_IMA_KEXEC is enabled.
> 
> Move ima_dump_measurement_list() and ima_add_kexec_buffer() to
> a new file namely ima_kexec_fdt.c in IMA. Update
> security/integrity/ima/Makefile to include ima_kexec_fdt.c only
> when CONFIG_IMA_KEXEC is enabled.
> 
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

The existing support for carrying the IMA measurement list across kexec
is limited to powerpc.  This patch set is adding similar support for
arm64, making as much of the existing code as generic as possible. 
However ima_dump_measurement_list() is already generic, but for some
reason this patch moves it to ima_kexec_fdt.c.  ima_kexec_fdt.c should
be limited to device tree specific code.

This patch is probably doing the right thing, but the way the patch is
formatted it replaces parts of a function with a different function. 
With the changes suggested above and in 1/4,  the next version should
be clearer.

thanks,

Mimi

