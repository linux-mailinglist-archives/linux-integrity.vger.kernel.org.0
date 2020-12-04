Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1FD2CEF36
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 15:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388132AbgLDODO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 09:03:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387474AbgLDODO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 09:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607090508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4M4yoOZ8+d2uOnRn+suIjK8Rel43Q7KGhvoch0szyZ0=;
        b=It2q/rtxa4PNwJtJE18C15hOA4oCKQVRqSkB5pzKAm/L/v6iyNt6Rs1ot0r8NmzKlNcSMn
        BMRbNbnPVWM06Ulqp4OMBQwuitElfmJK108tq2kkRZGGLMLf8EHY0mVBtJm/3JjH08nxiz
        IbYcjSz9D+tKfDKlHLb2MkvoCeQEi+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-99hyNT8ANI6M6dKa2e9EUQ-1; Fri, 04 Dec 2020 09:01:44 -0500
X-MC-Unique: 99hyNT8ANI6M6dKa2e9EUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACB5B193ECE3;
        Fri,  4 Dec 2020 14:01:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B36C9100164C;
        Fri,  4 Dec 2020 14:01:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <80fb0eae-8321-5ae2-8d50-eabbe86981da@digikod.net>
References: <80fb0eae-8321-5ae2-8d50-eabbe86981da@digikod.net> <20201120180426.922572-1-mic@digikod.net> <20201130024011.GA24870@kernel.org>
To:     =?us-ascii?Q?=3D=3FUTF-8=3FQ=3FMicka=3Dc3=3Dabl=5FSala=3Dc3=3Dbcn=3F?=
         =?us-ascii?Q?=3D?= <mic@digikod.net>
Cc:     dhowells@redhat.com, Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?us-ascii?Q?=3D=3FUTF-8=3FQ=3FMicka=3Dc3=3Dabl?=
         =?us-ascii?Q?=5FSala=3Dc3=3Dbcn=3F=3D?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 0/9] Enable root to update the blacklist keyring
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 04 Dec 2020 14:01:36 +0000
Message-ID: <113544.1607090496@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wrote:

> > What would be easiest way to smoke test the changes?
>=20
> An easy way to test it is to enable the second trusted keyring to
> dynamically load certificates in the kernel. Then we can create a hash
> of a valid certificate (but not loaded yet) and sign it as explained in
> tools/certs/print-cert-tbs-hash.sh (patch 9/9). Once this hash is loaded
> in the kernel, loading the blacklisted certificate will be denied. We
> can also test it with a PKCS#7 signature chain, either with the
> blacklist keyring itself, or with a signed dm-verity image.

It might also be possible to use the pkcs#7 test key type
(CONFIG_PKCS7_TEST_KEY) to aid in that.

David

