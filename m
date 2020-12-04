Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296BE2CEEF6
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 14:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgLDNq3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 08:46:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbgLDNq3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 08:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607089503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKxLsf6l3TvgTjJX2hGA0JH8gi1PXsDkZSEi0dcTZQQ=;
        b=ONVCzrC4OR1EwDtf+Q7huWbeNzI/Rp5lZUMXu8hp6CKTAIWAYO/6Jw6VBaWJQqqcpUZqHc
        7T149iFj4quMeWk3qlCC+LxKKZn8bFeXvR+kfneUsxEAqOrgwMs7naxgB6UcdDCwxRdrHS
        dl5ctU71BOt7fk3ifXiqXO98xmNP67Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-CBHgGRreOZKophYKOWo1Fg-1; Fri, 04 Dec 2020 08:44:58 -0500
X-MC-Unique: CBHgGRreOZKophYKOWo1Fg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC54B425CB;
        Fri,  4 Dec 2020 13:44:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 920EA5D9CA;
        Fri,  4 Dec 2020 13:44:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201129222004.4428-3-James.Bottomley@HansenPartnership.com>
References: <20201129222004.4428-3-James.Bottomley@HansenPartnership.com> <20201129222004.4428-1-James.Bottomley@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     dhowells@redhat.com, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v14 2/5] oid_registry: Add TCG defined OIDS for TPM keys
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <112050.1607089494.1@warthog.procyon.org.uk>
Date:   Fri, 04 Dec 2020 13:44:54 +0000
Message-ID: <112051.1607089494@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> The TCG has defined an OID prefix "2.23.133.10.1" for the various TPM
> key uses.

Is this registered?  I've checked a couple of OID registry sites
(eg. www.oid-info.com) and it seems to be unknown.

David

