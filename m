Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D96630AA92
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 16:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBAPJd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 10:09:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231467AbhBAPJI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 10:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612192062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rJ1BNHbLyBivT85os4ZEgQB+CLLa83qJkWROJrNOKGM=;
        b=HblbeuWPYkoWG8XruhJjKe/PvQLTqnkz76ehRZIdagMxoWc3zOgd5E2ubxEBE8u2NSjk6T
        rL/yYu2ohr04+Hjm5dv3CMQoUqkcPh/jOj9PYRDCt/Uufria0ts2vosIVBBE97WoB5eVJj
        T/HMWgdbbAHq84FzRsJp6LSQU5E5MGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-RvKMTgIPPmaxLkH-Yb_XOQ-1; Mon, 01 Feb 2021 10:07:40 -0500
X-MC-Unique: RvKMTgIPPmaxLkH-Yb_XOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB8F0801817;
        Mon,  1 Feb 2021 15:07:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D38EA5C1A1;
        Mon,  1 Feb 2021 15:07:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <58935b00f65e389e9ae3da2425d06bd88d280e43.camel@linux.ibm.com>
References: <58935b00f65e389e9ae3da2425d06bd88d280e43.camel@linux.ibm.com> <20210129150355.850093-3-stefanb@linux.vnet.ibm.com> <20210129150355.850093-1-stefanb@linux.vnet.ibm.com> <4162801.1612185801@warthog.procyon.org.uk> <71a77d10-e645-194f-5073-ebf180a8d70e@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     dhowells@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/4] x509: Detect sm2 keys by their parameters OID
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4170407.1612192055.1@warthog.procyon.org.uk>
Date:   Mon, 01 Feb 2021 15:07:35 +0000
Message-ID: <4170408.1612192055@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi Zohar <zohar@linux.ibm.com> wrote:

> > > Do you have a branch you want me to pull or did you want me to take just
> > > patches 2-4?
> > 
> > Please take it from the mailing list. If there are requests for more 
> > changes on the crypto level, I will send another series. I personally am 
> > waiting for some sort of verdict on the crypto level...
> 
> The entire patch set should be upstreamed as a single patch set, after
> having each of the maintainer's Ack it.  In addition, the v6 version is
> missing some Reviewed-by tags.  (Stefan will re-post a v7 patch set.)
> 
> David, I don't have problem with this patch set being upstreamed via
> the keys subsystem, assuming it's been tested.

Herbert wants the first patch to go through the crypto tree.  Maybe all of
them should proceed by that route if Herbert is willing?

What do patches 2-4 do if patch 1 isn't applied?

David

