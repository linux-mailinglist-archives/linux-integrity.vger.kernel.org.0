Return-Path: <linux-integrity+bounces-8372-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ9GMeC7fGlVOgIAu9opvQ
	(envelope-from <linux-integrity+bounces-8372-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 15:10:40 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB040BB757
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 15:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC53E300B44D
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 14:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1969E319860;
	Fri, 30 Jan 2026 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PE+kKaJB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7003A2DFA5A
	for <linux-integrity@vger.kernel.org>; Fri, 30 Jan 2026 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769782236; cv=none; b=aq9MZhhQt4iZbPu1/dzoFpaGqYEhT8x/o+VEbnGVnEpN6EW3SoQ/ZX1fczLvwikFi0EaAfZr91ssu56jFyYQ/5UzW3ZpChpFpMYw9NcKtYd6I4P2jTmXiGxj5hVLAkkdLx+PbkCHA603LWTiiGoVxw5R1zw7bek/eP+DB8Fkmi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769782236; c=relaxed/simple;
	bh=rmhZ5sOTwbtWVJbmT/uMxFq2nJwHusyhn+cZ3ChqXsU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=kVDDS1Ba9zq/ZPWSTJQXF2Q32Vby29SXqUB9RfbzAeYtBSVU0ZYPnUGoLWqyeLDxk252d/WMCSQwc9KV7PLeGYGymUGZFkci/m5uMgQILl5SYUKCHK+HjiuuQVZr6hAvzLx/v3lkoov7Wraezy8pzz01Oo3wFWHEIG6IS89eVow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PE+kKaJB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769782233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rmhZ5sOTwbtWVJbmT/uMxFq2nJwHusyhn+cZ3ChqXsU=;
	b=PE+kKaJBUbCFBQ8wGgc3qS/1wjiWLpAbS8K5I/7YOpVOpvG0uXOslvtV0Tbyl2dXG+oAfn
	tqszidJ5PqKaNmaLFcGpoycRdYZkYu7642EH+G41M6WdRLrebH/IPNJg0+SsIVRfdz5VPZ
	OJBCpTTElb20Vq7f/lJ2e9YIWkm0P4Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-g_mBxJh8MMqC7doZp1gvbg-1; Fri,
 30 Jan 2026 09:10:30 -0500
X-MC-Unique: g_mBxJh8MMqC7doZp1gvbg-1
X-Mimecast-MFC-AGG-ID: g_mBxJh8MMqC7doZp1gvbg_1769782228
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B5EC1956095;
	Fri, 30 Jan 2026 14:10:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.164])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0CF3319560A2;
	Fri, 30 Jan 2026 14:10:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aXrKaTem9nnWNuGV@Rk>
References: <aXrKaTem9nnWNuGV@Rk> <1783975.1769190197@warthog.procyon.org.uk>
To: Coiby Xu <coxu@redhat.com>
Cc: dhowells@redhat.com, Mimi Zohar <zohar@linux.ibm.com>,
    Simo Sorce <simo@redhat.com>,
    Roberto Sassu <roberto.sassu@huawei.com>,
    Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
    Eric Snowberg <eric.snowberg@oracle.com>,
    Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
    linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
    linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: IMA and PQC
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2265996.1769782221.1@warthog.procyon.org.uk>
Date: Fri, 30 Jan 2026 14:10:21 +0000
Message-ID: <2265997.1769782221@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8372-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB040BB757
X-Rspamd-Action: no action

Coiby Xu <coxu@redhat.com> wrote:

> Take latest fresh CentOS Stream 10 x86_64 KVM guest as example, without any
> file system optimization, extra ~189MB disk space is needed if all files in
> /usr signed using by ML-DSA-65 where the disk size is 50G.

Is that storing raw signatures rather than PKCS#7 wrapped signatures?

David


