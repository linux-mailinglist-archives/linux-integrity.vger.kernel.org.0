Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D023FD07A
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Sep 2021 02:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241406AbhIAAyA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Aug 2021 20:54:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231509AbhIAAx7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Aug 2021 20:53:59 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1810Y9nI045052;
        Tue, 31 Aug 2021 20:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=S+vwLi+45krq88Ka4EYXVLoMuSWJAYuOgMxx8mDnubQ=;
 b=deAYEqqU5aMCIswtLnTyk20aVNmtPFebxB6Tb3W2Q+RlZ1JZpkUg+bi3bh076TlO3Zqr
 P95ZJCOPOYnHl6CZipEbclRZ0m4uKYbZN0c3X0DxnP/IFQsJ+0ArbYDxFfE0mc43xG+r
 WENoBR7WakeYsK0HHbszjwW5d+TyCcbDprhvZ03BFiIM2N/U5AFozB6MT1+zeB3RoXbL
 CXJ/wSxXNVG/DFGcDRe4THE92ijXKbp0H+vCb3QNjADQXQE/nBTn0liWMcgVvl7tHfFx
 U73FzRipvJWl2mqhr5O4pEIQDkhgxyPSvjaB1u4kbzRPeA2tlf0Ni/I8TFKf9mi9/E6Q sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3asxn70vg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 20:52:25 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1810kmff086585;
        Tue, 31 Aug 2021 20:52:24 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3asxn70vfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 20:52:24 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1810miJh026273;
        Wed, 1 Sep 2021 00:52:23 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 3aqcsc2suu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 00:52:23 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1810qLa738142332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Sep 2021 00:52:21 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DD6228066;
        Wed,  1 Sep 2021 00:52:21 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65BA028058;
        Wed,  1 Sep 2021 00:52:17 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.211.95.128])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  1 Sep 2021 00:52:17 +0000 (GMT)
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        lszubowi@redhat.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Patrick Uiterwijk <patrick@puiterwijk.org>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
 <fcb30226f378ef12cd8bd15938f0af0e1a3977a2.camel@kernel.org>
 <f76fcf41728fbdd65f2b3464df0821f248b2cba0.camel@linux.ibm.com>
 <91B1FE51-C6FC-4ADF-B05A-B1E59E20132E@oracle.com>
 <e7e251000432cf7c475e19c56b0f438b92fec16e.camel@linux.ibm.com>
 <cedc77fefdf22b2cec086f3e0dd9cc698db9bca2.camel@kernel.org>
 <bffb33a3-d5b5-f376-9d7d-706d38357d1a@linux.vnet.ibm.com>
 <9526a4e0be9579a9e52064dd590a78c6496ee025.camel@linux.ibm.com>
 <9067ff7142d097698b827f3c1630a751898a76bf.camel@kernel.org>
 <bc37d1da3ef5aae16e69eeda25d6ce6fe6a51a77.camel@HansenPartnership.com>
 <10bc1017-2b45-43f3-ad91-d09310b24c2c@linux.vnet.ibm.com>
 <D07DE64F-FE8B-4020-8EC2-94C3C0F9920A@oracle.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <89a37802-1423-6b1c-c0ef-6f84e544ac33@linux.vnet.ibm.com>
Date:   Tue, 31 Aug 2021 20:52:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <D07DE64F-FE8B-4020-8EC2-94C3C0F9920A@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WV_ZVu190WkpdPe5PqSJVTYkBc2NlkNX
X-Proofpoint-ORIG-GUID: fXWlbOls-kFkB-Cmew8atS2JC6VEAo20
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_10:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010001
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 8/30/21 1:39 PM, Eric Snowberg wrote:
>> On Aug 27, 2021, at 2:44 PM, Nayna <nayna@linux.vnet.ibm.com> wrote:
>> On 8/25/21 6:27 PM, James Bottomley wrote:
>>> Remember, a CA cert is a self signed cert with the CA:TRUE basic
>>> constraint.  Pretty much no secure boot key satisfies this (secure boot
>>> chose deliberately NOT to use CA certificates, so they're all some type
>>> of intermediate or leaf), so the design seems to be only to pick out
>>> the CA certificates you put in the MOK keyring.  Adding the _ca suffix
>>> may deflect some of the "why aren't all my MOK certificates in the
>>> keyring" emails ...
>>
>> My understanding is the .system_ca keyring should not be restricted only
>> to self-signed CAs (Root CA). Any cert that can qualify as Root or
>> Intermediate CA with Basic Constraints CA:TRUE should be allowed. In
>> fact, the intermediate CA certificates closest to the leaf nodes would be
>> best.
> With an intermediate containing CA:TRUE, the intermediate cert would not
> be self signed. Just for my clarification, does this mean I should remove
> the check that validates if it is self signed and instead somehow check if
> the CA flag is set?  Wouldn’t this potentially allow improperly signed certs
> into this new keyring?
>
In this model, we are relying on the admin to ensure the authenticity of 
the certificate(s) being loaded onto the new keyring. It is similar to 
trusting the admin to enable the variable and add keys to MOK. Following 
are the checks that must pass before adding it to .system_ca keyring.

1. Check against revocation_list.
2. Check Basic Constraints: CA=TRUE.
3. Check keyUsage = keyCertSign.

Thanks & Regards,

        - Nayna

