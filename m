Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CBB3708B2
	for <lists+linux-integrity@lfdr.de>; Sat,  1 May 2021 21:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhEATKp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 1 May 2021 15:10:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231556AbhEATKo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 May 2021 15:10:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 141J4FhR072785;
        Sat, 1 May 2021 15:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sc5qIlwkcqfH6ez90GqgSYPiB6utd1gUTTkOArlqVpA=;
 b=PqhjPUKp3Aq+fx6yThsGNBTFiaKeYnce67Wuv8Cbwb8qFhNvp3Ti9fczYNVd6HdmKxh9
 4LDBrI5vEuIHzTGLngHpvp7TYuQroJ7ZGD/6f+IhWIrjRPDfwTwUomdFsrQMglKTW3ID
 Z11jWHx/wNX/LyqXaDbK/9AdS4cSBTgVO6b/vtRGU1nTQN6UJHFWpZeJhRScA8q7ffrV
 v+V8Hcx5ln27TUyknTcg4CUlrDn1mI1cV2lPVSRIbbtOzN4YvQfRWZLXMP6kaVF4oSSW
 vONDdmb3w7akvHs5/IyCIxZyjsKaR8VjNEiXWj9MI2VGRdl1hKIYT02zNsS7bEHUzKW4 Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 389ck4g9ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 May 2021 15:09:48 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 141J9mfs086205;
        Sat, 1 May 2021 15:09:48 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 389ck4g9ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 May 2021 15:09:48 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 141J8HaQ011533;
        Sat, 1 May 2021 19:09:47 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 388xm8muwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 May 2021 19:09:47 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 141J9kNQ36962654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 1 May 2021 19:09:46 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B49A7805F;
        Sat,  1 May 2021 19:09:46 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3F127805E;
        Sat,  1 May 2021 19:09:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat,  1 May 2021 19:09:45 +0000 (GMT)
Subject: Re: [PATCH v3 4/4] tpm: Only enable supported irqs
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
 <20210501135727.17747-5-LinoSanfilippo@gmx.de>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <d9da4946-c380-d56d-6d42-1ec6f9bd3d8b@linux.ibm.com>
Date:   Sat, 1 May 2021 15:09:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210501135727.17747-5-LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m4gJmjFLRuQWsCoaULyc4ZwPf8_TfSr4
X-Proofpoint-GUID: XguFMLCRjMKrT5Cga_O5fCpgVYmeyy6B
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-01_14:2021-04-30,2021-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0 impostorscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105010134
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 5/1/21 9:57 AM, Lino Sanfilippo wrote:
> Do not set interrupts which are not supported by the hardware. Instead use
> the information from the capability query and activate only the reported
> interrupts.
>
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


