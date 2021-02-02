Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0214530BB0E
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 10:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhBBJfd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 04:35:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232760AbhBBJe5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 04:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612258411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6LJM+19s3E1PYrGOVy7eL/hPhE6m39946JYABim2wbg=;
        b=TLUgtyfA5WxmBZlYYTbLTGfxhr2jeNbb7eJOX+oH00vy0UtoShfheFrpViK6Z+hpIrqQhy
        4X1ZHHev/AzoBaHjYas4SeoBMxWUxjahUukiVNcg6LbcNfYE71Rf+SCwwIwBWG0xK3CH3Y
        EpylkSmhmlr2c367JvXZXa3FkFAl1a4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-vRaAA1sZOWiQWGE52tiRRg-1; Tue, 02 Feb 2021 04:33:27 -0500
X-MC-Unique: vRaAA1sZOWiQWGE52tiRRg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC624190B2A1;
        Tue,  2 Feb 2021 09:33:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E07B519717;
        Tue,  2 Feb 2021 09:33:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210202085537.GA28682@gondor.apana.org.au>
References: <20210202085537.GA28682@gondor.apana.org.au> <20210202035655.GA26997@gondor.apana.org.au> <58935b00f65e389e9ae3da2425d06bd88d280e43.camel@linux.ibm.com> <20210129150355.850093-3-stefanb@linux.vnet.ibm.com> <20210129150355.850093-1-stefanb@linux.vnet.ibm.com> <4162801.1612185801@warthog.procyon.org.uk> <71a77d10-e645-194f-5073-ebf180a8d70e@linux.ibm.com> <4170408.1612192055@warthog.procyon.org.uk> <110279.1612254455@warthog.procyon.org.uk>
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
Content-ID: <114434.1612258403.1@warthog.procyon.org.uk>
Date:   Tue, 02 Feb 2021 09:33:23 +0000
Message-ID: <114435.1612258403@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> > Should I defer it till the next merge window?
> 
> Is there any specific reason why this has to be in the current
> one?

No idea.  It seems straightforward enough, at least on the keyrings side, that
I was going to add it.

David

