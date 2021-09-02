Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249E03FEC08
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Sep 2021 12:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242697AbhIBKUa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Sep 2021 06:20:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233716AbhIBKU2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Sep 2021 06:20:28 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 182AGMps189559;
        Thu, 2 Sep 2021 06:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=qJKX3OAaHlW+MwDMgKwO9dzOxTJmQcQS8OEW09vAzkM=;
 b=PzeYjjT5UE7SOybxQLPHr4kSgVYAZOax1uzgwtLaK5AqUbQkLG/fFmnAbfJjOXhf75N3
 ofFyy+Q7xqd4Rt+quJFO/xWpGREMieN9g486/kyN5bMmcZSAPf3qPpRVmb2WiRZRWLPB
 a5/AdTZhoWhzLHwhEkWqj4HW0nYZNtRcwGEOUuWhpis46/f93pahS2NDZri4wdYVYdTr
 vaaUCl//50ZYDE17nQEo6drbmof0H1mAif2VEl5Y/EIe2HngAF3P9HCejTA5nbmdBgQf
 BdD6Bqb9C5zYvllHR2r1a1aahjCJ5bfP7P87Ne/DTqCMAvlrgwnVIv9TcDoyiNVIejdN zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3atvqcg1h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 06:18:47 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 182AIksm008444;
        Thu, 2 Sep 2021 06:18:47 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3atvqcg1gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 06:18:46 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 182ABj4c007335;
        Thu, 2 Sep 2021 10:18:44 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3atdxsg8be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 10:18:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 182AIfOW38994286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 10:18:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D38EA405B;
        Thu,  2 Sep 2021 10:18:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B972A4054;
        Thu,  2 Sep 2021 10:18:35 +0000 (GMT)
Received: from sig-9-65-193-241.ibm.com (unknown [9.65.193.241])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 Sep 2021 10:18:35 +0000 (GMT)
Message-ID: <da852592bff4d162a6a1a77fc01df55727199885.camel@linux.ibm.com>
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Nayna <nayna@linux.vnet.ibm.com>
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
Date:   Thu, 02 Sep 2021 06:18:34 -0400
In-Reply-To: <D5553DD8-7CD4-4D78-A9D6-FC22BA16181B@oracle.com>
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
         <89a37802-1423-6b1c-c0ef-6f84e544ac33@linux.vnet.ibm.com>
         <D5553DD8-7CD4-4D78-A9D6-FC22BA16181B@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cQVsDurILdUYFQFQw8xB44aL22GCET1q
X-Proofpoint-ORIG-GUID: zJvOY9nZGAuZDU2Qq7Ca6IuyxegSX9Hs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_03:2021-09-01,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109020063
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-08-31 at 19:51 -0600, Eric Snowberg wrote:
> > On Aug 31, 2021, at 6:52 PM, Nayna <nayna@linux.vnet.ibm.com> wrote:
> > On 8/30/21 1:39 PM, Eric Snowberg wrote:
> >>> On Aug 27, 2021, at 2:44 PM, Nayna <nayna@linux.vnet.ibm.com> wrote:
> >>> On 8/25/21 6:27 PM, James Bottomley wrote:
> >>>> Remember, a CA cert is a self signed cert with the CA:TRUE basic
> >>>> constraint.  Pretty much no secure boot key satisfies this (secure boot
> >>>> chose deliberately NOT to use CA certificates, so they're all some type
> >>>> of intermediate or leaf), so the design seems to be only to pick out
> >>>> the CA certificates you put in the MOK keyring.  Adding the _ca suffix
> >>>> may deflect some of the "why aren't all my MOK certificates in the
> >>>> keyring" emails ...
> >>> 
> >>> My understanding is the .system_ca keyring should not be restricted only
> >>> to self-signed CAs (Root CA). Any cert that can qualify as Root or
> >>> Intermediate CA with Basic Constraints CA:TRUE should be allowed. In
> >>> fact, the intermediate CA certificates closest to the leaf nodes would be
> >>> best.
> >> With an intermediate containing CA:TRUE, the intermediate cert would not
> >> be self signed. Just for my clarification, does this mean I should remove
> >> the check that validates if it is self signed and instead somehow check if
> >> the CA flag is set?  Wouldn’t this potentially allow improperly signed certs
> >> into this new keyring?
> >> 
> > In this model, we are relying on the admin to ensure the authenticity of the certificate(s) being loaded onto the new keyring. It is similar to trusting the admin to enable the variable and add keys to MOK. Following are the checks that must pass before adding it to .system_ca keyring.
> > 
> > 1. Check against revocation_list.
> > 2. Check Basic Constraints: CA=TRUE.
> > 3. Check keyUsage = keyCertSign.
> 
> Originally I thought the request to only load CA certs into this new keyring 
> was so root of trust could be validated for the entire chain.  If a portion
> of the model now relies on the admin to ensure authenticity, and the complete
> chain is not needed, why not have the admin also check for #2 and #3? Meaning,
> when the Kconfig option is enabled and the new MokListTrustedRT UEFI is set, 
> whatever the admin has placed in the MOKList goes into this new keyring.

The root of trust for the new "machine" keyring, at least in the UEFI
use case, is registering keys in the MOK db, which requires physical
presence.  So we're trusting the MOK db, which means we're really
trusting both the admin and UEFI to do the right things.  There is no
harm in verifying the CA assumption when loading the certs onto the
"machine" keyring.

From an IMA perspective, all that is needed to sign an IMA custom
policy and local code is the ability to load a single self-signed CA
certificate.  So the self-signed CA restriction is fine.  Obviously
other use cases are being discussed here.  If the other use cases want
to relax the self-signed CA restriction to allow intermediary CA's, it
should be explicitly called out in a separate patch, with its own patch
description, providing the motivation.

thanks,

Mimi

