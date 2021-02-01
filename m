Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CFA30B0C3
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 20:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhBATtl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 14:49:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31684 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232556AbhBATrk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 14:47:40 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111JZIjB058875;
        Mon, 1 Feb 2021 14:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=sKJjfjUqLOlqXtjaN1d9Tjfi7+1WFA92zYmJdaUoOpU=;
 b=IubyAw4X+wxXGlqQI+Bq/cuJHB0zSvWqeiODDOcujpXguo7Zw61CMFG843pdr7ed95TG
 9DZnkUhtyB/RttjgDc2HiEIH8hZ6glAPgKr+alfveuNcFB+SiezqHAlduoJInberf7hw
 nYjky9Wh21iEKrN2CcaoFsGQlUu4fPjV4lOucBMde0Y+CY2l6m1LT/kHCRTWCGtmTsmG
 6z7dZfelKbio4D4wGdydV2fcIeF+eJF7nSijQmA4HfEszyis5YAO9NDNGDouzx0ayAAu
 62/GCBH3afDGwSBLpbGpYStXxDmCiH4EjqAb+Mkzm57l8HOVM+iUrgz6qCteuvt8EJ+4 Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36eqnurk28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 14:46:53 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 111JdSKD072829;
        Mon, 1 Feb 2021 14:46:52 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36eqnurk1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 14:46:52 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 111JhJqF010291;
        Mon, 1 Feb 2021 19:46:50 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 36cy3894cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 19:46:50 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 111JkmoV42992000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 19:46:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 548F942047;
        Mon,  1 Feb 2021 19:46:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C2BB4203F;
        Mon,  1 Feb 2021 19:46:46 +0000 (GMT)
Received: from sig-9-65-218-191.ibm.com (unknown [9.65.218.191])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Feb 2021 19:46:46 +0000 (GMT)
Message-ID: <e9e7814c35d9ce5a6351a960081bf3c6b90bdca7.camel@linux.ibm.com>
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
Date:   Mon, 01 Feb 2021 14:46:45 -0500
In-Reply-To: <0be34899c9686b95cd22aa016f466523579cbeed.camel@pengutronix.de>
References: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
         <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
         <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
         <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de>
         <d4eeefa0c13395e91850630e22d0d9e3690f43ac.camel@linux.ibm.com>
         <64472434a367060ddce6e03425156b8312a5ad6c.camel@pengutronix.de>
         <bd3246ebb4eae526c84efe2d27c6fadff662b0c8.camel@linux.ibm.com>
         <0be34899c9686b95cd22aa016f466523579cbeed.camel@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_06:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010098
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-02-01 at 17:38 +0100, Jan Lübbe wrote:
> On Mon, 2021-02-01 at 11:11 -0500, Mimi Zohar wrote:
> > On Mon, 2021-02-01 at 16:31 +0100, Jan Lübbe wrote:
> > > On Sun, 2021-01-31 at 09:29 -0500, Mimi Zohar wrote:
> <snip>
> > > > Usage::
> > > > 
> > > >     keyctl add encrypted name "new [format] key-type:master-key-name keylen"
> > > >         ring
> > > >     keyctl add encrypted name "load hex_blob" ring
> > > 
> > > 'load' (as I understand the code) only accepts an encrypted blob.
> > > 
> > > So the only way I see to have an encrypted key with a non-random key data would
> > > be:
> > > - create a random temporary master key and load a copy as a user key
> > > - encrypt the chosen key data with the temporary master key (using a new
> > > userspace reimplementation of the kernel encrypted key blob format)
> > > - use keyctl add encrypted dmcrypt "load <encrypted blob>" <keyring>
> > > - create new trusted master key (OP-TEE or CAAM in our case) as 
> > > - use keyctl update to switch to the new trusted master key
> > > - use keyctl pipe on the trusted and encrypted keys and store both for loading
> > > on later boots
> > > 
> > > If we'd support importing a pre-existing key into a trusted or encrypted key,
> > > we'd do instead:
> > > - use keyctl add trusted dmcrypt "import <unencrypted key data>"
> > > - use keyctl pipe on the trusted key and store it for loading on later boots
> > > 
> > > This way, users wouldn't need to care which backend is used by trusted keys
> > > (TPM/OP-TEE/CAAM/...). That would make use-cases where a random key is not
> > > suitable as straight-forward as the those where a random key is OK.
> > 
> > As I said above, the "encrypted" key update doesn't change the key data
> > used for encrypting/decrypting storage in the dm-crypt case, it just
> > updates the key under which it is encrypted/signed.
> 
> Yes, that's clear. I only used it to demonstrate how a workaround for importing
> key material into an encrypted key could look like.
> 
> > Yes, the reason for using an encrypted "trusted" key, as opposed to an
> > encrypted "user" key, is that the "trusted" key is encrypted/decrypted
> > by the TPM and never exposed to userspace in the clear.
> 
> Yes, and that's the main reason I'd like to use trusted keys with dm-crypt: a
> much lower chance of exposing this key somewhere it could be extracted.
> 
> > It doesn't sound like you're wanting to update the storage key in the
> > field, just the key used to encrypt/decrypt that key.  So I'm still not
> > clear as to why you would want an initial non-random encrypted key. 
> > Providing that key on the command line certaining isn't a good idea.
> 
> Some of our customers have systems in the field which use non-mainline patches
> for access to the CAAM [1], which also have the downside of exposing the
> decrypted key material directly to userspace. In that thread you suggested to
> use trusted keys instead. With Sumit's work that rework is finally within reach.
> :)
> 
> 
> In those systems, we have data that's encrypted with a pre-existing dm-crypt or
> ecryptfs key. As we update those systems in the field to newer kernels, we want
> to get rid of those custom patches, but can't reencrypt everything.
> 
> So the approach would be to perform a one-time migration when updating a device:
> - use our old interface to decrypt the key and 'import' it into a trusted key
> - use keyctl pipe and save the re-encrypted key to disk
> - destroy the old encrypted key
> After this migration, the key material is no longer available to userspace (only
> to dm-crypt).
> 
> 
> Another use-case for supporting key import that we want to support is  analysis
> of broken devices returned from the field:
> - generate an encryption key per device in the factory
> - encrypt it to a private key in escrow and archive it for later use
> - import it into a trusted key on the device
> - keyctl pipe it to a file on the device for use on boot
> 
> Later, when you need to do an analysis, you can get the key from escrow even if
> the device cannot boot any longer.

The first use case doesn't sound like a valid reason for upstreaming
such support.  It's a one time update to migrate everyone to a newer
kernel.  That you can carry independently of upstream.  In terms of the
second use case, do you really want the ability and the resulting
responsibility of being able to decrypt user's data?   Please think
this through carefully, before you decide you really want/need this
feature.

thanks,

Mimi

