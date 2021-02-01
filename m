Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CEE30AD72
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 18:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhBARKN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 12:10:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230110AbhBARKM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 12:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612199320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pW3FtlUJS2fN56E7BRK6xYg8pzPm9uc4qoRwK8ELBPM=;
        b=cPwkdBFDaH55ywT2wjtZFFGQ2M5CK8wcqzHVS1sFQDKe033kOQdkofM/pOpzE+hbR8Iuej
        RISyy+uY3hAGq19KEwF+Bpsk2CHPiqNfie9qMwxUSUxoCwdD/X3iv02OfzmhTTbHtnzwv6
        L5OhdL23RLMTM27DUkAI3jsAFCDNkJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-n5sR1x5xMNSY4bwcGtO9dA-1; Mon, 01 Feb 2021 12:08:36 -0500
X-MC-Unique: n5sR1x5xMNSY4bwcGtO9dA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B36B801B1D;
        Mon,  1 Feb 2021 17:08:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A2B960C7A;
        Mon,  1 Feb 2021 17:08:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <702232df-e229-a716-b688-918fe7e168e8@digikod.net>
References: <702232df-e229-a716-b688-918fe7e168e8@digikod.net> <20210128191705.3568820-1-mic@digikod.net> <4160652.1612184844@warthog.procyon.org.uk> <9d95ec74-cc89-9e0c-dac8-c05ea52991ac@digikod.net>
To:     =?us-ascii?Q?=3D=3FUTF-8=3FQ=3FMicka=3Dc3=3Dabl=5FSala=3Dc3=3Dbcn=3F?=
         =?us-ascii?Q?=3D?= <mic@digikod.net>
Cc:     dhowells@redhat.com, David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?us-ascii?Q?=3D=3FUTF-8=3FQ=3FMicka=3Dc3=3Dabl?=
         =?us-ascii?Q?=5FSala=3Dc3=3Dbcn=3F=3D?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Enable root to update the blacklist keyring
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 01 Feb 2021 17:08:30 +0000
Message-ID: <36340.1612199310@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wrote:

> It doesn't contain Jarkko's Tested-by and Reviewed-by tags though.

I can add that in the merge.

David

