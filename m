Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A3A38C5D
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2019 16:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfFGOOu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jun 2019 10:14:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727915AbfFGOOu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jun 2019 10:14:50 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x57ECMeS081309
        for <linux-integrity@vger.kernel.org>; Fri, 7 Jun 2019 10:14:48 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2syrg23f39-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 07 Jun 2019 10:14:48 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.ibm.com>;
        Fri, 7 Jun 2019 15:14:47 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Jun 2019 15:14:43 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x57EEgMd7405892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jun 2019 14:14:42 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2D067806D;
        Fri,  7 Jun 2019 14:14:41 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2753C78060;
        Fri,  7 Jun 2019 14:14:41 +0000 (GMT)
Received: from [9.2.202.76] (unknown [9.2.202.76])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jun 2019 14:14:40 +0000 (GMT)
Subject: Re: [PATCH 0/2] [IMA] Measure public keys of BuiltIn Trusted Keys
To:     Lakshmi <nramas@linux.microsoft.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     James Morris <jamorris@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Jordan Hand <jorhand@linux.microsoft.com>
References: <f9f2a5ab-a880-7131-d0ca-fb3b72571478@linux.microsoft.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Date:   Fri, 7 Jun 2019 10:14:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f9f2a5ab-a880-7131-d0ca-fb3b72571478@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19060714-8235-0000-0000-00000EA509B1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011228; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01214556; UDB=6.00638452; IPR=6.00995642;
 MB=3.00027220; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-07 14:14:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060714-8236-0000-0000-000045EA5FB0
Message-Id: <71cc3b9b-d045-8a69-5917-96b4c5654b16@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906070100
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/5/2019 8:16 PM, Lakshmi wrote:
> The motive behind this patch series is to measure the public key
> of keys in BuiltIn_Trusted_Keys keyring to IMA log.

I don't understand the motivation behind this proposal.  Below, you 
explain what you do.  Can you explain why?

I.e., I don't see a problem with the proposal, but what is the benefit?

> The kernel could be built with the config parameter
> CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY enabled.
> If this is done only those "IMA Signer Keys" that are signed by a key in
> the "BuiltIn Trusted Keys" or the "Secondary Trusted Keys" can be added
> to the "IMA Keyring".
> 
> In other words, "IMA Signer Keys" are attested by the "Trusted Keys"
> on the client machines if the above config parameter is enabled.
> 
> IMA will enumerate the keys in the Trusted Keys keyring, and measure
> them in the IMA log. On file read, IMA will validate the signature of
> the system files using "IMA Signer Key" present in "IMA Keyring".
> 
> An attestation service would receive the "Trusted Keys" from
> a trusted source (which is different from the client machines it is
> attesting). The service would compare the Trusted Keys reported by
> the client with the list of known Trusted Keys. A client would be
> marked trusted by the service if and only if the keys reported
> by the client are all trusted.

Why is this important?  What is gained by measuring the keys on the
built-in keyring?  The IMA log already measures [a pointer to] the
IMA keys used for signature verification.  Why does the service care 
what keys were used to install the IMA keys?

> Using the above approach the attestation service will be attesting
> the "IMA Signer" while the clients attest the IMA Signature of
> the system files. This enables the service to attest the client
> machines by maintaining only a list of "Trusted Keys". These keys
> change much less frequently than "IMA Signer Keys". It also frees
> the service from having to maintain the "Hash of System Files"
> which would change very frequently. This approach would significantly
> reduce the maintenance cost of the service with respect to the data used
> for attesting clients.

I don't understand this reasoning.

To me, there is a difference between signed files and trusted files. 
E.g., an old version may be signed, but it is no longer trusted.

In other words, the service wants to know all files that have run, not 
just whether they are signed.

Further, the service also wants to know files that were blocked from 
running, either because of no signature, a signature with an untrusted 
IMA key, or a bad signature.  I.e., the service needs the entire IMA 
log, not just the keys used to install the keys used to locally verify 
the signatures.

While the built-in keys may change less frequently that the IMA keys, 
both are likely to be stable.  I.e., is this proposal to provide an 
additional security benefit, or is it to improve performance?

