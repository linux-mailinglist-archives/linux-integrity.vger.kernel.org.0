Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAC6316A9F
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Feb 2021 17:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhBJQAS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 11:00:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59106 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232058AbhBJQAM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 11:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612972725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Hj2bYtLRiNywI9rFq4Gfg76I5Aktqh0moobf3YJXDo=;
        b=MXXlP/eulCpyZiabHCZJuHRYuSwtWOtMMO3a6v9JYfGYBQT/TD0/6AzfKt3e5jtF/aa/6b
        Q0XrBYNyQf8gnihzaikXll+7gO0zTgXIsoqUguZ6ii37w3HiJS76feR/M4l8oza+zfpu4H
        szNOFNCy/bEArF/jL91cpX0xXNVdojc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-9k_DJKzSPH6twxBmy9_7DA-1; Wed, 10 Feb 2021 10:58:41 -0500
X-MC-Unique: 9k_DJKzSPH6twxBmy9_7DA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFA7B107ACE4;
        Wed, 10 Feb 2021 15:58:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8483A72F80;
        Wed, 10 Feb 2021 15:58:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210127190617.17564-4-James.Bottomley@HansenPartnership.com>
References: <20210127190617.17564-4-James.Bottomley@HansenPartnership.com> <20210127190617.17564-1-James.Bottomley@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     dhowells@redhat.com, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v15 3/5] security: keys: trusted: fix TPM2 authorizations
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1327392.1612972717.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 10 Feb 2021 15:58:37 +0000
Message-ID: <1327393.1612972717@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> keyctl add trusted kmk "new 32 blobauth=3Df572d396fae9206628714fb2ce00f7=
2e94f2258fkeyhandle=3D81000001" @u

I presume there should be a space in there?

David

