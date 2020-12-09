Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D787B2D4196
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Dec 2020 13:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgLIMAU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Dec 2020 07:00:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730957AbgLIMAJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Dec 2020 07:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607515123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/OLi6xw6A05rVF+FY+DCz7u5b/15LezMPYjls9q2mPE=;
        b=UaHMZcqNM8GVl+b7AfaWaYTaqDyBD9L8FkOKZM6byZ9Bf7zSZa+zlsQB37V261+Ewr/B09
        twCVSFY+qcijJUPge+sYhuGyePmTErTxYcSuZ0adnW5Hhs/Nx9eX23Y0pZNOZVffgm+yxp
        uGXkh9FDaS+dKma+4MR3kZvImh7UBFk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-B7C-5k_CNgGhnwgKwhTXzg-1; Wed, 09 Dec 2020 06:58:39 -0500
X-MC-Unique: B7C-5k_CNgGhnwgKwhTXzg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A43F4612A2;
        Wed,  9 Dec 2020 11:58:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C798919C78;
        Wed,  9 Dec 2020 11:58:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201120180426.922572-5-mic@digikod.net>
References: <20201120180426.922572-5-mic@digikod.net> <20201120180426.922572-1-mic@digikod.net>
To:     =?us-ascii?Q?=3D=3FUTF-8=3Fq=3FMicka=3DC3=3DABl=3D20Sala=3DC3=3DBCn=3F?=
         =?us-ascii?Q?=3D?= <mic@digikod.net>
Cc:     dhowells@redhat.com, David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?us-ascii?Q?=3D=3FUTF-8=3Fq=3FMicka=3DC3=3DABl?=
         =?us-ascii?Q?=3D20Sala=3DC3=3DBCn=3F=3D?= 
        <mic@linux.microsoft.com>, Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 4/9] certs: Check that builtin blacklist hashes are valid
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 09 Dec 2020 11:58:31 +0000
Message-ID: <1221725.1607515111@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wrote:

> +      cmd_check_blacklist_hashes =3D $(AWK) -f scripts/check-blacklist-h=
ashes.awk $(2); touch $@

The script name needs prefixing with $(srctree)/ so that it can be used with
alternative build directories.

Note that doesn't apply to scripts/extract-cert in the same makefile as tha=
t's
a built program and is to be found in the build dir, not the sources.

Btw, I'm pulling some of your cleanups/fixes into my fixes branch.

David

