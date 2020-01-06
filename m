Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67B91131593
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2020 17:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgAFQBz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jan 2020 11:01:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbgAFQBz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jan 2020 11:01:55 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 006FvZgV026372
        for <linux-integrity@vger.kernel.org>; Mon, 6 Jan 2020 11:01:54 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xb924faqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 06 Jan 2020 11:01:53 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 006G0U64018512
        for <linux-integrity@vger.kernel.org>; Mon, 6 Jan 2020 16:01:58 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01wdc.us.ibm.com with ESMTP id 2xajb63bfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 06 Jan 2020 16:01:58 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 006G1ntk63045936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jan 2020 16:01:49 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF48BBE04F;
        Mon,  6 Jan 2020 16:01:49 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DDBEBE053;
        Mon,  6 Jan 2020 16:01:49 +0000 (GMT)
Received: from [9.2.202.58] (unknown [9.2.202.58])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jan 2020 16:01:49 +0000 (GMT)
Subject: Re: Spec needed for ima-modsig template
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgoldman@us.ibm.com>
References: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
 <1577996725.5874.114.camel@linux.ibm.com>
 <584145d6-bf12-e5ee-972f-91283aa66f74@linux.ibm.com>
 <1578007322.5874.128.camel@linux.ibm.com>
 <69ef3bb7-abdd-8c18-1afc-722d35a807c1@linux.ibm.com>
 <1578180770.5152.30.camel@linux.ibm.com>
 <748a5aaf-8537-4313-a020-18c57a6056bb@linux.ibm.com>
 <1578325821.5222.42.camel@linux.ibm.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <7415a1ba-7fa9-4e86-f143-a3bc1bfdc80f@linux.ibm.com>
Date:   Mon, 6 Jan 2020 11:01:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578325821.5222.42.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_04:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=885 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060144
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/6/2020 10:50 AM, Mimi Zohar wrote:
>> I did have a question about the 'd-ng | sig | sig' template.  Is that an
>> error or could a file be signed with e.g. both RSA-2048 and RSA-3072?
>>
>> Etc.  You can see where I'm going - precise rules for an IMA log verifier.
> The "sig" field is the original IMA signature, stored as an extended
> attribute.  If/when IMA fs-verity support is added, that signature
> would require defining new digest and signature field types.  A
> template with two "sig" fields doesn't make sense.

We cannot prevent an attacker from creating the custom template 'd-ng | 
sig | sig', nor can we prevent an attacker from sending such a log to a 
verifier.  Thus, we have to specify to a verifier what logs are valid 
and what logs should be rejected and flagged as an attack.

I.e., the verifier cannot assume that it will only receive logs that 
make sense.  A secure parser has to handle any cleverly malformed event log.

There are 8-9 different possible IMA log fields, and we have to assume 
the attacker will corrupt any or all of them.

