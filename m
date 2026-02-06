Return-Path: <linux-integrity+bounces-8459-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE5zKyukhWmSEQQAu9opvQ
	(envelope-from <linux-integrity+bounces-8459-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Feb 2026 09:19:55 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29346FB65C
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Feb 2026 09:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E802303930A
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Feb 2026 08:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D58348463;
	Fri,  6 Feb 2026 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsT++EXP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BB23358C7
	for <linux-integrity@vger.kernel.org>; Fri,  6 Feb 2026 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770365959; cv=none; b=beYZgVhiGywpzOZAm1wVJy1aLAXevbuGX40iE+e1RZAv46LyrlockEsoSPJidV16sOo2+gfITGXjslP3sVC5sqSLDTCZN381v9AEIrAfgd532K+Pv7JqsMYX6lmdoaKrfhrYjf+q73//iWlInPhyQXazk01Dt3qR/iuTz7pTtIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770365959; c=relaxed/simple;
	bh=bCriBhlazS/0HXIrSjYBexp6X65YIc7sYJB9i7mUNXQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=rnTAOf3kITxZr/Vxn/7d3iB2nPamTgqbVM+7XstG4L4OAIqloLdZQubiVvH3XITLicp3H/nyd8Sbz4fpBknywTnrqGHLffjzTlahySS0HNEA+gj2+8YXtU4oEBrV7ja4wZW4gdHY7YBU2YXPbrE867zyPy9jqTXTdaoNd5XkV3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsT++EXP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770365958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCriBhlazS/0HXIrSjYBexp6X65YIc7sYJB9i7mUNXQ=;
	b=JsT++EXPU2VrOW4VemMXTcMdSxVJeIjXjSK/uQRHXozUAVDZEQ1dUY3HPXVOzADpFYKh6i
	o1ft6DgXWlH2j6EsQzHm2tXkpiTnPksxwcEacyX+7moL3bPGsEq8RwSoIO5wXOtJ1hkC48
	dXDA2iHGhzRxexmEJWQkqdUhSyYxE0A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516--zY-X-rwO-qBHh21bdBLDA-1; Fri,
 06 Feb 2026 03:19:15 -0500
X-MC-Unique: -zY-X-rwO-qBHh21bdBLDA-1
X-Mimecast-MFC-AGG-ID: -zY-X-rwO-qBHh21bdBLDA_1770365951
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABCD01956095;
	Fri,  6 Feb 2026 08:19:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.164])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C245A3000707;
	Fri,  6 Feb 2026 08:18:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260113-module-hashes-v4-5-0b932db9b56b@weissschuh.net>
References: <20260113-module-hashes-v4-5-0b932db9b56b@weissschuh.net> <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
To: =?us-ascii?Q?=3D=3Futf-8=3Fq=3FThomas=5FWei=3DC3=3D9Fschuh=3F=3D?= <linux@weissschuh.net>
Cc: dhowells@redhat.com, Nathan Chancellor <nathan@kernel.org>,
    Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
    Petr Pavlu <petr.pavlu@suse.com>,
    Sami Tolvanen <samitolvanen@google.com>,
    Daniel Gomez <da.gomez@samsung.com>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E.
 Hallyn" <serge@hallyn.com>,
    Jonathan Corbet <corbet@lwn.net>,
    Madhavan Srinivasan <maddy@linux.ibm.com>,
    Michael Ellerman <mpe@ellerman.id.au>,
    Nicholas Piggin <npiggin@gmail.com>,
    Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
    Roberto Sassu <roberto.sassu@huawei.com>,
    Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
    Eric Snowberg <eric.snowberg@oracle.com>,
    Nicolas Schier <nicolas.schier@linux.dev>,
    Daniel Gomez <da.gomez@kernel.org>,
    Aaron Tomlin <atomlin@atomlin.com>,
    "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>,
    Nicolas Schier <nsc@kernel.org>,
    Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
    Xiu Jianfeng <xiujianfeng@huawei.com>,
    Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
    Arnout Engelen <arnout@bzzt.net>,
    Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
    Christian Heusel <christian@heusel.eu>,
    =?utf-8?Q?C=C3=A2ju?= Mihai-Drosi <mcaju95@gmail.com>,
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
    linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
    linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
    linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 05/17] module: Switch load_info::len to size_t
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Feb 2026 08:18:53 +0000
Message-ID: <2919071.1770365933@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	TO_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8459-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,arndb.de,suse.com,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,warthog.procyon.org.uk:mid]
X-Rspamd-Queue-Id: 29346FB65C
X-Rspamd-Action: no action

Thomas Wei=C3=9Fschuh <linux@weissschuh.net> wrote:

> As both 'size_t' and 'unsigned int' are always the same size, this
> should be risk-free.

Did you mean 'unsigned long'?

David


