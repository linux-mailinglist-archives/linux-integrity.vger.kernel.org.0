Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789972CFE95
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Dec 2020 20:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgLETxR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 5 Dec 2020 14:53:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725863AbgLETxP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 5 Dec 2020 14:53:15 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B5JWKnk100929;
        Sat, 5 Dec 2020 14:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=20DojOCkzItIpggooTsWGti8C6d2j+Xs/EA/CGgXk0A=;
 b=sTbTTf56SL5BZO6TZ/7yWLtd6WiUVEkivfREZ8xEDUClx3T387iGUHVSNKvy8VYHrHxJ
 ptvJhyPfp3/Yjn3iC7dLYhft+m+YKNxjlJzb9hj7+pH2be4aVE6IntptICFf0gtM330L
 92rzWoxRutEGUKiOuAHTSLpATbaku/leZB4hljdjwm3byqLrfFdJntudMHR5yuJuFaBo
 qbA+OJsbEEm7eQXE7xYaZRqNH3bXnxEydUK1R2UwKj7cAxTatzw8cEUX9O68DSgkiheT
 b2FOv5ahXmuqeE/9GMuLQotSIQwNuftEl+LCVjldC6apX2F8SHqIB2QA/AkLdhTe+vzq Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35857sax5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 14:51:43 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B5Jl483141760;
        Sat, 5 Dec 2020 14:51:42 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35857sax57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 14:51:42 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B5JfiBd014850;
        Sat, 5 Dec 2020 19:51:41 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 3581u8dbvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 19:51:41 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B5Jpehw23593426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Dec 2020 19:51:40 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1625478060;
        Sat,  5 Dec 2020 19:51:40 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A15577805C;
        Sat,  5 Dec 2020 19:51:32 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.85.177.236])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Sat,  5 Dec 2020 19:51:32 +0000 (GMT)
References: <20201204195149.611-1-nramas@linux.microsoft.com>
 <20201204195149.611-5-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v10 4/8] powerpc: Use ima kexec node functions
In-reply-to: <20201204195149.611-5-nramas@linux.microsoft.com>
Date:   Sat, 05 Dec 2020 16:51:30 -0300
Message-ID: <87v9dgm3p9.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-05_15:2020-12-04,2020-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=2 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012050127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> do_get_kexec_buffer() and get_addr_size_cells() are called by
> ima_get_kexec_buffer(), ima_free_kexec_buffer, and remove_ima_buffer()
> to retrieve the address and size of the buffer used for carrying
> forward the IMA measurement log across kexec system call. These
> functions correctly handle a device tree property that is a child node
> of the root node, but not anything other than the immediate root
> child nodes.
>
> Use the architecture independent functions get_ima_kexec_buffer()
> and get_root_addr_size_cells() defined in "drivers/of/ima_kexec.c",

s/ima_kexec.c/kexec.c/

> to get the address and size of the IMA measurement log buffer from
> the device tree. Remove do_get_kexec_buffer() and get_addr_size_cells()
> since they are not used anymore.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Looks good. Thanks!

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

> ---
>  arch/powerpc/kexec/ima.c | 58 +++++-----------------------------------
>  1 file changed, 7 insertions(+), 51 deletions(-)
>
> diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
> index a36c39db4b1a..906e8212435d 100644
> --- a/arch/powerpc/kexec/ima.c
> +++ b/arch/powerpc/kexec/ima.c
> @@ -13,40 +13,6 @@
>  #include <linux/libfdt.h>
>  #include <asm/ima.h>
>  
> -static int get_addr_size_cells(int *addr_cells, int *size_cells)
> -{
> -	struct device_node *root;
> -
> -	root = of_find_node_by_path("/");
> -	if (!root)
> -		return -EINVAL;
> -
> -	*addr_cells = of_n_addr_cells(root);
> -	*size_cells = of_n_size_cells(root);
> -
> -	of_node_put(root);
> -
> -	return 0;
> -}
> -
> -static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
> -			       size_t *size)
> -{
> -	int ret, addr_cells, size_cells;
> -
> -	ret = get_addr_size_cells(&addr_cells, &size_cells);
> -	if (ret)
> -		return ret;
> -
> -	if (len < 4 * (addr_cells + size_cells))
> -		return -ENOENT;
> -
> -	*addr = of_read_number(prop, addr_cells);
> -	*size = of_read_number(prop + 4 * addr_cells, size_cells);
> -
> -	return 0;
> -}
> -
>  /**
>   * ima_get_kexec_buffer - get IMA buffer from the previous kernel
>   * @addr:	On successful return, set to point to the buffer contents.
> @@ -56,16 +22,11 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
>   */
>  int ima_get_kexec_buffer(void **addr, size_t *size)
>  {
> -	int ret, len;
> +	int ret;
>  	unsigned long tmp_addr;
>  	size_t tmp_size;
> -	const void *prop;
>  
> -	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
> -	if (!prop)
> -		return -ENOENT;
> -
> -	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
> +	ret = get_ima_kexec_buffer(NULL, 0, &tmp_addr, &tmp_size);
>  	if (ret)
>  		return ret;
>  
> @@ -89,7 +50,7 @@ int ima_free_kexec_buffer(void)
>  	if (!prop)
>  		return -ENOENT;
>  
> -	ret = do_get_kexec_buffer(prop->value, prop->length, &addr, &size);
> +	ret = get_ima_kexec_buffer(NULL, 0, &addr, &size);
>  	if (ret)
>  		return ret;
>  
> @@ -98,7 +59,6 @@ int ima_free_kexec_buffer(void)
>  		return ret;
>  
>  	return memblock_free(addr, size);
> -
>  }
>  
>  /**
> @@ -112,19 +72,15 @@ int ima_free_kexec_buffer(void)
>   */
>  void remove_ima_buffer(void *fdt, int chosen_node)
>  {
> -	int ret, len;
> +	int ret;
>  	unsigned long addr;
>  	size_t size;
> -	const void *prop;
>  
> -	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
> -	if (!prop)
> +	ret = get_ima_kexec_buffer(fdt, chosen_node, &addr, &size);
> +	if (ret)
>  		return;
>  
> -	ret = do_get_kexec_buffer(prop, len, &addr, &size);
>  	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
> -	if (ret)
> -		return;
>  
>  	ret = delete_fdt_mem_rsv(fdt, addr, size);
>  	if (!ret)
> @@ -191,7 +147,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
>  	if (!image->arch.ima_buffer_size)
>  		return 0;
>  
> -	ret = get_addr_size_cells(&addr_cells, &size_cells);
> +	ret = get_root_addr_size_cells(&addr_cells, &size_cells);
>  	if (ret)
>  		return ret;


-- 
Thiago Jung Bauermann
IBM Linux Technology Center
