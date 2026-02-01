Return-Path: <linux-integrity+bounces-8397-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCKTGQKJf2mptAIAu9opvQ
	(envelope-from <linux-integrity+bounces-8397-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Feb 2026 18:10:26 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A64BC69F4
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Feb 2026 18:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB7833001CC0
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Feb 2026 17:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796A027B348;
	Sun,  1 Feb 2026 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cxievbm/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CEE274B5C
	for <linux-integrity@vger.kernel.org>; Sun,  1 Feb 2026 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769965819; cv=none; b=J+UMtv+9gR/TdSddn6mBJWc6F7JKUfY6Nw+NM48q1PiV9ywoOvZ+EBi39bB0foF0qS1Z2zAlOxqPTVcHv6lAwvFex6JoSXM5PsN2LyuRL1JB80GY7iR+paoepv9JFsKpyKZ9sgvfTgvVX2weXPadAeMPdmjipntD6JEchizeWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769965819; c=relaxed/simple;
	bh=l1Wbi14WkrPKE6m94OU3++sRcIxnpCP514pJT2bxYMQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=D5D1zaI6lAHxyBP8e6zObY/jMMT37nJNyXSTRIEFtT8lfT2BZ3p5/Fhcb5n0m990G/hzVu3pi42cdyqhDRaCzfuX8b6nnHYzVsBuUwLtQbPbDfc091ZvijPHqNjDoDs5rAOOkh/rm+DrgeuwjWKpiJXPgcPhTHK+FUamfYZHAOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cxievbm/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769965817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXzGf8dg7zdwjSpH9NQ85FkESCYj8y44yqTfJ6FGfkQ=;
	b=Cxievbm/9L3y0fPhfQsugjyYs+9a1OhKAZQDiksrVRfDtB/5XJbNMQeSvQySx+Rpy+d3QN
	u01eD5SykEE9EE8NlQI9wYWmX0xBijz9lXCXtGJqKaO9ubOKfSQeWeUTII1JVvVKXUqmeJ
	pN+ic6i9IaslbC6q1C+c+7yiFuProWg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-oQw7rZraM7KagOwiXj8BJg-1; Sun,
 01 Feb 2026 12:10:11 -0500
X-MC-Unique: oQw7rZraM7KagOwiXj8BJg-1
X-Mimecast-MFC-AGG-ID: oQw7rZraM7KagOwiXj8BJg_1769965807
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99D621956066;
	Sun,  1 Feb 2026 17:10:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.164])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D41A18004D8;
	Sun,  1 Feb 2026 17:09:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260131073636.65494-1-mcaju95@gmail.com>
References: <20260131073636.65494-1-mcaju95@gmail.com> <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
To: =?us-ascii?Q?=3D=3FUTF-8=3Fq=3FMihai-Drosi=3D20C=3DC3=3DA2ju=3F=3D?= <mcaju95@gmail.com>
Cc: dhowells@redhat.com, linux@weissschuh.net, arnd@arndb.de,
    arnout@bzzt.net, atomlin@atomlin.com, bigeasy@linutronix.de,
    chleroy@kernel.org, christian@heusel.eu, corbet@lwn.net,
    coxu@redhat.com, da.gomez@kernel.org, da.gomez@samsung.com,
    dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
    f.gruenbichler@proxmox.com, jmorris@namei.org, kpcyrd@archlinux.org,
    linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
    linux-integrity@vger.kernel.org, linux-kbuild@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
    linux-security-module@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
    lkp@intel.com, maddy@linux.ibm.com, mattia@mapreri.org,
    mcgrof@kernel.org, mpe@ellerman.id.au, nathan@kernel.org,
    naveen@kernel.org, nicolas.bouchinet@oss.cyber.gouv.fr,
    nicolas.schier@linux.dev, npiggin@gmail.com, nsc@kernel.org,
    paul@paul-moore.com, petr.pavlu@suse.com, roberto.sassu@huawei.com,
    samitolvanen@google.com, serge@hallyn.com, xiujianfeng@huawei.com,
    zohar@linux.ibm.com
Subject: Re: [PATCH v4 00/17] module: Introduce hash-based integrity checking
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Feb 2026 17:09:48 +0000
Message-ID: <2316630.1769965788@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	TO_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8397-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,weissschuh.net,arndb.de,bzzt.net,atomlin.com,linutronix.de,kernel.org,heusel.eu,lwn.net,samsung.com,gmail.com,oracle.com,proxmox.com,namei.org,archlinux.org,vger.kernel.org,lists.ozlabs.org,intel.com,linux.ibm.com,mapreri.org,ellerman.id.au,oss.cyber.gouv.fr,linux.dev,paul-moore.com,suse.com,huawei.com,google.com,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[warthog.procyon.org.uk:mid]
X-Rspamd-Queue-Id: 7A64BC69F4
X-Rspamd-Action: no action

Mihai-Drosi C=C3=A2ju <mcaju95@gmail.com> wrote:

> > The current signature-based module integrity checking has some drawbacks
> in combination with reproducible builds. Either the module signing key
> is generated at build time, which makes the build unreproducible, or a
> static signing key is used, which precludes rebuilds by third parties
> and makes the whole build and packaging process much more complicated.

There is another issue too: If you have a static private key that you use to
sign modules (and probably other things), someone will likely give you a GPL
request to get it.

One advantage of using a transient key every build and deleting it after is
that no one has the key.

One other thing to remember: security is *meant* to get in the way.  That's
the whole point of it.

However, IANAL.

David


