Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4D37477
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jun 2019 14:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfFFMpX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jun 2019 08:45:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725267AbfFFMpX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jun 2019 08:45:23 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56CgiFa026680
        for <linux-integrity@vger.kernel.org>; Thu, 6 Jun 2019 08:45:21 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sy13nefft-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 06 Jun 2019 08:44:57 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 6 Jun 2019 13:44:41 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Jun 2019 13:44:38 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x56Cibes52756720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jun 2019 12:44:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1D0D4C044;
        Thu,  6 Jun 2019 12:44:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B59CC4C040;
        Thu,  6 Jun 2019 12:44:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.80.30])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jun 2019 12:44:36 +0000 (GMT)
Subject: Re: [PATCH 0/2] [IMA] Measure public keys of BuiltIn Trusted Keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi <nramas@linux.microsoft.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgold@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     James Morris <jamorris@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Jordan Hand <jorhand@linux.microsoft.com>
Date:   Thu, 06 Jun 2019 08:44:25 -0400
In-Reply-To: <f9f2a5ab-a880-7131-d0ca-fb3b72571478@linux.microsoft.com>
References: <f9f2a5ab-a880-7131-d0ca-fb3b72571478@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19060612-0028-0000-0000-000003778CFB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060612-0029-0000-0000-000024376CDB
Message-Id: <1559825065.4278.94.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060091
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-06-05 at 17:16 -0700, Lakshmi wrote:
> The motive behind this patch series is to measure the public key
> of keys in BuiltIn_Trusted_Keys keyring to IMA log.
> 
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
> 
> Using the above approach the attestation service will be attesting
> the "IMA Signer" while the clients attest the IMA Signature of
> the system files. This enables the service to attest the client
> machines by maintaining only a list of "Trusted Keys". These keys
> change much less frequently than "IMA Signer Keys". It also frees
> the service from having to maintain the "Hash of System Files"
> which would change very frequently. This approach would significantly
> reduce the maintenance cost of the service with respect to the data used
> for attesting clients.

Instead of measuring all the files in policy, Roberto's "digest lists"
proposed patch set measures only "unknown" files.  Why bother with all
those messy measurements?!

In your use case scenario, will the measurement list only contain the builtin and secondary keys?

Mimi

> 
> To achieve the above the patch series does the following:
>    - Adds a new method in asymmetric_key_subtype to query
>      the public key of the given key
>    - Enumerate the keys in "BuiltIn Trusted Keys" and measure
>      them to IMA log.
> 
> Lakshmi (2):
>    Added a new interface method namely query_public_key to
>      asymmetric_key_subtype interface
>    Measure keys in BuiltIn Trusted Keys keyring
> 
>   Documentation/crypto/asymmetric-keys.txt |  1 +
>   certs/system_keyring.c                   |  7 ++
>   crypto/asymmetric_keys/public_key.c      |  7 ++
>   crypto/asymmetric_keys/signature.c       | 24 +++++++
>   include/crypto/public_key.h              |  1 +
>   include/keys/asymmetric-subtype.h        |  3 +
>   include/keys/system_keyring.h            |  9 +++
>   include/linux/key.h                      | 32 +++++++++
>   security/integrity/digsig.c              | 58 +++++++++++++++++
>   security/integrity/ima/Kconfig           |  9 +++
>   security/integrity/ima/ima_init.c        | 62 ++++++++++++++++++
>   security/integrity/integrity.h           | 25 ++++++++
>   security/keys/keyring.c                  | 82 ++++++++++++++++++++++++
>   13 files changed, 320 insertions(+)
> 

