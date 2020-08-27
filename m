Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916E32551A5
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 01:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgH0Xgw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Aug 2020 19:36:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726289AbgH0Xgw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Aug 2020 19:36:52 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RNWC2V192638;
        Thu, 27 Aug 2020 19:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=ZhmffRqPwMKAcgI8ZwOQVjkCRCQfNxZmt8Ua2z01y/4=;
 b=JZopFKZqVba31aKfx/hEFt0zjCGRJG9ZUzSrGTuvXMVdgWP86CwZqwLM2Bpvp/GnM2IW
 bSf3BZsshooZMLM8VAePnhPWXR2H5SJO/KfEPbserZQkkR1ROber1pgH71/E+3gwuP9U
 p5uVZrqgQK/ymr4NNsAnMJ0CxQTZmHfkTimydKz4JTSHG2tWI9EgeKnFbLL/966tH+Iz
 DQjo+6BblDZIWABiOIOytPWynBWHd+xzIxlbeQ1N4yCtiy0cvJZ4zZI205RjjrXOWxJp
 GaeEWrqstbfWrkMznkYOFr5iKvXgW6U5VW9vxcXVpJTCrRlRxYAWhox8DA0kPAVSv7kM QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 336pa88bh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 19:35:54 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07RNWgFs193728;
        Thu, 27 Aug 2020 19:35:53 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 336pa88bgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 19:35:53 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07RNSg89023892;
        Thu, 27 Aug 2020 23:35:52 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03wdc.us.ibm.com with ESMTP id 332utrdqyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 23:35:52 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07RNZq1r57475482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 23:35:52 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BFF1C6059;
        Thu, 27 Aug 2020 23:35:52 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2B24C6057;
        Thu, 27 Aug 2020 23:35:44 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.80.51])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 27 Aug 2020 23:35:44 +0000 (GMT)
References: <20200819172134.11243-1-nramas@linux.microsoft.com>
 <20200819172134.11243-2-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v4 1/5] powerpc: Refactor kexec functions to move arch
 independent code to IMA
In-reply-to: <20200819172134.11243-2-nramas@linux.microsoft.com>
Date:   Thu, 27 Aug 2020 20:35:41 -0300
Message-ID: <875z938xwy.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_14:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 clxscore=1011 mlxlogscore=606 malwarescore=0 spamscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270174
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> The functions ima_get_kexec_buffer() and ima_free_kexec_buffer() that
> handle carrying forward the IMA measurement logs on kexec for powerpc
> do not have architecture specific code, but they are currently defined
> for powerpc only.
>
> Move these functions to IMA subsystem so that it can be used for other
> architectures as well. A later patch in this series will use these
> functions for carrying forward the IMA measurement log for ARM64.
>
> Define FDT_PROP_IMA_KEXEC_BUFFER for the chosen node, namely
> "linux,ima-kexec-buffer", that is added to the DTB to hold
> the address and the size of the memory reserved to carry
> the IMA measurement log.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

This patch removes two functions from arch/powerpc/kexec/ima.c, but adds
four to security/integrity/ima/ima_kexec.c. The extra ones are
get_addr_size_cells() and do_get_kexec_buffer(), which are being copied
from the powerpc code but can't be removed yet because they're still
used there by remove_ima_buffer() and setup_ima_buffer().

On the next patch you remove the need for these functions in powerpc
code and therefore delete them. This confused me at first, so I think it
would be cleared if you put patch 2 first in the series and then on this
patch you can simply move the four functions and delete them from
arch/powerpc/kexec/ima.c.

If you prefer to keep the current order, it's worth mentioning on the
commit log where get_addr_size_cells() and do_get_kexec_buffer() are
coming from.

Regardless:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
