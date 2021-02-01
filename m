Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB6430A898
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 14:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhBANYy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 08:24:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231511AbhBANYx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 08:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612185807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rQ/8somOMzVQ3Ad0/BqJlYP8xwKLNGrctlhtSE/sB/I=;
        b=f9lplky/VNwQdPTuKAzWbJnBeTLbT9fiY4wz9TtNyrew0Ed6dHSU6xcaIZxvFXYKtHRcjb
        +5nZ9+wZH11lDEFuX9ZG5EBOXdhyidNBQHHxow2hCD+YPIBs9sXEVcKLFK+e7bUjYNQ5+g
        bkC4SX/iibfMpAGlSjHbOCJ++OoALq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-LohhxNHYM92gXIkYNSwnsw-1; Mon, 01 Feb 2021 08:23:25 -0500
X-MC-Unique: LohhxNHYM92gXIkYNSwnsw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F4119802B47;
        Mon,  1 Feb 2021 13:23:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 957D210016DB;
        Mon,  1 Feb 2021 13:23:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210129150355.850093-3-stefanb@linux.vnet.ibm.com>
References: <20210129150355.850093-3-stefanb@linux.vnet.ibm.com> <20210129150355.850093-1-stefanb@linux.vnet.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        patrick@puiterwijk.org, linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 2/4] x509: Detect sm2 keys by their parameters OID
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4162800.1612185801.1@warthog.procyon.org.uk>
Date:   Mon, 01 Feb 2021 13:23:21 +0000
Message-ID: <4162801.1612185801@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:

> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Detect whether a key is an sm2 type of key by its OID in the parameters
> array rather than assuming that everything under OID_id_ecPublicKey
> is sm2, which is not the case.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: keyrings@vger.kernel.org

I presume these cc's are intentionally not on the first patch or the cover (if
there is one)?

Do you have a branch you want me to pull or did you want me to take just
patches 2-4?

David

