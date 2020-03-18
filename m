Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3EC189F6C
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Mar 2020 16:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCRPOj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Mar 2020 11:14:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34806 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727035AbgCRPOi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Mar 2020 11:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584544477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rDahFV9TPWnSHYGEo4pu2LmiluREcgL9pHQHEehqYmE=;
        b=Dz15MQ4W0WxLh2CYuST0npl7v2oVIt0q2/wRZ+MMyN4B6ZkFYvBSBuH5dWqhqpFw9ExlmL
        S7rRXktEgyZ3hUaNj4JLJhI/MYOIvOyJk3UpEsmton3cjKsBVpQ75LAvLKldf1rxsOtKmO
        YFZ3UCNfG+vLr3geXcSbRnHyIIQMbUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-zLovBwwuOPCXLkjvjN2tvw-1; Wed, 18 Mar 2020 11:14:34 -0400
X-MC-Unique: zLovBwwuOPCXLkjvjN2tvw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97683107ACC7;
        Wed, 18 Mar 2020 15:14:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0851A5C1D8;
        Wed, 18 Mar 2020 15:14:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <e47bef56-9271-93e0-0e59-c77c253babea@redhat.com>
References: <e47bef56-9271-93e0-0e59-c77c253babea@redhat.com> <20200317194140.6031-5-longman@redhat.com> <20200317194140.6031-1-longman@redhat.com> <2832139.1584520054@warthog.procyon.org.uk>
To:     Waiman Long <longman@redhat.com>
Cc:     dhowells@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH v4 4/4] KEYS: Avoid false positive ENOMEM error on key read
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2866041.1584544464.1@warthog.procyon.org.uk>
Date:   Wed, 18 Mar 2020 15:14:24 +0000
Message-ID: <2866042.1584544464@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Waiman Long <longman@redhat.com> wrote:

> Doing this is micro-optimization. As the keys subsystem is that
> performance critical, do we need to do that to save a cycle or two while
> making the code a bit harder to read?

It was more sort of a musing comment.  Feel free to ignore it.  kvfree()
doesn't do this.

David

