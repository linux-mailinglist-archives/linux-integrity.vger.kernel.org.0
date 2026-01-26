Return-Path: <linux-integrity+bounces-8323-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLFDKKLed2n1mAEAu9opvQ
	(envelope-from <linux-integrity+bounces-8323-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jan 2026 22:37:38 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEA58DA9E
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jan 2026 22:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FBFE3024A51
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jan 2026 21:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E632E7167;
	Mon, 26 Jan 2026 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyJcrakV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454D82E62A4
	for <linux-integrity@vger.kernel.org>; Mon, 26 Jan 2026 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769463432; cv=none; b=kDrJDdJh4GpsiE8sQGNAaSgPNVempalOr5gBnakHX0WYgvBZmGWE9PXkhpy2/sVFHm848Rxmz1XmXZJbaR1Sd7Kvxlj1cl+nxcTJMEalpAPDwm3P+eHRUxyd7mM7rf32clG1y2mE4UEnHUT91TIomeXKepZ210lnLR8bwO0HkcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769463432; c=relaxed/simple;
	bh=0hWe7eQ4HIAf6/j5HOv37+1vd+FYqSwe0P+LEC7HsfQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=X1rAcbQkkxmk6oVua6iPYqTZluxmm+JyOS4wrQHbehy0wdr05KMnTUuUopbYYdldq3vqUg0nOCEoJmJ9bF/oZiWbf6JpsmRbh3XidYL0KS0m2w6Fnlx4KFgZAVXfMS1XQqgBKny/9rzAEsVYrd3Alhvrk4Ixbe/dvNpgxYYskvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyJcrakV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769463430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FuGQCOqf9yOzW+ft8te/e4xxRm2OgzH1ppkEP0d7iLg=;
	b=VyJcrakVFtvYwYtGuk4m7+1fPDnKA6CR0a7Vvx1tA/6XdH+syURXUdt7DtEUYuq7zAo1Je
	bnop4QYGQRhwn0A+kEPQkB7KPrB7jvHYj6Hj/2L2OR2wXGtxxZn/Uq8SjH2LtyTsM5evGD
	Am7UsxCa6xbwA8drhkbqA49eZFHsxBM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-bh118hx4PqOesZMsNWSXsw-1; Mon,
 26 Jan 2026 16:37:06 -0500
X-MC-Unique: bh118hx4PqOesZMsNWSXsw-1
X-Mimecast-MFC-AGG-ID: bh118hx4PqOesZMsNWSXsw_1769463425
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30ADA19775A5;
	Mon, 26 Jan 2026 21:37:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.164])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C9851956095;
	Mon, 26 Jan 2026 21:37:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <821cb2becf70b2dcb903e74685643f8b60a5cbb6.camel@linux.ibm.com>
References: <821cb2becf70b2dcb903e74685643f8b60a5cbb6.camel@linux.ibm.com> <1783975.1769190197@warthog.procyon.org.uk>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: dhowells@redhat.com, Simo Sorce <simo@redhat.com>,
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
Content-ID: <1988759.1769463419.1@warthog.procyon.org.uk>
Date: Mon, 26 Jan 2026 21:36:59 +0000
Message-ID: <1988760.1769463419@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,huawei.com,gmail.com,oracle.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8323-lists,linux-integrity=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,warthog.procyon.org.uk:mid]
X-Rspamd-Queue-Id: 4DEA58DA9E
X-Rspamd-Action: no action

Mimi Zohar <zohar@linux.ibm.com> wrote:

> > Further, we need to think how we're going to do PQC support in IMA -
> > particularly as the signatures are so much bigger and verification slower.
> 
> Perhaps, but these same reasons would apply to kernel modules, firmware, and
> the kernel image.  Why would IMA be special?!

Scale.  I wouldn't expect more than a couple of hundred or so kernel module
and firmware signatures - and, for the most part, that would be done once
during boot.  On the other hand, I'm assuming that a lot more IMA signatures
might need checking and maybe more frequently.

David


