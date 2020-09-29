Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AABC27D07E
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Sep 2020 16:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbgI2OE0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 10:04:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48600 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbgI2OEZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 10:04:25 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TDxmDC118624;
        Tue, 29 Sep 2020 14:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CFe+cvI5nz53lfd2+KweINkQ3YP12gBpcRgZPmyn9yY=;
 b=uUTAuRS94TAqd9hRPZZYzQIQspIUmVznDdSbHz1SrC1eO/K2NRu0Lew5h0f0rq9fo6TJ
 3odhIbjestgfsEsJcZWWLJ027Utn3s/p/xYo1X4LmC5tCjgCrmaxjFymCJHAUOzsK1Gq
 qeIHY3FQeyI6KjUN3BY/uOY+UHNj26M76bVBGnMIhoULMOjwecNs82FbYvKfXs4SSwbk
 G5HE/dSKbt0s/ShWoxTwzVaOjtxFCkfy0FGw9Eqv8mEDgvIhxyzFtslaXPEa5urqxXAs
 594j8vKP4/h8ILdHaIzmzVmTqmOczvNw6+Jn+8bPN9KTa5eQpvgKkQH/S5DQoKvXy33t yA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33su5au12n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 14:03:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08TE1kG5039541;
        Tue, 29 Sep 2020 14:03:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33tfjwrqg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 14:03:54 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08TE3p4c009567;
        Tue, 29 Sep 2020 14:03:51 GMT
Received: from [10.39.214.226] (/10.39.214.226)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 07:03:50 -0700
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
 <20200924173801.GA103726@rani.riverdale.lan>
 <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
 <20200925191842.GA643740@rani.riverdale.lan>
From:   Ross Philipson <ross.philipson@oracle.com>
Autocrypt: addr=ross.philipson@oracle.com; keydata=
 mQENBFtHZ04BCADHhtvMImplKfIEOytU7ZH4haZ9eFAqZpGeIpG9D+pzTCuReM2/49bvgNoI
 e1xuiQFO+UEJ8FjedFjDdqY7fSw3xVdX9gLwD1Rmw0Dadc1w6sGbcoOQLHcglesu+BmcKBtU
 tWQZkzCpEShN4etgZThk8469YnAvO08vNZsrizgrpD90T7mEYiNXxIkX87sPGbnBrL1X7RvZ
 TaRXfE8174W+XVwGEpSiO/GjRgLW8+DFZB5MgXpCR993+U1YT9Lz97/MRzr4hqcOYry6LBYi
 s8dOly4oP7gK15oW8Xap9+ur0Jd8Vy8o99Axq+7yunF+2KE2SwP3/w8H3VDpx7EeDhWDABEB
 AAG0KlJvc3MgUGhpbGlwc29uIDxyb3NzLnBoaWxpcHNvbkBvcmFjbGUuY29tPokBVAQTAQgA
 PgIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBFsN7r6v0OZTCaJ1wdpHdTZHiMYcBQJb
 R2eBBQkJZgGzAAoJENpHdTZHiMYcPYcH/Rlp3/F3P4/2i/W0F4yQDVD6rAkejCws4KlbgC5D
 Slkdvk6j8jOW/HNeIY3n+a3mW0iyyhZlipgYAqkK1loDiDxJjc2eUaHxiYWNLQ4CwIj2EC27
 AWCp6hgwHNWmZrdeNbM/Z6LTFQILx5xzgX+86KNqzFV7gOcAaS2qBVz1D83dgrFZaGaao918
 nvfe+SnImo0GaEf8nVDKgsD2zfzMBkk4q/E0mrEADFXwBHSvNCnVyrCN6Ve0dHWgI7SszUDt
 7v01zbGPR5mRfGuyC9gykd2SDCw5/Q27RMWfaPFL/dtiZBljUzb2yW5jicZAz7zNdDcBSUGR
 r//wxtG4k/dBrMW5AQ0EW0dnTwEIAPelEnLDnfJnHdFR+1Thrvv3Udt/1cjqQfHqH4F8zef/
 MsIcPV1skL7qPUYD+CrbasvmqhlPxtJAtN68inPa70fA2g0PtNmLUH1NBb2e6EjOoVZg9ais
 BWfdYUITZouOXs2zCTFsoNWjTJANnXxexbTf1ZEqfzlVtQK+xAnXl3kiL4Y47VMbgDkGedhw
 3ZMWQ2zMMZqYJkPYhtlTXtedhV91DL1347ULwHsvkUJDZ0gL+WU6tYhsCOOiD61x58PfUiFb
 /WkZEPxb96dSSSWrTlLlBWSSD24RnhfbJjfsXeSu9s4XldmGTDkj7jclMVU1xV0BUfqEwhVn
 xR8FlC+dZvkAEQEAAYkBPAQYAQgAJgIbDBYhBFsN7r6v0OZTCaJ1wdpHdTZHiMYcBQJbR2eB
 BQkJZgGyAAoJENpHdTZHiMYcDIAIAIRJrKjIStRvLsOOCX92s9XJPUjrC/xmtVsqVviyFWIC
 QRPQzDE+bDSvRazudBHmcPW+BOOB5B+p7zKZzOGoZV2peG8oA/Y8oCxOYBtpbBaZ5KJexm/g
 BbnJUwb3uhmKtDShHGUCmtq8MZBJBr6Q6xHprOU8Qnzs9Jea8NVwaz9O226Rrg4XVv/sK1Lh
 ++xZfhi7YqKWdx5vdfdnX1xWe8ma0eXLeCDh3V6Ys+Habw1jEbMuafrcVzAbp1rMt2Lju1ls
 BNAoxeViK7QXWfwGTmGJP++jHmo99gMqEtiohf+37N0oS6uYu6kaE7PxsEcOjWKJxW/DdgwO
 eFq+D6xuiKk=
