Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805E42CA19A
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Dec 2020 12:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgLALjs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Dec 2020 06:39:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728194AbgLALjs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Dec 2020 06:39:48 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1BZBEY190034;
        Tue, 1 Dec 2020 06:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=LslFoUWAmy3eJ8wtX1Tx8izP74FXAubZfJLRb8YwCzc=;
 b=K7HlZS6dZ9j02bp397SHAzjkqsxLfzYhV3yp+BowHqYXfXl9tNwGxnJAcjRUmPh6Rv6f
 +lOG8mLwsW6d7Ae8iSzzc+P23IAONM6qCEOQCVt0aK4mJGvCgLGoEsagJ8ulb10gWcR7
 2RXkJs7cKLZFn3GC6wBDy4xYPBgvDUOZcn8lP4Kq0wtkiNRjRXJOzqz7e7WeSb5AU57Q
 FJGhYEW42hocRl86jJHwHXt4qAfxenb6Rc/y2Fv2Xhsr1uuGwVoqgUsYqgYWl68/4zON
 xifhhkEe/EQ3OSyGhfjHZOKG2EcVBZlfM+HhNqPpqyHGXqSZv8CfrvT1Ql9VfxFRmegM FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 355j4f5k25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 06:38:22 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B1BcL2d007121;
        Tue, 1 Dec 2020 06:38:21 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 355j4f5k11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 06:38:21 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1BMIKP014882;
        Tue, 1 Dec 2020 11:38:18 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 354fpd9ts2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 11:38:18 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1BcGNs56033614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 11:38:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73299A4040;
        Tue,  1 Dec 2020 11:38:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0397FA4053;
        Tue,  1 Dec 2020 11:38:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.54.13])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Dec 2020 11:38:09 +0000 (GMT)
Message-ID: <493cf3c91579877d7e9cb79ad87ac086671d6ffc.camel@linux.ibm.com>
Subject: Re: [PATCH v9 6/8] powerpc: Move ima_get_kexec_buffer() and
 ima_free_kexec_buffer() to ima
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
Date:   Tue, 01 Dec 2020 06:38:09 -0500
In-Reply-To: <20201113192243.1993-7-nramas@linux.microsoft.com>
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
         <20201113192243.1993-7-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_04:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010072
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Fri, 2020-11-13 at 11:22 -0800, Lakshmi Ramasubramanian wrote:
> ima_get_kexec_buffer() retrieves the address and size of the buffer
> used for carrying forward the IMA measurement logs on kexec from
> the device tree.
> 
> ima_free_kexec_buffer() removes the chosen node namely
> "linux,ima-kexec-buffer" from the device tree, and frees the buffer
> used for carrying forward the IMA measurement logs on kexec.
> 
> These functions do not have architecture specific code, but are
> currently limited to powerpc.
> 
> Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to ima_kexec.c
> in IMA so that they are accessible for other architectures as well.

This sentence flows from the previous line.  No need for separate
paragraphs here.  

> 
> With the above change the functions in arch/powerpc/kexec/ima.c are
> defined only when the kernel config CONFIG_IMA_KEXEC is enabled.
> Update the Makefile to build arch/powerpc/kexec/ima.c only when
> CONFIG_IMA_KEXEC is enabled and remove "#ifdef CONFIG_IMA_KEXEC"
> in arch/powerpc/kexec/ima.c.
> 
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

After making the two changes,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 121de3e04af2..3f0fa2673dd3 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -9,9 +9,60 @@
>  
>  #include <linux/seq_file.h>
>  #include <linux/vmalloc.h>
> +#include <linux/memblock.h>
> +#include <linux/of.h>
>  #include <linux/kexec.h>
> +#include <linux/ima.h>
>  #include "ima.h"
>  
> +/**
> + * ima_get_kexec_buffer - get IMA buffer from the previous kernel
> + * @addr:	On successful return, set to point to the buffer contents.
> + * @size:	On successful return, set to the buffer size.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +static int ima_get_kexec_buffer(void **addr, size_t *size)
> +{
> +	int ret;
> +	unsigned long tmp_addr;
> +	size_t tmp_size;
> +
> +	ret = get_ima_kexec_buffer(NULL, 0, &tmp_addr, &tmp_size);
> +	if (ret)
> +		return ret;
> +
> +	*addr = __va(tmp_addr);
> +	*size = tmp_size;
> +
> +	return 0;
> +}
> +
> +/**
> + * ima_free_kexec_buffer - free memory used by the IMA buffer
> + */
> +static int ima_free_kexec_buffer(void)
> +{
> +	int ret;
> +	unsigned long addr;
> +	size_t size;
> +	struct property *prop;
> +
> +	prop = of_find_property(of_chosen, "linux,ima-kexec-buffer", NULL);
> +	if (!prop)
> +		return -ENOENT;
> +
> +	ret = get_ima_kexec_buffer(NULL, 0, &addr, &size);
> +	if (ret)
> +		return ret;
> +
> +	ret = of_remove_property(of_chosen, prop);
> +	if (ret)
> +		return ret;
> +
> +	return memblock_free(addr, size);
> +}
> +

Please move these functions, after the ifdef below, before the function
where they're used.

Mimi

>  #ifdef CONFIG_IMA_KEXEC
>  static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  				     unsigned long segment_size)


