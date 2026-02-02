Return-Path: <linux-integrity+bounces-8402-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAFgAXVtgGl38AIAu9opvQ
	(envelope-from <linux-integrity+bounces-8402-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Feb 2026 10:25:09 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A013CA16D
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Feb 2026 10:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E0EA301AD07
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Feb 2026 09:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40292C21F7;
	Mon,  2 Feb 2026 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JclSRvyg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FBB2D2488
	for <linux-integrity@vger.kernel.org>; Mon,  2 Feb 2026 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770024111; cv=none; b=O21c9viQTjoyvj7ceSQ+4K1NLi3LAOvtm7lve6G+OzUzBiXUbvaiYfOEUMkEn8Rx3j767LROMRYE0hImh4oM6zFx2JDAN71gqDWnpa2rWmGkChietg7d7MLnfar0ORBmSD04cSZHTlNqDnm5ag17q+GKkWrCU8tpqmy+eg7i1Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770024111; c=relaxed/simple;
	bh=bwnBNgHbFIW/GKpzdSfu0j1YrOO311FSebJ7+HObXGE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=af67lw1fszpAbj+ATwq5UQA3xOzOProSZtuLTTu6VpMa5hM1+7ZcoEdWxT3qi1plHMoMY4M1fWf9n65HpwqF60KE+YgxBCm/NsAbOhHtC3Vc4XXDXTWedBKAO2PtKB+yhHkkr687+6j1+SDmN/m580YO7QzBORQNpSw9uKGQo7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JclSRvyg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770024109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5lbDw7o/RaxnPFlRJ1INa0R+IZJyXDgWQKuA97onDkQ=;
	b=JclSRvygeWEw5b74C3R1wQwVcZm0FD0rq44itbAsTbripE8sDMTMiCMeXUZLy+JbHq1Ki2
	cDxAYP8e6kLoEwao5I9YK3wo6Rb2pne17J1BVpwjLRoQgTKchE26Bc4/JGAFTrvHlyk6OR
	t/RhrFDDjeKlMvKo+hZUnK3xfuzBMc4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-vRYKonroPPacvPvXG9Mi7g-1; Mon,
 02 Feb 2026 04:21:43 -0500
X-MC-Unique: vRYKonroPPacvPvXG9Mi7g-1
X-Mimecast-MFC-AGG-ID: vRYKonroPPacvPvXG9Mi7g_1770024097
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 468A818002CE;
	Mon,  2 Feb 2026 09:21:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.164])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77AA43001DB7;
	Mon,  2 Feb 2026 09:21:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260201201218.GA15755@quark>
References: <20260201201218.GA15755@quark> <20260131073636.65494-1-mcaju95@gmail.com> <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net> <2316630.1769965788@warthog.procyon.org.uk>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com,
    =?us-ascii?B?PT9VVEYtOD9xP01paGFpLURyb3NpPTIwQz1DMz1BMmp1Pz0=?= <mcaju95@gmail.com>,
    linux@weissschuh.net, arnd@arndb.de, arnout@bzzt.net,
    atomlin@atomlin.com, bigeasy@linutronix.de, chleroy@kernel.org,
    christian@heusel.eu, corbet@lwn.net, coxu@redhat.com,
    da.gomez@kernel.org, da.gomez@samsung.com, dmitry.kasatkin@gmail.com,
    eric.snowberg@oracle.com, f.gruenbichler@proxmox.com,
    jmorris@namei.org, kpcyrd@archlinux.org, linux-arch@vger.kernel.org,
    linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
    linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org,
    linuxppc-dev@lists.ozlabs.org, lkp@intel.com, maddy@linux.ibm.com,
    mattia@mapreri.org, mcgrof@kernel.org, mpe@ellerman.id.au,
    nathan@kernel.org, naveen@kernel.org,
    nicolas.bouchinet@oss.cyber.gouv.fr, nicolas.schier@linux.dev,
    npiggin@gmail.com, nsc@kernel.org, paul@paul-moore.com,
    petr.pavlu@suse.com, roberto.sassu@huawei.com,
    samitolvanen@google.com, serge@hallyn.com, xiujianfeng@huawei.com,
    zohar@linux.ibm.com
Subject: Re: [PATCH v4 00/17] module: Introduce hash-based integrity checking
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2339368.1770024079.1@warthog.procyon.org.uk>
Date: Mon, 02 Feb 2026 09:21:19 +0000
Message-ID: <2339369.1770024079@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,weissschuh.net,arndb.de,bzzt.net,atomlin.com,linutronix.de,kernel.org,heusel.eu,lwn.net,samsung.com,oracle.com,proxmox.com,namei.org,archlinux.org,vger.kernel.org,lists.ozlabs.org,intel.com,linux.ibm.com,mapreri.org,ellerman.id.au,oss.cyber.gouv.fr,linux.dev,paul-moore.com,suse.com,huawei.com,google.com,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-8402-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[45];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[warthog.procyon.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A013CA16D
X-Rspamd-Action: no action

Eric Biggers <ebiggers@kernel.org> wrote:

> With that being the case, why is there still effort being put into
> adding more features to module signing?  I would think efforts should be
> focused on hash-based module authentication, i.e. this patchset.

Because it's not just signing of modules and it's not just modules built with
the kernel.  Also a hash table just of module hashes built into the core
kernel image will increase the size of the kernel by around a third of a meg
(on Fedora 43 and assuming SHA512) with uncompressible data.

David


