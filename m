Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610EF2DC4DA
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Dec 2020 18:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgLPQ6n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Dec 2020 11:58:43 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51890 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgLPQ6n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Dec 2020 11:58:43 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id D8A2820B717A;
        Wed, 16 Dec 2020 08:58:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D8A2820B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608137881;
        bh=D7IeDQSLrMQalbqHtiNQWaTnbkIyUfEAlM97NWNMyc8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RQ4AeGq80q4TfLyhbvpIM28amv3LOW2hqkZrRtHYepCacrCmpTFo5lZyxpyHWCDIy
         Ez9h00a151IsBDnEXcz+esu18ZpQBy8FAiEq2d0pqemkwkSBmfPwu+FzysDWTsxNss
         fFZixRgup2LH0lIW3/ENv8OTQTJqcaX+VYtrsTa8=
Subject: Re: [PATCH v11 2/8] powerpc: Move ima buffer functions to
 drivers/of/kexec.c
To:     Rob Herring <robh@kernel.org>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au,
        james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20201214191854.9050-1-nramas@linux.microsoft.com>
 <20201214191854.9050-3-nramas@linux.microsoft.com>
 <20201215181601.GA4105316@robh.at.kernel.org>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <f0b4d1eb-83a4-d364-62c0-1d6cfc86c74b@linux.microsoft.com>
Date:   Wed, 16 Dec 2020 08:58:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201215181601.GA4105316@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/15/20 10:16 AM, Rob Herring wrote:
> On Mon, Dec 14, 2020 at 11:18:48AM -0800, Lakshmi Ramasubramanian wrote:
>> The functions do_get_kexec_buffer() and get_addr_size_cells(),
>> defined in arch/powerpc/kexec/ima.c, retrieve the address and size
>> of the given property from the device tree blob. These functions do
>> not have architecture specific code, but are currently limited to
>> powerpc. do_get_kexec_buffer() correctly handles a device tree property
>> that is a child node of the root node, but not anything other than
>> the immediate root child nodes.
>>
>> Move architecture independent functions get_ima_kexec_buffer() and
>> get_root_addr_size_cells() to "drivers/of/kexec.c". These functions
>> retrieve the chosen node "linux,ima-kexec-buffer" from the device tree,
>> and return the address and size of the buffer used for carrying forward
>> the IMA measurement log across kexec system call.
>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> ---
>>   drivers/of/kexec.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/of.h |  3 ++
>>   2 files changed, 71 insertions(+)
>>
>> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
>> index 66787be081fe..9af5371340b1 100644
>> --- a/drivers/of/kexec.c
>> +++ b/drivers/of/kexec.c
>> @@ -30,6 +30,10 @@
>>   /**
>>    * fdt_find_and_del_mem_rsv - delete memory reservation with given address and size
>>    *
>> + * @fdt: Flattened Device Tree to update
>> + * @start: Starting address of the reservation to delete
>> + * @size: Size of the reservation to delete
>> + *
> 
> This belongs in the patch adding fdt_find_and_del_mem_rsv.

Yes.

> 
>>    * Return: 0 on success, or negative errno on error.
>>    */
>>   static int fdt_find_and_del_mem_rsv(void *fdt, unsigned long start, unsigned long size)
>> @@ -226,3 +230,67 @@ int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
>>   
>>   	return 0;
>>   }
>> +
>> +/**
>> + * get_root_addr_size_cells - Get address and size of root node
>> + *
>> + * @addr_cells: Return address of the root node
>> + * @size_cells: Return size of the root node
>> + *
>> + * Return: 0 on success, or negative errno on error.
>> + */
>> +int get_root_addr_size_cells(int *addr_cells, int *size_cells)
>> +{
>> +	struct device_node *root;
>> +
>> +	root = of_find_node_by_path("/");
>> +	if (!root)
>> +		return -EINVAL;
>> +
>> +	*addr_cells = of_n_addr_cells(root);
>> +	*size_cells = of_n_size_cells(root);
>> +
>> +	of_node_put(root);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * get_ima_kexec_buffer - Get address and size of IMA kexec buffer
>> + *
>> + * @fdt: Flattened Device Tree
>> + * @chosen_node: Offset of chosen node in the FDT
>> + * @addr: Return address of the node
>> + * @size: Return size of the node
>> + *
>> + * Return: 0 on success, or negative errno on error.
>> + */
>> +int get_ima_kexec_buffer(void *fdt, int chosen_node,
>> +			 unsigned long *addr, size_t *size)
>> +{
>> +	const void *prop;
>> +	int addr_cells, size_cells, prop_len;
>> +	int rc;
>> +
>> +	rc = get_root_addr_size_cells(&addr_cells, &size_cells);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (fdt)
>> +		prop = fdt_getprop(fdt, chosen_node,
>> +				   "linux,ima-kexec-buffer", &prop_len);
>> +	else
>> +		prop = of_get_property(of_chosen,
>> +				       "linux,ima-kexec-buffer", &prop_len);
> 
> This is an odd structure. The DT APIs are generally of_foo() for
> unflattened tree and of_flat_foo() for FDT.
> 
Ok - will update.

>> +
>> +	if (!prop)
>> +		return -ENOENT;
>> +
>> +	if (prop_len < 4 * (addr_cells + size_cells))
>> +		return -EINVAL;
>> +
>> +	*addr = of_read_number(prop, addr_cells);
>> +	*size = of_read_number(prop + 4 * addr_cells, size_cells);
>> +
>> +	return 0;
>> +}
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 3375f5295875..fb2ef274135d 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -562,6 +562,9 @@ struct kimage;
>>   int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
>>   			   unsigned long initrd_load_addr, unsigned long initrd_len,
>>   			   const char *cmdline);
>> +int get_root_addr_size_cells(int *addr_cells, int *size_cells);
>> +int get_ima_kexec_buffer(void *fdt, int chosen_node,
>> +			 unsigned long *addr, size_t *size);
> 
> The whole point of moving code out of arch code was to avoid all these
> cross tree calls.
> 
> I was expecting the next step to be moving setup_ima_buffer() call into
> of_kexec_setup_new_fdt with all the code in powerpc/kexec/ima.c moved
> here. Then the end result to enable on arm64 is just selecting
> HAVE_IMA_KEXEC and adding fields to kimage_arch.
> 

setup_ima_buffer() implemented for powerpc can be simplified by using
fdt_appendprop_addrrange() to add the IMA buffer's address and size to 
"linux,ima-kexec-buffer" node. With that change, setup_ima_buffer() can 
be moved into of_kexec_setup_new_fdt along with all the code in 
powerpc/kexec/ima.c to drivers'of/kexec.c

I'll make the above change and post the next version shortly.

thanks,
  -lakshmi


