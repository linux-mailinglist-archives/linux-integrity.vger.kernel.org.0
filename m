Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD1A3FA0D9
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 22:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhH0UqV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 16:46:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231570AbhH0UqU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 16:46:20 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17RKcwUH175141;
        Fri, 27 Aug 2021 16:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=V4Bn5zvUHai0GK9if0diH+c0ro46+dVK+RJfgxCxnD0=;
 b=AT0KbGubyPbSknLxtnmiJHDDCRStB0x2euyH7EuqjQW9DcITZSX9RAp9Q2CA1foGcpWf
 AE4Ar3pHD/i46SeWI4eNCCf8DGB00Sffj0y3usaqjOqQ1nzEhAMApue2rFeuYY54aiLI
 LkV2hZccwthNMJrasQtwRwvcqSjo12Ak9e70/XYgq4MohAWMNlwpehaSQNadFBrHKe6K
 lamm+h6XgzpsVHNgVAZH4H9xvub8aobDdr5ZsJxAUzz11hDqQRkBWu87WBMt59mNI/cC
 Io881OjXqb45MSvsD1f+RbPNwAfb/VjPbuMJIMa+gDbWfoDZr+G/atpLk5dCkoAjELpm qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3aq68k1pcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 16:45:00 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17RKfEhP180599;
        Fri, 27 Aug 2021 16:44:59 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3aq68k1pc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 16:44:59 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17RKgLf6003118;
        Fri, 27 Aug 2021 20:44:58 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03wdc.us.ibm.com with ESMTP id 3ajs4ftd3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 20:44:58 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17RKivb618219340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 20:44:57 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEAFC28059;
        Fri, 27 Aug 2021 20:44:57 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A866C28058;
        Fri, 27 Aug 2021 20:44:54 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.211.72.200])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 Aug 2021 20:44:54 +0000 (GMT)
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org,
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
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <10bc1017-2b45-43f3-ad91-d09310b24c2c@linux.vnet.ibm.com>
Date:   Fri, 27 Aug 2021 16:44:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <bc37d1da3ef5aae16e69eeda25d6ce6fe6a51a77.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P8y2vFgMMz6mtKu6ZTA1-OA2iJE_cBk2
X-Proofpoint-GUID: jmXS99QL71NUcQhSu-DO56SNSiN-arUK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-27_06:2021-08-27,2021-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 spamscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108270120
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 8/25/21 6:27 PM, James Bottomley wrote:
> On Thu, 2021-08-26 at 01:21 +0300, Jarkko Sakkinen wrote:
>> On Tue, 2021-08-24 at 10:34 -0400, Mimi Zohar wrote:
>>>>>> Jarkko, I think the emphasis should not be on "machine" from
>>>>>> Machine Owner Key (MOK), but on "owner".  Whereas Nayna is
>>>>>> focusing more on the "_ca" aspect of the name.   Perhaps
>>>>>> consider naming it "system_owner_ca" or something along those
>>>>>> lines.
>>>>> What do you gain such overly long identifier? Makes no sense.
>>>>> What is "ca aspect of the name" anyway?
>>>> As I mentioned previously, the main usage of this new keyring is
>>>> that it should contain only CA keys which can be later used to
>>>> vouch for user keys loaded onto secondary or IMA keyring at
>>>> runtime. Having ca in the  name like .xxxx_ca, would make the
>>>> keyring name self-describing. Since you preferred .system, we can
>>>> call it .system_ca.
>>> Sounds good to me.  Jarkko?
>>>
>>> thanks,
>>>
>>> Mimi
>> I just wonder what you exactly gain with "_ca"?
> Remember, a CA cert is a self signed cert with the CA:TRUE basic
> constraint.  Pretty much no secure boot key satisfies this (secure boot
> chose deliberately NOT to use CA certificates, so they're all some type
> of intermediate or leaf), so the design seems to be only to pick out
> the CA certificates you put in the MOK keyring.  Adding the _ca suffix
> may deflect some of the "why aren't all my MOK certificates in the
> keyring" emails ...


My understanding is the .system_ca keyring should not be restricted only 
to self-signed CAs (Root CA). Any cert that can qualify as Root or 
Intermediate CA with Basic Constraints CA:TRUE should be allowed. In 
fact, the intermediate CA certificates closest to the leaf nodes would 
be best.

Thanks for bringing up that adding the _ca suffix may deflect some of 
the "why aren't all my MOK certificates in the keyring" emails.

Thanks & Regards,

     - Nayna

