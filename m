Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7856718C020
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 20:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCSTMN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 15:12:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24824 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgCSTMN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 15:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584645131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oXAlX2VCk6cDoL4on9GuMcxxAHTHOUG0oHDR/ajGhqU=;
        b=Ivu8SXQlt9DLmUSihdpjCmNUy1z7IHW5iKJryviZJBTFSZt5Rm4YDrSkaNZ8aPRgJ9xLbu
        g1kb8E9OcI1g1ZEscAlZHUUu7Qpv3V2Bz5HAyEQ0jWC+Zpc7FgozTwDtmof3d3+QWl10Ej
        FcdQJbQsFUVINNn8VEUCJBtYD3pV1HQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-ABlZIocgNICJyLOFk8ATgQ-1; Thu, 19 Mar 2020 15:12:09 -0400
X-MC-Unique: ABlZIocgNICJyLOFk8ATgQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D50B189F760;
        Thu, 19 Mar 2020 19:12:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF2AF19C58;
        Thu, 19 Mar 2020 19:12:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1584639086.3610.28.camel@HansenPartnership.com>
References: <1584639086.3610.28.camel@HansenPartnership.com> <20200310051607.30334-2-James.Bottomley@HansenPartnership.com> <20200310051607.30334-1-James.Bottomley@HansenPartnership.com> <3180269.1584636439@warthog.procyon.org.uk>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     dhowells@redhat.com, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v8 1/8] lib: add ASN.1 encoder
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3192643.1584645125.1@warthog.procyon.org.uk>
Date:   Thu, 19 Mar 2020 19:12:05 +0000
Message-ID: <3192644.1584645125@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> > I wonder if it's worth appending a note to the comment that if
> > indefinite length encoding is selected, then the result is not DER-
> > compliant and may not be CER-compliant since you're advertising
> > BER/DER/CER.
> 
> We only encode definite length currently, so the comment is superfluous
> (and probably confusing if you don't know the difference between
> DER/BER and CER).  Let's add something like this iff we ever start to
> use indefinite lengths in the encoder.

Your code appears to actually do indefinite length encoding if -1 is passed as
len to asn1_encode_tag().  The kdoc says:

	To encode in place pass a NULL @string and -1 for @len; all this will
	do is add an indefinite length tag and update the data pointer to the
	place where the tag contents should be placed.

Granted, your patches might not use it, but you're making a generic ASN.1
encoder library.

David

