Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B7830AD5D
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 18:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhBARF4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 12:05:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230298AbhBARFz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 12:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612199069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rH9wytnzyB+U91tV+Pg1sRMVmzeBVEAmUAO/MwEXhFQ=;
        b=CaNQIpBMaDmjCSgN3IGTJF7ljwm38aceF+dgL5rrBn2bPdKWDnqPEF62fMLE0Eq2VPZ006
        /PLTeEIhMono2rO8i2eoMZYackDFAPC/r77SW8A1yD8cAredfEA4LzpTmaj/koFeTmoWf1
        /4236NplIN0o73zdIWtQEWnDTFafMc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-g-a_wvW3N6WhlKwRHXdFGg-1; Mon, 01 Feb 2021 12:04:27 -0500
X-MC-Unique: g-a_wvW3N6WhlKwRHXdFGg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CCAF10054FF;
        Mon,  1 Feb 2021 17:04:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E0855C1A1;
        Mon,  1 Feb 2021 17:04:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <6b362abd95b116e26c65809a3a1525c7951ed0bd.camel@pengutronix.de>
References: <6b362abd95b116e26c65809a3a1525c7951ed0bd.camel@pengutronix.de> <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de> <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de> <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org> <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com> <4153718.1612179361@warthog.procyon.org.uk>
To:     Jan =?us-ascii?Q?=3D=3FISO-8859-1=3FQ=3FL=3DFCbbe=3F=3D?= 
        <jlu@pengutronix.de>
Cc:     dhowells@redhat.com, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>, keyrings@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel@pengutronix.de
Subject: Re: Migration to trusted keys: sealing user-provided key?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 01 Feb 2021 17:04:22 +0000
Message-ID: <35960.1612199062@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jan L=C3=BCbbe <jlu@pengutronix.de> wrote:

> > > ... But at this point, you can still do 'keyctl read' on that key, ex=
posing
> > > the key material to user space.
> >=20
> > I wonder if it would help to provide a keyctl function to mark a key as=
 being
> > permanently unreadable - so that it overrides the READ permission bit.
> >=20
> > Alternatively, you can disable READ and SETATTR permission - but that t=
hen
> > prevents you from removing other perms if you want to :-/
>=20
> That would mean using user type keys, right? Then we'd still have the core
> problem how a master key can be protected against simply reading it from
> flash/disk, as it would be unencrypted in this scenario.

It would apply to any type of key or keyring on which it was set.  It would
cause keyctl_read() on a flagged key to return EPERM.

David

