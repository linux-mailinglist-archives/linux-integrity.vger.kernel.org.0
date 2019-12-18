Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFA712450C
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 11:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfLRKuW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 05:50:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33357 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725828AbfLRKuW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 05:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576666221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0az4KKJfuYN7DyGnSzwf/5QIFxpWRQz3eoiHmfUOP1s=;
        b=Vw8ryD33etcQ+MAZc8qjYCNlKxFFA5+K/yWBFHa52gkcvzk1MbEwvQ4oY+6IZTCTe1QJuQ
        B9A8eeaCDmNnwwrLeR+QggcI4l5HduK5MgXVKakbsKBQ+d7orUpcp+p1LKqiibfJXawup6
        tGlu21PRWgCqsV6kuaSJpFfV9n88bqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-3VFPngL1Me2UbZnC6X4zXQ-1; Wed, 18 Dec 2019 05:50:19 -0500
X-MC-Unique: 3VFPngL1Me2UbZnC6X4zXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 329A6107ACFB;
        Wed, 18 Dec 2019 10:50:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D84EC26DC6;
        Wed, 18 Dec 2019 10:50:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1576069352.2812.1.camel@HansenPartnership.com>
References: <1576069352.2812.1.camel@HansenPartnership.com> <1575984010.3459.4.camel@HansenPartnership.com> <1575936272.31378.50.camel@HansenPartnership.com> <1575936367.31378.52.camel@HansenPartnership.com> <932257121039494734d97e290abb9159b1f5ca28.camel@infradead.org> <10037.1575986929@warthog.procyon.org.uk> <1576004020.3647.13.camel@HansenPartnership.com> <35B37965-359E-40E0-8F44-836A56EC4756@infradead.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     dhowells@redhat.com, David Woodhouse <dwmw2@infradead.org>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org
Subject: Re: [PATCH v2 2/8] lib: add asn.1 encoder
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26945.1576666216.1@warthog.procyon.org.uk>
Date:   Wed, 18 Dec 2019 10:50:16 +0000
Message-ID: <26946.1576666216@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> +/**
> + * asn1_encode_octet_string - encode an ASN.1 OCTET STRING
> + * @data: pointer to encode at
> + * @data_len: bytes remaining in @data buffer
> + * @string: string to be encoded
> + * @len: length of string
> + *
> + * Note ASN.1 octet strings may contain zeros, so the length is obligatory.
> + */
> +int asn1_encode_octet_string(unsigned char **data, int *data_len,
> +			     const unsigned char *string, u32 len)

I wonder if it makes more sense to pass in an end pointer and return the new
data pointer (or an error), ie.:

unsigned char *asn1_encode_octet_string(unsigned char *data,
				        unsigned char *data_end,
					const unsigned char *string, u32 len)

Further, I wonder - does it actually make more sense to encode backwards,
ie. start at the end of the buffer and do the last element first, working
towards the front.

The disadvantage being that the data start would likely not be coincident with
the buffer start.

David

