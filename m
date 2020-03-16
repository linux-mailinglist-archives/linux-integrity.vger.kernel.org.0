Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE09186CFC
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Mar 2020 15:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbgCPOYp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Mar 2020 10:24:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47026 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731492AbgCPOYp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Mar 2020 10:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584368683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8RPanWQj7akCZRE0rKGpc838ieDndaq2JCNq0zCn4Pw=;
        b=A7kONsz21u++jD1i3JiB9saUhUB2Sol/83ats6Q3Bo0wimV5rkoTH7vevI4irPoqh/wcB1
        l4FDgcEKukK1kyrhc6X8iq0BxrB8VHNKqjuGMpb4iRNE4Oi+ze9iP7wqZWZbMT2oGZrLip
        vkR0XjbSqfxwDax8MfEUxO86B357ISs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-seELQGmgNhqXzPmviVCfpg-1; Mon, 16 Mar 2020 10:24:42 -0400
X-MC-Unique: seELQGmgNhqXzPmviVCfpg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B759800D53;
        Mon, 16 Mar 2020 14:24:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D1A910246E3;
        Mon, 16 Mar 2020 14:24:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200313152102.1707-4-longman@redhat.com>
References: <20200313152102.1707-4-longman@redhat.com> <20200313152102.1707-1-longman@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     dhowells@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH v3 3/3] KEYS: Use kvmalloc() to better handle large buffer allocation
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1809106.1584368672.1@warthog.procyon.org.uk>
Date:   Mon, 16 Mar 2020 14:24:32 +0000
Message-ID: <1809107.1584368672@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I wonder if it's worth merging this into patch 2.  I'm not sure it's really
worth its own patch.  If you want to generalise kvzfree(), then that could go
as its own patch first.

David

