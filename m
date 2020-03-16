Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBD61869FB
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Mar 2020 12:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgCPLW6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Mar 2020 07:22:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48105 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730747AbgCPLW6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Mar 2020 07:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584357777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wZZ2dippKQdWRoE3jMgjrBrkll2rLCagVzHWW7VSO5s=;
        b=hZ+Tl7GotrDSQJbBmc0hYAa8VG8Pj9RDAAUGYBJTaModiu950rdcY0B/GQnbbHkQPb/irT
        O8gNwHhvgPj3CpToNl6Os6xyGB1vT8g/ZNZIVGKJeSK1MptjsWpTk5ZukvCegitgr6gDn8
        4HMpgta1SBW6zf44puC71jp1GnEBLPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-saTImSekPXiARTvR7zgBlw-1; Mon, 16 Mar 2020 07:22:54 -0400
X-MC-Unique: saTImSekPXiARTvR7zgBlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BCBB107ACC4;
        Mon, 16 Mar 2020 11:22:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE3077388E;
        Mon, 16 Mar 2020 11:22:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200315212706.GE224162@linux.intel.com>
References: <20200315212706.GE224162@linux.intel.com> <20200313152102.1707-1-longman@redhat.com> <20200313152102.1707-2-longman@redhat.com> <20200315192104.GD224162@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     dhowells@redhat.com, Waiman Long <longman@redhat.com>,
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
Content-ID: <1793252.1584357764.1@warthog.procyon.org.uk>
Date:   Mon, 16 Mar 2020 11:22:44 +0000
Message-ID: <1793253.1584357764@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> I guess we cannot sanely define fixes tag for this one, can we?

Use:

	Fixes: ^1da177e4c3f4 ("Linux-2.6.12-rc2")

David

