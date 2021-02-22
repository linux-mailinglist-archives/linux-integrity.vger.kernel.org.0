Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAED2321A7A
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 15:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhBVOis (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Feb 2021 09:38:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230141AbhBVOis (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Feb 2021 09:38:48 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11MERiEk019933;
        Mon, 22 Feb 2021 09:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YxyJsHAAeNR+8tn06sJ65l8NksUBProCeCm942uGM28=;
 b=KCf/VOJyHk7yDs1M57qJUxiXMklQbP1wIsGfHepyqSYclilS4twht9U5hQ+cDhtvnkcJ
 pb3CIaJB6SYZAAmGDmxlwu++1lcbGot4TCRqBNkwKOmXzh1BVf7FZqjMPKDMHijtaaMS
 GGuQEdMdQrRUeAFYOHIipa6yGfqE1TYcd/ZAfjm2HQj3ehN/fA7beaI+TiYTv3qhX1u9
 2RNQoEZfyS53Xba9yIsBSMIM2GP5C8tLuFSI2ee7ROW/Z2NRlMergbaE4EreBN+7xiYZ
 /OX564OjoOXvvmdN6WgG7EcBw09oRu6V+CCCVn1+lS998fnXR/8hlCypTBcWyzyLwG3G 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vecy88sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 09:31:55 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11MERidF019992;
        Mon, 22 Feb 2021 09:30:25 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36vecy82vw-27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 09:30:25 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11MDXRPx031337;
        Mon, 22 Feb 2021 13:33:36 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 36tt29aew5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 13:33:36 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11MDXZUK7734048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 13:33:35 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 161AEAC05B;
        Mon, 22 Feb 2021 13:33:35 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D88FCAC059;
        Mon, 22 Feb 2021 13:33:34 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 22 Feb 2021 13:33:34 +0000 (GMT)
Subject: Re: [PATCH] certs: Add support for using elliptic curve keys for
 signing modules
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, dhowells@redhat.com, dwmw2@infradead.org,
        linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        nayna@linux.ibm.com, saulo.alessandre@gmail.com
References: <20210219154114.2416778-1-stefanb@linux.vnet.ibm.com>
 <0e2a789456a970ebdde9a65717b15d478af73ae3.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <e96a24ea-be12-616e-09dc-f8cffa56bee9@linux.ibm.com>
Date:   Mon, 22 Feb 2021 08:33:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <0e2a789456a970ebdde9a65717b15d478af73ae3.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_02:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220130
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/19/21 11:52 AM, Mimi Zohar wrote:
> On Fri, 2021-02-19 at 10:41 -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> This patch adds support for using elliptic curve keys for signing
>> modules. It uses a NIST P256 (prime256v1) key if the user chooses an
>> elliptic curve key.
>>
>> A developer choosing an ECDSA key for signing modules has to manually
>> delete the signing key (rm certs/signing_key.*) when falling back to
>> an older version of a kernel that only supports RSA key since otherwise
>> ECDSA-signed modules will not be usable when that older kernel runs.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Thanks, Stefan!
>
> Tested with this patch applied on top of "[PATCH v8 0/4] Add support
> for x509 certs with NIST p256 and p192" and "[PATCH v2 0/5] ima: kernel
> build support for loading the kernel module" patch sets.

With Saulo's NIST p384 support we will now be able to improve this patch 
to use secp384r1 (NIST P384), which is probably the better equivalent to 
the current RSA 4096.


    Stefan


>
> Tested-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>

