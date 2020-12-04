Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44F82CEF5E
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 15:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgLDOHd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 09:07:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726775AbgLDOHd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 09:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607090767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2eQ95q8WyeD3Z8w3NMzomvxnqLrwKfurRNLB8W3+XdA=;
        b=gM9yTQ+w4mFX11Hr63d2k3SHrnhYmca5jSxZHLnoJgXVHvwPFnYXIYPl8bL4HPEPlk5pZS
        azudmmpWoiEVclRtbDlS+ieJbd0gUaA6jThJlOQKJEvy3gpBidmFtCRIZJid7fVwFXSetH
        vj+KWVxHsFZPrmJc3L5wAdIod9UCL4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-kbXB9TJ4NViVn0B_D_Ugog-1; Fri, 04 Dec 2020 09:06:05 -0500
X-MC-Unique: kbXB9TJ4NViVn0B_D_Ugog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C7D21005513;
        Fri,  4 Dec 2020 14:06:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FBB860C15;
        Fri,  4 Dec 2020 14:06:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201120180426.922572-2-mic@digikod.net>
References: <20201120180426.922572-2-mic@digikod.net> <20201120180426.922572-1-mic@digikod.net>
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
Subject: Re: [PATCH v1 1/9] certs: Fix blacklisted hexadecimal hash string check
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 04 Dec 2020 14:05:59 +0000
Message-ID: <113785.1607090759@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wrote:

> When looking for a blacklisted hash, bin2hex() is used to transform a
> binary hash to an ascii (lowercase) hexadecimal string.  This string is
> then search for in the description of the keys from the blacklist
> keyring.  When adding a key to the blacklist keyring,
> blacklist_vet_description() checks the hash prefix and the hexadecimal
> string, but not that this string is lowercase.  It is then valid to set
> hashes with uppercase hexadecimal, which will be silently ignored by the
> kernel.
>=20
> Add an additional check to blacklist_vet_description() to check that
> hexadecimal strings are in lowercase.

I wonder if it would be a better idea to allow the keyring type to adjust t=
he
description string - in this instance to change it to all lowercase.

David

