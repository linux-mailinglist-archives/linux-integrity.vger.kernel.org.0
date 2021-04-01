Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0434351456
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Apr 2021 13:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhDALMW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Apr 2021 07:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234335AbhDALLw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Apr 2021 07:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617275511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJkEd7cUvYTeRV/iEXpdtoXis6pieALRjw6SuJS8/i8=;
        b=aiZ3XVP7mlQUNMJy6r6uJV8LRvy40k/3M8dow2jH8JutMaKNUEat4hV43YsOZtGgyoxw52
        uSFrE6YSU8PdNvOP/6+ta6n0ZU0mkRym3+4KJy3+3WpO1IcKMc1cgIr3plrwkiTLOIHu+k
        x25FQylIjbXUP/k9sm3bu8bbe1LQQb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-IzKQ3i9nNnm-EJNdcp740A-1; Thu, 01 Apr 2021 07:11:46 -0400
X-MC-Unique: IzKQ3i9nNnm-EJNdcp740A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 984C6107ACCA;
        Thu,  1 Apr 2021 11:11:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39BBD5D9CA;
        Thu,  1 Apr 2021 11:11:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAFLxGvwNomKOo3mQLMxYGDA8T8zN=Szpo2q5jrp4D1CaMHydWA@mail.gmail.com>
References: <CAFLxGvwNomKOo3mQLMxYGDA8T8zN=Szpo2q5jrp4D1CaMHydWA@mail.gmail.com> <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de> <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com> <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     dhowells@redhat.com, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>, kernel@pengutronix.de,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3714193.1617275498.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 01 Apr 2021 12:11:38 +0100
Message-ID: <3714194.1617275498@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Richard Weinberger <richard.weinberger@gmail.com> wrote:

> On Wed, Mar 17, 2021 at 3:08 PM Ahmad Fatoum <a.fatoum@pengutronix.de> w=
rote:
> >     keyctl add trusted $KEYNAME "load $(cat ~/kmk.blob)" @s
>
> Is there a reason why we can't pass the desired backend name in the
> trusted key parameters?
> e.g.
> keyctl add trusted $KEYNAME "backendtype caam load $(cat ~/kmk.blob)" @s

I wonder...  Does it make sense to add a new variant of the add_key() and
keyctl_instantiate() syscalls that takes an additional parameter string,
separate from the payload blob?

       key_serial_t add_key2(const char *type, const char *description,
			     const char *params,
                             const void *payload, size_t plen,
                             key_serial_t keyring);

which could then by used, say:

	keyctl add --payload=3D~/kmk.blob trusted $KEYNAME "backendtype caam load=
" @s

This would then appear in

	struct key_preparsed_payload {
		const char	*orig_description;
		char		*description;
		char		*params;	<---
		union key_payload payload;
		const void	*data;
		size_t		datalen;
		size_t		quotalen;
		time64_t	expiry;
	};

params would then be NULL for add_key().

If add_key2() is not available, the --payload param gets concatenated to t=
he
parameters string.

Might be too complicated, I guess.  Though it might make sense just to do =
the
concatenation inside the keyctl program.

David

