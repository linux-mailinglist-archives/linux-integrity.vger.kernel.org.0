Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A361C30A6B0
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 12:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBALhg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 06:37:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229596AbhBALhf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 06:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612179369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VTFNHmYMNxGpEuIhBb8TR1rvnZN6QF66geki9lSctnE=;
        b=S8ZeQHhbP5+auBTWeu/+MLlfprMaS3JRFvyZw4SxLNq/KE+3/ajlgBCWWkaKBFojgw995R
        832tBaSa+mRumBL4tqSmyupHq9zMusM8te35J3W2TolJjP/UwOsY1cEoBkV419tDUE/zAM
        YP/5mSkZqX4ZQAPBv8Aki8Bc/BU82Pc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-65b3QYUnN6WdbbNFkB38Fw-1; Mon, 01 Feb 2021 06:36:05 -0500
X-MC-Unique: 65b3QYUnN6WdbbNFkB38Fw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCE08801817;
        Mon,  1 Feb 2021 11:36:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D25303AE1;
        Mon,  1 Feb 2021 11:36:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de>
References: <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de> <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de> <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org> <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
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
Date:   Mon, 01 Feb 2021 11:36:01 +0000
Message-ID: <4153718.1612179361@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jan L=C3=BCbbe <jlu@pengutronix.de> wrote:

> ... But at this point, you can still do 'keyctl read' on that key, exposi=
ng
> the key material to user space.

I wonder if it would help to provide a keyctl function to mark a key as bei=
ng
permanently unreadable - so that it overrides the READ permission bit.

Alternatively, you can disable READ and SETATTR permission - but that then
prevents you from removing other perms if you want to :-/

David

