Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA41022A9F3
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jul 2020 09:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgGWHpR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Jul 2020 03:45:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34321 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727854AbgGWHpQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Jul 2020 03:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595490316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T9lnr6ON1NCpEkmgxg4MNr+SzuEjRWxb4N7R2CLU4Jc=;
        b=VhDnLLS3TSGuDAMouN4hSlPh9ZAm77717hqOVDtShLIAknlulR0VubiNgHZ4yOrxOQe6RR
        qwqfyow9aOMmR+gVL0/yF4aNdg6QewL6Vu29+QbmPHQ9dV30Ts4xIUctDq/NBMdojG628m
        2iEF3rz6ZiMQuxK8+SOh/MZwpUF58uM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-7xir_t67MVeq1XS_-LNXcA-1; Thu, 23 Jul 2020 03:45:13 -0400
X-MC-Unique: 7xir_t67MVeq1XS_-LNXcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9656880046D;
        Thu, 23 Jul 2020 07:45:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E7B361176;
        Thu, 23 Jul 2020 07:45:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200723020114.GG45081@linux.intel.com>
References: <20200723020114.GG45081@linux.intel.com> <20200716195227.65839-1-grandmaster@al2klimov.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     dhowells@redhat.com,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] encrypted-keys: Replace HTTP links with HTTPS ones
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1269484.1595490310.1@warthog.procyon.org.uk>
Date:   Thu, 23 Jul 2020 08:45:10 +0100
Message-ID: <1269485.1595490310@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> Please remove this. We don't care about it. Git log should only contain
> information either for studying or maintaining the kernel source code.

Yeah - in this case it's not useful.  Sometimes it's worth including the
script if you think the target audience might be interested in running it for
themselves - such as to help resolve merge problems.

David

