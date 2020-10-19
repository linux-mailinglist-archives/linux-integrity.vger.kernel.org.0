Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73493292999
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Oct 2020 16:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgJSOiq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 10:38:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50326 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgJSOiq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 10:38:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JEY8dW129217;
        Mon, 19 Oct 2020 14:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Gud4ZzqGeg85rrC6j0kani9stDrAKUSQgky5o2ZZlR8=;
 b=R8R9MnKqMTwIJYDAt/6Jdf4Qbv6+uoErjhg2GHKKMrCT09g2kc9g4FdBR+VrkQHC1Xiz
 y5ToHugnAA9+EFfRr+5vCauCYh6dsAK+U+e+pbM/D8cSOVtSpPZRvHj4vcBh3zJShh6R
 qkHDj0ODful3EhcLwD+3cG4Qa7hGio7D2EGwkmQXuMDjSosyBQfutp+vYPy244SY7+Bi
 0RIwQ+saNZO03SwmmX89aIohTZA+5bHef7+ppg8f9g0Vv4Ke+fFqSKQ4wSKIBX2Wz4Bn
 O5iyA9w9U7AmU9m0Y0SdwK/uFznSE0ZRAInytSEWVg8eJipR+DpR1LvIfFX4/1F8X+wf kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 347s8mnsrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Oct 2020 14:38:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JEZwUM112014;
        Mon, 19 Oct 2020 14:38:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 348a6kyt4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Oct 2020 14:38:15 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09JEcCRM016646;
        Mon, 19 Oct 2020 14:38:12 GMT
Received: from [10.39.202.56] (/10.39.202.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Oct 2020 07:38:12 -0700
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Daniel Kiper <daniel.kiper@oracle.com>
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
 <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
 <20201015182654.lgtht5fd2aaunczu@tomti.i.net-space.pl>
 <20201016205151.GA1618249@rani.riverdale.lan>
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
Message-ID: <7529a1e7-4dd6-ab3a-6363-23fd2de6c338@oracle.com>
Date:   Mon, 19 Oct 2020 10:38:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016205151.GA1618249@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190101
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/16/20 4:51 PM, Arvind Sankar wrote:
> On Thu, Oct 15, 2020 at 08:26:54PM +0200, Daniel Kiper wrote:
>>
>> I am discussing with Ross the other option. We can create
>> .rodata.mle_header section and put it at fixed offset as
>> kernel_info is. So, we would have, e.g.:
>>
>> arch/x86/boot/compressed/vmlinux.lds.S:
>>         .rodata.kernel_info KERNEL_INFO_OFFSET : {
>>                 *(.rodata.kernel_info)
>>         }
>>         ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
>>
>>         .rodata.mle_header MLE_HEADER_OFFSET : {
>>                 *(.rodata.mle_header)
>>         }
>>         ASSERT(ABSOLUTE(mle_header) == MLE_HEADER_OFFSET, "mle_header at bad address!")
>>
>> arch/x86/boot/compressed/sl_stub.S:
>> #define mleh_rva(X) (((X) - mle_header) + MLE_HEADER_OFFSET)
>>
>>         .section ".rodata.mle_header", "a"
>>
>> SYM_DATA_START(mle_header)
>>         .long   0x9082ac5a    /* UUID0 */
>>         .long   0x74a7476f    /* UUID1 */
>>         .long   0xa2555c0f    /* UUID2 */
>>         .long   0x42b651cb    /* UUID3 */
>>         .long   0x00000034    /* MLE header size */
>>         .long   0x00020002    /* MLE version 2.2 */
>>         .long   mleh_rva(sl_stub_entry)    /* Linear entry point of MLE (virt. address) */
>>         .long   0x00000000    /* First valid page of MLE */
>>         .long   0x00000000    /* Offset within binary of first byte of MLE */
>>         .long   0x00000000    /* Offset within binary of last byte + 1 of MLE */
>>         .long   0x00000223    /* Bit vector of MLE-supported capabilities */
>>         .long   0x00000000    /* Starting linear address of command line (unused) */
>>         .long   0x00000000    /* Ending linear address of command line (unused) */
>> SYM_DATA_END(mle_header)
>>
>> Of course MLE_HEADER_OFFSET has to be defined as a constant somewhere.
>> Anyway, is it acceptable?
>>
>> There is also another problem. We have to put into mle_header size of
>> the Linux kernel image. Currently it is done by the bootloader but
>> I think it is not a role of the bootloader. The kernel image should
>> provide all data describing its properties and do not rely on the
>> bootloader to do that. Ross and I investigated various options but we
>> did not find a good/simple way to do that. Could you suggest how we
>> should do that or at least where we should take a look to get some
>> ideas?
>>
>> Daniel
> 
> What exactly is the size you need here? Is it just the size of the
> protected mode image, that's startup_32 to _edata. Or is it the size of

It is the size of the protected mode image. Though how to reference
those symbols to get the size might all more relocation issues.

> the whole bzImage file, or something else? I guess the same question
> applies to "first valid page of MLE" and "first byte of MLE", and the

Because of the way the launch environment is setup, both "first valid
page of MLE" and "first byte of MLE" are always zero so nothing to have
to sort out there. The only fields that need to be updated are "Linear
entry point of MLE" and "Offset within binary of last byte + 1 of MLE".

Thanks
Ross

> linear entry point -- are those all relative to startup_32 or do they
> need to be relative to the start of the bzImage, i.e. you have to add
> the size of the real-mode boot stub?
> 
> If you need to include the size of the bzImage file, that's not known
> when the files in boot/compressed are built. It's only known after the
> real-mode stub is linked. arch/x86/boot/tools/build.c fills in various
> details in the setup header and creates the bzImage file, but it does
> not currently modify anything in the protected-mode portion of the
> compressed kernel (i.e. arch/x86/boot/compressed/vmlinux, which then
> gets converted to binary format as arch/x86/boot/vmlinux.bin), so it
> would need to be extended if you need to modify the MLE header to
> include the bzImage size or anything depending on the size of the
> real-mode stub.
> 

