Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348575156C8
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Apr 2022 23:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiD2VeC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Apr 2022 17:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbiD2VeA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Apr 2022 17:34:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34B84756E;
        Fri, 29 Apr 2022 14:30:40 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TL0Xqj020003;
        Fri, 29 Apr 2022 21:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ojD+afCuSHRuR6G/2yGcUe3nIWhNGhLu7OHGLQvK4DE=;
 b=FJmJ1jbxaGw/8k+uTKVqlDa2jFiWXt7zNiuYvBasmXTQk6GQQZPx9ADIYLgtLnBmKzuj
 dsVSTwXdlhuq+YWgcM+/8x5FyLmXhHXmcwstwsnRkg1M9z6K6yQQR09XRdFO+vCW+taA
 g0gQc1lmJQxmGPOeJh/vCsi6e/NUo6IgKzUt0OW00S4wAKEqG4JKSQKuOONALJ8GxOHL
 UoGvsi805h2DDGhD1KtPIfYlaVVLRSnDPkN/kBa9UGK99TCHPP9LkSq1TroDkoB0KiOv
 Xyz04GzWphFT5Hmll51gGhTNygMJCWk5c4jgWbiVteEdpQ13B1RJxmPzDDRubyx6ZEJI NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqqtp2w1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 21:30:18 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23TL2mq8028038;
        Fri, 29 Apr 2022 21:30:17 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqqtp2vyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 21:30:17 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TLJZ9k008476;
        Fri, 29 Apr 2022 21:30:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3fpuygbknk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 21:30:15 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TLUDI946858638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 21:30:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E80664C040;
        Fri, 29 Apr 2022 21:30:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F4524C044;
        Fri, 29 Apr 2022 21:30:11 +0000 (GMT)
Received: from sig-9-65-75-248.ibm.com (unknown [9.65.75.248])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 21:30:10 +0000 (GMT)
Message-ID: <7d7fa18d396439d98e26890f647fffdc9e7d8b20.camel@linux.ibm.com>
Subject: Re: [PATCH v2] Carry forward IMA measurement log on kexec on x86_64
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jonathan McDowell <noodles@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Fri, 29 Apr 2022 17:30:10 -0400
In-Reply-To: <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
References: <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wSqEkRR4PEQUw2OtGFjUdCJNO5qAyjTA
X-Proofpoint-GUID: wYfoVQ2G-mAoHaZxBIe0LznPvYrG7-Jg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_09,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 13753136f03f..419c50cfe6b9 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -10,6 +10,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kexec.h>
> +#include <linux/memblock.h>
>  #include <linux/of.h>
>  #include <linux/ima.h>
>  #include "ima.h"
> @@ -134,10 +135,66 @@ void ima_add_kexec_buffer(struct kimage *image)
>  }
>  #endif /* IMA_KEXEC */
>  
> +#ifndef CONFIG_OF
> +static phys_addr_t ima_early_kexec_buffer_phys;
> +static size_t ima_early_kexec_buffer_size;
> +
> +void __init ima_set_kexec_buffer(phys_addr_t phys_addr, size_t size)
> +{
> +	if (size == 0)
> +		return;
> +
> +	ima_early_kexec_buffer_phys = phys_addr;
> +	ima_early_kexec_buffer_size = size;
> +}
> +
> +int __init ima_free_kexec_buffer(void)
> +{
> +	int rc;
> +
> +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> +		return -ENOTSUPP;
> +
> +	if (ima_early_kexec_buffer_size == 0)
> +		return -ENOENT;
> +
> +	rc = memblock_phys_free(ima_early_kexec_buffer_phys,
> +				ima_early_kexec_buffer_size);
> +	if (rc)
> +		return rc;
> +
> +	ima_early_kexec_buffer_phys = 0;
> +	ima_early_kexec_buffer_size = 0;
> +
> +	return 0;
> +}
> +
> +int __init ima_get_kexec_buffer(void **addr, size_t *size)
> +{
> +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> +		return -ENOTSUPP;
> +
> +	if (ima_early_kexec_buffer_size == 0)
> +		return -ENOENT;
> +
> +	*addr = __va(ima_early_kexec_buffer_phys);
> +	*size = ima_early_kexec_buffer_size;
> +
> +	return 0;
> +}
> +

Originally both ima_get_kexec_buffer() and ima_free_kexec_buffer() were
architecture specific.  Refer to commit 467d27824920 ("powerpc: ima:
get the kexec buffer passed by the previous kernel").  Is there any
need for defining them here behind an "#ifndef CONFIG_OF"?

> +#else
> +
> +void __init ima_set_kexec_buffer(phys_addr_t phys_addr, size_t size)
> +{
> +	pr_warn("CONFIG_OF enabled, ignoring call to set buffer details.\n");
> +}
> +#endif /* CONFIG_OF */
> +

Only when "HAVE_IMA_KEXEC" is defined is this file included.  Why is
this warning needed?

thanks,

Mimi

>  /*
>   * Restore the measurement list from the previous kernel.
>   */
> -void ima_load_kexec_buffer(void)
> +void __init ima_load_kexec_buffer(void)
>  {
>  	void *kexec_buffer = NULL;
>  	size_t kexec_buffer_size = 0;


