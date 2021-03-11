Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132773374DB
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Mar 2021 15:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhCKODC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Mar 2021 09:03:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36536 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232893AbhCKOCr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Mar 2021 09:02:47 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12BDWdlZ113553;
        Thu, 11 Mar 2021 09:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZQy2UK7TDDAPhQ/gJj/WhYvmNG5h42YrwOCdwC+eoWs=;
 b=mZdHA6u6DgWrM/atqNDbTeILNhYaaKrn4t+8Q/pnvd72VNoR67Sew8zd+O0d+qe4zxTw
 r+WQ+7aAI4R4R420FNu/1hqpKFBTXh3cvTZviHnf958s2cIzZF15apB0cMleYCc2vynb
 q2qjgEuk2actmncxm9tv2Du73gYI9n4bSS0DvQCPK1ObTB60zEcphj788ncqgTUa0v89
 cyBNTiCy6HsWRw7rAFgz12HEF9x4bNeA0kHlMyTWAAm3/SInEYRt/2Zve3JPL1OWWYf7
 T+MLWqR6CnuQkpnqgunzpzRWl029cY48+gNuo5tKaMWbXmCJfp+LuKoqAml/TysptmiL 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774m7xs10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 09:02:43 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12BDWgDJ113664;
        Thu, 11 Mar 2021 09:02:42 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774m7xrym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 09:02:42 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12BDrVjF027596;
        Thu, 11 Mar 2021 14:02:40 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 3768n4r55n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 14:02:40 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12BE2drc10879636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 14:02:39 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 045966E04C;
        Thu, 11 Mar 2021 14:02:39 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 997696E052;
        Thu, 11 Mar 2021 14:02:38 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 11 Mar 2021 14:02:38 +0000 (GMT)
Subject: Re: [PATCH v2 1/3] tpm: efi: Use local variable for calculating final
 log size
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjg59@google.com
References: <20210310221916.356716-1-stefanb@linux.ibm.com>
 <20210310221916.356716-2-stefanb@linux.ibm.com> <YElUiIFkyf6txZoV@kernel.org>
 <YElVN0kwMIyeF9gQ@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <39ea4fef-0a21-ad06-118f-dbdf01cd5c61@linux.ibm.com>
Date:   Thu, 11 Mar 2021 09:02:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YElVN0kwMIyeF9gQ@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_04:2021-03-10,2021-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110073
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 3/10/21 6:24 PM, Jarkko Sakkinen wrote:
> On Thu, Mar 11, 2021 at 01:21:47AM +0200, Jarkko Sakkinen wrote:
>> On Wed, Mar 10, 2021 at 05:19:14PM -0500, Stefan Berger wrote:
>>> When tpm_read_log_efi is called multiple times, which happens when
>>> one loads and unloads a TPM2 driver multiple times, then the global
>>> variable efi_tpm_final_log_size will at some point become a negative
>>> number due to the subtraction of final_events_preboot_size occurring
>>> each time. Use a local variable to avoid this integer underflow.
>>>
>>> The following issue is now resolved:
>>>
>>> Mar  8 15:35:12 hibinst kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>>> Mar  8 15:35:12 hibinst kernel: Workqueue: tpm-vtpm vtpm_proxy_work [tpm_vtpm_proxy]
>>> Mar  8 15:35:12 hibinst kernel: RIP: 0010:__memcpy+0x12/0x20
>>> Mar  8 15:35:12 hibinst kernel: Code: 00 b8 01 00 00 00 85 d2 74 0a c7 05 44 7b ef 00 0f 00 00 00 c3 cc cc cc 66 66 90 66 90 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 <f3> 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 f3 a4
>>> Mar  8 15:35:12 hibinst kernel: RSP: 0018:ffff9ac4c0fcfde0 EFLAGS: 00010206
>>> Mar  8 15:35:12 hibinst kernel: RAX: ffff88f878cefed5 RBX: ffff88f878ce9000 RCX: 1ffffffffffffe0f
>>> Mar  8 15:35:12 hibinst kernel: RDX: 0000000000000003 RSI: ffff9ac4c003bff9 RDI: ffff88f878cf0e4d
>>> Mar  8 15:35:12 hibinst kernel: RBP: ffff9ac4c003b000 R08: 0000000000001000 R09: 000000007e9d6073
>>> Mar  8 15:35:12 hibinst kernel: R10: ffff9ac4c003b000 R11: ffff88f879ad3500 R12: 0000000000000ed5
>>> Mar  8 15:35:12 hibinst kernel: R13: ffff88f878ce9760 R14: 0000000000000002 R15: ffff88f77de7f018
>>> Mar  8 15:35:12 hibinst kernel: FS:  0000000000000000(0000) GS:ffff88f87bd00000(0000) knlGS:0000000000000000
>>> Mar  8 15:35:12 hibinst kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> Mar  8 15:35:12 hibinst kernel: CR2: ffff9ac4c003c000 CR3: 00000001785a6004 CR4: 0000000000060ee0
>>> Mar  8 15:35:12 hibinst kernel: Call Trace:
>>> Mar  8 15:35:12 hibinst kernel: tpm_read_log_efi+0x152/0x1a7
>>> Mar  8 15:35:12 hibinst kernel: tpm_bios_log_setup+0xc8/0x1c0
>>> Mar  8 15:35:12 hibinst kernel: tpm_chip_register+0x8f/0x260
>>> Mar  8 15:35:12 hibinst kernel: vtpm_proxy_work+0x16/0x60 [tpm_vtpm_proxy]
>>> Mar  8 15:35:12 hibinst kernel: process_one_work+0x1b4/0x370
>>> Mar  8 15:35:12 hibinst kernel: worker_thread+0x53/0x3e0
>>> Mar  8 15:35:12 hibinst kernel: ? process_one_work+0x370/0x370
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Fixes tag for this one?
> Or just sanity check, I think it is:
>
> Fixes: 166a2809d65b ("tpm: Don't duplicate events from the final event log in the TCG2 log")
Looks good.
>
> Also, I guess all of the patches ought to have stable cc, right?

Yes, please. I think the maintainer has to add this 'at some point'.

Since you queued them already I won't send a v3.


Thanks!

    Stefan


