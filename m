Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38173347AF
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Mar 2021 20:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCJTOZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Mar 2021 14:14:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhCJTOP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Mar 2021 14:14:15 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AJC2Ed141522;
        Wed, 10 Mar 2021 14:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=amzags5YcX+M0MJ1WgRdmRhqbumE4K+Zq6EJs80Aru0=;
 b=TqspHXiH1DhaCkEtORVakTEYbeZOVpF+upmAptCFYCDRnR42+gpwPJ/WJIWV346FWVIo
 qPX/c7nRYq7Pk6e+ChNluZSpKQVsAZUh2UezlcHi7oYwIZX7Ojt3zRIjvDpNlEGxfUuc
 qvZU5kypOc2bnMe7jmBmWUTvwLzbOTvLGavS46SU+LCmCbLJNw6Ip0XZ1QC8NIcmLBQh
 FMUHXUIhymOy3dh1gITIIdA6JSjsijnAJl4lyyuHjOpHSMA1SWUS7vrLPG+gNczMcEGL
 l+TL8H3ApUPviyYPIYtq+FWTkL8Q6n0RwAoBwtmKEN+B2wCHJj7g48TdYEmG03IU8F79 Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37742d85e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 14:14:06 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12AJCFic143091;
        Wed, 10 Mar 2021 14:13:58 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37742d82gm-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 14:13:58 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12AIbcBW009470;
        Wed, 10 Mar 2021 18:38:14 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 3768s24cxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 18:38:14 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12AIcDVQ15270284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 18:38:13 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52A21BE05D;
        Wed, 10 Mar 2021 18:38:13 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94BF9BE058;
        Wed, 10 Mar 2021 18:38:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 10 Mar 2021 18:38:12 +0000 (GMT)
Subject: Re: [PATCH v11 01/10] oid_registry: Add OIDs for ECDSA with
 sha224/256/384/512
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org
References: <20210305205956.3594375-1-stefanb@linux.vnet.ibm.com>
 <20210305205956.3594375-2-stefanb@linux.vnet.ibm.com>
 <YEjnPZOVit+U9YcG@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <b2672c92-ddf5-51ba-bb4c-f3aadee26daf@linux.ibm.com>
Date:   Wed, 10 Mar 2021 13:38:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEjnPZOVit+U9YcG@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_10:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100090
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 3/10/21 10:35 AM, Jarkko Sakkinen wrote:
> On Fri, Mar 05, 2021 at 03:59:47PM -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Add OIDs for ECDSA with sha224/256/384/512.
> Nit: SHA224/256/384/512 (sorry cannot help myself with these, have been
> doing this way too much, consider me as a bot :-) )
>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>   
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

Jarrko,

   I applied the nit and the 4 Acked-by's.

Thank you!


    Stefan


