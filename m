Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B672E2CFE91
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Dec 2020 20:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgLETu1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 5 Dec 2020 14:50:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgLETu0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 5 Dec 2020 14:50:26 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B5JXCEO163033;
        Sat, 5 Dec 2020 14:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=TkHcsLG8dAL+RnhNBxOBlnSfXxHw/ayhM50ATHOAvdI=;
 b=gq6W7yzSDeOA/2osPmeE0OkSF6rrF/Js1p5pYpjNUvPTWnIBU80t5UCA4uUy6caXRCXt
 RdsVYRFkJTJRMfq+iM+fX6fJt2OOfwEUWuySrlMZVGIExKuDO3tA69J07zp2LskeCrE+
 MGPqeMwLgqX1L7QDEgQYKS1Y3mW6xVfQU5t0Qjw9LTDtGO7lHTcox7h1Ie0GFUfRmoBu
 mUWVCqkml3zBO/9EvBIQSz5zzY2qgsMiCQtJOXIZ9nngILJd1GLZDUB6kZwQ670mYpnz
 VWEyOaQgjE7jj8KHrhQC55NMKe8s9P7x50agELMeuv6uSjt13hEdLV+mNwzWJ+eW8JV4 Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3586dbjgu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 14:49:09 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B5JYInf164918;
        Sat, 5 Dec 2020 14:49:09 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3586dbjgsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 14:49:08 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B5JhBWk012199;
        Sat, 5 Dec 2020 19:49:07 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 3581u8nbcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 19:49:07 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B5Jn6fc17891756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Dec 2020 19:49:06 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C5B3BE059;
        Sat,  5 Dec 2020 19:49:06 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9390BE04F;
        Sat,  5 Dec 2020 19:48:58 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.85.177.236])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Sat,  5 Dec 2020 19:48:58 +0000 (GMT)
References: <20201204195149.611-1-nramas@linux.microsoft.com>
 <20201204195149.611-4-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v10 3/8] powerpc: Move ima buffer functions to
 drivers/of/kexec.c
In-reply-to: <20201204195149.611-4-nramas@linux.microsoft.com>
Date:   Sat, 05 Dec 2020 16:48:56 -0300
Message-ID: <87zh2sm3tj.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-05_15:2020-12-04,2020-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012050130
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> The functions do_get_kexec_buffer() and get_addr_size_cells(),
> defined in arch/powerpc/kexec/ima.c, retrieve the address and size
> of the given property from the device tree blob. These functions do
> not have architecture specific code, but are currently limited to
> powerpc. do_get_kexec_buffer() correctly handles a device tree property
> that is a child node of the root node, but not anything other than
> the immediate root child nodes.
>
> Move architecture independent functions get_ima_kexec_buffer() and
> get_root_addr_size_cells() to "drivers/of/kexec.c". These functions
> retrieve the chosen node "linux,ima-kexec-buffer" from the device tree,
> and return the address and size of the buffer used for carrying forward
> the IMA measurement log across kexec system call.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

I'd personally squash this patch with the next one, but I'll leave it
just as a suggestion since maintainers are the ones who know best what
works well in this regard.

The code is good, except for a nit below:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

> ---
>  drivers/of/kexec.c    | 70 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/kexec.h |  3 ++
>  2 files changed, 73 insertions(+)
>
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index b7d59105fcb8..516b86f7113a 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -59,3 +59,73 @@ int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
>  
>  	return -ENOENT;
>  }
> +
> +/**
> + * get_root_addr_size_cells - Get address and size of root node
> + *
> + * @addr_cells: Return address of the root node
> + * @size_cells: Return size of the root node
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +int get_root_addr_size_cells(int *addr_cells, int *size_cells)
> +{
> +	struct device_node *root;
> +
> +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> +		return -EOPNOTSUPP;
> +
> +	root = of_find_node_by_path("/");
> +	if (!root)
> +		return -EINVAL;
> +
> +	*addr_cells = of_n_addr_cells(root);
> +	*size_cells = of_n_size_cells(root);
> +
> +	of_node_put(root);
> +
> +	return 0;
> +}
> +
> +/**
> + * get_ima_kexec_buffer - Get address and size of IMA kexec buffer
> + *
> + * @fdt: Flattened Device Tree
> + * @chosen_node: Offset of chosen node in the FDT
> + * @addr: Return address of the node
> + * @size: Return size of the node
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +int get_ima_kexec_buffer(void *fdt, int chosen_node,
> +			 unsigned long *addr, size_t *size)
> +{
> +	const void *prop;
> +	int addr_cells, size_cells, prop_len;
> +	int rc;
> +
> +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> +		return -EOPNOTSUPP;
> +
> +	rc = get_root_addr_size_cells(&addr_cells, &size_cells);
> +	if (rc)
> +		return rc;
> +
> +	if (fdt)
> +		prop = fdt_getprop(fdt, chosen_node,
> +				   "linux,ima-kexec-buffer", &prop_len);
> +	else
> +		prop = of_get_property(of_chosen,
> +				       "linux,ima-kexec-buffer", &prop_len);
> +
> +	if (!prop)
> +		return -ENOENT;
> +
> +	if (prop_len < 4 * (addr_cells + size_cells))
> +		return -EINVAL;
> +
> +	*addr = of_read_number(prop, addr_cells);
> +	*size = of_read_number(prop + 4 * addr_cells, size_cells);
> +
> +	return 0;
> +}
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index d0234c4815da..10ff704ab670 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -408,6 +408,9 @@ static inline int kexec_crash_loaded(void) { return 0; }
>  #endif /* CONFIG_KEXEC_CORE */
>  
>  #if defined(CONFIG_OF_FLATTREE)
> +extern int get_root_addr_size_cells(int *addr_cells, int *size_cells);
> +extern int get_ima_kexec_buffer(void *fdt, int chosen_node,
> +				unsigned long *addr, size_t *size);
>  extern int delete_fdt_mem_rsv(void *fdt, unsigned long start,
>  			      unsigned long size);
>  #endif /* CONFIG_OF_FLATTREE */

The extern keyword on function prototypes doesn't have any meaning.
It's better to drop them (I should have mentioned this on the previous
patch as well).

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
