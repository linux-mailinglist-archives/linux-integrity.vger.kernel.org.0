Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41B132D4C3
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Mar 2021 15:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhCDOAv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Mar 2021 09:00:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232591AbhCDOAb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Mar 2021 09:00:31 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124DcIPr170802;
        Thu, 4 Mar 2021 08:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=AR0H8gw8Jtn8ZcHHNn5tbGNJ1AS3AbzB1oQc+pxjvo0=;
 b=EqcZb7u8cIbQ2KuK2xSkb3wW+sqm3m0vdgQQmd3EbAOzLEWmJmnIHilCJwnFAR56ltlI
 XEKQgVzXPfK0u9mbYKUfyzIQ+Fp6cF7NN8/I3jZ3PBK1l8X575SvdiiETJqrSUFJvzmd
 Awidpml/HJy9bEhOwGkOOJMRZ0nCDSP6pRNg/Gdg+OQawn8p6YqfJopSXUi7ZcMf3yOo
 Raz/FHejtDXE72uAZ7UwhlcHk0B+PA/W2kiJGz0s2/om7++5aUs3jvLsg1l2GVCFd/LL
 xpPw6fdZmCjxSIqPH/AwHMnWBilZfZBO3WL4JvUR9tFRqygBu6tYSU1vlnPCWhd1Niko nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 372yd9au0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 08:59:38 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 124DcMcR171101;
        Thu, 4 Mar 2021 08:59:37 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 372yd9atyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 08:59:37 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 124DwHEk031000;
        Thu, 4 Mar 2021 13:59:37 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 3720r0pjwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 13:59:37 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 124DxaK87996006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Mar 2021 13:59:36 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4647AAE062;
        Thu,  4 Mar 2021 13:59:36 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35E89AE05C;
        Thu,  4 Mar 2021 13:59:36 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  4 Mar 2021 13:59:36 +0000 (GMT)
Subject: Re: [PATCH v9 6/9] crypto: Add NIST P384 curve parameters
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Saulo Alessandre <saulo.alessandre@tse.jus.br>
References: <20210225160802.2478700-1-stefanb@linux.vnet.ibm.com>
 <20210225160802.2478700-7-stefanb@linux.vnet.ibm.com>
 <20210304052809.GB25972@gondor.apana.org.au>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <37e5c232-11e8-0533-ab3e-676829091d19@linux.ibm.com>
Date:   Thu, 4 Mar 2021 08:59:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210304052809.GB25972@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_03:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103040063
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/4/21 12:28 AM, Herbert Xu wrote:
> On Thu, Feb 25, 2021 at 11:07:59AM -0500, Stefan Berger wrote:
>> From: Saulo Alessandre <saulo.alessandre@tse.jus.br>
>>
>> * crypto/ecc_curve_defs.h
>>    - add nist_p384 params
>>
>> * include/crypto/ecdh.h
>>    - add ECC_CURVE_NIST_P384
>>
>> Signed-off-by: Saulo Alessandre <saulo.alessandre@tse.jus.br>
>> Tested-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   crypto/ecc_curve_defs.h | 32 ++++++++++++++++++++++++++++++++
>>   include/crypto/ecdh.h   |  1 +
>>   2 files changed, 33 insertions(+)
> Can you reorder the patches so that the crypto patches come first
> and then I can apply them?

Yes, sounds good.

Are you going to take the other patches as well, except for maybe 9/9, 
which depends on Nayan's patch series. Mimi suggested to me to ask you 
whether you could create a topic branch where we can apply other patches 
to, such as Nayna's?

The NIST P384 patch temporarily introduces this warning, which goes away 
when the immediately following patch (current 7/9) is applied. Is this 
an issue or should I squash Saulo's patches or put the top hunk from 7/9 
into 6/9?


In file included from crypto/ecc.c:38:
crypto/ecc_curve_defs.h:76:25: warning: ?nist_p384? defined but not used 
[-Wunused-variable]
    76 | static struct ecc_curve nist_p384 = {
       |                         ^~~~~~~~~

    Stefan


>
> Thanks,


