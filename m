Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A448F186A60
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Mar 2020 12:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbgCPLvC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Mar 2020 07:51:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43268 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730882AbgCPLvC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Mar 2020 07:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584359460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tryDzo9SohMjPK6GcmpV+7d9g8Sngd5hQyCi5ctTNMA=;
        b=ebaQF4qDjiITPoCSnY2RsyYiISWNjaG9dTNkPmjCpd9Zi5FK9xM8nH64kf3T82sxjlYedo
        Sd9bbszV24NWpge7Go+S+BiMRZ6VKqFFNoS+D2Ammcy/bgj2cuhaONSK7otREbDcpZ6yMT
        Qg39SncxJnDHnJG2LsMfNhiZULWLYFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-iG6UQSl3NH2zipfAM4M8Sg-1; Mon, 16 Mar 2020 07:50:59 -0400
X-MC-Unique: iG6UQSl3NH2zipfAM4M8Sg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76A4218B5FAC;
        Mon, 16 Mar 2020 11:50:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B84DE92F83;
        Mon, 16 Mar 2020 11:50:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200313152102.1707-2-longman@redhat.com>
References: <20200313152102.1707-2-longman@redhat.com> <20200313152102.1707-1-longman@redhat.com>
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
Subject: Re: [PATCH v3 1/3] KEYS: Don't write out to userspace while holding key semaphore
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1797277.1584359451.1@warthog.procyon.org.uk>
Date:   Mon, 16 Mar 2020 11:50:51 +0000
Message-ID: <1797278.1584359451@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Waiman Long <longman@redhat.com> wrote:

>  include/linux/key-type.h                  |  2 +-
>  security/keys/big_key.c                   | 11 ++---
>  security/keys/encrypted-keys/encrypted.c  |  7 ++-
>  security/keys/keyctl.c                    | 57 +++++++++++++++++++----
>  security/keys/keyring.c                   |  6 +--
>  security/keys/request_key_auth.c          |  7 ++-
>  security/keys/trusted-keys/trusted_tpm1.c | 14 +-----
>  security/keys/user_defined.c              |  5 +-
> ...
> -	long (*read)(const struct key *key, char __user *buffer, size_t buflen);
> +	long (*read)(const struct key *key, char *buffer, size_t buflen);

Note that there are read functions outside of security/keys/ that also need
fixing - dns_resolver_read() and rxrpc_read().

David

