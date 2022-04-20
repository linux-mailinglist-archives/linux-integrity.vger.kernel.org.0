Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DAD50864C
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 12:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377791AbiDTKux (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 06:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377790AbiDTKuw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 06:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1160D13F42
        for <linux-integrity@vger.kernel.org>; Wed, 20 Apr 2022 03:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650451686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YeuUl3FgKBq3ulAiRQVIkPodY1d8UaUkeElFnx59KAU=;
        b=gQr34vT4SzzYOGs7zRfjNe1u5QssmTlwYKCjWn0UwBGIZl+FXVqdRVeYFHaEcp/SHYf00S
        mGDwB8O3Ewi9QXYh1VTVaEzS0ZSjFA4+mOu6SWTUO87xcXU+FSjsgx+MLFr9KoBfMvo41+
        bSnZhnRAT4lqNQxwOFU33C413qkatzs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-CZ15ePgHOjCgsVQ2kn_MbA-1; Wed, 20 Apr 2022 06:48:01 -0400
X-MC-Unique: CZ15ePgHOjCgsVQ2kn_MbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 731AD80346F;
        Wed, 20 Apr 2022 10:48:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24E4C403D19A;
        Wed, 20 Apr 2022 10:47:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Yl95wykQMHc/tIq8@kernel.org>
References: <Yl95wykQMHc/tIq8@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, James Morris <jmorris@namei.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?us-ascii?Q?=3D=3Fiso-8859-1=3FQ=3FMicka=3DEBl?=
         =?us-ascii?Q?=5FSala=3DFCn=3F=3D?= <mic@linux.microsoft.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER updates for tpmdd-next-v5.18-rc4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 20 Apr 2022 11:47:58 +0100
Message-ID: <649342.1650451678@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> Micka=C3=ABl's patches to add signed hash to the blacklist keyring that w=
ere
> left out from the original v5.18 PR. They should be safe to include to
> rc4 as they've been in circulation for ages, and have been tested
> throughly.

Barring a bit in patch 3 where I think strncmp() would be better employed f=
or
checking prefixes (and can be fixed up later):

Reviewed-by: David Howells <dhowells@redhat.com>

