Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683932CEEEB
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 14:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgLDNlv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 08:41:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbgLDNlv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 08:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607089225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bPbgPYe1Qp/L63WTrch06Vgz0Fmr1gl6VIg62XAvGw0=;
        b=VICdaPtbjg3c6lElFXnI5YCUY92uWBliONQmqOx7uI2/CWCdLzFIdnwvsZETEB2fFynevn
        dSWrb/NBaqJfe8i7ZhcR+zKewi21Et0ap2WpYpPM70NWx/wuLGkZdkuhwNtly09/RlURyy
        OzjfgjbJvTiMhLif20AzpnNtmsWboxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-V7lWDw6nPn-f9Ffw4juKHg-1; Fri, 04 Dec 2020 08:40:21 -0500
X-MC-Unique: V7lWDw6nPn-f9Ffw4juKHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8053C858183;
        Fri,  4 Dec 2020 13:40:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CC5D5D9CA;
        Fri,  4 Dec 2020 13:40:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201129222004.4428-2-James.Bottomley@HansenPartnership.com>
References: <20201129222004.4428-2-James.Bottomley@HansenPartnership.com> <20201129222004.4428-1-James.Bottomley@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     dhowells@redhat.com, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v14 1/5] lib: add ASN.1 encoder
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <111393.1607089218.1@warthog.procyon.org.uk>
Date:   Fri, 04 Dec 2020 13:40:18 +0000
Message-ID: <111394.1607089218@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> +	*(data++) = _tagn(CONT, CONS, tag);

You might want to move the _tag() and _tagn() macros into linux/asn1.h so that
you don't need to include asn1_ber_bytecode.h.

But apart from that:

Reviewed-by: David Howells <dhowells@redhat.com>

