Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9B8358D6A
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Apr 2021 21:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhDHTT7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Apr 2021 15:19:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231420AbhDHTT6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Apr 2021 15:19:58 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138J3aLQ059560;
        Thu, 8 Apr 2021 15:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=z+SOJozTAJ0BmatceWnXqEICf7YQQfqohk2XpAt/TpU=;
 b=ZmIA/kMe4sJssPOhpvsHO2eMrIVgHy8BjqS9BWfjDHRLrsCRWXNknxhNv5IufcAZxCmn
 hTJWOGxtxo3jf/7xqYNRPTD8t5EmufSpoNM6XuL1cCBDInY+FFynWTHXjN+liuHhrjVV
 9ZYBl48R41KfJMqufZdSfg8d9LvNYNvIteQpKhQxDwl1VAvop56y6bGUgwW+XqPKP8D1
 y7o1pz+7vDrXdM/O8T8cJdvKoChzBXqEC1xJCepADmSQxgXglifpUk53bHp081XhkPhZ
 ByuPl0M5XoyPgGDHdLyjoIO/AyCZZWBqRxQTkY9if1n713/kEZ9jtwpmKi31ndhuiL1E rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rw7kte0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 15:19:46 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 138J3bcB059647;
        Thu, 8 Apr 2021 15:19:46 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rw7ktdyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 15:19:45 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 138JHbCx011385;
        Thu, 8 Apr 2021 19:19:44 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 37rvu271jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 19:19:44 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 138JJiEc33030460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 19:19:44 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C2A1112066;
        Thu,  8 Apr 2021 19:19:44 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10EC5112065;
        Thu,  8 Apr 2021 19:19:44 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Apr 2021 19:19:43 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] certs: Trigger creation of RSA module signing key
 if it's not an RSA key
To:     Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        dhowells@redhat.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210408152403.1189121-1-stefanb@linux.ibm.com>
 <20210408152403.1189121-2-stefanb@linux.ibm.com>
 <a5f7f2b44e7d4de94b761324139024a31a1cf209.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <b04939a3-c9e5-faf2-ec7b-27127b2ab41d@linux.ibm.com>
Date:   Thu, 8 Apr 2021 15:19:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <a5f7f2b44e7d4de94b761324139024a31a1cf209.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FhHuUVT38rLiiW6pS4wK_P2erK-LMWuD
X-Proofpoint-ORIG-GUID: uhx-9dEtlZKVTTqnbhaqGdfFKOxYX0eF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_04:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080125
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/8/21 1:15 PM, Mimi Zohar wrote:
> On Thu, 2021-04-08 at 11:24 -0400, Stefan Berger wrote:
>> Address a kbuild issue where a developer created an ECDSA key for signing
>> kernel modules and then builds an older version of the kernel, when bi-
>> secting the kernel for example, that does not support ECDSA keys.
>>
>> Trigger the creation of an RSA module signing key if it is not an RSA key.
>>
>> Fixes: cfc411e7fff3 ("Move certificate handling to its own directory")
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Thanks, Stefan.
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>

Via which tree will this go upstream? keyrings?


    Stefan

