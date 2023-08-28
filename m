Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0F978B9F2
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Aug 2023 23:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjH1VGE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Aug 2023 17:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjH1VF4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Aug 2023 17:05:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F007B131
        for <linux-integrity@vger.kernel.org>; Mon, 28 Aug 2023 14:05:53 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SKc5sY021171;
        Mon, 28 Aug 2023 21:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CREY5a2bK95xiPIbwHdDilhTRVvo43b8D4jT84KqfZ4=;
 b=UgOabpvEn14wnTL/9GbD+/kSV3ny1xqs0K938vmB0b7PuE871+B3nUe2QPerilmpuprb
 MOCAtuN0DWUmyjx7/cGA7YEqQGS+n65v1gjJVMwmKMtw9AiqSeFuHuwPcU9P0Ebf7Kwf
 IVQThHP4ugcnCgIp9+sL+w3Q2OLODovuE6i0O+yrGLkofK612Sd8dHXhR6IMybzYTWh9
 pLkFT2jmxmg9iNcudgrmVnu/aeWPyWF3j9lg+Vxx3HJoTxMqXEwQG/fqfvF6zK8oAyg7
 pjMNVNP7xX7tPrBmeyC4mL43DwKrdHaztRc8rR0yHy4fVyhosUIAQ8YSpNqZhirHhZyy xg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3srv4ykrug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 21:05:49 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37SJ2YeL014115;
        Mon, 28 Aug 2023 21:05:48 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqwxjnuvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 21:05:48 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37SL5lV034603320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 21:05:47 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ACCA58068;
        Mon, 28 Aug 2023 21:05:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BFB05805D;
        Mon, 28 Aug 2023 21:05:47 +0000 (GMT)
Received: from [9.67.181.110] (unknown [9.67.181.110])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 28 Aug 2023 21:05:47 +0000 (GMT)
Message-ID: <76227f6b-a0ac-d198-fc0b-2029899cfe15@linux.ibm.com>
Date:   Mon, 28 Aug 2023 17:05:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH -next] ima: Make tpm hash configurable
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "Guozihua (Scott)" <guozihua@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-integrity@vger.kernel.org
References: <20230817061334.1910-1-guozihua@huawei.com>
 <90b4b5573182ec68b2da2f9ef2bc6567d724f8f1.camel@linux.ibm.com>
 <e2c5711c-6549-e81f-42a7-eec176b39d63@huawei.com>
 <97198ee38422fbb1891981ac5c41263d5b03b321.camel@linux.ibm.com>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <97198ee38422fbb1891981ac5c41263d5b03b321.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ndxHjy-W_sbmJXM6ugBfRTtFC6uC1JMv
X-Proofpoint-GUID: ndxHjy-W_sbmJXM6ugBfRTtFC6uC1JMv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=685 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280181
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I'd like to present three possible cases, expanding on Mimi's
observation that the template hash is currently the hash of the
template data.

My vote is #2, but all have merits.

----------

1. Leave the SHA-1 template hash.

A. This does not break existing applications.

B. The template data is protected by the TPM quote, which does not
have to be SHA-1.

C. The SHA-1 digest provides some debug usefulness against a
non-malicious alteration of the template data. The application can
report which event record is incorrect.

----------

2. Include template hashes for all PCR banks.

A. This breaks existing applications on the attestor side, but could
be made backward compatible / deprecated at the verifier side.

B. The redundant data is an attack surface, in that the verifier must
remember to check the hashes against the quote AND against the
template data.

C. The digest provides debug usefulness against malicious attacks on
the template data.

D. This permits the use case where the template hash is NOT a hash of
the template data. In the UEFI event log (using IMA terms), the
template hash can be a digest of some other data and the template data
is a hint as to where and what that data is.

E.g., the UEFI event EV_CPU_MICROCODE template data field has a patch
descriptor, while the template hash is a digest of the patch itself.

----------

3. Include a template hash for the strongest hash algorithm.

A. It's not always clear what the strongest algorithm is.

Otherwise, this is the same as #2.

On 8/18/2023 7:17 PM, Mimi Zohar wrote:
> On Fri, 2023-08-18 at 09:25 +0800, Guozihua (Scott) wrote:
>> On 2023/8/17 22:19, Mimi Zohar wrote:
>>> On Thu, 2023-08-17 at 14:13 +0800, GUO Zihua wrote:
> 
> True SHA1 is being phased out due to hash collisions.  Verifying the
> template data hash against the template data isn't necessary for the
> attestation server to verify a TPM quote against any of the enabled TPM
> banks.  The attestation server walks the measurement list calculating
> the bank specific template data hash.  Breaking existing applications
> is unreasonable.


