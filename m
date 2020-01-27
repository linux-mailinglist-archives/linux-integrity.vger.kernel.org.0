Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43F5614AB5B
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 21:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgA0UzX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 15:55:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbgA0UzX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 15:55:23 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RKsEgl010508;
        Mon, 27 Jan 2020 15:55:22 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrgvmdfmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 15:55:22 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00RKqrQM023597;
        Mon, 27 Jan 2020 20:55:21 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma05wdc.us.ibm.com with ESMTP id 2xrda6m2ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 20:55:21 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00RKtK7U51249414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 20:55:20 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60A476A04D;
        Mon, 27 Jan 2020 20:55:20 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F145D6A047;
        Mon, 27 Jan 2020 20:55:19 +0000 (GMT)
Received: from [9.2.202.58] (unknown [9.2.202.58])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jan 2020 20:55:19 +0000 (GMT)
Subject: Re: [PATCH 2/2] ima: support calculating the boot_aggregate based on
 different TPM banks
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
 <1580140919-6127-2-git-send-email-zohar@linux.ibm.com>
 <87e6b531-3596-4523-a6b0-629ae8fd6995@linux.microsoft.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <2f93bcf7-9a59-06a6-9590-f002e15ba10a@linux.ibm.com>
Date:   Mon, 27 Jan 2020 15:55:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87e6b531-3596-4523-a6b0-629ae8fd6995@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_07:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270165
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/27/2020 11:50 AM, Lakshmi Ramasubramanian wrote:
> Can the number of allocated banks (ima_tpm_chip->nr_allocated_banks) be 
> zero? Should that be checked before accessing "allocated_banks"?

Summary:

It's unlikely that Linux on a PC will encounter a TPM without PCR 10.

It is likely that PCR 10 will be only SHA-256, that there will be no 
SHA-1 PCR 10.

~~

In theory:

Yes, one could have a TPM with no allocated banks.

In practice:

A PC Client TPM must have at least one bank with PCR 0 and PCR 17.

Some other TPMs, like automotive or embedded, may be different.

Most platforms will be designed to meet Windows requirements, which will 
have AFAIK at least one bank of 24 PCRs.

The TPM specification permits allocation of partial banks.  In theory, 
one could encounter a TPM with e.g., PCR 0-7 but not PCR 10.

In practice, AFAIK the hardware TPMs implement only full banks. 
Platform firmware allocates full banks.
