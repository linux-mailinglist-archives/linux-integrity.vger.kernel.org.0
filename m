Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B149D278B9C
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Sep 2020 17:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgIYO71 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Sep 2020 10:59:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35538 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgIYO7R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Sep 2020 10:59:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PEtON7093194;
        Fri, 25 Sep 2020 14:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=KBajAr//8CgaZncjmmtHx6pmz9MNjgdQXqLWcgD3Ze0=;
 b=H30XNnlMx/xzx8IZE1wtRV4+gckn0lpbNz1IbsI2v8nNN8f286skb2qnNlg2nyUFOCvp
 w2TwnjINm0zZU/IFe3WD95g0/xOdtd3UNg0NpUIurdM0+nB/Cx8Oo5Gjp0z2nfv8mkpt
 Wa6UqopzfVowKR2n3eppuxHL1XDnYX5j8Z/oS79SBE2bshcbZuKia4osjF3L7ZUIAlxN
 MXE+83u2mamMLNUg8N9rOym5mySnKbTeDyf2KfWU2ljoL2oOWzflWvzibyXPCH3mcU/J
 HP0Wb2mpNP07GDVC++sjGMmd49MHQm5LAVgnYvu74+JsHNcbydjdLBjwdP6mAKErEu0L /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33q5rgvgcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 14:58:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PEuYVx135834;
        Fri, 25 Sep 2020 14:56:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33nurxwgjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 14:56:49 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08PEukPK009487;
        Fri, 25 Sep 2020 14:56:47 GMT
Received: from [10.39.243.24] (/10.39.243.24)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 07:56:46 -0700
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
Message-ID: <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
Date:   Fri, 25 Sep 2020 10:56:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924173801.GA103726@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250107
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/24/20 1:38 PM, Arvind Sankar wrote:
> On Thu, Sep 24, 2020 at 10:58:35AM -0400, Ross Philipson wrote:
>> The Secure Launch (SL) stub provides the entry point for Intel TXT (and
>> later AMD SKINIT) to vector to during the late launch. The symbol
>> sl_stub_entry is that entry point and its offset into the kernel is
>> conveyed to the launching code using the MLE (Measured Launch
>> Environment) header in the structure named mle_header. The offset of the
>> MLE header is set in the kernel_info. The routine sl_stub contains the
>> very early late launch setup code responsible for setting up the basic
>> environment to allow the normal kernel startup_32 code to proceed. It is
>> also responsible for properly waking and handling the APs on Intel
>> platforms. The routine sl_main which runs after entering 64b mode is
>> responsible for measuring configuration and module information before
>> it is used like the boot params, the kernel command line, the TXT heap,
>> an external initramfs, etc.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> Which version of the kernel is this based on?

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

master branch

> 
>> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
>> index 97d37f0..42043bf 100644
>> --- a/arch/x86/boot/compressed/head_64.S
>> +++ b/arch/x86/boot/compressed/head_64.S
>> @@ -279,6 +279,21 @@ SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
>>  SYM_FUNC_END(efi32_stub_entry)
>>  #endif
>>  
>> +#ifdef CONFIG_SECURE_LAUNCH
>> +SYM_FUNC_START(sl_stub_entry)
>> +	/*
>> +	 * On entry, %ebx has the entry abs offset to sl_stub_entry. To
>> +	 * find the beginning of where we are loaded, sub off from the
>> +	 * beginning.
>> +	 */
> 
> This requirement should be added to the documentation. Is it necessary
> or can this stub just figure out the address the same way as the other
> 32-bit entry points, using the scratch space in bootparams as a little
> stack?

It is based on the state of the BSP when TXT vectors to the measured
launch environment. It is documented in the TXT spec and the SDMs.

> 
>> +	leal	(startup_32 - sl_stub_entry)(%ebx), %ebx
>> +
>> +	/* More room to work in sl_stub in the text section */
>> +	jmp	sl_stub
>> +
>> +SYM_FUNC_END(sl_stub_entry)
>> +#endif
>> +
>>  	.code64
>>  	.org 0x200
>>  SYM_CODE_START(startup_64)
>> @@ -537,6 +552,25 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>>  	shrq	$3, %rcx
>>  	rep	stosq
>>  
>> +#ifdef CONFIG_SECURE_LAUNCH
>> +	/*
>> +	 * Have to do the final early sl stub work in 64b area.
>> +	 *
>> +	 * *********** NOTE ***********
>> +	 *
>> +	 * Several boot params get used before we get a chance to measure
>> +	 * them in this call. This is a known issue and we currently don't
>> +	 * have a solution. The scratch field doesn't matter and loadflags
>> +	 * have KEEP_SEGMENTS set by the stub code. There is no obvious way
>> +	 * to do anything about the use of kernel_alignment or init_size
>> +	 * though these seem low risk.
>> +	 */
> 
> There are various fields in bootparams that depend on where the
> kernel/initrd and cmdline are loaded in memory. If the entire bootparams
> page is getting measured, does that mean they all have to be at fixed
> addresses on every boot?

Yes that is a very good point. In other places when measuring we make
sure to skip things like addresses and sizes of things outside of the
structure being measured. This needs to be done with boot params too.

> 
> Also KEEP_SEGMENTS support is gone from the kernel since v5.7, since it
> was unused. startup_32 now always loads a GDT and then the segment
> registers. I think this should be ok for you as the only thing the flag
> used to do in the 64-bit kernel was to stop startup_32 from blindly
> loading __BOOT_DS into the segment registers before it had setup its own
> GDT.

Yea this was there to prevent that blind loading of __BOOT_DS. I see it
is gone so I will remove the comment and the place where the flag is set.

> 
> For the 32-bit assembler code that's being added, tip/master now has
> changes that prevent the compressed kernel from having any runtime
> relocations.  You'll need to revise some of the code and the data
> structures initial values to avoid creating relocations.

Could you elaborate on this some more? I am not sure I see places in the
secure launch asm that would be creating relocations like this.

Thank you,
Ross

> 
> Thanks.
> 

