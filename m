Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B886B309776
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 19:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhA3SIo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 13:08:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhA3SIn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 13:08:43 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10UI2dJn193214;
        Sat, 30 Jan 2021 13:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=SKR7hqBhsu6j+K+DkJbkd2xdJO63+eVAZKv7ApW8XcM=;
 b=fjTzecvh+XCjaHTPOgEtOltGZvvVL6aBxy2rNy9gPL5guIC/R1HbOqsfhKrcxUjc1JHJ
 uz/sX+cuPZBEtvUXMSqGXHbvLjQ0vrxEZSG2SwfM1DkP4KmISTlWdFIVLdzGhgpuLVKp
 XhmxNtPNu6FjS7XGbSfeep2IO68CdzX2EnDhFseP6MTXETgfol/FwjcYuLX8VnW2TS3K
 8VoYRfRn+JEjXqUpCwR5KSDEFyibV2GCNe9NDKyP/D4QbLGF2fjpuh/gN7S8b2cjQzdb
 s2raGNjwxGCh19Y9FJAPZw8d/Q3NWLcoHKi2Zrvpmp8WgkuxDRTrPf+E3CHfcn5kmzTA Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36dccug2gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 30 Jan 2021 13:07:56 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10UI6aRm007584;
        Sat, 30 Jan 2021 13:07:56 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36dccug2g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 30 Jan 2021 13:07:56 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10UHvuLZ026023;
        Sat, 30 Jan 2021 18:07:55 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03wdc.us.ibm.com with ESMTP id 36cy38bmjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 30 Jan 2021 18:07:54 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10UI7sgE12780112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jan 2021 18:07:54 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDD427805F;
        Sat, 30 Jan 2021 18:07:53 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 757937805E;
        Sat, 30 Jan 2021 18:07:51 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.85.153.205])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 30 Jan 2021 18:07:51 +0000 (GMT)
Message-ID: <92ff93ef9ecb90705466194afee67d236237ec9e.camel@linux.ibm.com>
Subject: Re: Migration to trusted keys: sealing user-provided key?
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel@pengutronix.de,
        jlu@pengutronix.de
Date:   Sat, 30 Jan 2021 10:07:49 -0800
In-Reply-To: <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
References: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
         <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-30_12:2021-01-29,2021-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=685 clxscore=1011
 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101300097
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-01-30 at 19:53 +0200, Jarkko Sakkinen wrote:
> On Thu, 2021-01-28 at 18:31 +0100, Ahmad Fatoum wrote:
> > Hello,
> > 
> > I've been looking into how a migration to using trusted/encrypted
> > keys would look like (particularly with dm-crypt).
> > 
> > Currently, it seems the the only way is to re-encrypt the
> > partitions because trusted/encrypted keys always generate their
> > payloads from RNG.
> > 
> > If instead there was a key command to initialize a new
> > trusted/encrypted key with a user provided value, users could use
> > whatever mechanism they used beforehand to get a plaintext key and
> > use that to initialize a new trusted/encrypted key. From there on,
> > the key will be like any other trusted/encrypted key and not be
> > disclosed again to userspace.
> > 
> > What are your thoughts on this? Would an API like
> > 
> >   keyctl add trusted dmcrypt-key 'set <content>' # user-supplied
> > content
> > 
> > be acceptable?
> 
> Maybe it's the lack of knowledge with dm-crypt, but why this would be
> useful? Just want to understand the bottleneck, that's all.

There was a recent patch to dm-crypt to add encrypted key support:
27f5411a718c ("dm crypt: support using encrypted keys").  The
implementation requires the actual disk encryption master key to be in
the payload.  Most people don't want to change that key because it
involves re-encrypting the whole disk (usually what people mean when
they say "key" for dm-crypt is a passphrase that decrypts this master
key from a keyslot in the metadata, which is why you can change your
passphrase without changing the underlying encryption).

However, once we get the trusted key rework upstream, we do have a
solution:  The key format becomes interoperable with the
openssl_tpm2_engine and we can now do seal_tpm2_data on any payload and
the kernel will accept it.

James


