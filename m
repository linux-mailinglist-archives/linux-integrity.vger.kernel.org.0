Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCAD30AC61
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 17:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhBAQMt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 11:12:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230038AbhBAQMc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 11:12:32 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111G2NvR048444;
        Mon, 1 Feb 2021 11:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MEf2Ej0vaq4vyxMbn1+L/rY1MMhnIo8IZ8yGILDx19A=;
 b=gnhnl8jB+tbW+nxHbogHuCm4FdUdNUEUQea2d0qnYhZAND5Jnk5gL7qzAy1gZEoCpEnb
 PWcMSuDHoVUxR9vx1EfnJtVG/K3OwkazTOaC3mxNni9UaNrj/Yoi5cBm47DOumrK7WL+
 Me57jzmhLYHMoNl6tU5YGHQKx+R6Dn8szhdAe07c66WoLUxAVUp+RnWNwhK305cwYDAE
 hJywl55cnO8ps+nUXyR6ZCG1Jc4R41BFpPORpc751n7FHQdQif4Witv/WU2qXHlRPcH/
 wtAexfJm42l0QrN6CKPCzK00eVtWb3tWPZBAdwmnf6Mwat1Z42KVrIUx+v2+fX0j4sVc 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36emrggfs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 11:11:45 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 111G33kD053700;
        Mon, 1 Feb 2021 11:11:43 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36emrggfq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 11:11:43 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 111FXw6C002680;
        Mon, 1 Feb 2021 16:11:40 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 36cy3891qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 16:11:39 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 111GBT1C20840866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 16:11:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA3045204F;
        Mon,  1 Feb 2021 16:11:37 +0000 (GMT)
Received: from sig-9-65-218-191.ibm.com (unknown [9.65.218.191])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3F1BD5205A;
        Mon,  1 Feb 2021 16:11:35 +0000 (GMT)
Message-ID: <bd3246ebb4eae526c84efe2d27c6fadff662b0c8.camel@linux.ibm.com>
Subject: Re: Migration to trusted keys: sealing user-provided key?
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel@pengutronix.de
Date:   Mon, 01 Feb 2021 11:11:34 -0500
In-Reply-To: <64472434a367060ddce6e03425156b8312a5ad6c.camel@pengutronix.de>
References: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
         <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
         <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
         <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de>
         <d4eeefa0c13395e91850630e22d0d9e3690f43ac.camel@linux.ibm.com>
         <64472434a367060ddce6e03425156b8312a5ad6c.camel@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_06:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-02-01 at 16:31 +0100, Jan Lübbe wrote:
> On Sun, 2021-01-31 at 09:29 -0500, Mimi Zohar wrote:
> > On Sun, 2021-01-31 at 15:14 +0100, Jan Lübbe wrote:
> > > On Sun, 2021-01-31 at 07:09 -0500, Mimi Zohar wrote:
> > 
> > <snip>
> > 
> > > > 
> > > > [1] The ima-evm-utils README contains EVM examples of "trusted" and
> > > > "user" based "encrypted" keys.
> > > 
> > > I assume you refer to
> > > https://sourceforge.net/p/linux-ima/ima-evm-utils/ci/master/tree/README#l143
> > > "Generate EVM encrypted keys" and "Generate EVM trusted keys (TPM based)"?
> > > 
> > > In both cases, the key used by EVM is a *newly generated* random key. The only
> > > difference is whether it's encrypted to a user key or a (random) trusted key.
> > 
> > The "encrypted" asymmetric key data doesn't change, "update" just
> > changes the key under which it is encrypted/decrypted.
> > 
> > Usage::
> > 
> >     keyctl add encrypted name "new [format] key-type:master-key-name keylen"
> >         ring
> >     keyctl add encrypted name "load hex_blob" ring
> 
> 'load' (as I understand the code) only accepts an encrypted blob.
> 
> So the only way I see to have an encrypted key with a non-random key data would
> be:
> - create a random temporary master key and load a copy as a user key
> - encrypt the chosen key data with the temporary master key (using a new
> userspace reimplementation of the kernel encrypted key blob format)
> - use keyctl add encrypted dmcrypt "load <encrypted blob>" <keyring>
> - create new trusted master key (OP-TEE or CAAM in our case) as 
> - use keyctl update to switch to the new trusted master key
> - use keyctl pipe on the trusted and encrypted keys and store both for loading
> on later boots
> 
> If we'd support importing a pre-existing key into a trusted or encrypted key,
> we'd do instead:
> - use keyctl add trusted dmcrypt "import <unencrypted key data>"
> - use keyctl pipe on the trusted key and store it for loading on later boots
> 
> This way, users wouldn't need to care which backend is used by trusted keys
> (TPM/OP-TEE/CAAM/...). That would make use-cases where a random key is not
> suitable as straight-forward as the those where a random key is OK.

As I said above, the "encrypted" key update doesn't change the key data
used for encrypting/decrypting storage in the dm-crypt case, it just
updates the key under which it is encrypted/signed.

Yes, the reason for using an encrypted "trusted" key, as opposed to an
encrypted "user" key, is that the "trusted" key is encrypted/decrypted
by the TPM and never exposed to userspace in the clear.

It doesn't sound like you're wanting to update the storage key in the
field, just the key used to encrypt/decrypt that key.  So I'm still not
clear as to why you would want an initial non-random encrypted key. 
Providing that key on the command line certaining isn't a good idea.

Mimi

