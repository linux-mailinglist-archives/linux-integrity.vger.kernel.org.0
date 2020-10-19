Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABAD292E09
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Oct 2020 21:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbgJSTC5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 15:02:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42980 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731171AbgJSTC4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 15:02:56 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JIt3B9001923;
        Mon, 19 Oct 2020 19:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=75k25M017qek88/4gZDH4qga+PVWWC3GXgN88Ccu/Nk=;
 b=fVpyz6yb551ZJnH1g/uOZAVndNR4qVE8UgTLjo4p9UWrAwtpUINP1WkTUhDYXeqTgvFn
 23eD2d8Ub+WwPaOjoSHRSxvuhiaz/UFzLH03Ut3LtXTIqaTWQatzdqmaRv07D0t2utvq
 06iymj7AhoXQ3swedYT1TkVvD1yGOCV3IN2Rs2ScKZQkNISt5GNsVsY6rGTmZls6XV8r
 AV5+uhNL3FSVvJtuOOMq0yz2jTcCvA2z7auAhmQbPfjpYCQD8DDtBqK/QSlyzUBE3XeH
 70nS11MnoVA7nUFdEwRf7EllsCcaC2JLl3jVix0VmsJMxc4VVgzOu3enLbtbg6wI/HZE WQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 347p4aqcnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Oct 2020 19:02:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JItxXj104123;
        Mon, 19 Oct 2020 19:00:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 348a6m8822-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Oct 2020 19:00:39 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09JJ0bHP031008;
        Mon, 19 Oct 2020 19:00:37 GMT
Received: from [10.39.202.56] (/10.39.202.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Oct 2020 12:00:37 -0700
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
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
 <7529a1e7-4dd6-ab3a-6363-23fd2de6c338@oracle.com>
 <20201019170615.GB2701355@rani.riverdale.lan>
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
Message-ID: <aeb92fc9-535d-8310-238c-f8a738d60acb@oracle.com>
Date:   Mon, 19 Oct 2020 15:00:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019170615.GB2701355@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010190126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/19/20 1:06 PM, Arvind Sankar wrote:
> On Mon, Oct 19, 2020 at 10:38:08AM -0400, Ross Philipson wrote:
>> On 10/16/20 4:51 PM, Arvind Sankar wrote:
>>> On Thu, Oct 15, 2020 at 08:26:54PM +0200, Daniel Kiper wrote:
>>>>
>>>> I am discussing with Ross the other option. We can create
>>>> .rodata.mle_header section and put it at fixed offset as
>>>> kernel_info is. So, we would have, e.g.:
>>>>
>>>> arch/x86/boot/compressed/vmlinux.lds.S:
>>>>         .rodata.kernel_info KERNEL_INFO_OFFSET : {
>>>>                 *(.rodata.kernel_info)
>>>>         }
>>>>         ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
>>>>
>>>>         .rodata.mle_header MLE_HEADER_OFFSET : {
>>>>                 *(.rodata.mle_header)
>>>>         }
>>>>         ASSERT(ABSOLUTE(mle_header) == MLE_HEADER_OFFSET, "mle_header at bad address!")
>>>>
>>>> arch/x86/boot/compressed/sl_stub.S:
>>>> #define mleh_rva(X) (((X) - mle_header) + MLE_HEADER_OFFSET)
>>>>
>>>>         .section ".rodata.mle_header", "a"
>>>>
>>>> SYM_DATA_START(mle_header)
>>>>         .long   0x9082ac5a    /* UUID0 */
>>>>         .long   0x74a7476f    /* UUID1 */
>>>>         .long   0xa2555c0f    /* UUID2 */
>>>>         .long   0x42b651cb    /* UUID3 */
>>>>         .long   0x00000034    /* MLE header size */
>>>>         .long   0x00020002    /* MLE version 2.2 */
>>>>         .long   mleh_rva(sl_stub_entry)    /* Linear entry point of MLE (virt. address) */
>>>>         .long   0x00000000    /* First valid page of MLE */
>>>>         .long   0x00000000    /* Offset within binary of first byte of MLE */
>>>>         .long   0x00000000    /* Offset within binary of last byte + 1 of MLE */
>>>>         .long   0x00000223    /* Bit vector of MLE-supported capabilities */
>>>>         .long   0x00000000    /* Starting linear address of command line (unused) */
>>>>         .long   0x00000000    /* Ending linear address of command line (unused) */
>>>> SYM_DATA_END(mle_header)
>>>>
>>>> Of course MLE_HEADER_OFFSET has to be defined as a constant somewhere.
>>>> Anyway, is it acceptable?
>>>>
>>>> There is also another problem. We have to put into mle_header size of
>>>> the Linux kernel image. Currently it is done by the bootloader but
>>>> I think it is not a role of the bootloader. The kernel image should
>>>> provide all data describing its properties and do not rely on the
>>>> bootloader to do that. Ross and I investigated various options but we
>>>> did not find a good/simple way to do that. Could you suggest how we
>>>> should do that or at least where we should take a look to get some
>>>> ideas?
>>>>
>>>> Daniel
>>>
>>> What exactly is the size you need here? Is it just the size of the
>>> protected mode image, that's startup_32 to _edata. Or is it the size of
>>
>> It is the size of the protected mode image. Though how to reference
>> those symbols to get the size might all more relocation issues.
>>
> 
> Ok, then I think mleh_rva(_edata) should get you that -- I assume you
> don't want to include the uninitialized data in the size? The kernel
> will access memory beyond _edata (upto the init_size in the setup
> header), but that's not part of the image itself.

Yea we basically want the size of the image. There is nothing to measure
beyond the image as loaded into memory by the bootloader. rva(_edata)
seems to be the ticket.

Thanks
Ross

> 

