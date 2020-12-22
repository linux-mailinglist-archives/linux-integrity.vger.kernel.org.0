Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E692E1069
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Dec 2020 23:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgLVWym (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 17:54:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727559AbgLVWyl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 17:54:41 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BMMWE1W196591;
        Tue, 22 Dec 2020 17:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=8jk/M5PwVWO5wCBRpi9U2tfKxLuehNr5+6fPogwpGkI=;
 b=crM0xizDekFtIHO00jVdxL37gyE/toBUdwbyhNICzkCR9cQ5Hp6Q0XkClF7aHcXk7jDG
 wg7bVc5B/cSIEsYnAQPH15LbxFwn3Gii0TCw7LuO9M/3c8VdMyMKAa5GMTZYu0DOPMvJ
 y0pSETEVSjIsqYTHGQxGkSitKKD0W5nzO0Tn4lL+Mwd1UdpIZWqOntpfHyjjhC5+yi5W
 0f68UYxIdlKe75rgqx/IoEQkEUHi2UAazEUGKwm7xqf30dkl7Wds53xFQJyGlfoUF+I3
 60fK5uP1rLtkzJwp5CoPY6cjYMVEu+z0pPCwd7z6UI2zjHT4i9OsfvgKmPNakG2AUc8G Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35kr71j8xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 17:53:23 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BMMrMKu086583;
        Tue, 22 Dec 2020 17:53:22 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35kr71j8xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 17:53:22 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BMMrAKW006408;
        Tue, 22 Dec 2020 22:53:21 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 35kj7queyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 22:53:21 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BMMrKgW23396644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Dec 2020 22:53:20 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3357EC6055;
        Tue, 22 Dec 2020 22:53:20 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23184C605B;
        Tue, 22 Dec 2020 22:53:13 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.219.136])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 22 Dec 2020 22:53:12 +0000 (GMT)
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
 <20201219175713.18888-2-nramas@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, takahiro.akashi@linaro.org,
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
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v13 1/6] ima: Move arch_ima_add_kexec_buffer() to ima
In-reply-to: <20201219175713.18888-2-nramas@linux.microsoft.com>
Date:   Tue, 22 Dec 2020 19:53:10 -0300
Message-ID: <87eejhlag9.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_11:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012220159
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> arch_ima_add_kexec_buffer() defined in "arch/powerpc/kexec/ima.c"
> sets up the address and size of the IMA measurement list in
> the architecture specific fields in kimage struct. This function does not
> have architecture specific code, but is currently limited to powerpc.
>
> Move arch_ima_add_kexec_buffer() to ima.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/powerpc/include/asm/ima.h     |  3 ---
>  arch/powerpc/kexec/ima.c           | 17 -----------------
>  security/integrity/ima/ima_kexec.c | 22 ++++++++++++++++++++++
>  3 files changed, 22 insertions(+), 20 deletions(-)

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Just one nit below.

Also, I just noticed that this patch series hasn't been cc'd to the linuxppc-dev
mailing list. You should do that, since it affects powerpc code. The
powerpc maintainers are being copied so at least they've been made aware
of it, but that isn't enough.

> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 121de3e04af2..38bcd7543e27 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -10,6 +10,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kexec.h>
> +#include <linux/ima.h>
>  #include "ima.h"
>  
>  #ifdef CONFIG_IMA_KEXEC

There's no need to add this include.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
