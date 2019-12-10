Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 144FE118A76
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2019 15:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfLJOI5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 09:08:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40458 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727145AbfLJOI5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 09:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575986936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJg8UIY2eWyB9kEcZeR7laFFzIrOLQf8vRS2rGcLNGg=;
        b=LYArEBCoW1CsAcDa0rHtyLvrd7Xw5DH3aUJubmtwsSpvTW78gkuFJm5BSCr8VFxE2VdzYz
        mFx6a/drWzdrEkt3ZlbeSmRCXwtdZTd7mhnzujL8kejJzQ0d8K2Dj00hji/rmKvt1LweYe
        ZKzgKiyXJM8kOBl7HlFRnYnazQyna6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-6V6EJp81OcO5cSV8xti8LA-1; Tue, 10 Dec 2019 09:08:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E970C1800D45;
        Tue, 10 Dec 2019 14:08:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EDF91001901;
        Tue, 10 Dec 2019 14:08:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1575984010.3459.4.camel@HansenPartnership.com>
References: <1575984010.3459.4.camel@HansenPartnership.com> <1575936272.31378.50.camel@HansenPartnership.com> <1575936367.31378.52.camel@HansenPartnership.com> <932257121039494734d97e290abb9159b1f5ca28.camel@infradead.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     dhowells@redhat.com, David Woodhouse <dwmw2@infradead.org>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org
Subject: Re: [PATCH v2 2/8] lib: add asn.1 encoder
MIME-Version: 1.0
Content-ID: <10036.1575986929.1@warthog.procyon.org.uk>
Date:   Tue, 10 Dec 2019 14:08:49 +0000
Message-ID: <10037.1575986929@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 6V6EJp81OcO5cSV8xti8LA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> > Didn't you say you were going to make it return an error when it ran
> > out of space or was asked to encode a negative number?
>=20
> it follows the pattern of all the other functions in that it dumps a
> kernel warning on problems and bails.

I don't see any bounds checking there, let alone anything that dumps a kern=
el
warning and bails - except if the length is so large that the ASN.1 cannot =
be
constructed.  That said, there is a check in patch 4.

> ... as long as the buffer doesn't overflow.

Yes, but that's Dave's point.

[from patch 4]

> +=09 * Assume both ovtet strings will encode to a 2 byte definite length

octet, btw.

At least I've found a preliminary bounds check there

> +=09 */
> +=09if (WARN(work - scratch + pub_len + priv_len + 8 > SCRATCH_SIZE,
> +=09=09 "BUG: scratch buffer is too small"))
> +=09=09return -EINVAL;

which I presume makes the correct calculation.

I thought TPM comms were slow - slow enough that putting bounds checking in
your asn1_encode_* routines will be insignificant.

Further, you're promoting this ASN.1 encoder as a general library within th=
e
kernel, presumably so that other people can make use of it.  Please therefo=
re
put bounds checking and error handling in it.  And please *don't* just prod=
uce
broken ASN.1 when something goes wrong.

David

