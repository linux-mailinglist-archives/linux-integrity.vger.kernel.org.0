Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B1B3573A1
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 19:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244312AbhDGRxi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Apr 2021 13:53:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229917AbhDGRxh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Apr 2021 13:53:37 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137HWdDj061896;
        Wed, 7 Apr 2021 13:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/pzpTFWjcg8XerqK9b4p2kQrT39jf3KYt4MGERPE7rs=;
 b=mnTXAti4cQTdHWtjSARDkVrUAfrQJM9JbhvABrl82Lv0nLNNWQMi00WP2jbXljNjxaOI
 RY3YQTyEZvr6v/kvTBk5R1rTpPottG3jDJsIHtHfkLrPDtpaYW3wmvdbPfiIlmO6wMfz
 YexK82FiPXwuTKoAgCk+18OmhSgoXwi/37TkcqrWSQ4GRy2aXQbdQVM02vMPUoe+x8oJ
 kioA64XMrz6bjjubLtiAmpBOb9xbgpvpVd4irC/VzhOsHZbBt5Ulk43diZiAa/TCefjX
 6/qR1XaVGUg+pK8p2TuxBXJkcON9+6oKs/BHZ9Vx4VJGk+IohepPOWcZIvjAarJf858d uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37sd1a9bqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 13:53:27 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 137HXRb9067638;
        Wed, 7 Apr 2021 13:53:26 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37sd1a9bpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 13:53:26 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 137Hpnc7003975;
        Wed, 7 Apr 2021 17:53:25 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 37rvyvf2e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 17:53:25 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 137HrOJ838470066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Apr 2021 17:53:24 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4DA6124053;
        Wed,  7 Apr 2021 17:53:24 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5200124052;
        Wed,  7 Apr 2021 17:53:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  7 Apr 2021 17:53:24 +0000 (GMT)
Subject: Re: [PATCH 0/2] Add support for ECDSA-signed kernel modules
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     keyrings@vger.kernel.org, dhowells@redhat.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210406185340.1079403-1-stefanb@linux.ibm.com>
 <YG3Ve9CR0zZE+tUu@kernel.org>
 <5a217256a53f9c33aba4528ab0393b84c42b1813.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <70f7b2a4-ec3c-3da0-bcb6-7c96f391c1c1@linux.ibm.com>
Date:   Wed, 7 Apr 2021 13:53:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <5a217256a53f9c33aba4528ab0393b84c42b1813.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Oyv7zYRV4oySxgSxDKyffIZsH0Z8Wkco
X-Proofpoint-ORIG-GUID: nCW2PQEPC_GyhQ5erTTJur-PkxJeh1vR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_09:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070120
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/7/21 12:10 PM, Mimi Zohar wrote:
> On Wed, 2021-04-07 at 18:53 +0300, Jarkko Sakkinen wrote:
>> On Tue, Apr 06, 2021 at 02:53:38PM -0400, Stefan Berger wrote:
>>> This series adds support for ECDSA-signed kernel modules.
>>>
>>> The first patch in this series attempts to address the issue where a
>>> developer created an ECDSA key for signing modules and then falls back
>>> to compiling an older version of the kernel that does not support
>>> ECDSA keys. In this case this patch would delete that ECDSA key if it is
>>> in certs/signing_key.pem and trigger the creation of an RSA key. However,
>>> for this to work this patch would have to be applied to previous versions
>>> of the kernel but would also only work for the developer if he/she used a
>>> stable version of the kernel to which this patch was applied. So whether
>>> this patch actually achieves the wanted effect is not always guaranteed.
>> Just wondering why the key needs to be removed in the fallback.
Because if you signed an older kernel's modules with the ECDSA key it 
won't be able to load the modules...
> The main concern is with bisecting the kernel.  Either elliptic curve
> support or the first patch needs to be backported.  This patch will
> cause the kernel module signing key to be regenerated.


This assumes of course that one will bisect via the stable kernels where 
this 1st patch has been applied. Not sure whether that's what people 
will do.

    Stefan


>
> Mimi
>
