Return-Path: <linux-integrity+bounces-8300-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF9EOEmzc2liyAAAu9opvQ
	(envelope-from <linux-integrity+bounces-8300-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jan 2026 18:43:37 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 229EC79256
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jan 2026 18:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF01630080B2
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jan 2026 17:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF1D28C2A1;
	Fri, 23 Jan 2026 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGr7JoEU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E3827EFEE
	for <linux-integrity@vger.kernel.org>; Fri, 23 Jan 2026 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190209; cv=none; b=nWUv2TSbxQ+30102WHFi2bqzfoBKQZtG56JvVtmVxHAyZAtwxXd3cAa93+HCH+b6GsZCc5siGGdBmr1X30rR/pQApMQrEi3iOsAK0f02GSnLSeLueb173+C1ll7XFGwRWX5KBEYXvlQwoSRBqq5jOIYNp/r9yixlMXhboitxHPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190209; c=relaxed/simple;
	bh=kT+Pn3gyhaoNqIWv1mtrMDHTRArFu/zsHuhePGBpLPs=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=MhlAxpNTdcegKfxCc4G1NCfDr5qZcho7vPvDy9nB6rmWDVlmpD3K+FUr2o8AgAaQhjyrqXTIpW/dOT5IHi64E9KeoFdfSeCsuK0K7DMY1vmPpOxPpofaxTQYpEqMHNceVLhrJePQ0KjyJXmHclC4JFSWz6JM6044gyv/mkch1BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGr7JoEU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769190207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HXWgAtc6UurHJ7v7o10vNJH+C+IF5KjA0KAPDFaMV1I=;
	b=TGr7JoEUDn3a8IvIw/RA9lMMwp6cLXJQJSKncxUaUqZ/RVDOdJWhHMaajwPJ0RvfJF1wLr
	bjLkXp8S6hTPO61MlF2otu3V8QwD4tWrkJOgFQeAHpc7TtrIbtqdseYoq2QtSjfKSkQHVm
	YRQVGqXML8O93tOpb3feT0hW9Alop8c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-wrds9M3_M2qiXpued7TKRg-1; Fri,
 23 Jan 2026 12:43:23 -0500
X-MC-Unique: wrds9M3_M2qiXpued7TKRg-1
X-Mimecast-MFC-AGG-ID: wrds9M3_M2qiXpued7TKRg_1769190202
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D1E41800378;
	Fri, 23 Jan 2026 17:43:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95809180099B;
	Fri, 23 Jan 2026 17:43:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
cc: dhowells@redhat.com, Simo Sorce <simo@redhat.com>,
    Roberto Sassu <roberto.sassu@huawei.com>,
    Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
    Eric Snowberg <eric.snowberg@oracle.com>,
    Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
    linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
    linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: IMA and PQC
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1783974.1769190197.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Jan 2026 17:43:17 +0000
Message-ID: <1783975.1769190197@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,huawei.com,gmail.com,oracle.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8300-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[warthog.procyon.org.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 229EC79256
X-Rspamd-Action: no action

Hi Mimi,

I've posted patches which I hope will accepted to implement ML-DSA module
signing:

	https://lore.kernel.org/linux-crypto/1753972.1769166821@warthog.procyon.o=
rg.uk/T/#t

but for the moment, it will give an error to pkcs7_get_digest() if there's=
 no
digest available (which there won't be with ML-DSA).  This means that ther=
e
isn't a hash for IMA to get at for TPM measurement.

Now, I probably have to make a SHA256 hash anyway for UEFI blacklisting
purposes, so that could be used.  Alternatively, we can require the use of
authenticatedAttributes/signedAttrs and give you the hash of that - but th=
en
you're a bit at the mercy of whatever hashes were used.

Further, we need to think how we're going to do PQC support in IMA -
particularly as the signatures are so much bigger and verification slower.

Would ML-DSA-44 be acceptable?  Should we grab some internal state out of
ML-DSA to use in lieu of a hash?

David


