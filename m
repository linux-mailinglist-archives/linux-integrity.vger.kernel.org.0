Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A490D12ED0D
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jan 2020 23:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgABWY3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jan 2020 17:24:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729226AbgABWY2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jan 2020 17:24:28 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 002MLVl0126702
        for <linux-integrity@vger.kernel.org>; Thu, 2 Jan 2020 17:24:28 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x88jwde30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 02 Jan 2020 17:24:27 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 002MKvI2011648
        for <linux-integrity@vger.kernel.org>; Thu, 2 Jan 2020 22:24:26 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03wdc.us.ibm.com with ESMTP id 2x5xp6m151-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 02 Jan 2020 22:24:26 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 002MONwB57213206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Jan 2020 22:24:24 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDDD3BE054;
        Thu,  2 Jan 2020 22:24:23 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CBAABE051;
        Thu,  2 Jan 2020 22:24:23 +0000 (GMT)
Received: from [9.2.202.58] (unknown [9.2.202.58])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Jan 2020 22:24:23 +0000 (GMT)
Subject: Re: Spec needed for ima-modsig template
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgoldman@us.ibm.com>
References: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
 <1577996725.5874.114.camel@linux.ibm.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <584145d6-bf12-e5ee-972f-91283aa66f74@linux.ibm.com>
Date:   Thu, 2 Jan 2020 17:24:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1577996725.5874.114.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_07:2020-01-02,2020-01-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=635 mlxscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001020181
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/2/2020 3:25 PM, Mimi Zohar wrote:
> On Thu, 2020-01-02 at 15:10 -0500, Ken Goldman wrote:
>> I'm trying to document the ima-modsig template and then write aparser.
>> Can anyone help me complete it?
>>
>> 1 - What the implementation does today is interesting.  Even betterwould
>> be what the implementation is permitted to do so that theparser will
>> handle future changes.
>>
>> 2 - My understanding so far:
>>
>>       ima-modsig        is        d-ng | n-ng | sig | d-modsig |modsig
>>
>>       where (both have a prepended uint32_t length)
>>
>>       d-modsig            is    d-ng, filedata hash, omitting the
>> appended modsig signature
>>       modsig                is     pkcs7DER, appended signature
>>
>> My immediate issue is that the d-modsig should be a length +
>> hashalgorithm + file data hash.  However, the length in my sample log
>> issometimes zero, which I did not expect.
>>
>> I.e., it it legal for an ima-modsig template to contain an emptyd-modsig
>> item?
>>
>> Can the modsig item also be empty?
> 
> Like the "sig" field in the "ima-sig" template, both the "d-modsig"
> and "modsig" fields in the "ima-modsig" template may be empty.
> 

I understand sig being empty is the file isn't signed.  Same with 
modsig.  The verifier could flag that.

However, d-modsig is a hash.  How should a parser interpret a missing 
[file data] hash?  Under what conditions would that be legal / illegal / 
something to flag to an admin UI?

