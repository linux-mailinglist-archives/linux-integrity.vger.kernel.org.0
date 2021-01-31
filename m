Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF2A309EBC
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Jan 2021 21:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhAaUM2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 31 Jan 2021 15:12:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231329AbhAaTpX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 31 Jan 2021 14:45:23 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10VI1HwP062940;
        Sun, 31 Jan 2021 13:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=NYwwPXnKTvtbxcHJO8ZCSxE1/bI2BZQ+pSd+KZpx11k=;
 b=c+WnTmaCFyijzidSpXm34w3P25aRIQ/Y+w5VgJY9NXXuh5/NsWwbp+RPNWk07yv45pj6
 w8YmqES50lgVaTMe/D4W6VmwTodcdldGMwykKYGrJ2coeRTP3enA4uSIkLNCABlkSoVs
 B8/0uCaV+zGKdBDTHoCPjulHm8zvNZf4xUsI4rGALuYLJSLCtx5TeNxMUtnUEVYp+lNf
 od+DumpDrkH61M3EJm3OQR5CgXV1+2TfLGKuzxl8Ld/wNeLi1LG1eBv7zHQFbzY/LhpC
 cq0jTWZzLneVH21w4kunmCjT7bQeMHuQUj5iwTlKBAfer3C1jzbfwaGnw+Awo5c5vs0b uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36dwsubb6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 13:10:01 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10VIA0SM087751;
        Sun, 31 Jan 2021 13:10:00 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36dwsubb64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 13:10:00 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10VI6poI025079;
        Sun, 31 Jan 2021 18:09:59 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 36cy38kqab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 18:09:59 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10VI9ws527525628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 18:09:58 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48F9F78060;
        Sun, 31 Jan 2021 18:09:58 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94DF97805F;
        Sun, 31 Jan 2021 18:09:55 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.85.153.205])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 31 Jan 2021 18:09:55 +0000 (GMT)
Message-ID: <18529562ed71becf21401ec9fd9d95c4ac44fdc0.camel@linux.ibm.com>
Subject: Re: Migration to trusted keys: sealing user-provided key?
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel@pengutronix.de
Date:   Sun, 31 Jan 2021 10:09:54 -0800
In-Reply-To: <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de>
References: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
         <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
         <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
         <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-31_05:2021-01-29,2021-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 impostorscore=0 mlxlogscore=760 mlxscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101310102
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2021-01-31 at 15:14 +0100, Jan Lübbe wrote:
> On Sun, 2021-01-31 at 07:09 -0500, Mimi Zohar wrote:
> > On Sat, 2021-01-30 at 19:53 +0200, Jarkko Sakkinen wrote:
> > > On Thu, 2021-01-28 at 18:31 +0100, Ahmad Fatoum wrote:
> > > > Hello,
> > > > 
> > > > I've been looking into how a migration to using
> > > > trusted/encrypted keys would look like (particularly with dm-
> > > > crypt).
> > > > 
> > > > Currently, it seems the the only way is to re-encrypt the
> > > > partitions because trusted/encrypted keys always generate their
> > > > payloads from RNG.
> > > > 
> > > > If instead there was a key command to initialize a new
> > > > trusted/encrypted key with a user provided value, users could
> > > > use whatever mechanism they used beforehand to get a plaintext
> > > > key and use that to initialize a new trusted/encrypted key.
> > > > From there on, the key will be like any other trusted/encrypted
> > > > key and not be disclosed again to userspace.
> > > > 
> > > > What are your thoughts on this? Would an API like
> > > > 
> > > >   keyctl add trusted dmcrypt-key 'set <content>' # user-
> > > > supplied content
> > > > 
> > > > be acceptable?
> > > 
> > > Maybe it's the lack of knowledge with dm-crypt, but why this
> > > would be useful? Just want to understand the bottleneck, that's
> > > all.
> 
> Our goal in this case is to move away from having the dm-crypt key
> material accessible to user-space on embedded devices. For an
> existing dm-crypt volume, this key is fixed. A key can be loaded into
> user key type and used by dm-crypt (cryptsetup can already do it this
> way). But at this point, you can still do 'keyctl read' on that key,
> exposing the key material to user space.
> 
> Currently, with both encrypted and trusted keys, you can only
> generate new random keys, not import existing key material. 
> 
> James Bottomley mentioned in the other reply that the key format will
> become compatible with the openssl_tpm2_engine, which would provide a
> workaround. This wouldn't work with OP-TEE-based trusted keys (see
> Sumit Garg's series), though.

Assuming OP-TEE has the same use model as the TPM, someone will
eventually realise the need for interoperable key formats between key
consumers and then it will work in the same way once the kernel gets
updated to speak whatever format they come up with.

> > We upstreamed "trusted" & "encrypted" keys together in order to
> > address this sort of problem.   Instead of directly using a
> > "trusted" key for persistent file signatures being stored as
> > xattrs, the "encrypted" key provides one level of
> > indirection.   The "encrypted" key may be encrypted/decrypted with
> > either a TPM based "trusted" key or with a "user" type symmetric
> > key[1].
> > 
> > Instead of modifying "trusted" keys, use a "user" type "encrypted"
> > key.
> 
> I don't see how this would help. When using dm-crypt with an
> encrypted key, I can't use my existing key material.
> 
> Except for the migration aspect, trusted keys seem ideal. Only a
> single exported blob needs to be stored and can only be loaded/used
> again on the same (trusted) system. Userspace cannot extract the key
> material. 

Yes, that's what I was thinking ... especially when you can add policy
to the keys, which includes PCR locking.  Part of the problem is that
changing policy, which you have to do if something happens to update
the PCR values, is technically a migration, so your trusted keys for
dm-crypt are really going to have to be migrateable.

> To get to this point on systems in the field without re-encryption of
> the whole storage, only the initial trusted/encrypted key creation
> would need to allow passing in existing key material.

What about a third option: why not make dm-crypt store the master key
it uses as an encrypted key (if a parent trusted key is available)? 
That way you'd be able to extract the encrypted form of the key as
root, but wouldn't be able to extract the actual master key.

James


