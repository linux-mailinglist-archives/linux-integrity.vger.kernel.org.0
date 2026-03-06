Return-Path: <linux-integrity+bounces-8943-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLRTD1Fjq2mmcgEAu9opvQ
	(envelope-from <linux-integrity+bounces-8943-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 07 Mar 2026 00:29:21 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE64F228B24
	for <lists+linux-integrity@lfdr.de>; Sat, 07 Mar 2026 00:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C142C303F44B
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Mar 2026 23:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8990A378D70;
	Fri,  6 Mar 2026 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DZLtQeEa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wseMXmnJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20937375F93;
	Fri,  6 Mar 2026 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839758; cv=none; b=PrBZRYsXzU8uWL1wWeghyHPVLxj2OplLJJnAt23bgwtSoUX372gUgKe7+61mdHef8ytGzhO+W3p51wZdUg6JRsAR+eycKacAPHTIBYI/KQC0firFYlsxoUNao3tQZd/XbuAfTPqJNQ0DUEXicloTYV578l+VvVuULquHVz7kGlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839758; c=relaxed/simple;
	bh=cY2s7/qEuxqwfkrFpJGX5cmRmBLdKB08nhmezUnAbEk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HR7XvDBx0mCTqRwt7Wf0fDfpBjUO0jT2uMjkE7feMR7+PxN70GV/lnRsfrR4ULUDZqCbWOgGorTrZnDxPvhdUGgNdxCt0B+f5GG3yj8rlT3QfqKdgZ3VpwexCCJwogNsiktJpNqhZC55HNPpEWdP6WCnCBOIbk7yJnsMMz8LsHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DZLtQeEa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wseMXmnJ; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 468D31380B55;
	Fri,  6 Mar 2026 18:29:08 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 06 Mar 2026 18:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772839748;
	 x=1772846948; bh=GETdZGM4YA8yA694WxEZkZM09wEgzGQFz172whB4Qxk=; b=
	DZLtQeEaE1Dg/BQ7D4AeSS6PstNxPQGzBfjmzElVIT2ViU5ATfpUTqv7ybEr9Ht1
	oNWpbiqL2pq7dtr+d/nQeWQrsgtFOolMVDDHLGag5CqmqYuNkKJu2fV6pYT4kFal
	VDcmU/ygQtSSYNKAlWfynduCxhSfxMxJ/q6eqKV67R8jo3kpmDwFf+3Ik4ZFpRP+
	kvRibMs1AygZJ5Mt/9LmTVRSM1O1u1satUPynemVwMfrv1RBET+4vzB1y5wKEJxP
	mNV8qPxnb6oCZhF7tZuLWePLcH4p1BgF4X0Dl+jJZpUQtYR5ZhLhvmsR+wjOQQGx
	O2oXve4Du80lwmuLrMWrCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772839748; x=
	1772846948; bh=GETdZGM4YA8yA694WxEZkZM09wEgzGQFz172whB4Qxk=; b=w
	seMXmnJeT7pXctEfb0cuHkhDGFIved/RrLP41GOYSHJZIudzgjXdkCaMKc3/fuOc
	VZSiKq/sFK46Wv0P1yfi6XTTGcjVcOF4t16lFjNAn0khkeQexoCxqlKk20jAOh5Z
	3FXnJc/w+W/aHe8VwOhDWyYQlwq2ziIThwloozu1G1am3J/+FA4JrhkVlv382NxA
	OLKtCAKtzSbyQfVzIG1J+C+7UP4aLUuKtIeM+0s/AdlXgqDkeRlkd44mZXcj+fa3
	w3JdHa4D+s/qlnJKWqICmb+3+32uBHUCjfdPoY02ErP23mAM8KZErJQaJiORqdAK
	1b4FEirgnOfR6NSecGlLA==
X-ME-Sender: <xms:QmOraWsyLvlZyKLelmZchVJg1xBgRira818lH5Wjars5zRp85n6CQw>
    <xme:QmOraWRtKrrRDmlCNZGOpBg7hN286NecEsEM-hXsK-CEU4Kvci-J_B3E_EW-_GbjF
    PGKco_Wq02UUw_hQh5BDkaiv8zqs7AnWCU8vkT9nPcakQV0ANylFxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepfeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhope
    gumhhithhrhidrkhgrshgrthhkihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhi
    tghkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtth
    hopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhushhtihhnshht
    ihhtthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhhorhgsohesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepshgvrhhgvgeshhgrlhhlhihnrdgtohhmpdhrtghpthhtohep
    rhhosggvrhhtohdrshgrshhsuheshhhurgifvghirdgtohhmpdhrtghpthhtoheprghrug
    gssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QmOraRrSb10jiymrzAb9WoZsi2Tz-RWq3EgTbOMgthiE6ddf2js5fg>
    <xmx:QmOraV59nHhEl8HgbMxhoT5o00wgqHOBxJi98jSFMQacjFhPKo6bVA>
    <xmx:QmOraeTzKignEiBCyYkH7DDUy6V7Tt_Ly1cVrUvLgxoPLAb5URLvJA>
    <xmx:QmOraV22SWxKf9dNjfi4R5SgY50umdOU57z7mmavyGXn0CHg06wlMA>
    <xmx:RGOraemTV6W3wcgRW43rhHE9NEY71V2JSNopp6mLKexfMh9JtslQFcRw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 629A3700065; Fri,  6 Mar 2026 18:29:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYSH_HmCkp7N
Date: Sat, 07 Mar 2026 00:28:27 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nathan Chancellor" <nathan@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Mimi Zohar" <zohar@linux.ibm.com>,
 "Roberto Sassu" <roberto.sassu@huawei.com>,
 "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Jarkko Sakkinen" <jarkko@kernel.org>,
 "Ard Biesheuvel" <ardb@kernel.org>, "Coiby Xu" <coxu@redhat.com>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>,
 "Andrew Donnellan" <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <e16f0912-c928-4f25-94f8-18b260416ce3@app.fastmail.com>
In-Reply-To: <20260306225648.GC2746259@ax162>
References: <20260306150421.270124-1-arnd@kernel.org>
 <20260306225648.GC2746259@ax162>
Subject: Re: [PATCH] integrity: avoid using __weak functions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CE64F228B24
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-8943-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,huawei.com,gmail.com,paul-moore.com,namei.org,hallyn.com,kernel.org,redhat.com,oracle.com,google.com,lists.ozlabs.org,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity,lkml];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:dkim,messagingengine.com:dkim]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026, at 23:56, Nathan Chancellor wrote:
> On Fri, Mar 06, 2026 at 04:03:24PM +0100, Arnd Bergmann wrote:
>
> Thanks, I noticed this as well. The version I came up with and have been
> locally testing is the following, which is a little bit more compact.
>
>  arch/Kconfig                     |  3 +++
>  arch/powerpc/Kconfig             |  1 +
>  arch/s390/Kconfig                |  1 +
>  arch/s390/kernel/ipl.c           | 10 +++++-----
>  include/linux/secure_boot.h      |  4 ++++
>  security/integrity/Makefile      |  2 +-
>  security/integrity/secure_boot.c | 16 ----------------
>  7 files changed, 15 insertions(+), 22 deletions(-)
>

Right, your version looks good to me as well.

       Arnd

