Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC3E329395
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Mar 2021 22:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhCAV2r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Mar 2021 16:28:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236903AbhCAVVX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Mar 2021 16:21:23 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 121L5C2K043314;
        Mon, 1 Mar 2021 16:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bPdwz9xFSopP3gWyKd2EGm5vl/YJynNlL1UC6MxIubU=;
 b=Jr2suGvMJ+lZlBgjT0aXd0epRwqeFozlihoOEjnv2Zz61Stn6BfA/6uB3y+IiDmbwXA4
 YozXgwuWJ6a3FiNwzLnNzo+Rev1Dt3x+p3lrIj+S11kRzkx43Xm2DhKIatks+sJSjsIt
 IGzm3JXmQ+ri/dRt0OrEtllkGt6jKlz/7G0ZE6KzzqjgS0Uev7NL8wx9s2NjzW1z1exP
 VV4AdP3lxjdWPWegN5xKKtnRuOQj9J4damZ7+l2o/9K1mBNPqCC2MV5iPc1jIu3pk1Wc
 3aA+1v7Oy+ltoTL4v05s4ZMGIkwTgJeH4WJZyf8AZj7AshvmvUh+pHG8XPoGi3xjSNRg EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3717cf173p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 16:19:58 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 121L7HqF052227;
        Mon, 1 Mar 2021 16:19:58 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3717cf1738-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 16:19:58 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 121LC5de024690;
        Mon, 1 Mar 2021 21:19:57 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 37103vv3ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 21:19:57 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 121LJvhl24510740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Mar 2021 21:19:57 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECFADAC059;
        Mon,  1 Mar 2021 21:19:56 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA31DAC062;
        Mon,  1 Mar 2021 21:19:56 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Mar 2021 21:19:56 +0000 (GMT)
Subject: Re: [PATCH v9 9/9] certs: Add support for using elliptic curve keys
 for signing modules
To:     yumeng <yumeng18@huawei.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org
References: <20210225160802.2478700-1-stefanb@linux.vnet.ibm.com>
 <20210225160802.2478700-10-stefanb@linux.vnet.ibm.com>
 <ce098224-893c-fba8-5995-a7bac90f82c2@huawei.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <bb9fafb2-90f5-35b0-5c72-f3879d6efcb2@linux.ibm.com>
Date:   Mon, 1 Mar 2021 16:19:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ce098224-893c-fba8-5995-a7bac90f82c2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_13:2021-03-01,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010171
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/26/21 10:35 PM, yumeng wrote:
>
> 在 2021/2/26 0:08, Stefan Berger 写道:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>
>> diff --git a/certs/Makefile b/certs/Makefile
>> index 3fe6b73786fa..c487d7021c54 100644
>> --- a/certs/Makefile
>> +++ b/certs/Makefile
>> @@ -69,6 +69,18 @@ else
>>   SIGNER = -signkey $(obj)/signing_key.key
>>   endif # CONFIG_IMA_APPRAISE_MODSIG
>
> Is there anything wrong in this patch?
> I can't apply it when I use 'git am '.
> errors like below:

This patch builds on top Nayna's series for 'kernel build support for
loading the kernel module signing key'.
-https://lkml.org/lkml/2021/2/18/856

      Stefan


