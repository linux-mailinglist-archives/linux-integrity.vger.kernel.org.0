Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E012FC86
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2020 19:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgACS1s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jan 2020 13:27:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728251AbgACS1s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jan 2020 13:27:48 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 003IRjeh132552
        for <linux-integrity@vger.kernel.org>; Fri, 3 Jan 2020 13:27:47 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xa48kug3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jan 2020 13:27:45 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 003IQKsf014108
        for <linux-integrity@vger.kernel.org>; Fri, 3 Jan 2020 18:27:14 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 2x5xp77m59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jan 2020 18:27:14 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 003IRBc952363638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jan 2020 18:27:11 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAFDBBE051;
        Fri,  3 Jan 2020 18:27:11 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B59CBE053;
        Fri,  3 Jan 2020 18:27:11 +0000 (GMT)
Received: from [9.2.202.58] (unknown [9.2.202.58])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jan 2020 18:27:11 +0000 (GMT)
Subject: Re: Spec needed for ima-modsig template
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgoldman@us.ibm.com>
References: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
 <1577996725.5874.114.camel@linux.ibm.com>
 <584145d6-bf12-e5ee-972f-91283aa66f74@linux.ibm.com>
 <1578007322.5874.128.camel@linux.ibm.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <69ef3bb7-abdd-8c18-1afc-722d35a807c1@linux.ibm.com>
Date:   Fri, 3 Jan 2020 13:27:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578007322.5874.128.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-03_05:2020-01-02,2020-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001030167
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/2/2020 6:22 PM, Mimi Zohar wrote:
>> However, d-modsig is a hash.  How should a parser interpret a missing
>> [file data] hash?  Under what conditions would that be legal / illegal /
>> something to flag to an admin UI?
> The "d-modsig" is the hash of the file without the appended signature.
>   That hash is needed to verify the appended signature.  If there isn't
> an appended signature, then there would be no reason for "d-modsig".

I'd like to make the leap from "no reason to" to what is permissible, 
what a verifier would treat as legal or an error case.

E.g., should the IMA log specification say:

If the sig length is zero, the d-modsig length MUST be zero.

Or might it be a MAY, and then state

If the signature length is zero and the d-modsig length is non-zero,
then the contents MUST be the same as the d-ng value.

What if the template has no 'd-ng', but it has a d-modsig?

What happens if the template has no 'sig'.  I.e. the sig
is absent, then ... perhaps absent is the same as length zero?

Would we enforce that the d-ng hash algorithm MUST be the same as
that of the d-modsig, or could they be different?

What if there are two 'sig' fields, one is zero and the other is not.

~~

While the above are clearly not the normal case:

1 - An attacker can use a custom IMA template to find a vulnerability in 
the IMA implementation, or

2 - An attacker could send a malformed log to a verifier.  To the 
verifier, the received IMA log is unvalidated input, so the parser has 
to be fastidious.





