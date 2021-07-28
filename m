Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A873D9792
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 23:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhG1VeD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 17:34:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45655 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231665AbhG1VeD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 17:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627508040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WNZBj5MKnVmlpn9dEuqf6VhmlsMwQlSTVEvd+hOrbZ8=;
        b=KoImWpvlOSkhx9hC3FtOf1FXFzKDCkKdFKrkxMPqYz/lut4TC4jDTDUVcvTY/OPKDQ7Naa
        IbsGwRYz9iaqft2QzwUtjBOgxpfppae31p2vLrQU57smwZpz+l3XpAvm9D6mQEdDmRGx5k
        9IdcUhxft72pgGNXTxoVtmrV1+7A2Ds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-y8J8c3SEM0ap7pgETk4_CA-1; Wed, 28 Jul 2021 17:33:59 -0400
X-MC-Unique: y8J8c3SEM0ap7pgETk4_CA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E2C81006C80;
        Wed, 28 Jul 2021 21:33:58 +0000 (UTC)
Received: from agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (agk-cloud1.hosts.prod.upshift.rdu2.redhat.com [10.0.13.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8171A60875;
        Wed, 28 Jul 2021 21:33:48 +0000 (UTC)
Received: by agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (Postfix, from userid 3883)
        id E1D9540B6597; Wed, 28 Jul 2021 22:33:50 +0100 (BST)
Date:   Wed, 28 Jul 2021 22:33:50 +0100
From:   Alasdair G Kergon <agk@redhat.com>
To:     Thore Sommer <public@thson.de>
Cc:     tusharsu@linux.microsoft.com, agk@redhat.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, nramas@linux.microsoft.com,
        snitzer@redhat.com, zohar@linux.ibm.com
Subject: Re: [dm-devel] [PATCH 0/7] device mapper target measurements using
 IMA
Message-ID: <20210728213350.GA115575@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
Mail-Followup-To: Thore Sommer <public@thson.de>,
        tusharsu@linux.microsoft.com, agk@redhat.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, nramas@linux.microsoft.com,
        snitzer@redhat.com, zohar@linux.ibm.com
References: <c833339e-c4bf-6e78-5719-cd902fa8426f@linux.microsoft.com>
 <20210727101802.779067-1-public@thson.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727101802.779067-1-public@thson.de>
Organization: Red Hat UK Ltd. Registered in England and Wales, number
 03798903. Registered Office: Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 27, 2021 at 12:18:02PM +0200, Thore Sommer wrote:
> How is the measured uuid created? The format seems to be
> "CRYPT-VERITY-UUID-NAME" where UUID is uuid from the verity device and NAME is
> the device mapper name. Does this naming come from the kernel or libcryptsetup?

See libdevmapper.h:
/*
 * Configure default UUID prefix string.
 * Conventionally this is a short capitalised prefix indicating the subsystem
 * that is managing the devices, e.g. "LVM-" or "MPATH-".
 * To support stacks of devices from different subsystems, recursive functions
 * stop recursing if they reach a device with a different prefix.
 */
int dm_set_uuid_prefix(const char *uuid_prefix);


Each device-mapper device may have a uuid of up to 128 characters plus
trailing NUL.  Whichever piece software activates the device assigns the
uuid (so userspace or kernel boot parameters).  By convention each such
piece of software uses a short prefix ending with a hyphen that
identifies that software as the "owner" (manager) of that dm device.
This means each piece of software can easily filter out the devices for
which it is responsible and ignore all the others etc.  It can use the
remainder of the UUID to identify the device uniquely to itself.
Another convention is that when one device is a 'wrapper' of some sort
around another, it may create the uuid by adding its prefix to the uuid
of the device it is wrapping - this might give you stacked prefixes.
When there's a complex one-composed-from-many device structure, suffices
may be used to identify the components.

Think of the 'name' as the human-friendly device name and the uuid as
a software-friendly internal name.

Alasdair

