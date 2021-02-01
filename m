Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490BB30AC69
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 17:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBAQO6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 11:14:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230013AbhBAQO6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 11:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612196011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8488sZEgg9QbBdKoC/LCHUC78reNRJ4sBzh7J5Or4xI=;
        b=iNPK0hFRo8mVBzZQtMDXfWBUHdFmsGw++nAJnTlU794BDj+pV5S1YyW7aI7E+32rCvMLfy
        aELUJa0Cbw+i3a1gePNMdVFJMqVwGI0rtzCpYX4eNg3i1xnqGx0DKxavEXJHu0By6pVFU7
        rUIVAM6niNkUaI0bmPESqVN84cpnpg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-gGKPnbMRNcOvdPBBOuwESw-1; Mon, 01 Feb 2021 11:13:28 -0500
X-MC-Unique: gGKPnbMRNcOvdPBBOuwESw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 483B1801817;
        Mon,  1 Feb 2021 16:13:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C09110013C0;
        Mon,  1 Feb 2021 16:13:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210201151910.1465705-1-stefanb@linux.ibm.com>
References: <20210201151910.1465705-1-stefanb@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v7 0/4] Add support for x509 certs with NIST p256 and p192 keys
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32176.1612196003.1@warthog.procyon.org.uk>
Date:   Mon, 01 Feb 2021 16:13:23 +0000
Message-ID: <32177.1612196003@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan Berger <stefanb@linux.ibm.com> wrote:

> v6->v7:
>   - Moved some OID defintions to patch 1 for bisectability
>   - Applied R-b's

But I can't now apply 2-4 without patch 1.

David

