Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771962551BE
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 01:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgH0XwC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Aug 2020 19:52:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgH0XwB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Aug 2020 19:52:01 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RNWVDo178263;
        Thu, 27 Aug 2020 19:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=gsfH5cdUIsr8xA74mrGAD9ZYsv+fpUZMZdw3j3Pvhx8=;
 b=pSGykFPcU+B/ZIxHUo70hu/a+OkOt+mfFVoQzXapACuGVYMmPqCDc+Ufz+9IAOx6OFk0
 9GvomlgTXELbH5kyuIQmn40sT8SDxCt57z2VZTKfXpBqe0wlXxoRWOAzahZTEjaIYrQE
 bylXXHiyJ2pUivCeBRTmQ+6gBx6FnWY0OGK8PjWEsJo85ExBCltYXA9ZrQJvP8I+d52b
 MG0jg3yBk0MOGS5q2D7p62UmuTmRpZ7Gyb7jhdEnilSkD7Pp5j3NMfPRAEUBR5tT0POf
 /UHMl70HOUIu5YXUlSDLbwuvF4QNAZ9PpfANezJNLr/5ZSZwOD5GhlnAemvWIn7YJS25 mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 336m7bkq9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 19:51:07 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07RNXYTF180444;
        Thu, 27 Aug 2020 19:51:06 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 336m7bkq91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 19:51:06 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07RNl2R2026415;
        Thu, 27 Aug 2020 23:51:05 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 332ujf5v8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 23:51:05 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07RNp1K020906332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 23:51:01 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51787BE051;
        Thu, 27 Aug 2020 23:51:04 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF2AABE04F;
        Thu, 27 Aug 2020 23:50:56 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.80.51])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 27 Aug 2020 23:50:56 +0000 (GMT)
References: <20200819172134.11243-1-nramas@linux.microsoft.com>
 <20200819172134.11243-3-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v4 2/5] powerpc: Use libfdt functions to fetch IMA
 buffer properties
In-reply-to: <20200819172134.11243-3-nramas@linux.microsoft.com>
Date:   Thu, 27 Aug 2020 20:50:54 -0300
Message-ID: <8736478x7l.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_14:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=974
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270174
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> @@ -63,7 +29,22 @@ void remove_ima_buffer(void *fdt, int chosen_node)
>  	if (!prop)
>  		return;
>  
> -	ret = do_get_kexec_buffer(prop, len, &addr, &size);
> +	ret = fdt_address_cells(fdt, chosen_node);

This change was already present in the previous version of the patch but
it was just today that I noticed a problem: there's no #address-cells
property in /chosen. This code will still work though because if there's
no property this function returns 2 which is the correct value for
ppc64. But it's conceptually wrong. You need to pass the node offset for
/ so that it gets the #address-cells property from there.

> +	if (ret < 0)
> +		return;
> +	addr_cells = ret;
> +
> +	ret = fdt_size_cells(fdt, chosen_node);

Here we're not so lucky. The default value returned when no #size-cells
property is present is 1, which is wrong for ppc64 so this change
introduces a bug. You also need to pass the node offset for / here.

> +	if (ret < 0)
> +		return;
> +	size_cells = ret;
> +
> +	if (len < 4 * (addr_cells + size_cells))
> +		return;
> +
> +	addr = of_read_number(prop, addr_cells);
> +	size = of_read_number(prop + 4 * addr_cells, size_cells);
> +
>  	fdt_delprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER);
>  	if (ret)
>  		return;
> @@ -129,9 +110,15 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
>  	if (!image->arch.ima_buffer_size)
>  		return 0;
>  
> -	ret = get_addr_size_cells(&addr_cells, &size_cells);
> -	if (ret)
> +	ret = fdt_address_cells(fdt, chosen_node);
> +	if (ret < 0)
> +		return ret;
> +	addr_cells = ret;
> +
> +	ret = fdt_size_cells(fdt, chosen_node);
> +	if (ret < 0)
>  		return ret;
> +	size_cells = ret;
>  
>  	entry_size = 4 * (addr_cells + size_cells);

Ditto here.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
