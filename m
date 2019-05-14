Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC0851CDFB
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2019 19:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfENRaB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 May 2019 13:30:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726272AbfENRaA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 May 2019 13:30:00 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EHMVBK038904
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2019 13:29:59 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sfyg5yqfn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 14 May 2019 13:29:59 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 14 May 2019 18:29:57 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 May 2019 18:29:55 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4EHTsUG55705608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 17:29:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2317CA405F;
        Tue, 14 May 2019 17:29:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47FC2A4054;
        Tue, 14 May 2019 17:29:53 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 May 2019 17:29:53 +0000 (GMT)
Subject: Re: [PATCH 0/2] public key: IMA signer logging: Log public key of
 IMA Signature signer in IMA log
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi <nramas@linux.microsoft.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>
Date:   Tue, 14 May 2019 13:29:52 -0400
In-Reply-To: <6b69f115-96cf-890a-c92b-0b2b05798357@linux.microsoft.com>
References: <6b69f115-96cf-890a-c92b-0b2b05798357@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051417-0028-0000-0000-0000036DA362
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051417-0029-0000-0000-0000242D3648
Message-Id: <1557854992.4139.69.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905140120
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-05-14 at 10:14 -0700, Lakshmi wrote:
> The motive behind this patch series is to measure the public key
> of the IMA signature signer in the IMA log.
> 
> The IMA signature of the file, logged using ima-sig template, contains
> the key identifier of the key that was used to generate the signature.
> But outside the client machine this key id is not sufficient to
> uniquely determine which key the signature corresponds to.
> Providing the public key of the signer in the IMA log would
> allow, for example, an attestation service to securely verify
> if the key used to generate the IMA signature is a valid and
> trusted one, and that the key has not been revoked or expired.
> 
> An attestation service would just need to maintain a list of
> valid public keys and using the data from the IMA log can attest
> the system files loaded on the client machine.
> 
> To achieve the above the patch series does the following:
>    - Adds a new method in asymmetric_key_subtype to query
>      the public key of the given key
>    - Adds a new IMA template namely "ima-sigkey" to store\read
>      the public key of the IMA signature signer. This template
>      extends the existing template "ima-sig"

Why duplicate the certificate info on each record in the measurement
list?  Why not add the certificate info once, as the key is loaded
onto the .ima and .platform keyrings?

Mimi


> 
> Lakshmi (2):
>    add support for querying public key from a given key
>    add a new template ima-sigkey to store/read the public, key of ima
>      signature signer
> 
>   .../admin-guide/kernel-parameters.txt         |  2 +-
>   Documentation/crypto/asymmetric-keys.txt      |  1 +
>   Documentation/security/IMA-templates.rst      |  5 +-
>   crypto/asymmetric_keys/public_key.c           |  7 +++
>   crypto/asymmetric_keys/signature.c            | 24 +++++++++
>   include/crypto/public_key.h                   |  1 +
>   include/keys/asymmetric-subtype.h             |  3 ++
>   security/integrity/digsig.c                   | 54 +++++++++++++++++--
>   security/integrity/digsig_asymmetric.c        | 44 +++++++++++++++
>   security/integrity/ima/Kconfig                |  3 ++
>   security/integrity/ima/ima_template.c         |  3 ++
>   security/integrity/ima/ima_template_lib.c     | 43 +++++++++++++++
>   security/integrity/ima/ima_template_lib.h     |  4 ++
>   security/integrity/integrity.h                | 29 +++++++++-
>   14 files changed, 216 insertions(+), 7 deletions(-)
> 

