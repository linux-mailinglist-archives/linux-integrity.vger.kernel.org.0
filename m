Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF4E30B9E5
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 09:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhBBI3Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 03:29:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232553AbhBBI3K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 03:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612254463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pl4uhcMFYXNVqbgTMnS7qgsoAWnyf+3tpQCijBxwzZk=;
        b=e7gwRmAF//mCYp7mLaZdwr9nbEagLB1cUojn+LYt5ijo4oIDRdpSu6jxX6UQQlfTEl9nEN
        M3z91EsJjORwg11pWOyK1odRVL0QESw8tQXynpRfL8GaNKG6DBv5aJBp1/5BAtcFnVPrt1
        cDaATwYS4LBMPnc1lWAcFEFS1XlaU+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-VPJrjoISPsaxxLNbIj-Xmg-1; Tue, 02 Feb 2021 03:27:40 -0500
X-MC-Unique: VPJrjoISPsaxxLNbIj-Xmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7845410054FF;
        Tue,  2 Feb 2021 08:27:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B1AA5D9C6;
        Tue,  2 Feb 2021 08:27:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210202035655.GA26997@gondor.apana.org.au>
References: <20210202035655.GA26997@gondor.apana.org.au> <58935b00f65e389e9ae3da2425d06bd88d280e43.camel@linux.ibm.com> <20210129150355.850093-3-stefanb@linux.vnet.ibm.com> <20210129150355.850093-1-stefanb@linux.vnet.ibm.com> <4162801.1612185801@warthog.procyon.org.uk> <71a77d10-e645-194f-5073-ebf180a8d70e@linux.ibm.com> <4170408.1612192055@warthog.procyon.org.uk>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dhowells@redhat.com, Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/4] x509: Detect sm2 keys by their parameters OID
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <110278.1612254455.1@warthog.procyon.org.uk>
Date:   Tue, 02 Feb 2021 08:27:35 +0000
Message-ID: <110279.1612254455@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> > Herbert wants the first patch to go through the crypto tree.  Maybe all of
> > them should proceed by that route if Herbert is willing?
> 
> I'm not actually all that fussed about where it goes through.  It's
> just the first patch happens to touch an area that is still under
> discussion for the Crypto API.  So once that's settled I'm more than
> happy for it to go through your tree if that's the easiest way to go.

Should I defer it till the next merge window?

David

