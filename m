Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61B02E0FE6
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Dec 2020 22:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgLVVny (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 16:43:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727691AbgLVVny (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 16:43:54 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BMLWFjs009803;
        Tue, 22 Dec 2020 16:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=R7AU34tNfE0Ufx8iMqWSvclFjcXLGDL0cBWvu+QX9Hk=;
 b=O3bMEIg/1UBrc8niWJJ/PGGYTnZjWypnNsIHGm52Eltj5YlsxTBfgTV2brm53NU0VI8W
 OH4TOiqbORYzdynjjJ9hH9toMtRWqAPqefiDrGuQLbkqAGDsAi4IUnd9tVrbMJyTxqFo
 4YDWSJyeEwutZN0SoDT/zltX+Isk2Z7zQl3+fkWw/2UV8HqxW9CyMMaMQ7JnNd0xJGSv
 JMuvNCOrPaUzv+NdeV58PHyo++GpqPc5tmKkinKppczSiQKkZT/lnI12KYOmlP2tixMW
 +54/wtP4kNzjuA5fk3xop5XAUGMifSJ5D96TVqPhLsrZXXH/yH9hgXRLv/uJFY1pV+7W Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35kqaxt91g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 16:42:32 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BMLbTR6029051;
        Tue, 22 Dec 2020 16:42:31 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35kqaxt917-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 16:42:31 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BMLajgI010111;
        Tue, 22 Dec 2020 21:42:30 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 35kejb4rc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 21:42:30 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BMLgTCh11993416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Dec 2020 21:42:30 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3FC7112061;
        Tue, 22 Dec 2020 21:42:29 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31DC5112062;
        Tue, 22 Dec 2020 21:42:23 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.219.136])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue, 22 Dec 2020 21:42:22 +0000 (GMT)
References: <20201211221006.1052453-1-robh@kernel.org>
 <20201211221006.1052453-2-robh@kernel.org>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        takahiro.akashi@linaro.org, will@kernel.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au, zohar@linux.ibm.com,
        james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Subject: Re: [RFC PATCH 1/4] powerpc: Rename kexec elfcorehdr_addr to
 elf_headers_mem
In-reply-to: <20201211221006.1052453-2-robh@kernel.org>
Date:   Tue, 22 Dec 2020 18:42:21 -0300
Message-ID: <87pn31ldqa.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_11:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012220153
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hello Rob,

Thank you for making this series.

Rob Herring <robh@kernel.org> writes:

> Align with arm64 name so common code can use it.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/powerpc/include/asm/kexec.h  | 2 +-
>  arch/powerpc/kexec/file_load.c    | 4 ++--
>  arch/powerpc/kexec/file_load_64.c | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