Message-ID: <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
Date:   Tue, 29 Sep 2020 10:03:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925191842.GA643740@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290124
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/25/20 3:18 PM, Arvind Sankar wrote:
> On Fri, Sep 25, 2020 at 10:56:43AM -0400, Ross Philipson wrote:
>> On 9/24/20 1:38 PM, Arvind Sankar wrote:
>>> On Thu, Sep 24, 2020 at 10:58:35AM -0400, Ross Philipson wrote:
>>>
>>>> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
>>>> index 97d37f0..42043bf 100644
>>>> --- a/arch/x86/boot/compressed/head_64.S
>>>> +++ b/arch/x86/boot/compressed/head_64.S
>>>> @@ -279,6 +279,21 @@ SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
>>>>  SYM_FUNC_END(efi32_stub_entry)
>>>>  #endif
>>>>  
>>>> +#ifdef CONFIG_SECURE_LAUNCH
>>>> +SYM_FUNC_START(sl_stub_entry)
>>>> +	/*
>>>> +	 * On entry, %ebx has the entry abs offset to sl_stub_entry. To
>>>> +	 * find the beginning of where we are loaded, sub off from the
>>>> +	 * beginning.
>>>> +	 */
>>>
>>> This requirement should be added to the documentation. Is it necessary
>>> or can this stub just figure out the address the same way as the other
>>> 32-bit entry points, using the scratch space in bootparams as a little
>>> stack?
>>
>> It is based on the state of the BSP when TXT vectors to the measured
>> launch environment. It is documented in the TXT spec and the SDMs.
>>
> 
> I think it would be useful to add to the x86 boot documentation how
> exactly this new entry point is called, even if it's just adding a link
> to some section of those specs. The doc should also say that an
> mle_header_offset of 0 means the kernel isn't secure launch enabled.

Ok will do.

> 
>>>
>>> For the 32-bit assembler code that's being added, tip/master now has
>>> changes that prevent the compressed kernel from having any runtime
>>> relocations.  You'll need to revise some of the code and the data
>>> structures initial values to avoid creating relocations.
>>
>> Could you elaborate on this some more? I am not sure I see places in the
>> secure launch asm that would be creating relocations like this.
>>
>> Thank you,
>> Ross
>>
> 
> You should see them if you do
> 	readelf -r arch/x86/boot/compressed/vmlinux
> 
> In terms of the code, things like:
> 
> 	addl    %ebx, (sl_gdt_desc + 2)(%ebx)
> 
> will create a relocation, because the linker interprets this as wanting
> the runtime address of sl_gdt_desc, rather than just the offset from
> startup_32.
> 
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/arch/x86/boot/compressed/head_64.S*n48__;Iw!!GqivPVa7Brio!JpZWv1cCPZdjD2jbCCGT7P9UIVl_lhX7YjckAnUcvi927jwZI7X3nX0MpIAZOyktJds$ 
> 
> has a comment with some explanation and a macro that the 32-bit code in
> startup_32 uses to avoid creating relocations.
> 
> Since the SL code is in a different assembler file (and a different
> section), you can't directly use the same macro. I would suggest getting
> rid of sl_stub_entry and entering directly at sl_stub, and then the code
> in sl_stub.S can use sl_stub for the base address, defining the rva()
> macro there as
> 
> 	#define rva(X) ((X) - sl_stub)
> 
> You will also need to avoid initializing data with symbol addresses.
> 
> 	.long mle_header
> 	.long sl_stub_entry
> 	.long sl_gdt
> 
> will create relocations. The third one is easy, just replace it with
> sl_gdt - sl_gdt_desc and initialize it at runtime with
> 
> 	leal	rva(sl_gdt_desc)(%ebx), %eax
> 	addl	%eax, 2(%eax)
> 	lgdt	(%eax)
> 
> The other two are more messy, unfortunately there is no easy way to tell
> the linker what we want here. The other entry point addresses (for the
> EFI stub) are populated in a post-processing step after the compressed
> kernel has been linked, we could teach it to also update kernel_info.
> 
> Without that, for kernel_info, you could change it to store the offset
> of the MLE header from kernel_info, instead of from the start of the
> image.
> 
> For the MLE header, it could be moved to .head.text in head_64.S, and
> initialized with
> 	.long rva(sl_stub)
> This will also let it be placed at a fixed offset from startup_32, so
> that kernel_info can just be populated with a constant.

Thank you for the detailed reply. I am going to start digging into this now.

Ross

> 

