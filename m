Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5B4132A2D
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2020 16:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgAGPkn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jan 2020 10:40:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727559AbgAGPkn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jan 2020 10:40:43 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007FcS9C191109;
        Tue, 7 Jan 2020 10:40:36 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xb8s9vx7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 10:40:36 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 007FZ8Di018489;
        Tue, 7 Jan 2020 15:40:35 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 2xajb6v8s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 15:40:35 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 007FeXMx60162472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jan 2020 15:40:33 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0523BE058;
        Tue,  7 Jan 2020 15:40:32 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79EC3BE053;
        Tue,  7 Jan 2020 15:40:32 +0000 (GMT)
Received: from [9.2.202.58] (unknown [9.2.202.58])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jan 2020 15:40:32 +0000 (GMT)
Subject: Re: Spec needed for ima-modsig template
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgoldman@us.ibm.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
References: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
 <1577996725.5874.114.camel@linux.ibm.com>
 <584145d6-bf12-e5ee-972f-91283aa66f74@linux.ibm.com>
 <1578007322.5874.128.camel@linux.ibm.com>
 <69ef3bb7-abdd-8c18-1afc-722d35a807c1@linux.ibm.com>
 <1578180770.5152.30.camel@linux.ibm.com>
 <748a5aaf-8537-4313-a020-18c57a6056bb@linux.ibm.com>
 <1578325821.5222.42.camel@linux.ibm.com>
 <7415a1ba-7fa9-4e86-f143-a3bc1bfdc80f@linux.ibm.com>
 <249898ce999b4385927a076aa2679726@huawei.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <0cdf74d5-671f-7958-c74f-6dc82bf3077e@linux.ibm.com>
Date:   Tue, 7 Jan 2020 10:40:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <249898ce999b4385927a076aa2679726@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-07_05:2020-01-07,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=771 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070130
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/7/2020 3:53 AM, Roberto Sassu wrote:
> Defining a specification for which combinations
> are legitimate would definitely help.

That's my goal.

>> There are 8-9 different possible IMA log fields, and we have to assume
>> the attacker will corrupt any or all of them.
> 
> Template data is protected by the TPM. Any corruption can be detected
> by comparing the quoted PCRs with the PCRs calculated from the template
> digest.

An attacker can create a custom template or even modify the IMA source 
so that the hashes and PCRs match.  Then they send the malformed log to 
the verifier to try to exploit a vulnerability.

E.g., the custom template 'd-ng|d-ng| ...' repeated 1,000,000,000 times.

> What it remains to be done is to include the template name in the
> calculation of the template digest.

There's a backward compatibility issue for old templates.  Is it 
feasible for new templates and new names - start creating tags and 
include them in the template data so they gets hashed?



