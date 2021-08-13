Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A890E3EBC0D
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 20:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhHMS1x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Aug 2021 14:27:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232611AbhHMS1w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Aug 2021 14:27:52 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17DI3jOQ042063;
        Fri, 13 Aug 2021 14:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=j1lczph9q4hxdvWvkJjwrPNCN+2CWHiDAOVh9v5sYiU=;
 b=F1+hlBD2gBPPNoUXcTiipWWtJWpJU6FA9KmkHDnQOfBVoCgwR2Gvxv0+7AkkSRL9NLFb
 IuJ4dAHIwl9hU6p2JZ9DKch49Qulh294Gwyy7a7ilsJyADL90YH1lcmLlXD/4gvvNNwR
 RXvrl+7pTe27FIpzGMwC1DqD22gyKtJU/wF5/gTs6ux1Pxjfe7IVF6mLjqA6Iu53yZ7q
 5mfElFskMjqkkkLE/zBIazGY6BhvHp6ivganzgDRCP1gPbuBMmL6UOMLP9po7E1W9/lE
 Q+s9FxubEmUypH5IIDwBtCWissidvLRObSxaa7VoV8Ap1VEMey3qVFtynTWRNk6ySgVt CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3adsf3yww9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 14:26:26 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17DI3lvf042231;
        Fri, 13 Aug 2021 14:26:26 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3adsf3ywvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 14:26:26 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17DIJkBu001449;
        Fri, 13 Aug 2021 18:26:24 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 3ackhs8q50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 18:26:24 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17DIQM5i30343530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 18:26:22 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38BE8112061;
        Fri, 13 Aug 2021 18:26:22 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 745E3112062;
        Fri, 13 Aug 2021 18:26:19 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.211.76.133])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 13 Aug 2021 18:26:19 +0000 (GMT)
Subject: Re: [PATCH v3 01/14] integrity: Introduce a Linux keyring for the
 Machine Owner Key (MOK)
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        glin@suse.com, konrad.wilk@oracle.com
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
 <20210812021855.3083178-2-eric.snowberg@oracle.com>
 <20210812185853.p5mgsgrftgwvt5fx@kernel.org>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <a3d7ce08-47e8-7287-772d-f7e789c47449@linux.vnet.ibm.com>
Date:   Fri, 13 Aug 2021 14:26:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210812185853.p5mgsgrftgwvt5fx@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NtaYsAueNdNnB6kwL7VEQdE3reAq6bwi
X-Proofpoint-GUID: 33tuCCwIGg_cW1kX4YoburxLjhDz1bfR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-13_06:2021-08-13,2021-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108130107
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 8/12/21 2:58 PM, Jarkko Sakkinen wrote:
> On Wed, Aug 11, 2021 at 10:18:42PM -0400, Eric Snowberg wrote:
>> Many UEFI Linux distributions boot using shim.  The UEFI shim provides
>> what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
>> Boot DB and MOK keys to validate the next step in the boot chain.  The
>> MOK facility can be used to import user generated keys.  These keys can
>> be used to sign an end-users development kernel build.  When Linux
>> boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
>> .platform keyring.
>>
>> Add a new Linux keyring called .mok.  This keyring shall contain just
> I would consider ".machine" instead. It holds MOK keys but is not a
> MOK key.

I agree with changing the name.

I believe the underlying source from where CA keys are loaded might vary 
based on the architecture (".mok" is UEFI specific.). The key part is 
that this new keyring should contain only CA keys which can be later 
used to vouch for user keys loaded onto IMA or secondary keyring at 
runtime. It would be good to have a "ca" in the name, like .xxxx-ca, 
where xxxx can be machine, owner, or system. I prefer .system-ca.

Thanks & Regards,

      - Nayna

